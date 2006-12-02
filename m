Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:62694 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759469AbWLBK7e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:34 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809421nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:33 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 15/26] Dynamic kernel command-line - parisc
Date: Sat, 2 Dec 2006 12:53:44 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021253.45260.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/parisc/kernel/setup.c linux-2.6.19/arch/parisc/kernel/setup.c
--- linux-2.6.19.org/arch/parisc/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/parisc/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -45,7 +45,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
-char	command_line[COMMAND_LINE_SIZE] __read_mostly;
+char	__initdata command_line[COMMAND_LINE_SIZE] __read_mostly;
 
 /* Intended for ccio/sba/cpu statistics under /proc/bus/{runway|gsc} */
 struct proc_dir_entry * proc_runway_root __read_mostly = NULL;
@@ -71,9 +71,9 @@ void __init setup_cmdline(char **cmdline
 	/* boot_args[0] is free-mem start, boot_args[1] is ptr to command line */
 	if (boot_args[0] < 64) {
 		/* called from hpux boot loader */
-		saved_command_line[0] = '\0';
+		boot_command_line[0] = '\0';
 	} else {
-		strcpy(saved_command_line, (char *)__va(boot_args[1]));
+		strcpy(boot_command_line, (char *)__va(boot_args[1]));
 
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (boot_args[2] != 0) /* did palo pass us a ramdisk? */
@@ -84,7 +84,7 @@ void __init setup_cmdline(char **cmdline
 #endif
 	}
 
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 	*cmdline_p = command_line;
 }
 
diff -urNp linux-2.6.19.org/arch/parisc/mm/init.c linux-2.6.19/arch/parisc/mm/init.c
--- linux-2.6.19.org/arch/parisc/mm/init.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/parisc/mm/init.c	2006-12-02 11:31:33.000000000 +0200
@@ -77,12 +77,12 @@ static void __init mem_limit_func(void)
 {
 	char *cp, *end;
 	unsigned long limit;
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 
 	/* We need this before __setup() functions are called */
 
 	limit = MAX_MEM;
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "mem=", 4) == 0) {
 			cp += 4;
 			limit = memparse(cp, &end);
