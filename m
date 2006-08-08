Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:18139 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S964831AbWHHLEd
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Aug 2006 07:04:33 -0400
Received: from localhost.localdomain ([127.0.0.1]:63980 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20040258AbWHHLEe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 12:04:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k78B4b1W020108
	for <linux-arch@vger.kernel.org>; Tue, 8 Aug 2006 12:04:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k78B4bSp020107
	for linux-arch@vger.kernel.org; Tue, 8 Aug 2006 12:04:37 +0100
Date: Tue, 8 Aug 2006 12:04:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Signal restarting happing multiple time in do_signal
Message-ID: <20060808110437.GB18770@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

In the MIPS entry.S the symbol resume_userspace to the call to
do_notify_resume form a loop through which the kernel will iterate as
long as work is pending.  If we iterate through this loop more than once
with no signal pending for at least one but the last iteration we will
perform the syscall restarting multiple times resulting in a syscall
return prior to the the syscall instruction in userspace because the
return program counter will be adjusted several times by:

        regs->regs[7] = regs->regs[26];
        regs->cp0_epc -= 8;

resulting in return to userspace at a too low address.  On MIPS this often
happens to be a stackpointer adjustment but in many cases this may also
just be a harmless instruction such as reloading the syscall number so
may go unnoticed.

We were able to trigger this when debugging a multithreaded programs.
At least i386 uses virtually identical algorithms so I think is likely
to have the same issue.

The fix in case of MIPS is trivial:

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 73f8aad..8676055 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -465,6 +464,7 @@ void do_signal(struct pt_regs *regs)
 			regs->regs[7] = regs->regs[26];
 			regs->cp0_epc -= 4;
 		}
+		regs->regs[0] = 0;	/* Don't deal with this again.  */
 	}
 
 	/*

  Ralf
