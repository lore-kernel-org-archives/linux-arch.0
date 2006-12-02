Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759453AbWLBK71 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2622816uga
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:27 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 09/26] Dynamic kernel command-line - i386
Date: Sat, 2 Dec 2006 12:51:22 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021251.23244.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/i386/kernel/head.S linux-2.6.19/arch/i386/kernel/head.S
--- linux-2.6.19.org/arch/i386/kernel/head.S	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/i386/kernel/head.S	2006-12-02 11:31:32.000000000 +0200
@@ -97,7 +97,7 @@ ENTRY(startup_32)
 	movzwl OLD_CL_OFFSET,%esi
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
-	movl $(saved_command_line - __PAGE_OFFSET),%edi
+	movl $(boot_command_line - __PAGE_OFFSET),%edi
 	movl $(COMMAND_LINE_SIZE/4),%ecx
 	rep
 	movsl
diff -urNp linux-2.6.19.org/arch/i386/kernel/setup.c linux-2.6.19/arch/i386/kernel/setup.c
--- linux-2.6.19.org/arch/i386/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/i386/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -145,7 +145,7 @@ unsigned long saved_videomode;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
@@ -1405,7 +1405,7 @@ void __init setup_arch(char **cmdline_p)
 		print_memory_map("user");
 	}
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	max_low_pfn = setup_memory();
