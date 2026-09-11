from pathlib import PurePosixPath
MEMORY_OPS={
    "LOAD" : "1",
    "STORE" : "0"    
}
ALU_OPS = {
    "NOT" : "000",
    "AND" : "001",
    "OR" : "010",
    "NAND" : "011",
    "NOR" : "100",
    "XOR" : "101",
    "ADD" : "110",
    "SUB" : "111"
}
R_REG_ADDRESS = {
    "R1" : "00",
    "R2" : "01",
    "R3" : "10",
    "R4" : "11"
}

def get_bin_file(file_path) :
    bin_write = ""
    line_num = 0

    with open(file_path, "r") as f:
        lines = f.readlines()

        for line in lines :
            line_num += 1
            parts = line.split()

            if len(parts) != 2 and len(parts) != 3 :
                return None, f"Invalid Number of instructions (white spaces) in line {line_num}"


            if parts[0].upper() in MEMORY_OPS :
                if parts[1].upper() not in R_REG_ADDRESS :
                    return None, f"Invalid R Register Address in line {line_num}"
                else :
                    bin_write = bin_write + "0" + MEMORY_OPS.get(parts[0].upper()) + R_REG_ADDRESS.get(parts[1].upper()) + parts[2] + "\n"

            elif parts[0].upper() in ALU_OPS :
                    if ALU_OPS.get(parts[0].upper()) == "000" :
                        if len(parts) != 2 :
                            return None, f"Invalid Syntax for NOT instruction in line {line_num}, must have only 1 R register"
                        else:
                            if parts[1].upper() not in R_REG_ADDRESS :
                                return None, f"Invalid R Register Address in line {line_num}"
                            else:
                                bin_write = bin_write + "1" + ALU_OPS.get(parts[0].upper()) + R_REG_ADDRESS.get(parts[1].upper()) + R_REG_ADDRESS.get(parts[1].upper()) + "\n"
                    else :
                        if parts[1].upper() not in R_REG_ADDRESS or parts[2].upper() not in R_REG_ADDRESS:
                            return None, f"Invalid R Register Address in line {line_num}"
                        else :
                            bin_write = bin_write + "1" + ALU_OPS.get(parts[0].upper()) + R_REG_ADDRESS.get(parts[1].upper()) + R_REG_ADDRESS.get(parts[2].upper()) + "\n"

            else :
                return None, f"Unidentified Command in line {line_num}"

    return bin_write, None