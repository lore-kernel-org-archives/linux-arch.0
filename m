Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCFQ6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Mar 2019 11:58:54 -0500
Date: Wed, 6 Mar 2019 17:58:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190306165831.GZ32477@hirez.programming.kicks-ass.net>
References: <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <20190226150450.GW32477@hirez.programming.kicks-ass.net>
 <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190306165831.M7WbCRV0JXrQlx5x9_hilD9Osxh5VgN7xhY1_-16R1c@z>

On Thu, Mar 07, 2019 at 12:46:05AM +0900, Akira Yokosawa wrote:
> So, I'm looking at the macro RELOC_HIDE() defined in include/linux/compiler-gcc.h.

> Am I the only one who was not aware of this gcc-specific macro?

It's one I regularly see, but had forgotten about in this context.

However; you can also fix things by adding asm volatile ("":::"memory");
in places.

But that's not really the point; I would really rather have a cmdline
knob to fix things. That way we can compile the kernel with and without
and look for differences. -fno-unicorns or something :-)

While I understand some compiler people revel in UB and love to make
unicorns happen, I think in this case the produces result is utterly
insane.
