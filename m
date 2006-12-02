Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162401AbWLBK7q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:46 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809406nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:45 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 25/26] Dynamic kernel command-line - x86_64
Date: Sat, 2 Dec 2006 12:57:24 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021257.24342.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/include/asm-x86_64/bootsetup.h linux-2.6.19/include/asm-x86_64/bootsetup.h
--- linux-2.6.19.org/include/asm-x86_64/bootsetup.h	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/include/asm-x86_64/bootsetup.h	2006-12-02 11:31:33.000000000 +0200
@@ -31,7 +31,7 @@ extern char x86_boot_params[BOOT_PARAM_S
 #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
 #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
-#define COMMAND_LINE saved_command_line
+#define COMMAND_LINE boot_command_line
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
diff -urNp linux-2.6.19.org/arch/x86_64/kernel/head64.c linux-2.6.19/arch/x86_64/kernel/head64.c
--- linux-2.6.19.org/arch/x86_64/kernel/head64.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/x86_64/kernel/head64.c	2006-12-02 11:31:33.000000000 +0200
@@ -34,7 +34,7 @@ static void __init clear_bss(void)
 #define OLD_CL_BASE_ADDR        0x90000
 #define OLD_CL_OFFSET           0x90022
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 static void __init copy_bootdata(char *real_mode_data)
 {
@@ -50,7 +50,7 @@ static void __init copy_bootdata(char *r
 		new_data = OLD_CL_BASE_ADDR + * (u16 *) OLD_CL_OFFSET;
 	}
 	command_line = (char *) ((u64)(new_data));
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 }
 
 void __init x86_64_start_kernel(char * real_mode_data)
diff -urNp linux-2.6.19.org/arch/x86_64/kernel/setup.c linux-2.6.19/arch/x86_64/kernel/setup.c
--- linux-2.6.19.org/arch/x86_64/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/x86_64/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(edid_info);
 
 extern int root_mountflags;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
@@ -343,7 +343,7 @@ static void discover_ebda(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	printk(KERN_INFO "Command line: %s\n", saved_command_line);
+	printk(KERN_INFO "Command line: %s\n", boot_command_line);
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	screen_info = SCREEN_INFO;
@@ -373,7 +373,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_identify_cpu(&boot_cpu_data);
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	parse_early_param();
