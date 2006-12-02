Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:56806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759468AbWLBK7d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:33 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809405nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:32 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 14/26] Dynamic kernel command-line - mips
Date: Sat, 2 Dec 2006 12:53:22 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021253.23807.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/mips/kernel/setup.c linux-2.6.19/arch/mips/kernel/setup.c
--- linux-2.6.19.org/arch/mips/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/mips/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -409,7 +409,7 @@ static void __init arch_mem_init(char **
 	print_memory_map();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 
