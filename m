Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264857AbUH0NAa@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21192 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S264795AbUH0NAa
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Aug 2004 09:00:30 -0400
Date: Fri, 27 Aug 2004 15:00:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/8] signal handling race fix
Message-ID: <20040827130034.GA2925@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: davem@redhat.com, akpm@osdl.org, linux-arch@vger.kernel.org, minyard@acm.org, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

> Can architecture people check the result of their respective 
> architectures? I'll check x86 and ppc64 myself, but..

Small name clash on s390. The attached patch renames the
offending force_sigsegv in arch/s390/mm/fault to do_sigsegv.
With the change the test app, the signal tests from the glibc
testsuite and the signal tests from the ltp testsuite run fine
with the current BitKeeper tree.

blue skies,
  Martin.

---

[PATCH] s390: force_sigsegv name clash.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The recent signal fix broke s390 because of a name clash.
Rename the s390 arch function to do_sigsegv.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/fault.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urN linux-2.6/arch/s390/mm/fault.c linux-2.6-s390/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	Sat Aug 14 12:56:26 2004
+++ linux-2.6-s390/arch/s390/mm/fault.c	Fri Aug 27 13:24:18 2004
@@ -126,8 +126,8 @@
  * Send SIGSEGV to task.  This is an external routine
  * to keep the stack usage of do_page_fault small.
  */
-static void force_sigsegv(struct pt_regs *regs, unsigned long error_code,
-			  int si_code, unsigned long address)
+static void do_sigsegv(struct pt_regs *regs, unsigned long error_code,
+		       int si_code, unsigned long address)
 {
 	struct siginfo si;
 
@@ -282,7 +282,7 @@
         if (regs->psw.mask & PSW_MASK_PSTATE) {
                 tsk->thread.prot_addr = address;
                 tsk->thread.trap_no = error_code;
-		force_sigsegv(regs, error_code, si_code, address);
+		do_sigsegv(regs, error_code, si_code, address);
                 return;
 	}
 
