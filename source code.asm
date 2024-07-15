
# made by: Ali Shaikh Qasem, Deyaa Rimawi
################# Data segment #####################
.data
      ##### note: for the file name, you must write the full path for your input file to access it #########
      file_name: .asciiz "C:\\Users\\hp\\Desktop\\mips programs\\MedicalTest.txt"
      file_string: .space 1024  # enough for about 30 input lines
      num_medical_tests: .word 0 # to store the number of current medical tests
      temp_string: .space 12 # temp string for general use
      second_temp_string: .space 12 # temp string for general use
      
      # defining the main data structure (parallel arrays)
      patient_id: .space 200 # 4 * 50 (max of 50 medical tests)
      test_name: .space 200
      test_date: .space 400 # (two words for each date)
      test_result: .space 400 # ( two different single precision floating point results)
      
      # defining some needed strings for text formatting
      menu_string: .asciiz "Choose an option:\n1. Add a new medical test.\n2. Retreive all patient tests.\n3. Retrieve all up normal patient tests.\n4. Retrieve all patient tests in a given specific period.\n5. Search for unnormal tests.\n6. Retrieve average values of tests.\n7. Update an existing test result.\n8. Delete a test.\n9. Print all medical tests.\n10. Exit\n"
      comma_string: .asciiz ", "
      new_line_str: .asciiz "\n" 
      enter_patient_id: .asciiz "Enter patient id: \n"
      enter_test_name: .asciiz "Enter test name: \n"
      enter_test_date: .asciiz "Enter test date (you must enter a date in the following format YYYY-MM): \n"
      enter_test_result: .asciiz "Enter test result: \n"
      enter_BPT_result1: .asciiz "Enter Systolic Blood Pressure result: \n"
      enter_BPT_result2: .asciiz "Enter Diastolic Blood Pressure result: \n"
      index_not_found_msg: .asciiz "The index is not found \n"
      id_not_found_msg: .asciiz "The id is not found \n"
      Bpt_str: .asciiz "BPT"
      Hgb_str: .asciiz "Hgb"
      BGT_str: .asciiz "BGT"
      LDL_str: .asciiz "LDL"
      Hgb_avg_msg: .asciiz "The average value of Hgb tests is: "
      BGT_avg_msg: .asciiz "The average value of BGT tests is: "
      LDL_avg_msg: .asciiz "The average value of LDL tests is: "
      BPT_sys_avg_msg: .asciiz "The average value of BPT systolic tests is: " 
      BPT_dias_avg_msg: .asciiz "The average value of BPT diastolic tests is: " 
      invalid_choice_msg: .asciiz "Invalid choice\n"
      test_is_added_msg: .asciiz "The test has been added.\n"
      period_start_date: .space 10
      period_end_date: .space 10
      period_start_date_msg: .asciiz "Enter the start date of the period: \n"
      period_end_date_msg: .asciiz "Enter the end date of the period: \n"
      illegal_period_msg: .asciiz "This is illegal period\n"
      
      id_upper_limit: .word 9999999
      id_lower_limit: .word 1000000
      invalid_id_msg: .asciiz "Invalid id, try again: \n"
      invalid_name_msg: .asciiz "Invalid name, try again: \n"
      test_not_found_msg: .asciiz "The test is not found\n"
      test_is_deleted_msg: .asciiz "The test is successfully deleted\n"
      test_is_updated_msg: .asciiz "Test result is updated successfully.\n"
	lower_limit_hgb:    .float 13.8    # Lower limit of Hemoglobin
	upper_limit_hgb:    .float 17.2    # Upper limit of Hemoglobin
	lower_limit_bgt:    .float 70.0    # Lower limit of Blood Glucose Test
	upper_limit_bgt:    .float 99.0    # Upper limit of Blood Glucose Test
	upper_limit_ldl:    .float 100.0   # Upper limit of LDL Cholesterol
	upper_limit_systolic_bpt:   .float 120.0   # Upper limit of Systolic Blood Pressure
	upper_limit_diastolic_bpt:  .float 80.0    # Upper limit of Diastolic Blood Pressure

   
   
              
################# Code segment #####################
.text
 .globl main
main:
    #reading the file
     jal read_file 
     #storing file string into our lists
     jal store_file_fields
     ### creating the menu ###
    menu_loop:
        # print a new line 
        la $a0, new_line_str
        li $v0, 4
        syscall
        # print the menu
        la $a0, menu_string
        li $v0, 4
        syscall
        # read the choice from user 
        li $v0, 5
        syscall
        move $t0, $v0 # t0 stores user's oprtion
        beq $t0, 1, choice_1
        beq $t0, 2, choice_2
        beq $t0, 3, choice_3
        beq $t0, 4, choice_4
        beq $t0, 5, choice_5
        beq $t0, 6, choice_6
        beq $t0, 7, choice_7
        beq $t0, 8, choice_8
        beq $t0, 9, choice_9
        beq $t0, 10, choice_10
        j invalid_choice
    choice_1:
        jal add_medical_test
        j menu_loop
    choice_2:
        jal retrieve_all_patient_tests
        j menu_loop
    choice_3:
	jal  Retrieve_all_upnormal_patient_by_id
        j menu_loop
    choice_4:
        jal retrieve_patient_specific_period_tests
        j menu_loop
    choice_5:
	jal retrieve_all_upnormal_patient_by_name
        j menu_loop
    choice_6:
        jal Average_test_value
        j menu_loop
    choice_7:
       jal update_medical_tests
        j menu_loop
    choice_8:
        jal delete_medical_test
        j menu_loop
    choice_9:
        jal print_medical_tests
        j menu_loop
    choice_10:
        j menu_done
                      
    invalid_choice:
        la $a0, invalid_choice_msg
        li $v0, 4
        syscall
        j menu_loop
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
     menu_done:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
     # Exit the program
     li $v0, 10
     syscall                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
#########################################################################################
# a function to read the input file and store the overall content in the string called file_String    
read_file:
     #opening the file
     li $v0, 13 # open file syscall code
     la $a0, file_name #file name
     li $a1, 0 # flag = 0 for read
     syscall 
     move $s0, $v0 # saving file descriptor
     
     # reading the file
     li $v0, 14 # reading syscall code
     move $a0, $s0 # file descriptor
     la $a1, file_string #file_String
     la $a2, 512 # buffer length
     syscall 
     
     #closing the file
     li $v0, 16 # the code
     move $a0, $s0 # the file descriptor
     syscall
     
     #return
     jr $ra
########################################################################3##############
# function to convert string to integer ( the address of string must be in $a0 and the result will be in $v0)
str_to_int:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     li  $v0, 0 # v0 will store the result
     li $t0, 10 
  sti_loop:
     lb $t1, 0($a0)
     blt $t1, '0' sti_done
     bgt $t1, '9', sti_done
     addiu $t1, $t1, -48
     mul $v0, $v0, $t0
     addu $v0, $v0, $t1
     addiu $a0, $a0, 1
     j sti_loop
  sti_done:
     # loading the resturn address ( in case of nested functions use)
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
#######################################################################################
# function to convert the fp string to fp value ( recieve string's address in $a0 and store result in $f0) --> fp stands for floating point
fpStr_to_fpVal: # single precision fp
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     # initialize the result and required registers
     li $t0, 0
     mtc1 $t0, $f0 # $f0 stores the result
     cvt.s.w $f0, $f0 # convert to floating point
     li $t0, 10
     mtc1 $t0, $f2
     cvt.s.w $f2, $f2
     
  ftf_loop:
     lb $t1, 0($a0) # $t1 storess each character
     beq $t1, '.', point_found
     beq $t1, 0, ftf_done
     addiu $t1, $t1, -48 
     mtc1 $t1, $f4 # f2 stores the digit value of the character
     cvt.s.w $f4, $f4
     mul.s $f0, $f0, $f2
     add.s $f0, $f0, $f4
     addiu $a0, $a0, 1
     j ftf_loop
     
  point_found:
     addiu $a0, $a0, 1 # move to next char after the point
     li $t3, 10
     mtc1 $t3, $f8 # $f8 =10
     cvt.s.w $f8, $f8
     ftf_loop2:
         lb $t1, 0($a0)
         beq $t1, 0, ftf_done
         addiu $t1, $t1, -48
         mtc1 $t1, $f4 # f4 stores the digit value of the character
         cvt.s.w $f4, $f4
         # get the decimal value for each decimal digit
         div.s $f6, $f4, $f2 
         mul.s $f2, $f2, $f8 
         add.s $f0, $f0, $f6
         addiu $a0, $a0, 1
         j ftf_loop2
            
  ftf_done:
     # loading the resturn address ( in case of nested functions use)
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
###########################################################################################
# function to store the fields from the input file to the parallel arrays 
store_file_fields:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     # loading required addresses
     la $s0, file_string 
     la $s1, patient_id 
     la $s2, test_name
     la $s3, test_date
     la $s4, test_result
     la $s5, temp_string
     
  main_loop:
     id_loop:
        lb $s6, 0($s0)
        beq $s6, ':', id_done
        beq $s6, 0, sff_done # if the file is empty then done
        sb $s6, 0($s5) 
        addiu $s0, $s0, 1
        addiu $s5, $s5, 1
        j id_loop
     id_done:
        addiu $s0, $s0, 2 # skip the space (which comes after ':') and go to test name
        la $a0, temp_string # move the address as an argument the the function str_to_int
        jal str_to_int # convert to integer
        sw $v0, 0($s1) # store it
        addiu $s1, $s1, 4 # move the address to next word
        la $s5, temp_string # return to the beginning of the temp string
        move $a0, $s5
        jal clear_string # clear the temp string for the next use
        
     name_loop:
        lb $s6, 0($s0)
        beq $s6, ',', name_done
        sb $s6, 0($s2)
        addiu $s0, $s0, 1
        addiu $s2, $s2, 1
        j name_loop
     name_done:
        addiu $s0, $s0, 2 #skip the next space character
        addiu $s2, $s2, 1 # move to next test-name word
     
     date_loop:
        lb $s6, 0($s0)
        beq $s6, ',', date_done
        sb $s6, 0($s3)
        addiu $s0, $s0, 1
        addiu $s3, $s3, 1
        j date_loop
        
     date_done:
        addiu $s0, $s0, 2 #skip the next space character
        addiu $s3, $s3, 1 # move to next test-date word
        
     result1_loop: ### the systolic blood pressure in BPT case
        lb $s6, 0($s0)
        beq $s6, 13, result1_done # carriege return \r found (each line ends with \r\n), in this case, new line found
        beq $s6, 0, result1_done # end of lines
        beq $s6, ',', result1_done
        sb $s6, 0($s5) # store the chraacters in the temp string
        addiu $s0, $s0, 1
        addiu $s5, $s5, 1
        j result1_loop
        
     result1_done:
        la $a0, temp_string # move the address as an argument the the function
        jal fpStr_to_fpVal # convert to fp value
        swc1 $f0, 0($s4) # store it
        la $s5, temp_string # return to the beginning of the temp string
        move $a0, $s5
        jal clear_string # clear the string for the next use
        
        
        # increase number of medical tests
        la $t0, num_medical_tests
        lw $t1, 0($t0)
        addiu $t1, $t1, 1
        sw $t1, 0($t0)
        
        beq $s6, ',', result2 # in the case we find another result (in BPT case)
        addiu $s0, $s0, 2 # move to next line (skip the \n character)
        addiu $s4, $s4, 8 # move the address to next test result
        beq $s6, 13, main_loop # if the char is CR (carriege return) then repeat the process (we reach end of line)
        beq $s6, 0, sff_done # if it's null termination then end the process
     
     result2: ### the diastolic blood pressure in BPT case
        addiu $s4, $s4, 4 # to store the second result
        addiu $s0, $s0, 2 # to skip the comma and the space
        
     result2_loop:
        lb $s6, 0($s0)
        beq $s6, 13, result2_done # carriege return \r found (each line ends with \r\n), in this case, new line found
        beq $s6, 0, result2_done # end of lines
        sb $s6, 0($s5) # store the chraacters in the temp string
        addiu $s0, $s0, 1
        addiu $s5, $s5, 1
        j result2_loop
        
     result2_done:
        la $a0, temp_string # move the address as an argument the the function
        jal fpStr_to_fpVal # convert to fp value
        swc1 $f0, 0($s4) # store it
        la $s5, temp_string # return to the beginning of the temp string
        move $a0, $s5
        jal clear_string # clear the string for the next use
        addiu $s4, $s4, 4 # go to next test result
        addiu $s0, $s0, 2 # move to next line (skip the \n character)
        beq $s6, 13, main_loop # if the char is CR (carriege return) then repeat the process (we reach end of line)
        beq $s6, 0, sff_done # if it's null termination then end the process
        
             
  sff_done:   
     # loading the resturn address ( in case of nested functions use)
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
#################################################################################################   
# function to clear a string (recieve the address of the string at $a0 )
clear_string:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     li $t1, 0 
        
  cs_loop:
     lb $t0, 0($a0)
     beq $t0, 0, cs_done
     sb $t1, 0($a0)
     addiu $a0, $a0, 1
     j cs_loop 
     
     
  cs_done:
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
#####################################################################################     
# function to print all medical tests
print_medical_tests:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     li $t1, 0
     
     li $t3, 0 # to store test index
     la $t4, patient_id
     
  pmt_loop:
     lw $t5, 0($t4)
     beq $t5, 0, pmt_done # stop when id=0 (end of the list)
     beq $t5, -1, pmt_deleted_id 
     move $a0, $t3 
     jal print_medical_test
     addiu $t4, $t4, 4 # go to next id
     addiu $t3, $t3, 1 # go to next index
     j pmt_loop
     
  pmt_deleted_id:
     addiu $t4, $t4, 4 # go to next id
     addiu $t3, $t3, 1 # go to next index
     j pmt_loop
           
  pmt_done:
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
################################################################################################      
# function to add a medical test
add_medical_test:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
 
     la $t0, num_medical_tests
     lw $s0, 0($t0) # s0 will store the number of current medical tests
     
     # read a patient id
     la $a0, enter_patient_id
     li $v0, 4
     syscall # for input message
     
     li $v0, 5
     syscall # read the id 
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, amt_invalid_id
     beq $v0, 1, amt_valid_id
     
  amt_invalid_id:
     la $a0, invalid_id_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     li $v0, 5
     syscall # read the id 
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, amt_invalid_id
     beq $v0, 1, amt_valid_id
     
  amt_valid_id: 
     #store the patient id
     move $v0, $t3 #$v0 = enterd id
     la $t0, patient_id
     move $t2, $s0 # t2 = num of current tests
     mul $t2, $t2, 4
     addu $t0, $t0, $t2 # to calculate the address of the next empty slot
     sw $v0, 0($t0) # store it
     
     #read test name
     la $a0, enter_test_name
     li $v0, 4
     syscall # for input message
     
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     move $t3, $a0 # store the name address in t3  
     #check the validity if the name
     jal validate_test_name
     beq $v0, 0, amt_invalid_name
     beq $v0, 1, amt_valid_name
     
  amt_invalid_name:
     la $a0, invalid_name_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     move $t3, $a0 # store the name address in t3  
     #check the validity if the name
     jal validate_test_name
     beq $v0, 0, amt_invalid_name
     beq $v0, 1, amt_valid_name
     
  amt_valid_name: 
     move $a0, $t3
     # store test name
     lw $t0, 0($a0) # $t0 takes the test name
     andi $t0, $t0, 0x00FFFFFF # clear the new line character read from user
     la $t3, test_name
     move $t2, $s0 # t2 = num of current tests
     mul $t2, $t2, 4
     addu $t3, $t3, $t2 # to calculate the address of the next empty slot
     sw $t0, 0($t3) # store it
     move $s2, $t3 ### s2 will store the address of the test name to check if it's BPT or not later
     
     # clear temp string for the next use
     la $a0, temp_string
     jal clear_string
     
     # read test date
     la $a0, enter_test_date
     li $v0, 4
     syscall # for input message
     
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     
     #store test date
     lw $t0, 0($a0) # load the first word
     la $t3, test_date
     move $t2, $s0 # t2 = num of current tests
     mul $t2, $t2, 8 # next empty slot for the new date
     addu $t3, $t3, $t2 # to calculate the address of the next empty slot
     sw $t0, 0($t3) # store the first word
     addiu $t3, $t3, 4  # address of next word in the array
     addiu $a0, $a0, 4 # address of next word in date string
     lw $t0, 0($a0) # load the second word
     andi $t0, $t0, 0x00FFFFFF # clear the new line character read from user
     sw $t0, 0($t3) # store the second word
     
     # clear temp string for the next use
     la $a0, temp_string
     jal clear_string
     
     # to add a test result we should check if the test takes two results (BPT) or one (others) 
     la $a0, Bpt_str # the "BPT" string
     move $a1, $s2 # the entered test name
     jal str_cmp
     beq $v0, 0, single_test_result
     beq $v0, 1, two_test_results
     
     
  single_test_result:
     #read test result
     la $a0, enter_test_result
     li $v0, 4
     syscall # for input message
     
     li $v0, 6
     syscall # the float is returned in $f0
     
     #store test result
     la $t0, test_result
     move $t2, $s0 # t2 = num of current tests
     mul $t2, $t2, 8
     addu $t0, $t0, $t2 # to calculate the address of the next empty slot
     swc1 $f0, 0($t0) # store it
     j amt_done
     
  two_test_results:
     #read test result num 1
     la $a0, enter_BPT_result1
     li $v0, 4
     syscall # for input message
     
     li $v0, 6
     syscall # the float is returned in $f0
     
     #store test result num1
     la $t0, test_result
     move $t2, $s0 # t2 = num of current tests
     mul $t2, $t2, 8
     addu $t0, $t0, $t2 # to calculate the address of the next empty slot
     swc1 $f0, 0($t0) # store it
     
     #read test result num 2
     la $a0, enter_BPT_result2
     li $v0, 4
     syscall # for input message
     
     li $v0, 6
     syscall # the float is returned in $f0
     
     #store test result num2
     addiu $t0, $t0, 4 # go to second result address
     swc1 $f0, 0($t0) # store it
  
      
  amt_done:   
     # increase number of medical tests
     la $t0, num_medical_tests
     lw $t1, 0($t0)
     addiu $t1, $t1, 1
     sw $t1, 0($t0)
     
     # print a message  
     la $a0, test_is_added_msg
     li $v0, 4
     syscall
         
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
###############################################################################################    
# function to comapre two strings ( address of str1 must be in $a0, and address of str2 in $a1, the result will be in $v0, 1 if equal, 0 otherwise)    
str_cmp:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     move $t8, $a0
     move $t9, $a1
     
     sc_loop:
         lb $t0, 0($a0) # characters of str1
         lb $t1, 0($a1) # characters of str2
         beq $t0, 0, str1_reach_zero
         bne $t0, $t1, different_str
         addiu $a0, $a0, 1
         addiu $a1, $a1, 1
         j sc_loop
         
     str1_reach_zero:
         beq $t1, 0, same_str
         bne $t1, 0, different_str
               
     different_str:
         li $v0, 0
         j sc_done 
         
     same_str:
         li $v0, 1
         j sc_done    
        
     sc_done:
         # return 
         move $a0, $t8
         move $a1, $t9   
         lw $ra, 0($sp)
         add $sp, $sp, 4
         jr $ra
###############################################################################################  
# function to print a test ( given it's index in $a0) 
print_medical_test:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     # storing number of existing medical tests
     la $t0, num_medical_tests
     lw $t1, 0($t0) # t1 = current num of medical tests
     beq $t1, 0, no_index_found # in the case there are not tests in the list 
     
     #checking if the index is valid
     subi $t1, $t1, 1 # sub 1 from tests to determine the last exist index in the list
     bgt $a0, $t1, no_index_found # in the case the target index greater than the last index then the index in invalid
     blt $a0, 0, no_index_found # in this case the index is negative
     move $s7, $a0 #store target index in $s7 (to avoid losing it's value)
     
     # print the test id
     la $s0, patient_id
     mul $t0, $s7, 4 # multiply index by 4 (id size)
     addu $s0, $s0, $t0 # add result to base address
     lw $a0, 0($s0)
     li $v0, 1
     syscall # print it
     
     # print a comma
     la $a0, comma_string
     li $v0, 4
     syscall
     
     # print test name
     la $s0, test_name
     mul $t0, $s7, 4
     addu $s0, $s0, $t0 # $s0 is the target address
     move $a0, $s0
     move $t7, $s0 # store the name address for later use (to check if it's BPT or not)
     li $v0, 4
     syscall # print it
     
     # print a comma
     la $a0, comma_string
     li $v0, 4
     syscall
     
     # print test date
     la $s0, test_date
     mul $t0, $s7, 8
     addu $s0, $s0, $t0 # $s0 is the target address
     move $a0, $s0
     li $v0, 4
     syscall # print it
     
     # print a comma
     la $a0, comma_string
     li $v0, 4
     syscall
     
     # print result1
     la $s0, test_result
     mul $t0, $s7, 8
     addu $s0, $s0, $t0 # $s0 is the target address
     lwc1 $f12, 0($s0)
     li $v0, 2
     syscall # print it
     
     # checking if the test is BPT or not
     move $a0, $t7 # a0 stores the test name address
     la $a1, Bpt_str
     jal str_cmp
     beq $v0, 0, single_result
     beq $v0, 1, two_results
     
  single_result:
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
     j pmtt_done
  
  two_results:
     # print a comma
     la $a0, comma_string
     li $v0, 4
     syscall
     
     # print second result
     addiu $s0, $s0, 4 # next result address
     lwc1 $f12, 0($s0)
     li $v0, 2
     syscall # print it
     
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
     j pmtt_done
     
                                                                   
  no_index_found:
     # print a messgae
     la $a0, index_not_found_msg
     li $v0, 4
     syscall
     
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
      
                                                                                                                      
  pmtt_done:   
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
##############################################################################################
# function to print all patient's tests ( the function asks user to enter an id)
retrieve_all_patient_tests:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     # read the id from user
     la $a0, enter_patient_id
     li $v0, 4
     syscall
     li $v0, 5
     syscall
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, rapt_invalid_id
     beq $v0, 1, rapt_valid_id
     
  rapt_invalid_id:
     la $a0, invalid_id_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     li $v0, 5
     syscall # read the id 
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, rapt_invalid_id
     beq $v0, 1, rapt_valid_id
     
  rapt_valid_id:
     move $v0, $t3
     move $a0, $v0
     move $t6, $a0 # $t6 store the target id
     li $s0, 0 # a flag register ( 1 if the id found and 0 if not found)
     
     # storing number of existing medical tests
     la $t0, num_medical_tests
     lw $t4, 0($t0) # t4 = current num of medical tests
     sub $t4, $t4, 1 # t4 = index of last mediacl test
     li $s1, 0 # s1 is the variable that keeps track of the indices
     la $s2, patient_id
     
  rapt_loop:
     bgt $s1, $t4, rapt_done
     lw $t2, 0($s2) # load the integer in $t2
     beq $t2, -1, rapt_deleted_id # in this case the if is -1 so the test is deleted so ignore it
     beq $t2, $t6, id_found
     addiu $s1, $s1, 1
     addiu $s2, $s2, 4
     j rapt_loop
  
  rapt_deleted_id: 
     addiu $s1, $s1, 1
     addiu $s2, $s2, 4
     j rapt_loop
           
  id_found:
     li $s0, 1 # set the found flag to 1
     move $a0, $s1 
     jal print_medical_test
     addiu $s1, $s1, 1
     addiu $s2, $s2, 4
     j rapt_loop
     
    
  rapt_done:
     beq $s0, 0, id_not_found
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
          
  id_not_found:
     # print a messgae
     la $a0, id_not_found_msg
     li $v0, 4
     syscall
     
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
####################################################################################################
# function to find the average test result for each medical test ( don't need ant arguments)
Average_test_value:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     # defining needed registers
     li $t0, 0
     mtc1 $t0, $f0 # f0 store the sum of Hgb test values
     cvt.s.w $f0, $f0
     mtc1 $t0, $f1 # f1 store the number of Hgb tests 
     cvt.s.w $f1, $f1
     mtc1 $t0, $f2 # f2 store the sum of BGT test values
     cvt.s.w $f2, $f2
     mtc1 $t0, $f3 # f3 store the number of BGT tests 
     cvt.s.w $f3, $f3
     mtc1 $t0, $f4 # f4 store the sum of LDL test values
     cvt.s.w $f4, $f4
     mtc1 $t0, $f5 # f5 store the number of LDL tests 
     cvt.s.w $f5, $f5
     mtc1 $t0, $f6 # f6 store the sum of BPT systolic test values
     cvt.s.w $f6, $f6
     mtc1 $t0, $f7 # f7 store the sum of BPT Diastolic test values
     cvt.s.w $f7, $f7
     mtc1 $t0, $f8 # f8 store the number of BPT tests 
     cvt.s.w $f8, $f8
     li $t0, 1
     mtc1 $t0, $f9
     cvt.s.w $f9, $f9 # $f9 = 1
     li $t0, 0
     mtc1 $t0, $f11
     cvt.s.w $f11, $f11 # $f9 = 0 (for later use)
     
     #####
     la $t0, test_name
     la $t1, test_result
     la $t5, patient_id

  atv_loop:
     lw $t6, 0($t5) # $t6 stores the id of each test
     lw $t2, 0($t0) # t1 = current test name
     beq $t6, -1, atv_deleted_test # in this case, the current test is deleted so ignore it
     beq $t6, 0, atv_done # exit loop when reach the end of list ( id = 0)
     beq $t2, 0x626748, Hgb_found
     beq $t2, 0x544742, BGT_found
     beq $t2, 0x4C444C, LDL_found
     beq $t2, 0x545042, BPT_found
     
   atv_deleted_test:
     addiu $t5, $t5, 4 # go to next id
     addiu $t0, $t0, 4 # go to next name
     addiu $t1, $t1, 8 # go to next result
     j atv_loop
     
   Hgb_found:
     lwc1 $f10, 0($t1) # f10 = the test result
     add.s $f0, $f0, $f10 # add it to Hgb sum
     add.s $f1, $f1, $f9 # add one to Hgb tests count
     addiu $t5, $t5, 4 # go to next id
     addiu $t0, $t0, 4 # go to next name
     addiu $t1, $t1, 8 # go to next result
     j atv_loop
   BGT_found:
     lwc1 $f10, 0($t1) # f10 = the test result
     add.s $f2, $f2, $f10 # add it to BGT sum
     add.s $f3, $f3, $f9 # add one to BGT tests count
     addiu $t5, $t5, 4 # go to next id
     addiu $t0, $t0, 4 # go to next name
     addiu $t1, $t1, 8 # go to next result
     j atv_loop  
   LDL_found:
     lwc1 $f10, 0($t1) # f10 = the test result
     add.s $f4, $f4, $f10 # add it to LDL sum
     add.s $f5, $f5, $f9 # add one to LDL tests count
     addiu $t5, $t5, 4 # go to next id
     addiu $t0, $t0, 4 # go to next name
     addiu $t1, $t1, 8 # go to next result
     j atv_loop
   BPT_found:
     lwc1 $f10, 0($t1) # f10 = the first test result
     add.s $f6, $f6, $f10 # add it to systolic sum
     addiu $t1, $t1, 4 # go to second result
     lwc1 $f10, 0($t1) # f10 = the second test result
     add.s $f7, $f7, $f10 # add it to diastolic sum
     add.s $f8, $f8, $f9 # add one to BPT tests count
     addiu $t1, $t1, 4 # go to next result
     addiu $t0, $t0, 4 # go to next name
     addiu $t5, $t5, 4 # go to next id
     j atv_loop
    
  atv_done:
     #print Hgb average value 
     # print a message
     la $a0, Hgb_avg_msg
     li $v0, 4
     syscall
     # check if sum is zero
     c.eq.s  $f0, $f11 # $f11 equal zero 
     bc1t Hgb_zero_sum
     div.s $f12, $f0, $f1# in this case the sum is not zero
     j Hgb_complete
   Hgb_zero_sum:
     mov.s $f12, $f11 # in case the sum is zero then print zero
   Hgb_complete:
     li $v0, 2
     syscall # print it
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
     
     #####
     #print BGT average value 
     # print a message
     la $a0, BGT_avg_msg
     li $v0, 4
     syscall
     # check if sum is zero
     c.eq.s $f2, $f11 # $f11 equal zero 
     bc1t BGT_zero_sum
     div.s $f12, $f2, $f3# in this case the sum is not zero
     j BGT_complete
   BGT_zero_sum:
     mov.s $f12, $f11 # in case the sum is zero then print zero
   BGT_complete:
     li $v0, 2
     syscall # print it
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
     
     #####
     #print LDL average value 
     # print a message
     la $a0, LDL_avg_msg
     li $v0, 4
     syscall
     # check if sum is zero
     c.eq.s  $f4, $f11 # $f11 equal zero 
     bc1t  LDL_zero_sum
     div.s $f12, $f4, $f5# in this case the sum is not zero
     j LDL_complete
   LDL_zero_sum:
     mov.s $f12, $f11 # in case the sum is zero then print zero
   LDL_complete:
     li $v0, 2
     syscall # print it
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
     
     #####
     #print BPT systolic average value 
     # print a message
     la $a0, BPT_sys_avg_msg
     li $v0, 4
     syscall
     # check if sum is zero
     c.eq.s  $f6, $f11 # $f11 equal zero 
     bc1t  BPTsys_zero_sum
     div.s $f12, $f6, $f8# in this case the sum is not zero
     j BPTsys_complete
   BPTsys_zero_sum:
     mov.s $f12, $f11 # in case the sum is zero then print zero
   BPTsys_complete:
     li $v0, 2
     syscall # print it
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
     
     #####
     #print BPT diastolic average value 
     # print a message
     la $a0, BPT_dias_avg_msg
     li $v0, 4
     syscall
     # check if sum is zero
     c.eq.s  $f7, $f11 # $f11 equal zero 
     bc1t  BPTdias_zero_sum
     div.s $f12, $f7, $f8# in this case the sum is not zero
     j BPTdias_complete
   BPTdias_zero_sum:
     mov.s $f12, $f11 # in case the sum is zero then print zero
   BPTdias_complete:
     li $v0, 2
     syscall # print it
     # print a new line 
     la $a0, new_line_str
     li $v0, 4
     syscall
        
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
############################################################################################
# function to convert the given date to a number ( for ex. the string date 2022-04 is converted to an integer 202204), given the string address in $a0 and return the integer in $v0
date_to_number:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     move $t0, $a0 # $t0 also stores the address of target string (temporar use fir removing the new line char)
     
     # removing the newline character at the end of the string (if exist) 
     rmv_newln_loop:
         lb $t1, 0($t0)
         beq $t1, 10, newln_found
         beq $t1, 0, rmv_newln_end 
         addiu $t0, $t0, 1
         j rmv_newln_loop
     newln_found:
         li $t2, 0
         sb $t2, 0($t0) # replace new line with null terminator
         j rmv_newln_end
         
     rmv_newln_end: 
     # converting the string to number
     li  $v0, 0 # v0 will store the result
     li $t0, 10 
     dtn_loop:
         lb $t1, 0($a0)
         beq $t1, '-', dash_found
         blt $t1, '0' dtn_done
         bgt $t1, '9', dtn_done
         addiu $t1, $t1, -48
         mul $v0, $v0, $t0
         addu $v0, $v0, $t1
         addiu $a0, $a0, 1
         j dtn_loop
     
     dash_found: # just skip it and return to loop
         addiu $a0, $a0, 1
         j dtn_loop
           
     dtn_done: 
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
##########################################################################################   
# function to print all patient's tests in a specific period ( the function asks user to enter the id and the period then pritns the results)
retrieve_patient_specific_period_tests:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     
     # read the id from user
     la $a0, enter_patient_id
     li $v0, 4
     syscall
     li $v0, 5
     syscall
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, rps_invalid_id
     beq $v0, 1, rps_valid_id
     
  rps_invalid_id:
     la $a0, invalid_id_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     li $v0, 5
     syscall # read the id 
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, rps_invalid_id
     beq $v0, 1, rps_valid_id
     
  rps_valid_id:
     move $v0, $t3
     move $a0, $v0
     move $t6, $a0 # $t6 store the target id
     li $s0, 0 # a flag register ( 1 if the id found and 0 if not found)
     
     # ask user to enter the start date
     la $a0, period_start_date_msg
     li $v0, 4
     syscall
     #read it
     la $a0, period_start_date #address
     li $a1, 10 # max buffer size
     li $v0, 8
     syscall
     
     # ask user to enter the end date
     la $a0, period_end_date_msg
     li $v0, 4
     syscall
     #read it
     la $a0, period_end_date #address
     li $a1, 10 # max buffer size
     li $v0, 8
     syscall
     
     # convert start date to number
     la $a0, period_start_date
     jal date_to_number
     move $s5, $v0 # $S5 stores the start date number
     
     # convert end date to number
     la $a0, period_end_date
     jal date_to_number
     move $s6, $v0 # $S6 stores the end date number
     
     bgt $s5, $s6, rps_illegal_period # in this case the user enters a start date greater than end date
    
     # storing number of existing medical tests
     la $t0, num_medical_tests
     lw $t4, 0($t0) # t4 = current num of medical tests
     sub $t4, $t4, 1 # t4 = index of last mediacl test
     
     li $s1, 0 # s1 is the variable that keeps track of the indices
     la $s2, patient_id
     
  rps_loop:
     bgt $s1, $t4, rps_done # in this case the current index is greater than the last index
     lw $t2, 0($s2) # load the integer in $t2
     beq $t2, -1, rps_deleted_id # in this case the current index is deleted so igonre it
     beq $t2, $t6, rps_id_found
     addiu $s1, $s1, 1
     addiu $s2, $s2, 4
     j rps_loop
  
  rps_deleted_id:
     addiu $s1, $s1, 1
     addiu $s2, $s2, 4
     j rps_loop
           
  rps_id_found:
     li $s0, 1 # set the found flag to 1
     # convert date of current test to number
       # to calculate the address of current test date
     mul $t0 $s1, 8 
     la $a0, test_date
     addu $a0, $a0, $t0
     jal date_to_number
     move $s7, $v0 # $s7 stores the date number of current test
     
     #checking if the current test date matches the required period or not
     blt $s7, $s5, period_mismatch # in this case the current test date is less than the start date
     bgt $s7, $s6, period_mismatch # in this case the current test date is greater than the end date
     j period_match # in this case the current test date matches the period
     
   period_mismatch:
   # go to next medical test
     addiu $s1, $s1, 1 
     addiu $s2, $s2, 4
     j rps_loop
      
   period_match:
   # print the test   
     move $a0, $s1 
     jal print_medical_test
     addiu $s1, $s1, 1
     addiu $s2, $s2, 4
     j rps_loop
        
  rps_done:
     beq $s0, 0, rps_id_not_found
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
     
  rps_illegal_period:
     # print a messgae
     la $a0, illegal_period_msg
     li $v0, 4
     syscall
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
          
  rps_id_not_found:
     # print a messgae
     la $a0, id_not_found_msg
     li $v0, 4
     syscall 
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
###########################################################################





# function to validate the id enterd by user ( the id should be in $a0, the result will be in $v0, 1 if valid, 0 otherwise)
validate_id:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     la $t0, id_lower_limit
     lw $t1, 0($t0) # store the lower limit of id in t1
     la $t0, id_upper_limit
     lw $t2, 0($t0) # store the upper limit of id in t2
     
     blt $a0, $t1, vi_invalid_id 
     bgt $a0, $t2, vi_invalid_id
     j vi_valid_id
     
   vi_invalid_id:
     li $v0, 0
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
     
   vi_valid_id:
     li $v0, 1
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
################################################################################     
# function to validate the enterd test name from user( the address of entered test name must be in $a0 and the result will be $v0, 1 if valid , 0 if not)
validate_test_name:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     move $t0, $a0 # $t0 also stores the address of entered string (temporar use for removing the new line char)   
     # removing the newline character at the end of the entered string 
     vtn_rmv_newln_loop:
         lb $t1, 0($t0)
         beq $t1, 10, vtn_newln_found
         beq $t1, 0, vtn_rmv_newln_end 
         addiu $t0, $t0, 1
         j vtn_rmv_newln_loop
     vtn_newln_found:
         li $t2, 0
         sb $t2, 0($t0) # replace new line with null terminator
         j vtn_rmv_newln_end
         
     vtn_rmv_newln_end:
     # checking if valid name or not
     # check if Hgb
     la $a1, Hgb_str
     jal str_cmp
     beq $v0, 1, vtn_valid_name # if equal, then it's valid id, if not, check next test
     
     # check if BGT
     la $a1, BGT_str
     jal str_cmp
     beq $v0, 1, vtn_valid_name # if equal, then it's valid id, if not, check next test
     
     # check if BPT
     la $a1, Bpt_str
     jal str_cmp
     beq $v0, 1, vtn_valid_name # if equal, then it's valid id, if not, then it's invalid
     
     # check if LDL
     la $a1, LDL_str
     jal str_cmp
     beq $v0, 1, vtn_valid_name # if equal, then it's valid id, if not, check next test
     
     
     # if all tests fail then it's not valid
     li $v0, 0
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra

     vtn_valid_name:
     li $v0, 1
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
######################################################################
# function to delete a medical test ( the id of the deleted test will be -1 )
delete_medical_test:
     # storing the return address ( in case of nested functions use)
     sub $sp, $sp, 4
     sw $ra, 0($sp)
     
     jal print_medical_tests # display all medical tests to choose from them
     
     # ask user to enter the id of the chosen test
     la $a0, enter_patient_id
     li $v0, 4
     syscall
     li $v0, 5
     syscall
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity of the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, dmt_invalid_id
     beq $v0, 1, dmt_valid_id
     
  dmt_invalid_id:
     la $a0, invalid_id_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     li $v0, 5
     syscall # read the id 
     move $t3, $v0 # $t3 to keep the enterd id
     #check the validity if the id
     move $a0, $v0
     jal validate_id
     beq $v0, 0, dmt_invalid_id
     beq $v0, 1, dmt_valid_id
     
  dmt_valid_id:
     move $s0, $t3 # s0 store the entered id
     
     # ask user to enter the test name of the chosen test
     la $a0, enter_test_name
     li $v0, 4
     syscall # for input message 
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     move $t3, $a0 # store the name address in t3  
     #check the validity if the name
     jal validate_test_name
     beq $v0, 0, dmt_invalid_name
     beq $v0, 1, dmt_valid_name
     
  dmt_invalid_name:
     la $a0, invalid_name_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     move $t3, $a0 # store the name address in t3  
     #check the validity if the name
     jal validate_test_name
     beq $v0, 0, dmt_invalid_name
     beq $v0, 1, dmt_valid_name
     
  dmt_valid_name: 
     move $a0, $t3
     lw $t0, 0($a0) # $t0 takes the test name
     andi $t0, $t0, 0x00FFFFFF # clear the new line character read from user
     move $s1, $t0 # s1 store the entered test name
     
     # ask user to enter the date of the chosen test
     # read test date
     la $a0, enter_test_date
     li $v0, 4
     syscall # for input message
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     # removing new line character from the date
     addiu $a0, $a0, 4 # go to second word in the date
     lw $t0, 0($a0) # t0 takes the second word
     andi $t0, $t0, 0x00FFFFFF # remove the new line from it
     sw $t0, 0($a0) # store it back
     subi $a0, $a0, 4 # return to the base address
     move $s2, $a0 # s2 store the address of the entered date
     
     la $s3, patient_id
     la $s4, test_name
     la $s5, test_date
     li $s6, 0 # s6 is a flag bit to check if the target test is found or not ( 1 if found, 0 if not)
     
   dmt_loop:
     lw $t0, 0($s3) # t = id of current test
     beq $t0, 0, dmt_done # in this case we reach the end of list
     beq $t0, $s0, dmt_id_found # in this casem the current id matches the needed id
     addiu $s3, $s3, 4 # go to next id
     addiu $s4, $s4, 4 # go to next name
     addiu $s5, $s5, 8 # go to next date
     j dmt_loop
     
   dmt_id_found: # if the id match then check the name
     lw $t0, 0($s4) # t0 = name of current test
     beq $t0, $s1, dmt_name_found  # in this case the current name matches the needed name
     # if not equal, then go to next test 
     addiu $s3, $s3, 4 # go to next id
     addiu $s4, $s4, 4 # go to next name
     addiu $s5, $s5, 8 # go to next date
     j dmt_loop
     
   dmt_name_found:# if the name match then check the date
     la $a0, 0($s5) # a0 = address of current test date
     move $a1, $s2 # a1 = address of needed test date
     jal str_cmp # compare them
     beq $v0, 1, dmt_date_found # in this case the current date matches the needed date
     # if not match, then go to next test 
     addiu $s3, $s3, 4 # go to next id
     addiu $s4, $s4, 4 # go to next name
     addiu $s5, $s5, 8 # go to next date
     j dmt_loop
    
   dmt_date_found: # in this case the date is found, thus the current test is the chosen test from user  
     lw $t0, 0 ($s3) # t0 = id of current test
     li $t0, -1 # just assing -1 to the id
     sw $t0, 0 ($s3) # store it back
     li $s6, 1 # set the flag bit to one ( test is found)
     
   dmt_done:
     la $a0, temp_string 
     jal clear_string # clear the temp string for the next use
     beq $s6, 0, dmt_test_not_found 
     beq $s6, 1, dmt_test_found 
     
   dmt_test_not_found: # if the test is not found then print a message and return 
     la $a0, test_not_found_msg
     li $v0, 4
     syscall # for the message
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra
     
   dmt_test_found:
     la $a0, test_is_deleted_msg
     li $v0, 4
     syscall # for the message
     # return    
     lw $ra, 0($sp)
     add $sp, $sp, 4
     jr $ra

##################################################################
# Function to update the results of a medical test
update_medical_tests:
    # Storing the return address
    sub $sp, $sp, 4
    sw $ra, 0($sp)
    
    # Display all medical tests to choose from them
    jal print_medical_tests
    
    # Ask the user to enter the ID of the chosen test
    la $a0, enter_patient_id
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t3, $v0  # $t3 to keep the entered ID
    
    # Check the validity of the ID
    move $a0, $v0
    jal validate_id
    beq $v0, 0, umt_invalid_id
    beq $v0, 1, umt_valid_id
    
umt_invalid_id:
    la $a0, invalid_id_msg  # Ask the user to enter it again
    li $v0, 4
    syscall  # For input message
    li $v0, 5
    syscall  # Read the ID
    move $t3, $v0  # $t3 to keep the entered ID
    # Check the validity of the ID
    move $a0, $v0
    jal validate_id
    beq $v0, 0, umt_invalid_id
    beq $v0, 1, umt_valid_id
    
umt_valid_id:
    move $s0, $t3  # $s0 stores the entered ID
    
    # Ask the user to enter the test name of the chosen test
    la $a0, enter_test_name
    li $v0, 4
    syscall  # For input message 
    la $a0, temp_string  # Input buffer
    li $a1, 12  # Max length
    li $v0, 8
    syscall
    move $t3, $a0  # Store the name address in $t3
    # Check the validity of the name
    jal validate_test_name
    beq $v0, 0, umt_invalid_name
    beq $v0, 1, umt_valid_name
    
umt_invalid_name:
    la $a0, invalid_name_msg  # Ask the user to enter it again
    li $v0, 4
    syscall  # For input message
    la $a0, temp_string  # Input buffer
    li $a1, 12  # Max length
    li $v0, 8
    syscall
    move $t3, $a0  # Store the name address in $t3
    # Check the validity of the name
    jal validate_test_name
    beq $v0, 0, umt_invalid_name
    beq $v0, 1, umt_valid_name
    
umt_valid_name: 
    move $a0, $t3
    lw $t0, 0($a0)  # $t0 takes the test name
    andi $t0, $t0, 0x00FFFFFF  # Clear the newline character read from the user
    move $s1, $t0  # $s1 stores the entered test name
    
    # Ask the user to enter the date of the chosen test
    la $a0, enter_test_date
    li $v0, 4
    syscall  # For input message
    la $a0, temp_string  # Input buffer
    li $a1, 12  # Max length
    li $v0, 8
    syscall
    # Removing the newline character from the date
    addiu $a0, $a0, 4  # Go to second word in the date
    lw $t0, 0($a0)  # $t0 takes the second word
    andi $t0, $t0, 0x00FFFFFF  # Remove the newline from it
    sw $t0, 0($a0)  # Store it back
    subi $a0, $a0, 4  # Return to the base address
    move $s2, $a0  # $s2 stores the address of the entered date
    
    # Search for the test with the matching ID, name, and date
    la $s3, patient_id
    la $s4, test_name
    la $s5, test_date
        la $s7, test_result
    li $s6, 0  # $s6 is a flag bit to check if the target test is found or not (1 if found, 0 if not)
    
umt_loop:
    lw $t0, 0($s3)  # $t0 = ID of current test
    beq $t0, 0, umt_done  # In this case, we reach the end of the list
    beq $t0, $s0, umt_id_found  # In this case, the current ID matches the needed ID
    addiu $s3, $s3, 4  # Go to next ID
    addiu $s4, $s4, 4  # Go to next name
    addiu $s5, $s5, 8  # Go to next date
        addiu $s7, $s7, 8  # Go to next date
    j umt_loop
    
umt_id_found:  # If the ID matches, then check the name
    lw $t0, 0($s4)  # $t0 = Name of current test
    beq $t0, $s1, umt_name_found  # In this case, the current name matches the needed name
    # If not equal, then go to next test 
    addiu $s3, $s3, 4  # Go to next ID
    addiu $s4, $s4, 4  # Go to next name
    addiu $s5, $s5, 8  # Go to next date
           addiu $s7, $s7, 8  # Go to next date
    j umt_loop
    
umt_name_found:  # If the name matches, then check the date
    la $a0, 0($s5)  # $a0 = Address of current test date
    move $a1, $s2  # $a1 = Address of needed test date
    jal str_cmp  # Compare them
    beq $v0, 1, umt_date_found  # In this case, the current date matches the needed date
    # If not a match, then go to the next test 
    addiu $s3, $s3, 4  # Go to next ID
    addiu $s4, $s4, 4  # Go to next name
    addiu $s5, $s5, 8  # Go to next date
            addiu $s7, $s7, 8  # Go to next date
    j umt_loop
    
umt_date_found:  # In this case, the date is found, thus the current test is the chosen test from the user  

	 # Call the string compare function for BPT
    la $a0, Bpt_str        # Load the first string (BPT_str)
    move $a1,$s4
    jal str_cmp            # Compare the strings
    beq $v0, 1, BPT_update_result  # Branch if equal to 1 (strings are equal)
    
    

    # Ask the user for the new test result
    # Example: Prompt the user to enter the new test result
    la $a0, enter_test_result
    li $v0, 4
    syscall

    # Read the new test result
    li $v0, 6
    syscall                  # The float is returned in $f0

    # Store the new test result in register

    # Store the new test result in register
    mov.s $f1, $f0
    # Store the new test result back into the address stored in $s7
    swc1 $f1, 0($s7)

    li $s6, 1
    j umt_done
    
BPT_update_result:
      la $a0, enter_BPT_result1
    li $v0, 4
    syscall

    # Read the new test result
    li $v0, 6
    syscall                  # The float is returned in $f0
     # Store the second new test result in register
    mov.s $f2, $f0
        swc1 $f2, 0($s7)
      la $a0, enter_BPT_result2
    li $v0, 4
    syscall
        li $v0, 6
    syscall    
        mov.s $f1, $f0
        addi $s7,$s7,4
        swc1 $f1, 0($s7)
    li $s6, 1
    
umt_done:
    la $a0, temp_string 
    jal clear_string  # Clear the temp string for the next use
    beq $s6, 0, umt_test_not_found 
    beq $s6, 1, umt_test_found 
    
umt_test_not_found:  # If the test is not found then print a message and return 
    la $a0, test_not_found_msg
    li $v0, 4
    syscall  # For the message
    # Return    
    lw $ra, 0($sp)
    add $sp, $sp, 4
    jr $ra
    
umt_test_found:
    la $a0, test_is_updated_msg
    li $v0, 4
    syscall  # For the message
    # Return    
    lw $ra, 0($sp)
    add $sp, $sp, 4
    jr $ra

###############################################################################################################
# function to retireve all upnormal tests for a specific id  
Retrieve_all_upnormal_patient_by_id:
    # Storing the return address (in case of nested functions)
    sub $sp, $sp, 4
    sw $ra, 0($sp)

    # Prompt user for ID
    li $v0, 4
    la $a0, enter_patient_id
    syscall

    # Read user input (ID)
    li $v0, 5
    syscall
        move $t3, $v0  # $t3 to keep the entered ID
    
    # Check the validity of the ID
    move $a0, $v0
    jal validate_id
    beq $v0, 0, raup_invalid_id
    beq $v0, 1, raup_valid_id
    
raup_invalid_id:
    la $a0, invalid_id_msg  # Ask the user to enter it again
    li $v0, 4
    syscall  # For input message
    li $v0, 5
    syscall  # Read the ID
    move $t3, $v0  # $t3 to keep the entered ID
    # Check the validity of the ID
    move $a0, $v0
    jal validate_id
    beq $v0, 0, raup_invalid_id
    beq $v0, 1, raup_valid_id
    
raup_valid_id:
    move $v0, $t3  # $s0 stores the entered ID
    move $t6,$v0

    # Storing number of existing medical tests
    la $t1, num_medical_tests
    lw $t3, 0($t1)          # $t3 = current num of medical tests

    # Load test name from test_name array
    la $t4, test_name

    move $t2, $zero         # Initialize loop counter to 0
    la $a3, test_result
        la $a2,patient_id

iterate_tests_retrieve:
    li $s6, 0              # Initialize flag to 0

    # Check if loop counter exceeds the number of tests
    bge $t2, $t3, end_iteration_retrieve

    # Load the ID of the current test

    lw $s2, 0($a2)

    # Check if the ID matches the user input
    move $s0,$t6
    bne $s0,$s2 iterate_next_test_retrieve
    

    move $a1,$t4
    # If it's not BPT, check if it's BGT
    la $a0, BGT_str        # Load the first string (BGT_str)
    li $v0, 4              # Load syscall code for printing string

    jal str_cmp            # Compare the strings
    beq $v0, 1, BGT_check_retrieve  # Branch if equal to 1 (strings are equal)

    # Call the string compare function for BPT
    la $a0, Bpt_str        # Load the first string (BPT_str)
    jal str_cmp            # Compare the strings
    beq $v0, 1, BPT_check_retrieve  # Branch if equal to 1 (strings are equal)
    

    # If it's not BGT, check if it's HGB
    la $a0, Hgb_str        # Load the first string (HGB_str)
    jal str_cmp            # Compare the strings
    beq $v0, 1, Hgb_check_retrieve  # Branch if equal to 1 (strings are equal)

    # If it's not HGB, check if it's LDL
    la $a0, LDL_str        # Load the first string (LDL_str)
    jal str_cmp            # Compare the strings
    beq $v0, 1, LDL_check_retrieve  # Branch if equal to 1 (strings are equal)

    j iterate_next_test_retrieve    # Otherwise, jump to the next test

Hgb_check_retrieve:
    # Load Hemoglobin level from test result array
    lwc1 $f16, 0($a3)   # Load Hemoglobin level into a floating-point register

    # Load upper and lower limits for Hemoglobin into floating-point registers
    l.s $f14, upper_limit_hgb
    l.s $f15, lower_limit_hgb
    
    # Check if Hemoglobin level is within normal range
    c.lt.s $f16, $f15    # Compare with lower limit
    bc1t hgb_upnormal_retrieve  # Branch if less than lower limit
    c.le.s $f14, $f16    # Compare with upper limit
    bc1t hgb_upnormal_retrieve  # Branch if greater than or equal to upper limit
    j iterate_next_test_retrieve

LDL_check_retrieve:
    # Load LDL Cholesterol level from test result array
    lwc1 $f16, 0($a3)   # Load LDL Cholesterol level into a floating-point register

    # Load upper limit for LDL Cholesterol into a floating-point register
    l.s $f14, upper_limit_ldl
    
    # Check if LDL Cholesterol level is within normal range
    c.le.s $f14, $f16    # Compare with upper limit
    bc1t ldl_upnormal_retrieve  # Branch if greater than or equal to upper limit
    j iterate_next_test_retrieve

hgb_upnormal_retrieve:
    # If Hemoglobin level is not within normal range, print and go to the next test
    jal print_test_retrieve           # Print the test
    j iterate_next_test_retrieve     # Jump to the next test

ldl_upnormal_retrieve:
    # If LDL Cholesterol level is not within normal range, print and go to the next test
    jal print_test_retrieve           # Print the test
    j iterate_next_test_retrieve     # Jump to the next test

BGT_check_retrieve:
    # Load blood glucose level from test result array
    lwc1 $f26, 0($a3)   # Load blood glucose level into a floating-point register

    # Load upper and lower limits for blood glucose into floating-point registers
    l.s $f24, upper_limit_bgt
    l.s $f25, lower_limit_bgt
    
    # Check if blood glucose level is within normal range
    c.lt.s $f26, $f25    # Compare with lower limit
    bc1t blood_glucose_upnormal_retrieve  # Branch if less than lower limit
    c.le.s $f24, $f26    # Compare with upper limit
    bc1t blood_glucose_upnormal_retrieve  # Branch if greater than or equal to upper limit
    j iterate_next_test_retrieve

blood_glucose_upnormal_retrieve:
    # If blood glucose level is normal, continue to print the test
    jal print_test_retrieve
    j iterate_next_test_retrieve

        
less_than_upper_retrieve:
    # Handle if diastolic pressure is more than the upper limit
    j iterate_next_test_retrieve

greater_than_lower_retrieve:
    # Handle if diastolic pressure is more than the upper limit
    j iterate_next_test_retrieve
BPT_check_retrieve:
    li $s6,0

    lwc1 $f16, 0($a3)       # Load systolic pressure into a floating-point register
    addi $a3, $a3, 4
    lwc1 $f18, 0($a3)       # Load diastolic pressure into a floating-point register
	    subi $a3, $a3, 4
    l.s $f20, upper_limit_systolic_bpt   # Load upper limit for systolic pressure
    l.s $f22, upper_limit_diastolic_bpt  # Load upper limit for diastolic pressure
    
    # Check if systolic pressure is within normal range
    c.le.s $f20, $f16        # Compare with upper limit for systolic pressure
    bc1t more_than_systolic_retrieve  # Branch if greater than or equal to upper limit
    c.le.s $f22, $f18        # Compare with upper limit for diastolic pressure
    bc1t more_than_diastolic_retrieve  # Branch if greater than or equal to upper limit
    beq $s6,0,iterate_next_test_retrieve
    beq $s6,1,upnormal_retrieve

more_than_systolic_retrieve:
    li $s6,1

more_than_diastolic_retrieve:
    li $s6,1

upnormal_retrieve:
    # Check if diastolic pressure is within normal range
    j print_test_retrieve     # Branch if $t5 <= $t8
    li $s6,0
    j iterate_next_test_retrieve

print_test_retrieve:
    # If both systolic and diastolic pressures are normal, print the medical test
    move $a0, $t2           # Pass current loop counter to $a0
    jal print_medical_test

iterate_next_test_retrieve:
    addi $t2, $t2, 1        # Increment the loop counter for the test name
    addi $t4, $t4, 4        # Move to the next test name
    addi $a3, $a3, 8        # Move to the next test result
    addi $a2, $a2, 4        # Move to the next test ID

    # Check if we have reached the end of the tests
    blt $t2, $t3, iterate_tests_retrieve  # If not, continue iterating
    j end_iteration_retrieve          # If all tests have been checked, end the iteration


end_iteration_retrieve:
    # Restore the return address and return
  lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra



##############################################################################################
# function to retreive all upnormal tests by name
retrieve_all_upnormal_patient_by_name:
    # Storing the return address (in case of nested functions)
    sub $sp, $sp, 4
    sw $ra, 0($sp)
    
     # Prompt user for test name
    li $v0, 4
    la $a0, enter_test_name
    syscall
    
    # Read user input (test name)
    li $v0, 8
    la $a0, temp_string
    li $a1, 32
    syscall
    move $t3, $a0 # store the name address in t3  
     #check the validity if the name
     jal validate_test_name
     beq $v0, 0, raun_invalid_name
     beq $v0, 1, raun_valid_name
     
  raun_invalid_name:
     la $a0, invalid_name_msg # ask user to enter it again
     li $v0, 4
     syscall # for input message
     la $a0, temp_string # input buffer
     li $a1, 12 #max length
     li $v0, 8
     syscall
     move $t3, $a0 # store the name address in t3  
     #check the validity if the name
     jal validate_test_name
     beq $v0, 0, raun_invalid_name
     beq $v0, 1, raun_valid_name
     
  raun_valid_name: 
     move $a0, $t3
    
    # Clear the newline character from the input string
    la $t0, temp_string   # Load the address of the input string
    lw $t1, 0($t0)        # Load the first character of the string
    andi $t1, $t1, 0x00FFFFFF   # Clear the newline character
    sw $t1, 0($t0)        # Store the cleaned character back into the string




    # Storing number of existing medical tests
    la $t1, num_medical_tests
    lw $t3, 0($t1)          # $t3 = current num of medical tests

    # Load test name from test_name array
    la $t4, test_name

    move $t2, $zero         # Initialize loop counter to 0
    la $a3, test_result
    la $a2,patient_id

iterate_tests_retrieve_by_name:
    li $s6, 0              # Initialize flag to 0

    # Check if loop counter exceeds the number of tests
    bge $t2, $t3, end_iteration_retrieve_by_name



    # Compare the test name with the user input
    la $a0, temp_string
    # Check if the test name matches the user input

    move $a1,$t4
    # Compare the test names
    jal str_cmp

    beq $v0, 0, iterate_next_test_retrieve_by_name  # If not equal, go to the next test

    move $a1,$s2
	 
	 move $a1,$t4
    # If it's not BPT, check if it's BGT
    la $a0, BGT_str        # Load the first string (BGT_str)
    jal str_cmp            # Compare the strings

    beq $v0, 1, BGT_check_retrieve_by_name  # Branch if equal to 1 (strings are equal)



    # Call the string compare function for BPT
    la $a0, Bpt_str        # Load the first string (BPT_str)
    jal str_cmp            # Compare the strings
    beq $v0, 1, BPT_check_retrieve_by_name  # Branch if equal to 1 (strings are equal)
    

    # If it's not BGT, check if it's HGB
    la $a0, Hgb_str        # Load the first string (HGB_str)
    jal str_cmp            # Compare the strings
    beq $v0, 1, Hgb_check_retrieve_by_name  # Branch if equal to 1 (strings are equal)

    # If it's not HGB, check if it's LDL
    la $a0, LDL_str        # Load the first string (LDL_str)
    jal str_cmp            # Compare the strings
    beq $v0, 1, LDL_check_retrieve_by_name  # Branch if equal to 1 (strings are equal)

    j iterate_next_test_retrieve_by_name    # Otherwise, jump to the next test

Hgb_check_retrieve_by_name:
    # Load Hemoglobin level from test result array
    lwc1 $f16, 0($a3)   # Load Hemoglobin level into a floating-point register

    # Load upper and lower limits for Hemoglobin into floating-point registers
    l.s $f14, upper_limit_hgb
    l.s $f15, lower_limit_hgb
    
    # Check if Hemoglobin level is within normal range
    c.lt.s $f16, $f15    # Compare with lower limit
    bc1t hgb_upnormal_retrieve_by_name  # Branch if less than lower limit
    c.le.s $f14, $f16    # Compare with upper limit
    bc1t hgb_upnormal_retrieve_by_name  # Branch if greater than or equal to upper limit
    j iterate_next_test_retrieve_by_name

LDL_check_retrieve_by_name:
    # Load LDL Cholesterol level from test result array
    lwc1 $f16, 0($a3)   # Load LDL Cholesterol level into a floating-point register

    # Load upper limit for LDL Cholesterol into a floating-point register
    l.s $f14, upper_limit_ldl
    
    # Check if LDL Cholesterol level is within normal range
    c.le.s $f14, $f16    # Compare with upper limit
    bc1t ldl_upnormal_retrieve_by_name  # Branch if greater than or equal to upper limit
    j iterate_next_test_retrieve_by_name

hgb_upnormal_retrieve_by_name:
    # If Hemoglobin level is not within normal range, print and go to the next test
    jal print_test_retrieve_by_name           # Print the test
    j iterate_next_test_retrieve_by_name     # Jump to the next test

ldl_upnormal_retrieve_by_name:
    # If LDL Cholesterol level is not within normal range, print and go to the next test
    jal print_test_retrieve_by_name           # Print the test
    j iterate_next_test_retrieve_by_name     # Jump to the next test

BGT_check_retrieve_by_name:
	# Prompt user for test name

	
    # Load blood glucose level from test result array
    lwc1 $f26, 0($a3)   # Load blood glucose level into a floating-point register

    # Load upper and lower limits for blood glucose into floating-point registers
    l.s $f24, upper_limit_bgt
    l.s $f25, lower_limit_bgt
    
    # Check if blood glucose level is within normal range
    c.lt.s $f26, $f25    # Compare with lower limit
    bc1t blood_glucose_upnormal_retrieve_by_name  # Branch if less than lower limit
    c.le.s $f24, $f26    # Compare with upper limit
    bc1t blood_glucose_upnormal_retrieve_by_name  # Branch if greater than or equal to upper limit
    j iterate_next_test_retrieve_by_name

blood_glucose_upnormal_retrieve_by_name:
    # If blood glucose level is normal, continue to print the test
    jal print_test_retrieve_by_name
    j iterate_next_test_retrieve_by_name

        
less_than_upper_retrieve_by_name:
    # Handle if diastolic pressure is more than the upper limit
    j iterate_next_test_retrieve_by_name

greater_than_lower_retrieve_by_name:
    # Handle if diastolic pressure is more than the upper limit
    j iterate_next_test_retrieve_by_name
BPT_check_retrieve_by_name:
    li $s6,0

    lwc1 $f16, 0($a3)       # Load systolic pressure into a floating-point register
   addi $a3, $a3, 4
    lwc1 $f18, 0($a3)       # Load diastolic pressure into a floating-point register
   subi $a3, $a3, 4
    l.s $f20, upper_limit_systolic_bpt   # Load upper limit for systolic pressure
    l.s $f22, upper_limit_diastolic_bpt  # Load upper limit for diastolic pressure
    
    # Check if systolic pressure is within normal range
    c.le.s $f20, $f16        # Compare with upper limit for systolic pressure
    bc1t more_than_systolic_retrieve_by_name  # Branch if greater than or equal to upper limit
    c.le.s $f22, $f18        # Compare with upper limit for diastolic pressure
    bc1t more_than_diastolic_retrieve_by_name  # Branch if greater than or equal to upper limit
    beq $s6,0,iterate_next_test_retrieve_by_name
    beq $s6,1,upnormal_retrieve_by_name

more_than_systolic_retrieve_by_name:
    li $s6,1

more_than_diastolic_retrieve_by_name:
    li $s6,1

upnormal_retrieve_by_name:
    # Check if diastolic pressure is within normal range
    j print_test_retrieve_by_name     # Branch if $t5 <= $t8
    li $s6,0
    j iterate_next_test_retrieve_by_name

print_test_retrieve_by_name:
    # If both systolic and diastolic pressures are normal, print the medical test
    move $a0, $t2           # Pass current test name to $a0
    jal print_medical_test

iterate_next_test_retrieve_by_name:
    addi $t2, $t2, 1        # Increment the loop counter for the test name
    addi $t4, $t4, 4        # Move to the next test name
    addi $a3, $a3, 8        # Move to the next test result
    addi $a2, $a2, 4        # Move to the next test ID

    # Check if we have reached the end of the tests
    blt $t2, $t3, iterate_tests_retrieve_by_name  # If not, continue iterating
    j end_iteration_retrieve_by_name          # If all tests have been checked, end the iteration

end_iteration_retrieve_by_name:
    # Restore the return address and return
     lw $ra, 0($sp)
     addi $sp, $sp, 4
     jr $ra
##################################################################



