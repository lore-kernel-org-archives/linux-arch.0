From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 07:50:00 -0700
Message-ID: <20171011145000.GA3521@linux.vnet.ibm.com>
References: <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <20171011122217.GD11106@arm.com>
 <20171011125451.GW3521@linux.vnet.ibm.com>
 <20171011141817.GG11106@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751811AbdJKOwD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 10:52:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BEpTKE014146
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 10:52:03 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dhk0hsbgd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 10:51:45 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 10:50:03 -0400
Content-Disposition: inline
In-Reply-To: <20171011141817.GG11106@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>

On Wed, Oct 11, 2017 at 03:18:17PM +0100, Will Deacon wrote:
> On Wed, Oct 11, 2017 at 05:54:51AM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 11, 2017 at 01:22:17PM +0100, Will Deacon wrote:
> > > On Wed, Oct 11, 2017 at 01:19:59PM +0100, David Howells wrote:
> > > > Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > > 
> > > > > -	node = result.terminal_node.node;
> > > > > -	smp_read_barrier_depends();
> > > > > +	node = READ_ONCE(result.terminal_node.node); /* Address dependency. */
> > > > 
> > > > The main problem I have with this method of annotation is that it's not
> > > > obvious there's a barrier there or which side the barrier is.
> > > > 
> > > > I think one of the trickiest issues is that a barrier is typically between two
> > > > things and we're not making it clear what those two things actually are.
> > > > 
> > > > Also, I would say that the most natural interpretation of READ_ONCE() is that
> > > > the implicit barrier comes after the read, e.g.:
> > > > 
> > > > 	f = READ_ONCE(stuff->foo);
> > > > 	/* Implied barrier */
> > > > 	look_at(f->a);
> > > > 	look_at(f->b);
> > > > 
> > > > I.e. READ_ONCE() prevents stuff->foo from being reread whilst you access f and
> > > > orders LOAD(stuff->foo) before LOAD(f->a) and LOAD(f->b).
> > > 
> > > FWIW, that's exactly what my patches do, this fixup looks a bit weird
> > > because it removes a prior barrier which suggests that either (a) it's in
> > > the wrong place to start with, or (b) we're annotating the wrong load.
> > 
> > You lost me on this one.  Here is the side-by-side change, minus the
> > comment:
> > 
> > node = result.terminal_node.node;		 node = READ_ONCE(result.terminal_node.node);
> > smp_read_barrier_depends();
> > 
> > The barrier was after the load that got annotated.
> 
> Yes, sorry, I completely lost my ability to read diff. Looking again, I
> don't actually know what's being ordered by the smp_read_barrier_depends()
> in the snippet above, given that assigning "node" is a load from the stack
> afaict.

Good point, and in fact the required READ_ONCE() already exists off
in assoc_array_walk().  Updated.

							Thanx, Paul
