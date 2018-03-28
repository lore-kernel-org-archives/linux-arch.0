Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753040AbeC1QkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Mar 2018 12:40:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2SGakLj101890
        for <linux-arch@vger.kernel.org>; Wed, 28 Mar 2018 12:40:02 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2h0bpmhq4v-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 28 Mar 2018 12:40:02 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 28 Mar 2018 12:40:01 -0400
Date: Wed, 28 Mar 2018 09:33:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
Message-ID: <20180328163344.GT3675@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180328163344.r1VaOPc25if4yDvlWMAd6-WvYb9fnhD3XsMz9C0CWdE@z>

On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> On Wed, 28 Mar 2018, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > The prototype patch shown below provides files required to allow herd7 to
> > evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> > provided by s390.  This patch should be viewed with great suspicion.
> > It does what I expect it to do on SB (with and without barriers),
> > IRIW without barriers, and Alan's SB with read-of-write added, but my
> > expectations are quite likely faulty, and my test cases are very few
> > in number.
> > 
> > Either way, this is the easy part.  The hard part (which I am happy
> > to leave to others) is making litmus7 and klitmus7 able to do tests
> > on actual hardware, as well as enabling herd to handle litmus tests
> > containing BAL.  ;-)
> > 
> > Note that CPU architectures already supported by herd might well need
> > only a .cfg file that refers to herd's pre-existing support.
> > 
> > Thoughts?
> 
> I don't quite see the point of this.  You're not suggesting that we
> have one Linux Kernel Memory Consistency Model for s390 and another
> one for all the other architectures, are you?

Certainly not for common code!

> If the idea is merely to provide a herd model for s390 then it should 
> go into the DIY repository, not into the LKMM repository.

Makes sense.

In the meantime, does the cat file look to you like it correctly
models the combination of TSO and multicopy atomicity?  Do the
fences really work, or did I just get lucky with my choice of
litmus tests?

							Thanx, Paul
