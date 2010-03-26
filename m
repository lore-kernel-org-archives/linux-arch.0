From: Scott Lurndal <scott.lurndal@3leafsystems.com>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Fri, 26 Mar 2010 10:37:30 -0700
Message-ID: <20100326173730.GA27489@pendragon.3leafnetworks.com>
References: <20100326144241.8583.95617.stgit@warthog.procyon.org.uk> <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 65-115-68-195.dia.static.qwest.net ([65.115.68.195]:55113 "EHLO
	chronus.3leafnetworks.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752065Ab0CZRwp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 13:52:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 26, 2010 at 10:23:46AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 26 Mar 2010, David Howells wrote:
> >
> > fls(N), ffs(N) and fls64(N) can be optimised on x86/x86_64.  Currently they
> > perform checks against N being 0 before invoking the BSR/BSF instruction, or
> > use a CMOV instruction afterwards.  Either the check involves a conditional
> > jump which we'd like to avoid, or a CMOV, which we'd also quite like to avoid.
> > 
> > Instead, we can make use of the fact that BSR/BSF doesn't modify its output
> > register if its input is 0.  By preloading the output with -1 and incrementing
> > the result, we achieve the desired result without the need for a conditional
> > check.
> 
> This is totally incorrect.
> 
> Where did you find that "doesn't modify its output" thing? It's not true. 
> The truth is that the destination is undefined. Just read the dang Intel 
> documentation, it's very clearly stated right there.

While this is true for the current (253666-031US) Intel documentation,
the AMD documentation (rev 3.14) for the same instruction states that the
destination register is unchanged (as opposed to Intel's undefined).

I wonder if Intel's EM64 stuff makes this more deterministic, perhaps
David's implementation would work for x86_64 only?

scott
