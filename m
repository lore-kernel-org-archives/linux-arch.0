Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729089AbfAJOk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 09:40:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AET7X6029353
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 09:40:55 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2px53qrbve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 09:40:55 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 14:40:54 -0000
Date: Thu, 10 Jan 2019 06:40:49 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-7-paulmck@linux.ibm.com>
 <20190110094131.GA11647@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110094131.GA11647@andrea>
Message-ID: <20190110144049.GK1215@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org
Message-ID: <20190110144049.RgM1GOBV1kAZXqz4TinDBpEgknht1B-SCGG6bVSAr7c@z>

On Thu, Jan 10, 2019 at 10:41:31AM +0100, Andrea Parri wrote:
> On Wed, Jan 09, 2019 at 01:07:48PM -0800, Paul E. McKenney wrote:
> > From: Luc Maranget <Luc.Maranget@inria.fr>
> > 
> > This commit checks that the return value of srcu_read_lock() is passed
> > to the matching srcu_read_unlock(), where "matching" is determined by
> > nesting.  This check operates as follows:
> > 
> >    1. srcu_read_lock() creates an integer token, which is stored into
> >       the generated events.
> >    2. srcu_read_unlock() records its second (token) argument into the
> >       generated event.
> >    3. A new herd primitive 'different-values' filters out pairs of events
> >       with identical values from the relation passed as its argument.
> >    4. The bell file applies the above primitive to the (srcu)
> >       read-side-critical-section relation 'srcu-rscs' and flags non-empty
> >       results.
> > 
> > BEWARE: Works only with herd version 7.51+6 and onwards.
> > 
> > Signed-off-by: Luc Maranget <Luc.Maranget@inria.fr>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > [ paulmck: Apply Andrea Parri's off-list feedback. ]
> > ---
> >  tools/memory-model/linux-kernel.bell | 3 +++
> >  tools/memory-model/linux-kernel.cat  | 2 ++
> >  tools/memory-model/linux-kernel.def  | 2 +-
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> > index 9c42cd9ddcb4..def9131d3d8e 100644
> > --- a/tools/memory-model/linux-kernel.bell
> > +++ b/tools/memory-model/linux-kernel.bell
> > @@ -73,3 +73,6 @@ flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> >  
> >  (* Check for use of synchronize_srcu() inside an RCU critical section *)
> >  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > +
> > +(* Validate SRCU dynamic match *)
> > +flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 8dcb37835b61..95bf45f1215f 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  (*
> > + * Requires herd version 7.51+6 or higher.
> 
> I'm not all that exited about spreading version requirements in the
> source: we report this requirement in our README, and apparently we
> already struggle to keep this information up-to-date.  So what about
> squashing something like the below (assume that 7.52 will be released
> by the time this patch hit mainline; if this won't be the case, we
> may consider using the development version 7.51+6)? notice that this
> also removes an (obsolete, at this point) comment from lock.cat.

Sounds like a very good point to me!

Should have pointers in the various files to the README file?  Or maybe
get people used to using scripting that checks versions?  Or maybe
after answering questions for some time, people will get used to
checking versions?

							Thanx, Paul

>   Andrea
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 9d7d4f23503fd..b362a41358fa1 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -20,8 +20,8 @@ that litmus test to be exercised within the Linux kernel.
>  REQUIREMENTS
>  ============
>  
> -Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
> -separately:
> +Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
> +downloaded separately:
>  
>    https://github.com/herd/herdtools7
>  
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 95bf45f1215fc..8dcb37835b613 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  (*
> - * Requires herd version 7.51+6 or higher.
> - *
>   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
>   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
>   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> index 305ded17e7411..a059d1a6d8a29 100644
> --- a/tools/memory-model/lock.cat
> +++ b/tools/memory-model/lock.cat
> @@ -6,9 +6,6 @@
>  
>  (*
>   * Generate coherence orders and handle lock operations
> - *
> - * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
> - * spin_is_locked() is functional from herd7 version 7.49.
>   *)
>  
>  include "cross.cat"
> 
> 
> 
> > + *
> >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > index 1d6a120cde14..0c3f0ef486f4 100644
> > --- a/tools/memory-model/linux-kernel.def
> > +++ b/tools/memory-model/linux-kernel.def
> > @@ -49,7 +49,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> >  
> >  // SRCU
> >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
> > +srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> >  
> >  // Atomic
> > -- 
> > 2.17.1
> > 
> 
