From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Tue, 3 Apr 2018 09:50:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
References: <20180402193154.GA3948@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402193154.GA3948@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, 2 Apr 2018, Paul E. McKenney wrote:

> > > I will look at this more later, reaching end of both battery and useful
> > > attention span...
> 
> Like the following, perhaps?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> s390
> 
> include "fences.cat"
> include "cos.cat"
> 
> (* Fundamental coherence ordering *)
> let com = rf | co | fr
> acyclic po-loc | com as coherence
> 
> (* Atomic *)
> empty rmw & (fre;coe) as atom 
> 
> (* Fences *)
> let mb = [M] ; fencerel(Mb) ; [M]
> 
> (* TSO with multicopy atomicity *)
> let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W]) 
> acyclic mb | po-ghb | fr | rf | co as sc

Yes, that should work okay (apart from issues related to ordering of
atomic accesses).

By the way, what does that last "sc" stand for?  Surely not Sequential
Consistency!  You might consider renaming it to "tso-mca".

Alan
