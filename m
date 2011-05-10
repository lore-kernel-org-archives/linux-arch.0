From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/4] s390 mcount offset calculation
Date: Tue, 10 May 2011 10:10:43 +0200
Message-ID: <20110510081104.229147984@de.ibm.com>
References: <20110510081039.241831019@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.uk.ibm.com ([194.196.100.166]:48398 "EHLO
	mtagate6.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab1EJILC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 04:11:02 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate6.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4A8Avb8025874
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 08:10:57 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4A8AvZI2072706
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 09:10:57 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4A8AtO9025028
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 02:10:56 -0600
Content-Disposition: inline; filename=303-mcount-adjust-s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, H.
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Do the mcount offset adjustment in the recordmcount.pl/recordmcount.[ch]
at compile time and not in ftrace_call_adjust at run time.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---


 arch/s390/include/asm/ftrace.h |    4 +---
 scripts/recordmcount.c         |    8 ++++++--
 scripts/recordmcount.pl        |    2 ++
 3 files changed, 9 insertions(+), 5 deletions(-)
Index: test-2.6/arch/s390/include/asm/ftrace.h
===================================================================
--- test-2.6.orig/arch/s390/include/asm/ftrace.h	2011-01-10 10:32:42.825504709 +0100
+++ test-2.6/arch/s390/include/asm/ftrace.h	2011-05-03 09:39:07.757500412 +0200
@@ -11,15 +11,13 @@
 
 #ifdef CONFIG_64BIT
 #define MCOUNT_INSN_SIZE  12
-#define MCOUNT_OFFSET	   8
 #else
 #define MCOUNT_INSN_SIZE  20
-#define MCOUNT_OFFSET	   4
 #endif
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
-	return addr - MCOUNT_OFFSET;
+	return addr;
 }
 
 #endif /* __ASSEMBLY__ */
Index: test-2.6/scripts/recordmcount.c
===================================================================
--- test-2.6.orig/scripts/recordmcount.c	2011-05-03 09:39:04.929486388 +0200
+++ test-2.6/scripts/recordmcount.c	2011-05-03 09:39:07.757500412 +0200
@@ -338,8 +338,10 @@
 				"unrecognized ET_REL file: %s\n", fname);
 			fail_file();
 		}
-		if (EM_S390 == w2(ehdr->e_machine))
+		if (EM_S390 == w2(ehdr->e_machine)) {
 			reltype = R_390_32;
+			mcount_adjust_32 = -4;
+		}
 		if (EM_MIPS == w2(ehdr->e_machine)) {
 			reltype = R_MIPS_32;
 			is_fake_mcount32 = MIPS32_is_fake_mcount;
@@ -354,8 +356,10 @@
 				"unrecognized ET_REL file: %s\n", fname);
 			fail_file();
 		}
-		if (EM_S390 == w2(ghdr->e_machine))
+		if (EM_S390 == w2(ghdr->e_machine)) {
 			reltype = R_390_64;
+			mcount_adjust_64 = -8;
+		}
 		if (EM_MIPS == w2(ghdr->e_machine)) {
 			reltype = R_MIPS_64;
 			Elf64_r_sym = MIPS64_r_sym;
Index: test-2.6/scripts/recordmcount.pl
===================================================================
--- test-2.6.orig/scripts/recordmcount.pl	2011-05-03 09:39:04.929486388 +0200
+++ test-2.6/scripts/recordmcount.pl	2011-05-03 09:39:07.757500412 +0200
@@ -242,12 +242,14 @@
 
 } elsif ($arch eq "s390" && $bits == 32) {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_390_32\\s+_mcount\$";
+    $mcount_adjust = -4;
     $alignment = 4;
     $ld .= " -m elf_s390";
     $cc .= " -m31";
 
 } elsif ($arch eq "s390" && $bits == 64) {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_390_(PC|PLT)32DBL\\s+_mcount\\+0x2\$";
+    $mcount_adjust = -8;
     $alignment = 8;
     $type = ".quad";
     $ld .= " -m elf64_s390";
