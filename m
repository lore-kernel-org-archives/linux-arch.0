From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Thu, 6 Jul 2017 09:55:03 +0100
Message-ID: <20170706085503.GA15053@arm.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-9-palmer@dabbelt.com>
 <20170706020141.GA1965@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdGFIzE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jul 2017 04:55:04 -0400
Content-Disposition: inline
In-Reply-To: <20170706020141.GA1965@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org, mathieu.desnoyers@efficios.com

On Wed, Jul 05, 2017 at 07:01:41PM -0700, Christoph Hellwig wrote:
> I'm a bit concerned about these cmpxchg syscalls, and I'd like to
> understand if my concerns are justified.
> 
> For a new instruction set that starts out in the 201x years we really
> should have cmpxchg as a mandatory instruction - if not in the CPU
> it should be in the Linux ABI so that we don't have to deal with a mess
> where programs will either need an indirection for CPUs that have
> cmpxchg capabilities vs those that don't, and we don't need to worry
> if given binaries work on all CPUs.

Agreed on the indirection; it feels like this is something that should be in
the vDSO, which could use the cmpxchg instruction if it's available, or
otherwise just uses plain loads and stores. In the latter case, the kernel
can then detect if you're preempted in the vdso critical region and restart
the cmpxchg (we do something similar for arch/arm/, but it's slightly
simpler with the vectors page (see entry-armv.S).

Alternatively, we could revisit the restartable sequences work from Mathieu,
but I think that's stalled pending real-world performance data.

> What keeps from from declaring that the RISV-A extension is mandatory
> for Linux?

Or that!

Will
