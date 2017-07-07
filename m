Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750905AbdGGOlO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2017 10:41:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67Ecq28130734
        for <linux-arch@vger.kernel.org>; Fri, 7 Jul 2017 10:41:13 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bjaqac9kk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 07 Jul 2017 10:41:13 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 10:41:12 -0400
Date: Fri, 7 Jul 2017 07:41:07 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707083128.wqk6msuuhtyykhpu@gmail.com>
Message-ID: <20170707144107.GA27202@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, David Laight <David.Laight@ACULAB.COM>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "dave@stgolabs.net" <dave@stgolabs.net>, "manfred@colorfullife.com" <manfred@colorfullife.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "parri.andrea@gmail.com" <parri.andrea@gmail.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Message-ID: <20170707144107.nY9bmWcTfkQnBHowRO3Zrb3jsM5Jnr-JA8zi606g_aQ@z>

On Fri, Jul 07, 2017 at 10:31:28AM +0200, Ingo Molnar wrote:

[ . . . ]

> In fact I'd argue that any future high performance spin_unlock_wait() user is 
> probably better off open coding the unlock-wait poll loop (and possibly thinking 
> hard about eliminating it altogether). If such patterns pop up in the kernel we 
> can think about consolidating them into a single read-only primitive again.

I would like any reintroduction to include a header comment saying exactly
what the consolidated primitive actually does and does not do.  ;-)

> I.e. I think the proposed changes are doing no harm, and the unavailability of a 
> generic primitive does not hinder future optimizations either in any significant 
> fashion.

I will have a v3 with updated comments from Manfred.  Thoughts on when/where
to push this?

The reason I ask is if this does not go in during this merge window, I need
to fix the header comment on spin_unlock_wait().

							Thanx, Paul
