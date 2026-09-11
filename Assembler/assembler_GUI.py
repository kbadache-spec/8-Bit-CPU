import assembler
import tkinter as tk
from tkinter import filedialog
from pathlib import PurePosixPath

file_path = ""


def get_file():
    global file_path

    save_frame.pack_forget()
    confirmation_frame.pack_forget()


    file_path = filedialog.askopenfilename(
        title = "upload a .asm file (in a compatible format)",
        filetypes=[
            (".asm files", "*.asm")
        ],
    )
    if file_path :
        upload_button.pack_forget()
        text = ""
        with open(file_path) as file :
            lines = file.readlines()
            for line in lines :
                text = text + line
        text_box.config(state="normal", fg="black")
        text_box.delete("1.0", tk.END)
        text_box.insert("1.0", text)
        text_box.config(state="disabled")
        confirmation_label.config(text=f"""are you sure you want to submit "{PurePosixPath(str(file)).stem + ".asm"}" """)
        confirmation_frame.pack()

def get_bin_file() :
    text, error = assembler.get_bin_file(file_path)

    confirmation_frame.pack_forget()
    if error is None:
        text_box.config(state = "normal", fg="black")
        text_box.delete("1.0", tk.END)
        text_box.insert("1.0", text)
        text_box.config(state="disabled")

        save_frame.pack()
    else :
        text_box.config(state = "normal", fg="red")
        text_box.delete("1.0", tk.END)
        text_box.insert("1.0", error)
        text_box.config(state="disabled")
    
    upload_button.config(text = "upload another .asm file")
    upload_button.pack()

def save_bin() :
    file_path = filedialog.asksaveasfilename(initialdir="/", title="Save as .bin file", filetypes=[("Binary files", "*.bin")])
    if file_path :
        text = text_box.get("1.0", tk.END)
        with open(file_path, "w+") as f:
            f.write(text)

window = tk.Tk()
window.geometry("1000x720")
window.title("8-Bit CPU Assembler")

text_box = tk.Text(window, state="disabled", height = 20, width = 50)
text_box.pack()


upload_button = tk.Button(window, text = "Upload .asm file", command = get_file)
upload_button.pack()

confirmation_frame = tk.Frame(window)

confirmation_label = tk.Label(confirmation_frame, text = "Are you sure you want to submit?")
confirmation_button_yes = tk.Button(confirmation_frame, text = "Yes",  command = get_bin_file)
confirmation_button_no = tk.Button(confirmation_frame, text = "No", command = get_file)

confirmation_label.pack()
confirmation_button_yes.pack(side = "left", ipadx = 100, padx = 30)
confirmation_button_no.pack(side = "left", ipadx = 100)


save_frame=tk.Frame(window)

save_button_yes = tk.Button(save_frame, text = "Save as .bin", command = save_bin)

save_button_yes.pack()

window.mainloop()