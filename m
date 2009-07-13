From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2] score: add regset support
Date: Mon, 13 Jul 2009 16:24:28 +0200
Message-ID: <200907131624.28286.arnd@arndb.de>
References: <OF43365008.5559F266-ON482575F2.001F17EE-482575F2.00212259@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57768 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbZGMOZU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2009 10:25:20 -0400
In-Reply-To: <OF43365008.5559F266-ON482575F2.001F17EE-482575F2.00212259@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org, linux-arch-owner@vger.kernel.org, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Monday 13 July 2009, liqin.chen@sunplusct.com wrote:
> 
> unsigned long pad0[6];
> 
> was place at the start of pt_regs use 
> to hold the arguments from userland.
> caller(exception handler) not need to
> change stack pointer.
>
> unsigned long orig_r4;
> unsigned long orig_r7;
> move to end of the pt_regs haven't 
> problem.

Ok, I see.

Maybe to get a nicer layout, you can define separate
structures then:

struct user_regs_struct {
        unsigned long regs[32];

        unsigned long cel;
        unsigned long ceh;
 
        unsigned long sr0;      /* cnt */
        unsigned long sr1;      /* lcr */
        unsigned long sr2;      /* scr */
 
        unsigned long cp0_epc;
        unsigned long cp0_ema;
        unsigned long cp0_psr;
        unsigned long cp0_ecr;
        unsigned long cp0_condition;

	unsigned long reserved[6]; /* future extensions */
};

#ifdef __KERNEL__
struct pt_regs {
	/* stack arguments */
        unsigned long pad0[6];

	/* internal use */
        unsigned long orig_r4;
        unsigned long orig_r7;
        long is_syscall;

	/* saved registers */
	struct user_regs_struct uregs;
};
#endif

That would keep the user struct relatively clean.

	Arnd <><
