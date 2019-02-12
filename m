Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfBLSn7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Feb 2019 13:43:59 -0500
Date: Tue, 12 Feb 2019 18:43:54 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190212184354.GC20961@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <20190211202218.GQ4240@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211202218.GQ4240@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190212184354.90h2-zQbkOD4txMvfCx-BS7gRqoeVaJrJDla_eMVFMc@z>

On Mon, Feb 11, 2019 at 12:22:18PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 11, 2019 at 05:29:48PM +0000, Will Deacon wrote:
> > The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
> > x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
> > This is largely because I/O ordering is a horrible can of worms, but also
> > because the document has stagnated as our understanding has evolved.
> > 
> > Attempt to address some of that, by rewriting the section based on
> > recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
> > find a way to formalise this stuff, but for now let's at least try to
> > make the English easier to understand.
> > 
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Hello, Will,
> 
> The intent is to replace commit 3f305018dcf3 ("docs/memory-barriers.txt:
> Enforce heavy ordering for port I/O accesses"), correct?  Either way is
> fine, just guessing based on the conflicts when applying this one.  ;-)

Yup, I decided to abandon the old patch:

http://lkml.kernel.org/r/20190211153043.GC32385@fuggles.cambridge.arm.com

Thanks,

Will
