Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:9532 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750769AbWHKIMV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Aug 2006 04:12:21 -0400
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7B8CKnZ108576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 11 Aug 2006 08:12:20 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k7B8E9pO142940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 11 Aug 2006 09:14:09 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7B8CJn1009489
	for <linux-arch@vger.kernel.org>; Fri, 11 Aug 2006 09:12:19 +0100
Date: Fri, 11 Aug 2006 10:12:15 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Signal restarting happing multiple time in do_signal
Message-ID: <20060811081215.GB9590@osiris.boeblingen.de.ibm.com>
References: <20060808110437.GB18770@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808110437.GB18770@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> In the MIPS entry.S the symbol resume_userspace to the call to
> do_notify_resume form a loop through which the kernel will iterate as
> long as work is pending.  If we iterate through this loop more than once
> with no signal pending for at least one but the last iteration we will
> perform the syscall restarting multiple times resulting in a syscall
> return prior to the the syscall instruction in userspace because the
> return program counter will be adjusted several times by:
> 
>         regs->regs[7] = regs->regs[26];
>         regs->cp0_epc -= 8;
> 
> resulting in return to userspace at a too low address.  On MIPS this often
> happens to be a stackpointer adjustment but in many cases this may also
> just be a harmless instruction such as reloading the syscall number so
> may go unnoticed.
> 
> We were able to trigger this when debugging a multithreaded programs.
> At least i386 uses virtually identical algorithms so I think is likely
> to have the same issue.

s390 has the same problem. Thanks for pointing this out.
btw. is there a reason why mips doesn't have a 'return' within do_signal()
(see patch below)? That would save you some cycles.
Also I think that powerpc's do_signal() could be converted to be a void
function and that their EXPORT_SYMBOL(do_signal) could be removed. Would
also save some cycles/memory.

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 6b4d9be..43c37d9 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -446,6 +446,7 @@ void do_signal(struct pt_regs *regs)
 			if (test_thread_flag(TIF_RESTORE_SIGMASK))
 				clear_thread_flag(TIF_RESTORE_SIGMASK);
 		}
+		return;
 	}
 
 no_signal:
