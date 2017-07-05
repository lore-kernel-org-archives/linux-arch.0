From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patches] Re: [PATCH 1/9] RISC-V: Init and Halt Code
Date: Wed, 5 Jul 2017 08:39:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707050838020.2019@nanos>
References: <20170704195102.3974-1-palmer@dabbelt.com> <20170704195102.3974-2-palmer@dabbelt.com> <alpine.DEB.2.20.1707042224560.2131@nanos> <20170704211749.jqgfbgjqzm2bcppy@excalibur.cnev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbdGEGlQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 02:41:16 -0400
In-Reply-To: <20170704211749.jqgfbgjqzm2bcppy@excalibur.cnev.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Karsten Merker <merker@debian.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Tue, 4 Jul 2017, Karsten Merker wrote:
> On Tue, Jul 04, 2017 at 10:37:37PM +0200, Thomas Gleixner wrote:
> > > +	timer_riscv_init(cpu_id, riscv_timebase, &rdtime, &next_event);
> > 
> > This function is nowhere.... Neither can I find the header file.
> 
> It is part of the RISC-V clock driver patchset, please cf.
> https://github.com/riscv/riscv-linux/commit/0705a31372d4714e54c5104e02021441785c1fd5
> 
> https://github.com/riscv/riscv-linux/commits/riscv-for-submission-v4
> has the various RISC-V-related driver patchsets merged in (in
> addition to this arch patchset).

Well, then please move that timer stuff to the clock driver patchset, so
the combo can be reviewed. Having half functional patches with missing
references here and there makes review a PITA.

Thanks,

	tglx
