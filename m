Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932210AbdJJQFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 12:05:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9AG2u0n041745
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 12:05:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgyynd8gn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 12:05:29 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Oct 2017 12:05:28 -0400
Date: Tue, 10 Oct 2017 09:05:23 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <20171010155451.wv2dfirmra5aeake@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010155451.wv2dfirmra5aeake@hirez.programming.kicks-ass.net>
Message-ID: <20171010160523.GH3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171010160523.DrStmhEpDBS64ejCm2sMlo3RrSKxovoEeQ5jeINRjrc@z>

On Tue, Oct 10, 2017 at 05:54:51PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2017 at 08:50:42AM -0700, Paul E. McKenney wrote:
> > +			/* We need a barrier between the read of the pointer,
> > +			 * which is supplied by the above READ_ONCE().
> >  			 */
> 
> >  			/* We need a barrier between the read of the pointer
> >  			 * and dereferencing the pointer - but only if we are
> >  			 * actually going to dereference it.
> >  			 */
> 
> Could you also fix those "disgusting drug-induced crap" comment styles
> while you're there anyway?
> 
>   http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html

If Dave is OK with it, I will do so on my next pass.

							Thanx, Paul
