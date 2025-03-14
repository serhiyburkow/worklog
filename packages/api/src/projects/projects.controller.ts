import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ProjectsService } from './projects.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { ProjectResponseDto, CreateProjectDto, UpdateProjectDto, TaskResponseDto, ProjectUserResponseDto } from './dto';
import { ProjectUserRole } from '@prisma/client';
import { ProjectAccessGuard } from './guards/project-access.guard';

@ApiTags('projects')
@Controller('projects')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class ProjectsController {
  constructor(private readonly projectsService: ProjectsService) {}

  @Get()
  @ApiOperation({ summary: 'Get all projects' })
  @ApiResponse({ status: 200, description: 'Return all projects', type: [ProjectResponseDto] })
  async findAll() {
    return this.projectsService.findAll();
  }

  @Get(':id')
  @UseGuards(ProjectAccessGuard)
  @ApiOperation({ summary: 'Get project by id' })
  @ApiResponse({ status: 200, description: 'Return project by id', type: ProjectResponseDto })
  async findOne(@Param('id') id: string) {
    return this.projectsService.findOne(id);
  }

  @Post()
  @ApiOperation({ summary: 'Create project' })
  @ApiResponse({ status: 201, description: 'Project has been created', type: ProjectResponseDto })
  async create(@Body() createProjectDto: CreateProjectDto) {
    return this.projectsService.create(createProjectDto);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update project' })
  @ApiResponse({ status: 200, description: 'Project has been updated', type: ProjectResponseDto })
  async update(@Param('id') id: string, @Body() updateProjectDto: UpdateProjectDto) {
    return this.projectsService.update(id, updateProjectDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete project' })
  @ApiResponse({ status: 200, description: 'Project has been deleted' })
  async remove(@Param('id') id: string) {
    return this.projectsService.remove(id);
  }

  @Get('user/:userId')
  @ApiOperation({ summary: 'Get projects by user id' })
  @ApiResponse({ status: 200, description: 'Return projects by user id', type: [ProjectResponseDto] })
  async findByUser(@Param('userId') userId: string) {
    return this.projectsService.findByUser(userId);
  }

  @Get(':id/tasks')
  @ApiOperation({ summary: 'Get tasks by project id' })
  @ApiResponse({ status: 200, description: 'Return tasks by project id', type: [TaskResponseDto] })
  async findTasksByProject(@Param('id') id: string) {
    return this.projectsService.findTasksByProject(id);
  }

  @Get(':id/users')
  @ApiOperation({ summary: 'Get users by project id' })
  @ApiResponse({ status: 200, description: 'Return users by project id', type: [ProjectUserResponseDto] })
  async findUsersByProject(@Param('id') id: string) {
    return this.projectsService.findUsersByProject(id);
  }

  @Delete(':projectId/users/:userId')
  @ApiOperation({ summary: 'Remove user from project' })
  @ApiResponse({ status: 200, description: 'User has been removed from project' })
  async removeUser(
    @Param('projectId') projectId: string,
    @Param('userId') userId: string,
  ) {
    return this.projectsService.removeUserFromProject(projectId, userId);
  }

  @Put(':projectId/users/:userId/toggle-active')
  @ApiOperation({ summary: 'Toggle user active status in project' })
  @ApiResponse({ status: 200, description: 'User status has been updated' })
  async toggleUserActive(
    @Param('projectId') projectId: string,
    @Param('userId') userId: string,
    @Body('isActive') isActive: boolean,
  ) {
    return this.projectsService.toggleUserActive(projectId, userId, isActive);
  }

  @Get(':projectId/users')
  @ApiOperation({ summary: 'Get project users' })
  @ApiResponse({ status: 200, description: 'Return project users' })
  async getProjectUsers(@Param('projectId') projectId: string) {
    return this.projectsService.findUsersByProject(projectId);
  }

  @Put(':projectId/users/:userId/role')
  @ApiOperation({ summary: 'Update user role in project' })
  @ApiResponse({ status: 200, description: 'User role has been updated' })
  async updateUserRole(
    @Param('projectId') projectId: string,
    @Param('userId') userId: string,
    @Body('role') role: ProjectUserRole,
  ) {
    return this.projectsService.updateUserRole(projectId, userId, role);
  }
} 