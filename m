From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/15] Remove to-be-unneeded
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 05:56:36 -0700
Message-ID: <20171011125636.GX3521@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <26479.1507724463@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753027AbdJKM4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 08:56:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BCtDO0043829
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 08:56:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dhhdrskjd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 08:56:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 08:56:41 -0400
Content-Disposition: inline
In-Reply-To: <26479.1507724463@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, tj@kernel.org, cl@linux.com, davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org, corbet@lwn.net, james.l.morris@oracle.com, torvalds@linux-foundation.org

On Wed, Oct 11, 2017 at 01:21:03PM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Will Deacon has proposed adding smp_read_barrier_depends() to READ_ONCE(),
> > which would mean that quite a few instances of smp_read_barrier_depends()
> > would become redundant.
> 
> It's not clear from you description where the barrier is added in relation to
> the read: before, after or both?

After, similar to lockless_dereference().  Of course, there is not
really a barrier except for on Alpha.

							Thanx, Paul
