import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNumber, IsOptional, IsUUID } from 'class-validator';

export class CreateProductTaskDto {
  @ApiProperty()
  @IsUUID()
  projectId: string;

  @ApiProperty()
  @IsUUID()
  userId: string;

  @ApiProperty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsUUID()
  typeId: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  tags?: string;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  complexity?: number;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  estimatedTime?: number;
} 