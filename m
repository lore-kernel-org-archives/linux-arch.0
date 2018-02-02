From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Thu, 1 Feb 2018 21:40:13 -0800
Message-ID: <20180202054013.GV3741@linux.vnet.ibm.com>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180201011728.GL3741@linux.vnet.ibm.com>
 <20180202044603.i2z3q25jeftbct5c@tardis>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751935AbeBBIlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Feb 2018 03:41:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w128edBg085905
        for <linux-arch@vger.kernel.org>; Fri, 2 Feb 2018 03:41:09 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fvgm09bgg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 02 Feb 2018 03:41:07 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Feb 2018 03:40:52 -0500
Content-Disposition: inline
In-Reply-To: <20180202044603.i2z3q25jeftbct5c@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Feb 02, 2018 at 12:46:03PM +0800, Boqun Feng wrote:
> On Wed, Jan 31, 2018 at 05:17:28PM -0800, Paul E. McKenney wrote:
> [...]
> > > - A long term question: have you considered and would it make sense to generate a
> > >   memory-barriers.txt like file directly into Documentation/locking/, using the
> > >   formal description? That way any changes/extensions/fixes to the model could be
> > >   tracked on a high level, without readers having to understand the formal
> > >   representation.
> > 
> > I hadn't considered this at all, actually.  ;-)
> > 
> > The sections of memory-barriers.txt dealing with MMIO ordering would need
> > to stay hand-generated, but they are a very small fraction of the total.
> > The herd7 tool is capable of generating cool diagrams sort of like
> > this one: https://static.lwn.net/images/2017/mm-model/rmo-acyclic.png,
> > which might replace at least some of the hand-generated ASCII-art
> > diagrams.
> 
> Which reminds me, one thing we could start with is to try to convert all
> the examples with litmus tests. Has this been done somewhere (e.g. in
> your litmus github repo)? If not, I can try if you think that's a good
> idea.

That would be very helpful, thank you!

There are probably some that are already in the litmus-tests directory,
but I suspect that most are not yet converted.  So please do!

							Thanx, Paul

> Regards,
> Boqun
> 
> > Although I do confess harboring some skepticism about being able to
> > generated high-quality text, there is no denying that it would be
> > valuable to be able to do so.
> > 
> > > In any case, the base commit is certainly nice and clean and I've pulled it into 
> > > tip:locking/core for a v4.17 merge.
> > 
> > Very good!
> > 
> > > I believe these additional improvements (to the extent you agree with doing them!) 
> > > could/should be done as add-on commits on top of this existing commit.
> > 
> > Sounds good!
> > 
> > Would you prefer a pull request or a patch series for these?
> > 
> > 							Thanx, Paul
> > 
