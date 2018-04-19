Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752391AbeDSAF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Apr 2018 20:05:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3J04rKU004257
        for <linux-arch@vger.kernel.org>; Wed, 18 Apr 2018 20:05:28 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2heekjbkum-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 18 Apr 2018 20:05:27 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 18 Apr 2018 20:05:26 -0400
Date: Wed, 18 Apr 2018 17:06:30 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model 2/5] tools/memory-model: Add
 litmus test for multicopy atomicity
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180416162228.GA18167@linux.vnet.ibm.com>
 <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180418094033.GA3409@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418094033.GA3409@andrea>
Message-ID: <20180419000630.GX26088@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180419000630.elFvrEt0CKhh_VQaD6LlJL3UGxty45deW1pz7xjLrKM@z>

On Wed, Apr 18, 2018 at 11:40:33AM +0200, Andrea Parri wrote:
> On Mon, Apr 16, 2018 at 09:22:48AM -0700, Paul E. McKenney wrote:
> > This commit adds a litmus test suggested by Alan Stern that is forbidden
> > on multicopy atomic systems, but allowed on non-multicopy atomic systems.
> > Note that other-multicopy atomic systems are examples of non-multicopy
> > atomic systems.
> > 
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  .../litmus-tests/SB+poonceoncescoh.litmus          | 31 ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> 
> We seem to be missing an entry in litmus-tests/README...

We are, and I will add one once ...

> > diff --git a/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> > new file mode 100644
> > index 000000000000..991a2d6dec63
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> > @@ -0,0 +1,31 @@
> > +C SB+poonceoncescoh
> > +
> > +(*
> > + * Result: Sometimes
> > + *
> > + * This litmus test demonstrates that LKMM is not multicopy atomic.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y)
> > +{
> > +	int r1;
> > +	int r2;
> > +
> > +	WRITE_ONCE(*x, 1);
> > +	r1 = READ_ONCE(*x);
> > +	r2 = READ_ONCE(*y);
> > +}
> > +
> > +P1(int *x, int *y)
> > +{
> > +	int r3;
> > +	int r4;
> > +
> > +	WRITE_ONCE(*y, 1);
> > +	r3 = READ_ONCE(*y);
> > +	r4 = READ_ONCE(*x);
> > +}
> > +
> > +exists (0:r2=0 /\ 1:r4=0 /\ 0:r1=1 /\ 1:r3=1)
> 
> This test has a normalised name:  why don't use that?

... we come to agreement on the documentation on how to produce a
normalized name given a standard litmus test.

Ditto for the tests whose names include the string "silsil", but
those involve locking so might be considered lower priority.

							Thanx, Paul
