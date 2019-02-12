Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729845AbfBLTYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Feb 2019 14:24:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CJEBmL113981
        for <linux-arch@vger.kernel.org>; Tue, 12 Feb 2019 14:24:11 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qm2u1bqr2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 12 Feb 2019 14:24:11 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 12 Feb 2019 19:24:10 -0000
Date: Tue, 12 Feb 2019 11:24:05 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Reply-To: paulmck@linux.ibm.com
References: <20190211172948.3322-1-will.deacon@arm.com>
 <20190211202218.GQ4240@linux.ibm.com>
 <20190212184354.GC20961@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212184354.GC20961@fuggles.cambridge.arm.com>
Message-ID: <20190212192405.GU4240@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190212192405.x6OEoXY4xwpxaXgNpqhCygEOHVNqVL79xnZ_rgLCUj4@z>

On Tue, Feb 12, 2019 at 06:43:54PM +0000, Will Deacon wrote:
> On Mon, Feb 11, 2019 at 12:22:18PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 11, 2019 at 05:29:48PM +0000, Will Deacon wrote:
> > > The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
> > > x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
> > > This is largely because I/O ordering is a horrible can of worms, but also
> > > because the document has stagnated as our understanding has evolved.
> > > 
> > > Attempt to address some of that, by rewriting the section based on
> > > recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
> > > find a way to formalise this stuff, but for now let's at least try to
> > > make the English easier to understand.
> > > 
> > > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > > Cc: Daniel Lustig <dlustig@nvidia.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > Hello, Will,
> > 
> > The intent is to replace commit 3f305018dcf3 ("docs/memory-barriers.txt:
> > Enforce heavy ordering for port I/O accesses"), correct?  Either way is
> > fine, just guessing based on the conflicts when applying this one.  ;-)
> 
> Yup, I decided to abandon the old patch:
> 
> http://lkml.kernel.org/r/20190211153043.GC32385@fuggles.cambridge.arm.com

Got it, and thank you for the reminder!

							Thanx, Paul
