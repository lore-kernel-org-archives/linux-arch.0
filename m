From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Thu, 8 Feb 2018 21:02:19 +0100
Message-ID: <20180208200219.GE25181@hirez.programming.kicks-ass.net>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180208184106.GA17043@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208184106.GA17043@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 08, 2018 at 06:41:06PM +0000, Patrick Bellasi wrote:
> Hi Paul,
> thanks to you and all the involved guys for this useful tool.
> 
> I give it a try today and found that by installing herd7 by just
> following the instruction in herdtools7/INSTALL.md, and precisely
> installing it via:
> 
>    opam install herdtools7
> 
> it seems to give you a tool which fails to run the basic example in
> your README with this error:
> 
>    File "./linux-kernel.def", line 44, characters 29-30: unexpected '-' (in macros)
> 
> As suggested by Will, by building instead herd7 HEAD (commit 44d69c2)
> everything works fine.
> 
> Maybe it's a know issue, in case just ignore me. :)
> 
> Otherwise, maybe it can be worth to add to the README a note on which
> minimum version of the herd7 tool is required.
> 
>  opma   version (not working)    : 7.47, Rev: exported
>  master version (working for me) : 7.47+7(dev), Rev: 44d69c2b1b5ca0f97bd138899d31532ee5e4e084

Urgh. So that's why it wouldn't work.

I remember Paul saying you needed the latest version, which is why I
rebuild from opam, but building top of git is a bit much.
