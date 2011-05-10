Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:53124 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab1EJILC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 04:11:02 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4A8AuMG003670
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 08:10:56 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4A8Auv11769526
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 09:10:56 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4A8AtJj021710
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 02:10:56 -0600
Message-ID: <20110510081103.363216850@de.ibm.com>
Date: Tue, 10 May 2011 10:10:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/4] x86 mcount offset calculation
References: <20110510081039.241831019@de.ibm.com>
Content-Disposition: inline; filename=301-mcount-adjust-x86.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Russell King <linux@arm.linux.org.uk>, Rabin Vincent <rabin@rab.in>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20110510081041.Ii60eYJBCtLw8nKuQA_Uqqx26Lkqpq5NQhb3n3dY-5I@z>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Do the mcount offset adjustment in the recordmcount.pl/recordmcount.[ch]
at compile time and not in ftrace_call_adjust at run time.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---


 arch/x86/include/asm/ftrace.h |    7 +++----
 scripts/recordmcount.c        |   10 ++++++++--
 scripts/recordmcount.pl       |    2 ++
 3 files changed, 13 insertions(+), 6 deletions(-)
Index: test-2.6/arch/x86/include/asm/ftrace.h
===================================================================
--- test-2.6.orig/arch/x86/include/asm/ftrace.h	2009-09-12 09:47:14.000000000 +0200
+++ test-2.6/arch/x86/include/asm/ftrace.h	2011-05-03 09:39:02.145472579 +0200
@@ -38,11 +38,10 @@
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
-	 * call mcount is "e8 <4 byte offset>"
-	 * The addr points to the 4 byte offset and the caller of this
-	 * function wants the pointer to e8. Simply subtract one.
+	 * addr is the address of the mcount call instruction.
+	 * recordmcount does the necessary offset calculation.
 	 */
-	return addr - 1;
+	return addr;
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
Index: test-2.6/scripts/recordmcount.c
===================================================================
--- test-2.6.orig/scripts/recordmcount.c	2011-03-16 09:26:43.006913981 +0100
+++ test-2.6/scripts/recordmcount.c	2011-05-03 09:39:02.145472579 +0200
@@ -300,7 +300,10 @@
 			w2(ehdr->e_machine), fname);
 		fail_file();
 	} break;
-	case EM_386:	 reltype = R_386_32;                   break;
+	case EM_386:
+		reltype = R_386_32;
+		mcount_adjust_32 = -1;
+		break;
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
 			 break;
@@ -311,7 +314,10 @@
 	case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
 	case EM_SH:	 reltype = R_SH_DIR32;                 break;
 	case EM_SPARCV9: reltype = R_SPARC_64;     gpfx = '_'; break;
-	case EM_X86_64:	 reltype = R_X86_64_64;                break;
+	case EM_X86_64:
+		reltype = R_X86_64_64;
+		mcount_adjust_64 = -1;
+		break;
 	}  /* end switch */
 
 	switch (ehdr->e_ident[EI_CLASS]) {
Index: test-2.6/scripts/recordmcount.pl
===================================================================
--- test-2.6.orig/scripts/recordmcount.pl	2011-03-16 09:26:43.006913981 +0100
+++ test-2.6/scripts/recordmcount.pl	2011-05-03 09:39:02.145472579 +0200
@@ -222,6 +222,7 @@
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount([+-]0x[0-9a-zA-Z]+)?\$";
     $type = ".quad";
     $alignment = 8;
+    $mcount_adjust = -1;
 
     # force flags for this arch
     $ld .= " -m elf_x86_64";
@@ -231,6 +232,7 @@
 
 } elsif ($arch eq "i386") {
     $alignment = 4;
+    $mcount_adjust = -1;
 
     # force flags for this arch
     $ld .= " -m elf_i386";

