From: Hugh Dickins <hughd@google.com>
Subject: Re: [RFC] page-table walkers vs memory order
Date: Wed, 25 Jul 2012 13:26:43 -0700 (PDT)
Message-ID: <alpine.LSU.2.00.1207251313180.1942@eggly.anvils>
References: <1343064870.26034.23.camel@twins> <alpine.LSU.2.00.1207241356350.2094@eggly.anvils> <20120725175628.GH2378@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62367 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab2GYU1h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2012 16:27:37 -0400
Received: by yenl2 with SMTP id l2so1186261yen.19
        for <linux-arch@vger.kernel.org>; Wed, 25 Jul 2012 13:27:37 -0700 (PDT)
In-Reply-To: <20120725175628.GH2378@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@kernel.dk>, Andrea Arcangeli <aarcange@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org

On Wed, 25 Jul 2012, Paul E. McKenney wrote:
> On Tue, Jul 24, 2012 at 02:51:05PM -0700, Hugh Dickins wrote:
> > 
> > I'm totally unclear whether the kernel ever gets built with these
> > 'creative' compilers that you refer to.  Is ACCESS_ONCE() a warning
> > of where some future compiler would be permitted to mess with our
> > assumptions?  Or is it actually saving us already today?  Would we
> > know?  Could there be a boottime test that would tell us?  Is it
> > likely that a future compiler would have an "--access_once"
> > option that the kernel build would want to turn on?
> 
> The problem is that, unless you tell it otherwise, the compiler is
> permitted to assume that the code that it is generating is the only thing
> active in that address space at that time.  So the compiler might know
> that it already has a perfectly good copy of that value somewhere in
> its registers, or it might decide to fetch the value twice rather than
> once due to register pressure, either of which can be fatal in SMP code.
> And then there are more aggressive optimizations as well.
> 
> ACCESS_ONCE() is a way of telling the compiler to access the value
> once, regardless of what cute single-threaded optimizations that it
> otherwise might want to apply.

Right, but you say "might": I have never heard it asserted, that we do
build the kernel with a compiler which actually makes such optimizations.

There's a lot of other surprising things which a compiler is permitted
to do, but we would simply not use such a compiler to build the kernel.

Does some version of gcc, under the options which we insist upon,
make such optimizations on any of the architectures which we support?

Or is there some other compiler in use on the kernel, which makes
such optimizations?  It seems a long time since I heard of building
the kernel with icc.  clang?

I don't mind the answer "Yes, you idiot" - preferably with an example
or two of which compiler and which piece of code it has bitten us on.
I don't mind the answer "We just don't know" if that's the case.

But I'd like a better idea of how much to worry: is ACCESS_ONCE
demonstrably needed today, or rather future-proofing and documentation?

Thanks,
Hugh
