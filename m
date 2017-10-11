From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 09:19:33 -0700
Message-ID: <20171011161933.GH3521@linux.vnet.ibm.com>
References: <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <7484.1507738025@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751705AbdJKQTj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 12:19:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BGF6VR003243
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 12:19:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dhn6c513k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 12:19:38 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 12:19:38 -0400
Content-Disposition: inline
In-Reply-To: <7484.1507738025@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com

On Wed, Oct 11, 2017 at 05:07:05PM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > It does not.  In most cases, the barriered version would be
> > smp_store_release().
> 
> Ummm... Is that good enough?  Is:
> 
> 	WRITE_ONCE(x, 1);
> 	WRITE_ONCE(x, 2);
> 
> equivalent to:
> 
> 	smp_store_release(x, 1);
> 	smp_store_release(x, 2);
> 
> if CONFIG_SMP=n?

	smp_store_release(&x, 1);
	smp_store_release(&x, 2);

But yes, give or take that smp_store_release() potentially disables
more compiler optimizations than does WRITE_ONCE().

> (Consider what happens if an interrupt messes with x).

OK, I will bite...  What is your scenario in which an interrupt
gives different results for CONFIG_SMP=n?  The barriers

> If it is good enough, should we be using smp_load_acquire() rather than
> READ_ONCE()?

On x86, that might be OK, give or take that smp_load_acquire() potentially
disables more optimizations than does READ_ONCE().  But on ARM, PowerPC,
MIPS, and so on, smp_load_acquire() emits a memory-barrier instruction
and READ_ONCE() does not.

							Thanx, Paul
