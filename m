Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47673 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760164AbcALK0Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2016 05:26:24 -0500
Date: Tue, 12 Jan 2016 11:25:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112102555.GV6373@twins.programming.kicks-ass.net>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160112092711.GP6344@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, will.deacon@arm.com, james.hogan@imgtec.com
Message-ID: <20160112102555.PchGaXTF-nup2VpCaGIV-_Y2ttLwzKXiLyk9NZHYv7c@z>

On Tue, Jan 12, 2016 at 10:27:11AM +0100, Peter Zijlstra wrote:
> 2) the changelog _completely_ fails to explain the sync 0x11 and sync
> 0x12 semantics nor does it provide a publicly accessible link to
> documentation that does.

Ralf pointed me at: https://imgtec.com/mips/architectures/mips64/

> 3) it really should have explained what you did with
> smp_llsc_mb/smp_mb__before_llsc() in _detail_.

And reading the MIPS64 v6.04 instruction set manual, I think 0x11/0x12
are _NOT_ transitive and therefore cannot be used to implement the
smp_mb__{before,after} stuff.

That is, in MIPS speak, those SYNC types are Ordering Barriers, not
Completion Barriers. They need not be globally performed.
