Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262774AbUKXPoa@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:42400 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262758AbUKXPn1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Nov 2004 10:43:27 -0500
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id iAOF8SwV014731
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 07:09:34 -0800
Received: from d12nrmr1507.megacenter.de.ibm.com (d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id iAOF7YbP123208
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 15:07:34 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1507.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iAOF7VQl119804
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 16:07:31 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id iAOF7YNx008727
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 16:07:34 +0100
In-Reply-To: <20041122142921.GB3230@linux-mips.org>
Subject: Re: Unknown traps.
Message-ID: <OF7180588E.55ED6DF4-ON41256F56.00528D36-41256F56.005316AF@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 24 Nov 2004 16:07:32 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> > What is correct? For s390 I'd like to do a force_sig_info of some
> > kind, SIGBUS/BUS_OBJERR is a likely choice.
>
> I'm reacting a bit harsher on MIPS:
>
> asmlinkage void do_reserved(struct pt_regs *regs)
> {
>         /*
>          * Game over - no way to handle this if it ever occurs.  Most
probably
>          * caused by a new unknown cpu type or after another deadly
>          * hard/software error.
>          */
>         show_regs(regs);
>         panic("Caught reserved exception %ld - should not happen.",
>               (regs->cp0_cause & 0x7f) >> 2);
> }
>
> If this is happening it's a severe kernel or hardware problem and it's
not
> clear if continuing is safe or how to recover, so game over.

Makes sense, although to panic if the fault happened in user space
is a bit too harsh, isn't it? A do_exit(SIGSEGV) if the fault took place
in user space and a panic if it happened in the kernel is my favorite
at the moment.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
