Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40771 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751653AbdGFQUa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 12:20:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v66GIwo5117052
        for <linux-arch@vger.kernel.org>; Thu, 6 Jul 2017 12:20:30 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bhqu8jant-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 06 Jul 2017 12:20:29 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Jul 2017 12:20:29 -0400
Date: Thu, 6 Jul 2017 09:20:24 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/9] Remove spin_unlock_wait()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170629235918.GA6445@linux.vnet.ibm.com>
 <20170705232955.GA15992@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0033F01@AcuExch.aculab.com>
 <20170706160555.xc63yydk77gmttae@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706160555.xc63yydk77gmttae@hirez.programming.kicks-ass.net>
Message-ID: <20170706162024.GD2393@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Laight <David.Laight@ACULAB.COM>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "dave@stgolabs.net" <dave@stgolabs.net>, "manfred@colorfullife.com" <manfred@colorfullife.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "parri.andrea@gmail.com" <parri.andrea@gmail.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Message-ID: <20170706162024.gFeLtR0MTEwXrileYgyqHPhboKU-tbUot0BtZerM2Qk@z>

On Thu, Jul 06, 2017 at 06:05:55PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 06, 2017 at 02:12:24PM +0000, David Laight wrote:
> > From: Paul E. McKenney

[ . . . ]

> Now on the one hand I feel like Oleg that it would be a shame to loose
> the optimization, OTOH this thing is really really tricky to use,
> and has lead to a number of bugs already.

I do agree, it is a bit sad to see these optimizations go.  So, should
this make mainline, I will be tagging the commits that spin_unlock_wait()
so that they can be easily reverted should someone come up with good
semantics and a compelling use case with compelling performance benefits.

							Thanx, Paul
