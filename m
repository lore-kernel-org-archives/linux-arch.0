From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Fri, 9 Feb 2018 10:11:10 +0100
Message-ID: <20180209091110.GA14128@andrea>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180208184106.GA17043@e110439-lin>
 <20180208200219.GE25181@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208200219.GE25181@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 08, 2018 at 09:02:19PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 08, 2018 at 06:41:06PM +0000, Patrick Bellasi wrote:
> > Hi Paul,
> > thanks to you and all the involved guys for this useful tool.
> > 
> > I give it a try today and found that by installing herd7 by just
> > following the instruction in herdtools7/INSTALL.md, and precisely
> > installing it via:
> > 
> >    opam install herdtools7
> > 
> > it seems to give you a tool which fails to run the basic example in
> > your README with this error:
> > 
> >    File "./linux-kernel.def", line 44, characters 29-30: unexpected '-' (in macros)
> > 
> > As suggested by Will, by building instead herd7 HEAD (commit 44d69c2)
> > everything works fine.
> > 
> > Maybe it's a know issue, in case just ignore me. :)
> > 
> > Otherwise, maybe it can be worth to add to the README a note on which
> > minimum version of the herd7 tool is required.
> > 
> >  opma   version (not working)    : 7.47, Rev: exported
> >  master version (working for me) : 7.47+7(dev), Rev: 44d69c2b1b5ca0f97bd138899d31532ee5e4e084
> 
> Urgh. So that's why it wouldn't work.
> 
> I remember Paul saying you needed the latest version, which is why I
> rebuild from opam, but building top of git is a bit much.

+1

_Sadly_ enough, co-developers and I were aware of this issue,
but it was only mildly reported here (c.f.,

  https://marc.info/?l=linux-kernel&m=151638196427685&w=2 ).

This bisects to that (crazy):

  2d5fba7782d669c6a1cc577dbc3bf507780273bb
  ("linux-kernel*: Make RCU identifiers match ASPLOS paper")

  From repo.: https://github.com/aparri/memory-model

which not only did break 7.47, but also made the bell uglier
by mixing dashes and underscores in a very same block.

As a solution to this issue, I can envisage a partial revert
of that commit (just replace those dashes); Paul, Jade, Luc:
any better solution?

(Sorry for being late on IRC, glad this came out here,)

  Andrea
