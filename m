Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752726AbdGHLlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jul 2017 07:41:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v68BcXVE080076
        for <linux-arch@vger.kernel.org>; Sat, 8 Jul 2017 07:41:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bjufnmajh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 08 Jul 2017 07:41:18 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 8 Jul 2017 07:41:17 -0400
Date: Sat, 8 Jul 2017 04:41:12 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/9] Remove spin_unlock_wait()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170629235918.GA6445@linux.vnet.ibm.com>
 <20170705232955.GA15992@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0033F01@AcuExch.aculab.com>
 <20170706160555.xc63yydk77gmttae@hirez.programming.kicks-ass.net>
 <20170706162024.GD2393@linux.vnet.ibm.com>
 <20170706165036.v4u5rbz56si4emw5@hirez.programming.kicks-ass.net>
 <20170707083128.wqk6msuuhtyykhpu@gmail.com>
 <20170707144107.GA27202@linux.vnet.ibm.com>
 <20170708084323.iuyb4smp2a4ca4fh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170708084323.iuyb4smp2a4ca4fh@gmail.com>
Message-ID: <20170708114112.GO2393@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, David Laight <David.Laight@ACULAB.COM>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "dave@stgolabs.net" <dave@stgolabs.net>, "manfred@colorfullife.com" <manfred@colorfullife.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "parri.andrea@gmail.com" <parri.andrea@gmail.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Message-ID: <20170708114112.iX8jWzx0Mq70vQRfK8cp8Byz6BwKOXtJ9U6UA2mpP_s@z>

On Sat, Jul 08, 2017 at 10:43:24AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Fri, Jul 07, 2017 at 10:31:28AM +0200, Ingo Molnar wrote:
> > 
> > [ . . . ]
> > 
> > > In fact I'd argue that any future high performance spin_unlock_wait() user is 
> > > probably better off open coding the unlock-wait poll loop (and possibly thinking 
> > > hard about eliminating it altogether). If such patterns pop up in the kernel we 
> > > can think about consolidating them into a single read-only primitive again.
> > 
> > I would like any reintroduction to include a header comment saying exactly
> > what the consolidated primitive actually does and does not do.  ;-)
> > 
> > > I.e. I think the proposed changes are doing no harm, and the unavailability of a 
> > > generic primitive does not hinder future optimizations either in any significant 
> > > fashion.
> > 
> > I will have a v3 with updated comments from Manfred.  Thoughts on when/where
> > to push this?
> 
> Once everyone agrees I can apply it to the locking tree. I think PeterZ's was the 
> only objection?

Oleg wasn't all that happy, either, but he did supply the relevant patch.

> > The reason I ask is if this does not go in during this merge window, I need
> > to fix the header comment on spin_unlock_wait().
> 
> Can try it next week after some testing - let's see how busy things get for Linus 
> in the merge window?

Sounds good!  Either way is fine with me.

							Thanx, Paul
