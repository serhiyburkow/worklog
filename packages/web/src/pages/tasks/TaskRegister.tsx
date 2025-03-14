import React from 'react';
import { useParams, useNavigate, useLocation } from 'react-router-dom';
import { Container, Heading, useToast } from '@chakra-ui/react';
import { TaskRegisterForm } from '../../components/forms/TaskRegisterForm';
import { api } from '../../lib/api';
import { useAuth } from '../../hooks/useAuth';

export const TaskRegister: React.FC = () => {
  const { projectId } = useParams<{ projectId: string }>();
  const navigate = useNavigate();
  const location = useLocation();
  const toast = useToast();
  const { user } = useAuth();

  const getTaskType = () => {
    if (location.pathname.includes('/register/product')) return 'PRODUCT';
    if (location.pathname.includes('/register/intermediate')) return 'INTERMEDIATE';
    return 'GENERAL';
  };

  const taskType = getTaskType();
  const isProductTask = taskType === 'PRODUCT';

  if (!projectId || !user) {
    return null;
  }

  const handleSubmit = async (formData: {
    productCode: string;
    taskId: string;
    registeredAt: string;
    userId?: string;
    timeSpent?: string;
    hours?: string;
    minutes?: string;
    quantity?: string;
  }) => {
    try {
      if (isProductTask) {
        // Розділяємо коди продуктів та видаляємо дублікати
        const productCodes = [...new Set(
          formData.productCode
            .split(/[\s,]+/)
            .map(code => code.trim())
            .filter(code => code.length > 0)
        )];

        // Створюємо окремий запис для кожного коду
        const promises = productCodes.map(code => 
          api.post('/task-logs/register', {
            projectId,
            taskId: formData.taskId,
            registeredAt: formData.registeredAt,
            userId: formData.userId,
            type: taskType,
            productCode: code
          })
        );

        await Promise.all(promises);

        toast({
          title: 'Успіх',
          description: `Успішно зареєстровано ${productCodes.length} унікальних задач`,
          status: 'success',
          duration: 3000,
          isClosable: true,
        });
      } else {
        const payload = {
          projectId,
          taskId: formData.taskId,
          registeredAt: formData.registeredAt,
          userId: formData.userId,
          type: taskType,
          ...(taskType === 'INTERMEDIATE' 
            ? { quantity: parseInt(formData.quantity || '0') }
            : { timeSpent: parseFloat(formData.timeSpent || '0') })
        };

        await api.post('/task-logs/register', payload);

        toast({
          title: 'Успіх',
          description: 'Задачу успішно зареєстровано',
          status: 'success',
          duration: 3000,
          isClosable: true,
        });
      }
      navigate(`/projects/${projectId}`);
    } catch (error: any) {
      console.error('Помилка при реєстрації задачі:', error);
      toast({
        title: 'Помилка',
        description: error.response?.data?.message || 'Не вдалося зареєструвати задачу',
        status: 'error',
        duration: 3000,
        isClosable: true,
      });
    }
  };

  const getHeading = () => {
    switch (taskType) {
      case 'PRODUCT':
        return 'Реєстрація виконаних продуктових задач';
      case 'INTERMEDIATE':
        return 'Реєстрація виконаної проміжної задачі';
      default:
        return 'Реєстрація виконаної загальної задачі';
    }
  };

  return (
    <Container maxW="container.md" py={8}>
      <Heading mb={6}>{getHeading()}</Heading>
      <TaskRegisterForm
        projectId={projectId}
        currentUser={{
          id: user.id,
          role: user.role
        }}
        onSubmit={handleSubmit}
        isProductTask={isProductTask}
        taskType={taskType}
      />
    </Container>
  );
}; 