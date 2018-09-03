Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32858 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeICWth (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Sep 2018 18:49:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so1427430edv.0
        for <linux-arch@vger.kernel.org>; Mon, 03 Sep 2018 11:28:12 -0700 (PDT)
Date: Mon, 3 Sep 2018 20:28:05 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180903182805.GA6848@andrea>
References: <20180903090153.GA4560@andrea>
 <Pine.LNX.4.44L0.1809031346300.1940-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809031346300.1940-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180903182805.BVPBjkzevbBb2N0hffEvV5RO8JzhoFlZ5Qpvqmyr34s@z>

On Mon, Sep 03, 2018 at 01:52:07PM -0400, Alan Stern wrote:
> On Mon, 3 Sep 2018, Andrea Parri wrote:
> 
> > In Cat speak,
> > 
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 59b5cbe6b6240..fd9c0831adf0a 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -38,7 +38,7 @@ let strong-fence = mb | gp
> >  (* Release Acquire *)
> >  let acq-po = [Acquire] ; po ; [M]
> >  let po-rel = [M] ; po ; [Release]
> > -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> > +let po-rel-rf-acq-po = po ; [Release] ; rf ; [Acquire] ; po
> >  
> >  (**********************************)
> >  (* Fundamental coherence ordering *)
> > @@ -60,13 +60,13 @@ let dep = addr | data
> >  let rwdep = (dep | ctrl) ; [W]
> >  let overwrite = co | fr
> >  let to-w = rwdep | (overwrite & int)
> > -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> > +let to-r = addr | (dep ; rfi)
> >  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> > -let ppo = to-r | to-w | fence
> > +let ppo = to-r | to-w | fence | (po-rel-rf-acq-po & int)
> >  
> >  (* Propagation: Ordering from release operations and strong fences. *)
> >  let A-cumul(r) = rfe? ; r
> > -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> > +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-rel-rf-acq-po
> >  let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> >  
> >  (*
> 
> I thought the goal you were aiming for was a patch making
> atomic-acquire/ordinary-release be RCtso (along with lock/unlock),
> while leaving ordinary-acquire/ordinary-release to remain RCpc.  

Such a patch would belong to the second approach (the "two distinct
release-acquire" approach from my previous email).


> Clearly that is not what this patch does.

I meant the above ;-)  to illustrate yet another approach (not that
it makes me happy, as should be clear from previous posts ;-).

  Andrea


> 
> Alan
> 
