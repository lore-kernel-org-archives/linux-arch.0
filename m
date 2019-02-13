Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBMSd3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 13:33:29 -0500
Date: Wed, 13 Feb 2019 19:33:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190213183314.GB32494@hirez.programming.kicks-ass.net>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190213183314.urbDn-ScmgUTWNrogRTV3g2ZY0EJJo_GGdJFG4wyrxg@z>

On Wed, Feb 13, 2019 at 10:27:09AM -0800, Linus Torvalds wrote:
> Yeah, yeah, there's the SGI "SN" platform that apparently has a bug,
> so because of that platform problem maybe it needs the more complex
> "use a flag" model.  But even the complex model isn't _hugely_
> complex.
> 
> But we *could* first just do the mmiowb() unconditionally in the ia64
> unlocking code, and then see if anybody notices?
> 
> Tony, comments? Are there any SGI SN machines around any more?

I think the last time this came up, it was said that those people still
running Linux on Itanium were running old disto kernels, not upstream.

So yeah, we could probably do whatever and nobody would ever notice,
except maybe Al, who is rumoured to still have an ia64 :-)
