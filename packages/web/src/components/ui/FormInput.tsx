import {
  FormControl,
  FormLabel,
  Input,
  InputGroup,
  InputLeftElement,
  FormErrorMessage,
  type InputProps as ChakraInputProps,
} from '@chakra-ui/react';
import { useFormContext } from 'react-hook-form';
import { ReactNode } from 'react';

interface FormInputProps extends Omit<ChakraInputProps, 'size'> {
  name: string;
  label: string;
  icon?: ReactNode;
  size?: 'sm' | 'md' | 'lg';
  isRequired?: boolean;
}

export const FormInput = ({
  name,
  label,
  icon,
  size = 'lg',
  isRequired = false,
  ...props
}: FormInputProps) => {
  const {
    register,
    formState: { errors, touchedFields },
  } = useFormContext();

  const error = errors[name]?.message as string;
  const touched = touchedFields[name];

  return (
    <FormControl isInvalid={!!(error && touched)} isRequired={isRequired}>
      <FormLabel fontWeight="medium">{label}</FormLabel>
      <InputGroup>
        {icon && (
          <InputLeftElement pointerEvents="none" h="full">
            {icon}
          </InputLeftElement>
        )}
        <Input
          {...register(name)}
          {...props}
          size={size}
          borderRadius="md"
          bg="gray.50"
          _hover={{ bg: 'gray.100' }}
          _focus={{ bg: 'white', borderColor: 'blue.400', boxShadow: 'outline' }}
        />
      </InputGroup>
      <FormErrorMessage>{error}</FormErrorMessage>
    </FormControl>
  );
}; 