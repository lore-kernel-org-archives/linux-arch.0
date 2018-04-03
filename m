From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Tue, 3 Apr 2018 08:16:42 -0700
Message-ID: <20180403151642.GK3948@linux.vnet.ibm.com>
References: <20180402193154.GA3948@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 03, 2018 at 09:50:19AM -0400, Alan Stern wrote:
> On Mon, 2 Apr 2018, Paul E. McKenney wrote:
> 
> > > > I will look at this more later, reaching end of both battery and useful
> > > > attention span...
> > 
> > Like the following, perhaps?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > s390
> > 
> > include "fences.cat"
> > include "cos.cat"
> > 
> > (* Fundamental coherence ordering *)
> > let com = rf | co | fr
> > acyclic po-loc | com as coherence
> > 
> > (* Atomic *)
> > empty rmw & (fre;coe) as atom 
> > 
> > (* Fences *)
> > let mb = [M] ; fencerel(Mb) ; [M]
> > 
> > (* TSO with multicopy atomicity *)
> > let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W]) 
> > acyclic mb | po-ghb | fr | rf | co as sc
> 
> Yes, that should work okay (apart from issues related to ordering of
> atomic accesses).
> 
> By the way, what does that last "sc" stand for?  Surely not Sequential
> Consistency!  You might consider renaming it to "tso-mca".

Good point, fixed.

But it is the closest to SC in commercial computing systems, for whatever
that is worth.  ;-)

							Thanx, Paul
