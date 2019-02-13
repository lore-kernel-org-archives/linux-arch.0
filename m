Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4318 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405195AbfBMSnn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:43 -0500
From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Date: Wed, 13 Feb 2019 18:43:41 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D4FF0DE@ORSMSX110.amr.corp.intel.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
 <20190213183314.GB32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190213183314.GB32494@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>
Message-ID: <20190213184341.MGjiYuelZ7tat2JRnJttGISuxR1f6d6qkJrbbBoBGZw@z>

> I think the last time this came up, it was said that those people still
> running Linux on Itanium were running old distro kernels, not upstream.
>
> So yeah, we could probably do whatever and nobody would ever notice,
> except maybe Al, who is rumoured to still have an ia64 :-)

I haven't heard of anyone taking upstream kernels and actually using them
for production work in a long time. It's mostly just a few folks keeping ia64
alive "just because" these days.  I doubt any of them have an SGI Altix
to test on (so realistically Altix was probably broken upstream many releases
ago).

-Tony
