Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbeFDP7t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jun 2018 11:59:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w54Fsn7F039818
        for <linux-arch@vger.kernel.org>; Mon, 4 Jun 2018 11:59:49 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jd84v9bht-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 04 Jun 2018 11:59:49 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 4 Jun 2018 11:59:47 -0400
Date: Mon, 4 Jun 2018 09:01:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180602144440.GI3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1806041014250.1380-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806041014250.1380-100000@iolanthe.rowland.org>
Message-ID: <20180604160129.GP3593@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
Message-ID: <20180604160129.G08FpqpsjvAC1iGhTtrPBmxhWP-jgRLPzyk2LGmRKp8@z>

On Mon, Jun 04, 2018 at 10:17:47AM -0400, Alan Stern wrote:
> On Sat, 2 Jun 2018, Paul E. McKenney wrote:
> 
> > One crude but effective workaround is to replicate the code following the
> > "if" statement into both legs of the "if" statement.  This has the effect
> > of extending the control dependency to cover all of the code that used to
> > follow the "if" statement, leveraging herd's current limited knowledge of
> > compiler optimization.  This workaround would of course be hopeless for
> > general Linux-kernel code, but should be at least semi-acceptable for the
> > very small snippets of code that can be accommodated within litmus tests.
> > 
> > Please see the litmus test shown below, which uses this workaround,
> > allowing the smp_store_release() to be downgraded to WRITE_ONCE().
> > 
> > Given this workaround, crude though it might be, I believe that we can
> > take a more measured approach to identifying a longer-term solution.
> > 
> > Thoughts?
> 
> Yes, this works, although it is clearly just a stopgap.  And obviously
> it can't be applied in situations where one of the legs of the "if"  
> statement contains a non-trivial branch.

A non-trivial branch as in a goto?  If so, that could be problematic
depending on exactly what herd does in that case.

> In the long run, I don't think this problem is solvable.  At least, not 
> for all cases.  It requires too much guesswork about what optimizations 
> a compiler might do.

I agree that it cannot be perfect, but I bet that we can come extremely
close.  But yes, we need to think carefully about nested "if" statements
at the very least.  And there might well be some other way to get in
trouble.  ;-)

							Thanx, Paul
