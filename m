Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:61385 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759490AbWLBK7p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2622831uga
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:44 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 24/26] Dynamic kernel command-line - v850
Date: Sat, 2 Dec 2006 12:56:59 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021257.00265.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/v850/kernel/setup.c linux-2.6.19/arch/v850/kernel/setup.c
--- linux-2.6.19.org/arch/v850/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/v850/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -42,7 +42,7 @@ extern char _root_fs_image_start __attri
 extern char _root_fs_image_end __attribute__ ((__weak__));
 
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* Memory not used by the kernel.  */
 static unsigned long total_ram_pages;
@@ -64,8 +64,8 @@ void __init setup_arch (char **cmdline)
 {
 	/* Keep a copy of command line */
 	*cmdline = command_line;
-	memcpy (saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	memcpy (boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	console_verbose ();
 
