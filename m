From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for
 synchronize_srcu_expedited()
Date: Thu, 4 Apr 2019 13:50:27 -0700
Message-ID: <20190404205027.GM14111@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-8-paulmck@linux.ibm.com>
 <20190402144911.GA10044@andrea>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190402144911.GA10044@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 02, 2019 at 04:49:11PM +0200, Andrea Parri wrote:
> On Tue, Mar 26, 2019 at 04:41:20PM -0700, Paul E. McKenney wrote:
> > Given that synchronize_rcu_expedited() is supported, this commit adds
> > support for synchronize_srcu_expedited().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  tools/memory-model/linux-kernel.def | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > index 0c3f0ef486f4..551eeaa389d4 100644
> > --- a/tools/memory-model/linux-kernel.def
> > +++ b/tools/memory-model/linux-kernel.def
> > @@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> >  srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > +synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> 
> This and the other patches from the series do not apply to "tip/core/rcu"

Ah, that is instead their hoped-for destination within the -tip tree.
They are included in -rcu branch "dev".

> (from the Subject), but this seems straightforward enough:
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied, thank you!

							Thanx, Paul

>   Andrea
> 
> 
> >  
> >  // Atomic
> >  atomic_read(X) READ_ONCE(*X)
> > -- 
> > 2.17.1
> > 
> 
