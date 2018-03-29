Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752065AbeC2EyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Mar 2018 00:54:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2T4nwiD050666
        for <linux-arch@vger.kernel.org>; Thu, 29 Mar 2018 00:54:00 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h0j00eb2g-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Mar 2018 00:54:00 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Mar 2018 00:53:59 -0400
Date: Wed, 28 Mar 2018 18:33:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
 <20180328175136.GL4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328175136.GL4082@hirez.programming.kicks-ass.net>
Message-ID: <20180329013316.GU3675@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180329013316.rWh09egxKywQ0gia2SKXmcpUK37gpJEc8Yok4bOxSw4@z>

On Wed, Mar 28, 2018 at 07:51:36PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> > I don't quite see the point of this.  You're not suggesting that we
> > have one Linux Kernel Memory Consistency Model for s390 and another
> > one for all the other architectures, are you?
> > 
> > If the idea is merely to provide a herd model for s390 then it should 
> > go into the DIY repository, not into the LKMM repository.
> 
> I suspect the use-case was validating s390 arch code which might not
> have followed all the regular linux rules because they know its TSO. But
> yes, I'm tempted to agree that even arch specific code ought to follow
> the regular rules, just to avoid completely messing up the reader.

Another use case is testing an s390 .cat file without having to teach
herd about s390 assembly.  ;-)

							Thanx, Paul
