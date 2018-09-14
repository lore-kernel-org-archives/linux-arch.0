Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbeINXpK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 19:45:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EITN3q040042
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 14:29:27 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mgg2vd97t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 14:29:27 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 14:29:26 -0400
Date: Fri, 14 Sep 2018 11:29:21 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
Reply-To: paulmck@linux.ibm.com
References: <20180914163649.GA13942@linux.ibm.com>
 <Pine.LNX.4.44L0.1809141315580.1482-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809141315580.1482-100000@iolanthe.rowland.org>
Message-ID: <20180914182921.GC652@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, Will Deacon <will.deacon@arm.com>, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com
Message-ID: <20180914182921.BfoWj6x79I2chYuJqgROipYfjme2x5XWbkNCz2CN7UI@z>

On Fri, Sep 14, 2018 at 01:19:37PM -0400, Alan Stern wrote:
> On Fri, 14 Sep 2018, Paul E. McKenney wrote:
> 
> > 	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
> > 
> > 		Small change, needs an ack.  Looks to me like is is
> > 		just aligning the documentation with the code, so
> > 		should not be controversial (famous last words).
> > 
> > 		Please take a look and consider giving feedback
> > 		and/or a review/ack.
> 
> What branch is this commit in?  It doesn't seem to be in the lkmm 
> branch.

It was in the dev branch, and was the child of the lkmm branch.

> In any case, the change is trivial and obviously correct.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you, applied!

And now it is in the lkmm branch.  ;-)

							Thanx, Paul
