import { Controller, Post, Body, Get, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { AnonymousLoginDto } from './dto/anonymous-login.dto';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import { JwtAuthGuard } from './jwt-auth.guard';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Get('me')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get current user data' })
  @ApiResponse({ status: 200, description: 'Return current user data' })
  async getCurrentUser(@Request() req) {
    return req.user;
  }

  @Post('login')
  @ApiOperation({ summary: 'Login with email and password' })
  @ApiResponse({ status: 200, description: 'Return access token and user data' })
  async login(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto.email, loginDto.password);
  }

  @Post('register')
  @ApiOperation({ summary: 'Register new user' })
  @ApiResponse({ status: 201, description: 'User has been created' })
  async register(@Body() registerDto: RegisterDto) {
    return this.authService.register(
      registerDto.email,
      registerDto.password,
      registerDto.name,
      registerDto.role,
      registerDto.phone,
    );
  }

  @Post('anonymous')
  @ApiOperation({ summary: 'Login as anonymous user' })
  @ApiResponse({ status: 200, description: 'Return access token and user data' })
  async loginAnonymous(@Body() { nickname }: AnonymousLoginDto) {
    return this.authService.loginAnonymous(nickname);
  }

  @Post('change-password')
  @ApiOperation({ summary: 'Change user password' })
  @ApiResponse({ status: 200, description: 'Password has been changed' })
  async changePassword(@Body() { currentPassword, newPassword }: ChangePasswordDto, @Body('email') email: string) {
    return this.authService.changePassword(email, currentPassword, newPassword);
  }
} 