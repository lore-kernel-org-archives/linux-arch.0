Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:45664 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcANUgy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2016 15:36:54 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 14 Jan 2016 13:36:53 -0700
Date: Thu, 14 Jan 2016 12:36:37 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160114203637.GD3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com>
 <5697FA0A.6040601@imgtec.com>
 <20160114201513.GI6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160114201513.GI6357@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Will Deacon <will.deacon@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20160114203637.7nBXYAur0pbDpbYK0aHOF12yKwBi-z-kIJ005rOZH1s@z>

On Thu, Jan 14, 2016 at 09:15:13PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 14, 2016 at 11:42:02AM -0800, Leonid Yegoshin wrote:
> > An the only point - please use an appropriate SYNC_* barriers instead of
> > heavy bold hammer. That stuff was design explicitly to support the
> > requirements of Documentation/memory-barriers.txt
> 
> That's madness. That document changes from version to version as to what
> we _think_ the actual hardware does. It is _NOT_ a specification.

There is work in progress on a specification, but please don't hold
your breath.  And I am not as optimistic as I might be about any formal
specification keeping up with the Linux kernel or with the hardware that
it supports.  But it seems worth a good try.

> You cannot design hardware from that. Its incomplete and fails to
> specify a bunch of things. It not a mathematically sound definition of a
> memory model.
> 
> Please stop referring to that document for what a particular barrier
> _should_ do.  Explain what MIPS does, so we can attempt to integrate
> this knowledge with our knowledge of PPC/ARM/Alpha/x86/etc. and improve
> upon our understanding of hardware and improve the Linux memory model.

Please!

							Thanx, Paul

