export interface ProjectUser {
  id: string;
  name: string;
  lastName: string | null;
  callSign: string | null;
  email: string;
  role: string;
  isActive: boolean;
} 