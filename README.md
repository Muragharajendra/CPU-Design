# 32bitARM_like_CPU_design
This repository contains the complete source code, design files for designing an ARM-like CPU.
## CPUs Instruction set 
Our designed CPU can handle the following commands. 

Data Processing: ADD SUB AND ORR 

Memory Operation: STR and LDR 

Branch: B 

Also, cover all the conditional mnemonics from ARM LRM, as shown in the snapshot below. 

![WhatsApp Image 2024-10-21 at 8 50 46 PM](https://github.com/user-attachments/assets/5dfd10a9-aad9-4771-a08e-51e941b20dde)
ref: Digital Design and Computer Architecture ARM edition by Harris


## Micro Architecture in details : 

In our workshop, we have explained the reason behind each line of wire across multiple episodes. 

![image](https://github.com/user-attachments/assets/0cbcf160-2750-4286-9c24-b48418b063c9)

## Netlist:

![image](https://github.com/Muragharajendra/CPU-Design/blob/main/Screenshot_Netlist.png)

## Testing : 

To test a CPU working we need to have an extensive code which can examine each and every instruction covered in this CPU design , and then if that code is being executed by our CPU 
with the required final result we can say that CPU passed the initial test 

To test our design, we have taken reference test Code from Digital Design and Computer Architecture ARM edition by Harris. 

### Test Code : 

![image](https://github.com/user-attachments/assets/6597a10c-7191-4b00-bbf0-d3e907aeeedd)


imem.v : instruction memory source this codes in hexadecimal format . 

testbench.sv : Check if we are getting mem[84]==7 or not, which is the final expected outcome of this test code . 
