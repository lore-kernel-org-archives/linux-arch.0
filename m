Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45259 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfAJAkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 19:40:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so8765343edb.12
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 16:40:01 -0800 (PST)
Date: Thu, 10 Jan 2019 01:39:52 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Message-ID: <20190110003952.GA4354@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
 <20190109234043.GD1215@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109234043.GD1215@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
Message-ID: <20190110003952.d4yxraMC6qqo32LR0wHowFWDhkVSMPG5jc7SQRr0M5U@z>

On Wed, Jan 09, 2019 at 03:40:43PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 10, 2019 at 12:18:53AM +0100, Andrea Parri wrote:
> > On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > This series contains updates for the Linux-kernel memory model:
> > > 
> > > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > > 
> > > 4.	Update README for adding of SRCU support.
> > > 
> > > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > > 	posted some feedback from an Intel manual here, which might
> > > 	be considered to be a close substitute, but...  ;-)
> > > 
> > > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > > 
> > > 6.	Update Documentation/explanation.txt to include SRCU support,
> > > 	courtesy of Alan Stern.
> > > 
> > > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > > 	Luc Maranget.  This needs an ack.
> > 
> > It seems that
> > 
> >   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> >   
> > from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> > considered that, IIRC, you introduced the primitive and RCU is currently
> > its only user.)
> 
> That commit is in -tip:
> 
> 4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> 
> So it has already left my -rcu tree.  ;-)

Oh, you're right: now I see the commit (e.g., with "git show"), but I
don't see the corresponding changes applied to the tree.

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=4607abbcf464ea2be14da444215d05c73025cf6e
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/memory-model/linux-kernel.bell?h=locking/core

Is this expected?

  Andrea


> 
> 							Thanx, Paul
> 
