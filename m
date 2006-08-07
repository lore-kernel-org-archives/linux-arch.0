Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [198.99.130.12] ([198.99.130.12]:40385 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750790AbWHGRLf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 7 Aug 2006 13:11:35 -0400
Received: from ccure.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id k77HBX2c029376
	for <linux-arch@vger.kernel.org>; Mon, 7 Aug 2006 13:11:33 -0400
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.13.7/8.13.4) with ESMTP id k77HBQrs004640
	for <linux-arch@vger.kernel.org>; Mon, 7 Aug 2006 13:11:26 -0400
Received: (from jdike@localhost)
	by ccure.user-mode-linux.org (8.13.7/8.13.7/Submit) id k77HBPMm004639
	for linux-arch@vger.kernel.org; Mon, 7 Aug 2006 13:11:25 -0400
Date: Mon, 7 Aug 2006 13:11:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [RFC] Splitting asm-{i386/x86_64}/ptrace.h
Message-ID: <20060807171125.GB4556@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I'm going to be sending the patch below to Andrew.  It splits the
userspace-usable stuff into ptrace-abi.h.

The impetus for this was the introduction of SEGMENT_RPL_MASK in place of
0x3 x86-allow-a-kernel-to-not-be-in-ring-0.patch.  This breaks the UML
build, as it pulls in the underlying arch's ptrace.h, but I have no
easy way of grabbing the definition of SEGMENT_RPL_MASK.

Splitting the header so that UML gets only the parts that it can use
cleans up the UML side of things nicely.  It also produces a header
which is close to something that can be dropped into libc.

				Jeff

Index: linux-2.6.17/include/asm-i386/ptrace-abi.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-i386/ptrace-abi.h
@@ -0,0 +1,60 @@
+#ifndef I386_PTRACE_ABI_H
+#define I386_PTRACE_ABI_H
+
+#define EBX 0
+#define ECX 1
+#define EDX 2
+#define ESI 3
+#define EDI 4
+#define EBP 5
+#define EAX 6
+#define DS 7
+#define ES 8
+#define FS 9
+#define GS 10
+#define ORIG_EAX 11
+#define EIP 12
+#define CS  13
+#define EFL 14
+#define UESP 15
+#define SS   16
+#define FRAME_SIZE 17
+
+/* this struct defines the way the registers are stored on the
+   stack during a system call. */
+
+struct pt_regs {
+	long ebx;
+	long ecx;
+	long edx;
+	long esi;
+	long edi;
+	long ebp;
+	long eax;
+	int  xds;
+	int  xes;
+	long orig_eax;
+	long eip;
+	int  xcs;
+	long eflags;
+	long esp;
+	int  xss;
+};
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
+
+#endif
Index: linux-2.6.17/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.17.orig/include/asm-i386/ptrace.h
+++ linux-2.6.17/include/asm-i386/ptrace.h
@@ -1,61 +1,7 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H
 
-#define EBX 0
-#define ECX 1
-#define EDX 2
-#define ESI 3
-#define EDI 4
-#define EBP 5
-#define EAX 6
-#define DS 7
-#define ES 8
-#define FS 9
-#define GS 10
-#define ORIG_EAX 11
-#define EIP 12
-#define CS  13
-#define EFL 14
-#define UESP 15
-#define SS   16
-#define FRAME_SIZE 17
-
-/* this struct defines the way the registers are stored on the 
-   stack during a system call. */
-
-struct pt_regs {
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	int  xds;
-	int  xes;
-	long orig_eax;
-	long eip;
-	int  xcs;
-	long eflags;
-	long esp;
-	int  xss;
-};
-
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
-#define PTRACE_SYSEMU		  31
-#define PTRACE_SYSEMU_SINGLESTEP  32
+#include <asm/ptrace-abi.h>
 
 #ifdef __KERNEL__
 
Index: linux-2.6.17/include/asm-x86_64/ptrace-abi.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-x86_64/ptrace-abi.h
@@ -0,0 +1,83 @@
+#ifndef _X86_64_PTRACE_ABI_H
+#define _X86_64_PTRACE_ABI_H
+
+#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS)
+#define R15 0
+#define R14 8
+#define R13 16
+#define R12 24
+#define RBP 32
+#define RBX 40
+/* arguments: interrupts/non tracing syscalls only save upto here*/
+#define R11 48
+#define R10 56
+#define R9 64
+#define R8 72
+#define RAX 80
+#define RCX 88
+#define RDX 96
+#define RSI 104
+#define RDI 112
+#define ORIG_RAX 120       /* = ERROR */
+/* end of arguments */
+/* cpu exception frame or undefined in case of fast syscall. */
+#define RIP 128
+#define CS 136
+#define EFLAGS 144
+#define RSP 152
+#define SS 160
+#define ARGOFFSET R11
+#endif /* __ASSEMBLY__ */
+
+/* top of stack page */
+#define FRAME_SIZE 168
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long r15;
+	unsigned long r14;
+	unsigned long r13;
+	unsigned long r12;
+	unsigned long rbp;
+	unsigned long rbx;
+/* arguments: non interrupts/non tracing syscalls only save upto here*/
+ 	unsigned long r11;
+	unsigned long r10;
+	unsigned long r9;
+	unsigned long r8;
+	unsigned long rax;
+	unsigned long rcx;
+	unsigned long rdx;
+	unsigned long rsi;
+	unsigned long rdi;
+	unsigned long orig_rax;
+/* end of arguments */
+/* cpu exception frame or undefined */
+	unsigned long rip;
+	unsigned long cs;
+	unsigned long eflags;
+	unsigned long rsp;
+	unsigned long ss;
+/* top of stack page */
+};
+
+#endif
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+/* only useful for access 32bit programs */
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#define PTRACE_ARCH_PRCTL	  30	/* arch_prctl for child */
+
+#endif
Index: linux-2.6.17/include/asm-x86_64/ptrace.h
===================================================================
--- linux-2.6.17.orig/include/asm-x86_64/ptrace.h
+++ linux-2.6.17/include/asm-x86_64/ptrace.h
@@ -1,84 +1,7 @@
 #ifndef _X86_64_PTRACE_H
 #define _X86_64_PTRACE_H
 
-#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS) 
-#define R15 0
-#define R14 8
-#define R13 16
-#define R12 24
-#define RBP 32
-#define RBX 40
-/* arguments: interrupts/non tracing syscalls only save upto here*/
-#define R11 48
-#define R10 56	
-#define R9 64
-#define R8 72
-#define RAX 80
-#define RCX 88
-#define RDX 96
-#define RSI 104
-#define RDI 112
-#define ORIG_RAX 120       /* = ERROR */ 
-/* end of arguments */ 	
-/* cpu exception frame or undefined in case of fast syscall. */
-#define RIP 128
-#define CS 136
-#define EFLAGS 144
-#define RSP 152
-#define SS 160
-#define ARGOFFSET R11
-#endif /* __ASSEMBLY__ */
-
-/* top of stack page */ 
-#define FRAME_SIZE 168
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#ifndef __ASSEMBLY__ 
-
-struct pt_regs {
-	unsigned long r15;
-	unsigned long r14;
-	unsigned long r13;
-	unsigned long r12;
-	unsigned long rbp;
-	unsigned long rbx;
-/* arguments: non interrupts/non tracing syscalls only save upto here*/
- 	unsigned long r11;
-	unsigned long r10;	
-	unsigned long r9;
-	unsigned long r8;
-	unsigned long rax;
-	unsigned long rcx;
-	unsigned long rdx;
-	unsigned long rsi;
-	unsigned long rdi;
-	unsigned long orig_rax;
-/* end of arguments */ 	
-/* cpu exception frame or undefined */
-	unsigned long rip;
-	unsigned long cs;
-	unsigned long eflags; 
-	unsigned long rsp; 
-	unsigned long ss;
-/* top of stack page */ 
-};
-
-#endif
-
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-/* only useful for access 32bit programs */
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
-#define PTRACE_ARCH_PRCTL	  30	/* arch_prctl for child */
+#include <asm/ptrace-abi.h>
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) 
 #define user_mode(regs) (!!((regs)->cs & 3))
