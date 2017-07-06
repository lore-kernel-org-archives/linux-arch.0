From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 5 Jul 2017 19:01:41 -0700
Message-ID: <20170706020141.GA1965@infradead.org>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-9-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50389 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdGFCCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 22:02:43 -0400
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-9-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

I'm a bit concerned about these cmpxchg syscalls, and I'd like to
understand if my concerns are justified.

For a new instruction set that starts out in the 201x years we really
should have cmpxchg as a mandatory instruction - if not in the CPU
it should be in the Linux ABI so that we don't have to deal with a mess
where programs will either need an indirection for CPUs that have
cmpxchg capabilities vs those that don't, and we don't need to worry
if given binaries work on all CPUs.

What keeps from from declaring that the RISV-A extension is mandatory
for Linux?
