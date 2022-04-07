#include <stdio.h>

/*
  1. Do NOT declare ANY global variables
  2. ALL variables MUST be declared within the main function
  3. Declaring global constants using the #define keyword is okay
  4. Pass appropriate variables as arguments to each function
  5. The function MUST be an exact translation of the MIPS assembly code
*/
void prepareData(int[], int[], int[], int);
int processData(int[], int);
void displayResult(int, int);

int main()
{
    int array[20] = {35,-34,82,-95,-2,22,-17,80,-67,-39,64,94,-96,95,-70,-63,69,-3,75,-10};
    int data1[10];
    int data2[10];
    int size = 20;
    int halfSize = 10;
  
  prepareData(array, data1, data2, size);
  
int result1 = processData(data1, halfSize);
  int result2 = processData(data2, halfSize);
  displayResult(result1, result2);
  
    return 0;
}

/*
  1. Add the appropriate arguments to the function
  2. The function MUST be an exact translation of the MIPS assembly code
*/
void displayResult(int result1, int result2)
{
  int finalResult = result1 + result2;
  printf("Assignment 3\n");
  printf("------------\n");
  printf("Result: %d", finalResult);

}

/*
  1. Add the appropriate arguments to the function
  2. The function MUST be an exact translation of the MIPS assembly code
*/
void prepareData(int array[], int data1[], int data2[], int size)
{
int i = 0;
int x = 0;
int y = 0;

    while (i < size){

      if ( array[i] % 2 == 0){
          data1[x] = array[i];
          x++;
      }
      
      else {
        data2[y] = array[i];
        y++;
      }
      
      i++;
  }
  
}

/*
  1. Add the appropriate arguments to the function
  2. The function MUST be an exact translation of the MIPS assembly code
*/
int processData(int a[], int halfSize)
{
  int res = 100;
  
  for (int i = 0; i < halfSize; i++){
      
    if (i % 2 == 0){
      res += a[i];
    }
    else {
      res -= a[i];
    }
  }

	return res; // Return the appropriate value
}