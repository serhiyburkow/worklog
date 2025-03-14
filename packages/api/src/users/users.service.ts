import { Injectable, NotFoundException, ConflictException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateUserDto, CreateUserDto } from './dto';
import * as bcrypt from 'bcrypt';
import { UpdateProfileDto } from './dto/update-profile.dto';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(createUserDto: CreateUserDto) {
    const existingUser = await this.prisma.user.findUnique({
      where: { email: createUserDto.email },
    });

    if (existingUser) {
      throw new ConflictException('User with this email already exists');
    }

    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);

    const user = await this.prisma.user.create({
      data: {
        name: createUserDto.name,
        email: createUserDto.email,
        passwordHash: hashedPassword,
        phone: createUserDto.phone,
      },
      include: {
        skills: {
          select: {
            skillId: true,
          },
        },
      },
    });

    return {
      ...user,
      skills: user.skills.map(s => s.skillId),
    };
  }

  async findAll() {
    const users = await this.prisma.user.findMany({
      include: {
        skills: {
          select: {
            skillId: true,
          },
        },
      },
    });

    return users.map(user => ({
      ...user,
      skills: user.skills.map(s => s.skillId),
    }));
  }

  async findOne(id: string) {
    const user = await this.prisma.user.findUnique({
      where: { id },
      include: {
        skills: {
          select: {
            skillId: true,
          },
        },
      },
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return {
      ...user,
      skills: user.skills.map(s => s.skillId),
    };
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    const updateData: any = { ...updateUserDto };
    
    if (updateUserDto.password) {
      updateData.passwordHash = await bcrypt.hash(updateUserDto.password, 10);
      delete updateData.password;
    }

    const user = await this.prisma.user.update({
      where: { id },
      data: updateData,
      include: {
        skills: {
          select: {
            skillId: true,
          },
        },
      },
    });

    return {
      ...user,
      skills: user.skills.map(s => s.skillId),
    };
  }

  async remove(id: string) {
    await this.prisma.user.delete({
      where: { id },
    });
  }

  async addSkill(userId: string, skillId: string) {
    await this.prisma.userSkill.create({
      data: {
        userId,
        skillId,
      },
    });
  }

  async removeSkill(userId: string, skillId: string) {
    await this.prisma.userSkill.delete({
      where: {
        userId_skillId: {
          userId,
          skillId,
        },
      },
    });
  }

  async updateProfile(userId: string, updateProfileDto: UpdateProfileDto) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new NotFoundException('Користувача не знайдено');
    }

    // Перевіряємо, чи існує користувач з таким email (крім поточного користувача)
    const existingUser = await this.prisma.user.findFirst({
      where: {
        email: updateProfileDto.email,
        NOT: {
          id: userId,
        },
      },
    });

    if (existingUser) {
      throw new BadRequestException('Користувач з таким email вже існує');
    }

    // Якщо користувач хоче змінити пароль
    if (updateProfileDto.currentPassword && updateProfileDto.newPassword) {
      const isPasswordValid = await bcrypt.compare(
        updateProfileDto.currentPassword,
        user.passwordHash,
      );

      if (!isPasswordValid) {
        throw new BadRequestException('Неправильний поточний пароль');
      }

      const hashedPassword = await bcrypt.hash(updateProfileDto.newPassword, 10);

      return this.prisma.user.update({
        where: { id: userId },
        data: {
          name: updateProfileDto.name,
          lastName: updateProfileDto.lastName,
          email: updateProfileDto.email,
          phone: updateProfileDto.phone,
          callSign: updateProfileDto.callSign,
          passwordHash: hashedPassword,
        },
        select: {
          id: true,
          name: true,
          lastName: true,
          email: true,
          phone: true,
          callSign: true,
          role: true,
        },
      });
    }

    // Якщо користувач не змінює пароль
    return this.prisma.user.update({
      where: { id: userId },
      data: {
        name: updateProfileDto.name,
        lastName: updateProfileDto.lastName,
        email: updateProfileDto.email,
        phone: updateProfileDto.phone,
        callSign: updateProfileDto.callSign,
      },
      select: {
        id: true,
        name: true,
        lastName: true,
        email: true,
        phone: true,
        callSign: true,
        role: true,
      },
    });
  }

  async findById(id: string) {
    const user = await this.prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        name: true,
        lastName: true,
        email: true,
        phone: true,
        callSign: true,
        role: true,
      },
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return user;
  }
} 