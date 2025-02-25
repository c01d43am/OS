void kernel_main() {
    char *video_memory = (char*) 0xB8000;
    video_memory[0] = 'H';
    video_memory[2] = 'i';
}
