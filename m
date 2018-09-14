Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbeINXf5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 19:35:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EI9bfL025066
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 14:20:17 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mggmpuhw8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 14:20:16 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 14:20:15 -0400
Date: Fri, 14 Sep 2018 11:20:09 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC LKMM 2/7] doc: Replace smp_cond_acquire() with
 smp_cond_load_acquire()
Reply-To: paulmck@linux.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-2-paulmck@linux.vnet.ibm.com>
 <20180914165907.GK6236@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914165907.GK6236@arm.com>
Message-ID: <20180914182009.GB652@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
Message-ID: <20180914182009.9BDNuojiJ3MyR5Jz27i2C9HjgFXbtUhg9C8T_vLNM5g@z>

On Fri, Sep 14, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> On Wed, Aug 29, 2018 at 02:10:48PM -0700, Paul E. McKenney wrote:
> > From: Andrea Parri <andrea.parri@amarulasolutions.com>
> > 
> > Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
> > with smp_cond_load_acquire()") by updating the documentation accordingly.
> > Also remove some obsolete information related to the implementation.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  Documentation/memory-barriers.txt | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 0d8d7ef131e9..c1d913944ad8 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -471,8 +471,7 @@ And a couple of implicit varieties:
> >       operations after the ACQUIRE operation will appear to happen after the
> >       ACQUIRE operation with respect to the other components of the system.
> >       ACQUIRE operations include LOCK operations and both smp_load_acquire()
> > -     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
> > -     semantics from relying on a control dependency and smp_rmb().
> > +     and smp_cond_load_acquire() operations.
> 
> Thanks for fixing the doc:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Applied, thank you Will!

							Thanx, Paul
