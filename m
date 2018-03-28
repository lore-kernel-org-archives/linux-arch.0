Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752899AbeC1OTW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Mar 2018 10:19:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2SEGuBN106611
        for <linux-arch@vger.kernel.org>; Wed, 28 Mar 2018 10:19:22 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h0bpnke45-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 28 Mar 2018 10:19:21 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 28 Mar 2018 10:19:18 -0400
Date: Wed, 28 Mar 2018 07:20:04 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <20180328134813.GF4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328134813.GF4082@hirez.programming.kicks-ass.net>
Message-ID: <20180328142004.GR3675@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180328142004.hUKnr1AgvUjvL72xea-TwqSJnDqf9l2rG2XBnryQTi0@z>

On Wed, Mar 28, 2018 at 03:48:13PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 28, 2018 at 06:42:32AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > The prototype patch shown below provides files required to allow herd7 to
> > evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> > provided by s390.  
> 
> There really isn't anything s390 specific here is there? That is, would
> this not equally work for x86 and sparc, both of which are similarly TSO
> ?

As I understand it, there is a difference.  The difference from TSO
systems such as x86 is that s390 is multicopy atomic as well as TSO.
In contrast, x86 is TSO as well as other-multicopy-atomic.  I must defer
to Martin and Christian for details -- this should be interpreted as a
feeble first attempt on my part, not any sort of IBM-approved definition
of s390.  ;-)

> Given that, should this not be called TSO instead of s390 ?

I agree completely with a single tso.cfg, TSO.cfg, or whatever name,
as opposed to a bunch of identical files for x86, SPARC, ...

							Thanx, Paul
