Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:62694 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759476AbWLBK7i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809421nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:37 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 18/26] Dynamic kernel command-line - s390
Date: Sat, 2 Dec 2006 12:55:00 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.00696.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/s390/kernel/setup.c linux-2.6.19/arch/s390/kernel/setup.c
--- linux-2.6.19.org/arch/s390/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/s390/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -633,7 +633,7 @@ setup_arch(char **cmdline_p)
 #endif /* CONFIG_64BIT */
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
 
 	*cmdline_p = COMMAND_LINE;
 	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';
