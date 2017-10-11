Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751991AbdJKM7E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 08:59:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BCx22N146844
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 08:59:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dhj86egw8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 08:59:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 08:59:02 -0400
Date: Wed, 11 Oct 2017 05:58:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26455.1507724399@warthog.procyon.org.uk>
Message-ID: <20171011125857.GY3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171011125857.PKjpBo4GlXk6IAvkKHlsl_l7s8G2Lj_PYM3iGqBfXpk@z>

On Wed, Oct 11, 2017 at 01:19:59PM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > -	node = result.terminal_node.node;
> > -	smp_read_barrier_depends();
> > +	node = READ_ONCE(result.terminal_node.node); /* Address dependency. */
> 
> The main problem I have with this method of annotation is that it's not
> obvious there's a barrier there or which side the barrier is.
> 
> I think one of the trickiest issues is that a barrier is typically between two
> things and we're not making it clear what those two things actually are.
> 
> Also, I would say that the most natural interpretation of READ_ONCE() is that
> the implicit barrier comes after the read, e.g.:
> 
> 	f = READ_ONCE(stuff->foo);
> 	/* Implied barrier */
> 	look_at(f->a);
> 	look_at(f->b);
> 
> I.e. READ_ONCE() prevents stuff->foo from being reread whilst you access f and
> orders LOAD(stuff->foo) before LOAD(f->a) and LOAD(f->b).

Placing the comment on the same line makes it less likely that some
later change will move the comment away from the load that it applies to.
Which appears to have happened on some of the other instances of
smp_read_barrier_depends() in other parts of the kernel.  It is not at
all clear what load they go with, or if that load is even still present
in the kernel.  :-/

							Thanx, Paul
