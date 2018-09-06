Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46154 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeIFS1o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 14:27:44 -0400
Date: Thu, 6 Sep 2018 14:52:18 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Message-ID: <20180906135218.GA5212@arm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
 <20180529121107.GF3803@linux.vnet.ibm.com>
 <20180529201713.GD591@arm.com>
 <20180906000117.GG4225@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906000117.GG4225@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
Message-ID: <20180906135218.Byrbw3aFgO3yrUVMxKpyBo8hcVZ0xVgp_QQQSsxYCFk@z>

On Wed, Sep 05, 2018 at 05:01:17PM -0700, Paul E. McKenney wrote:
> On Tue, May 29, 2018 at 09:17:13PM +0100, Will Deacon wrote:
> > On Tue, May 29, 2018 at 05:11:07AM -0700, Paul E. McKenney wrote:
> > > On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> > > > Hi Paul,
> > > > 
> > > > On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > > > > This commit documents the scheme used to generate the names for the
> > > > > litmus tests.
> > > > > 
> > > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > ---
> > > > >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > > 
> > > > Whilst I think documentation like this is extremely important for users,
> > > > this feels like it's documenting how to drive parts of diy and I'm not
> > > > convinced that it belongs in the kernel source tree as long as the projects
> > > > remain separate.
> > > > 
> > > > Why not contribute this to the herdtools7 documentation, then just reference
> > > > that from here? That would also be helpful for other people interested in
> > > > memory models, but perhaps not interested in Linux (assuming such people
> > > > exist ;).
> > > 
> > > We would still need at least a pointer from the Linux kernel to that
> > > documentation, but I am happy either way.  We probably need examples of
> > > the common cases, but probably not a full exposition of all the available
> > > herd7 edges.
> > 
> > Completely agreed.
> > 
> > > Should this be in the herdtools7 documentation, or as added detail
> > > from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
> > > command?  If the latter, I suppose that the ones coming from the .bell
> > > file might simply be labelled as such.
> > 
> > Many of the edges aren't specific to the Linux kernel, so I think they
> > should be part of the diyone7 documentation. We could then describe only
> > the additional edges added by the kernel memory model (e.g. "Once") in
> > the kernel documentation.
> 
> And there are a -lot- of them, and they are likely to change going
> forward, both in herd7 and in linux-kernel.bell.  How about if I give
> examples and say where they are from and how to get a list, as in the
> following --squash commit to be merged with the orginal?

Sure, that looks much easier to maintain. With that, you can add my ack:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will

> ------------------------------------------------------------------------
> 
> commit e366b8cd832535894c55265c112355c4de9a3247
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Wed Sep 5 15:38:00 2018 -0700
> 
>     squash! EXP tools/memory-model: Add litmus-test naming scheme
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     [ paulmck: Apply feedback from Will Deacon. ]
> 
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 08c1116c0314..5ee08f129094 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -243,56 +243,11 @@ produce the name:
>  
>  Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
>  
> +The descriptors that describe connections between consecutive accesses
> +within the cycle through a given litmus test can be provided by the herd
> +tool (Rfi, Po, Fre, and so on) or by the linux-kernel.bell file (Once,
> +Release, Acquire, and so on).
>  
> -=======================
> -LITMUS TEST DESCRIPTORS
> -=======================
> -
> -These descriptors cover connections between consecutive accesses within
> -the cycle through a given litmus test:
> -
> -Fre: From-read external.  The current process wrote a variable that
> -	the previous process read.  Example: The SB (store buffering) test.
> -Fri: From-read internal.  This process read a variable and then
> -	immediately wrote to it.  Example: ???
> -PodRR: Program-order different variable, read followed by read.
> -	This process read a variable and again read a different variable.
> -	Example: The read-side process in the MP (message-passing) test.
> -PodRW: Program-order different variable, read followed by write.
> -	This process read a variable and then wrote a different variable.
> -	Example: The LB (load buffering) test.
> -PodWR: Program-order different variable, write followed by read.
> -	This process wrote a variable and then read a different variable.
> -	Example: The SB (store buffering) test.
> -PodWW: Program-order different variable, write followed by write.
> -	This process wrote a variable and again wrote a different variable.
> -	Example: The write-side process in the MP (message-passing) test.
> -PosRR: Program-order same variable, read followed by read.
> -	This process read a variable and again read that same variable.
> -	Example: ???
> -PosRW: Program-order same variable, read followed by write.
> -	This process read a variable and then wrote that same variable.
> -	Example: ???
> -PosWR: Program-order same variable, write followed by read.
> -	This process wrote a variable and then read that same variable.
> -	Example: ???
> -PosWW: Program-order same variable, write followed by write.
> -	This process wrote a variable and again wrote that same variable.
> -	Example: ???
> -Rfe: Read-from external.  The current process read a variable written
> -	by the previous process.  Example: The MP (message passing) test.
> -Rfi: Read-from internal.  The current process wrote a variable and then
> -	immediately read the value back from it.  For the purposes
> -	of litmus-test code generation, Rfi acts identically to PosWR.
> -	However, they differ for purposes of naming, and they also result
> -	in different "exists" clauses.
> -	Example:  ???
> -Wse: Write same external.  The current process wrote to a variable that
> -	was also written to by the previous process.  Example:  ???
> -Wsi: Write same internal.  The current process wrote to a variable and
> -	then immediately wrote to it again.  Example:  ???
> -
> -Please note that the above is a partial list.  To see the full list of
> -descriptors, execute the following command:
> +To see the full list of descriptors, execute the following command:
>  
>  	$ diyone7 -bell linux-kernel.bell -show edges
> 
