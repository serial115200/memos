#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/capability.h>
#include <linux/capability.h>

#define PORT 80

int main()
{
    // Display current process capabilities
    cap_t caps = cap_get_proc();
    char *caps_text = cap_to_text(caps, NULL);
    printf("Current capabilities: %s\n", caps_text);
    cap_free(caps_text);
    cap_free(caps);

    // Create TCP socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Enable socket reuse option
    int opt = 1;
    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
        perror("setsockopt failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    // Configure server address structure
    struct sockaddr_in addr = {
        .sin_family = AF_INET,         // IPv4
        .sin_port = htons(PORT),        // HTTP port 80
        .sin_addr.s_addr = INADDR_ANY   // Bind to all interfaces
    };

    // Attempt to bind to privileged port
    printf("Attempting to bind to port %d...\n", PORT);
    if (bind(sockfd, (struct sockaddr*)&addr, sizeof(addr))) {
        perror("Bind failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("Successfully bound to privileged port %d!\n", PORT);
    close(sockfd);
    return 0;
}
