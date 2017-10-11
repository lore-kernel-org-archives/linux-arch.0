Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752077AbdJKQuJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 12:50:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BGnIk7142281
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 12:50:09 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dhpgs20jm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 12:50:09 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 12:50:08 -0400
Date: Wed, 11 Oct 2017 09:50:04 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
Message-ID: <20171011165004.GA14318@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com
Message-ID: <20171011165004.KXckoTZYF_Odfm0N0yt1Pu2idETDXFt_m__2lG1QOKU@z>

On Wed, Oct 11, 2017 at 06:12:20PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2017 at 08:59:48AM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 11, 2017 at 04:17:25PM +0100, David Howells wrote:
> > > I will, however, quibble with the appropriateness of the name READ_ONCE()...
> > > I still think it's not sufficiently obvious that this is a barrier and the
> > > barrier is after.  Maybe READ_AND_BARRIER()?
> > 
> > Linus was unhappy with READ_ONCE_CTRL() to tag control dependencies, but
> > indicated that he might consider it if it helped code-analysis tools.
> > Adding Dmitry Vyukov for his thoughts on whether tagging READ_ONCE()
> > for dependencies would help.  Me, I would suggest READ_ONCE_DEP(), but
> > let's figure out if the bikeshed needs to be painted before arguing over
> > the color.  ;-)
> 
> Count me one vote for the READ_ONCE() name. This is about dependent
> reads, which are nothing special on anything except Alpha.

Agreed, unless specially marking them makes it easier for tools to
find bugs.  In which case, we should definitely specially mark them.

							Thanx, Paul
