Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753404AbeFGTzq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 15:55:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57JsQxw013982
        for <linux-arch@vger.kernel.org>; Thu, 7 Jun 2018 15:55:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf90tpdsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 15:55:45 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 15:55:44 -0400
Date: Thu, 7 Jun 2018 12:57:28 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
 <20180606190710.GY3593@linux.vnet.ibm.com>
 <CA+55aFwZTAp3wZYGSJR1kPkc=QhPNMdEEPttsM4REcWPPDH9Bw@mail.gmail.com>
 <20180607094314.GF3593@linux.vnet.ibm.com>
 <CA+55aFzs0ueN22WaKs_R6=T4HHY9j0MtpoFA8eh=t=PN7grCnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzs0ueN22WaKs_R6=T4HHY9j0MtpoFA8eh=t=PN7grCnA@mail.gmail.com>
Message-ID: <20180607195728.GM3593@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20180607195728.rEtueJ7lVh01BJr9_bM-nVRJ0_ER2VeisAODDPxLqao@z>

On Thu, Jun 07, 2018 at 08:06:51AM -0700, Linus Torvalds wrote:
> On Thu, Jun 7, 2018 at 2:41 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > We are considering adding unmarked accesses, for example, accesses
> > protected by locks.  One possible litmus test (not yet supported!)
> > might look like this:
> 
> Fair enough - you do want to have the distinction between "marked" and
> "unmarked".
> 
> And it does make sense, although at that point I think you do hit the
> "what can a compiler do" issue more. Right now, I think the things you
> check are all pretty much "compiler can't do a lot of movement".

Agreed, and the added freedom unmarked accesses give the compiler is
one reason why this is something being thought about as opposed to
something already done.  The approach that looks most feasible is to
make LKMM complain if there is a data race involving unmarked accesses.
This is a bit annoying given the Linux kernel's large number of unmarked
accesses to shared variable that do involve data races, however, my
belief is that developers and maintainers of such code are under the
obligation to make sure that the compiler cannot mess them up.  One
way that they could do this is to list the transformations that the
compiler could carry out, and make a separate litmus test for each,
substituting READ_ONCE() and WRITE_ONCE() for the unmarked accesses.

Then unmarked accesses would be for code protected by locks or that
used dependencies to avoid data races.

Thoughts?

> But I suspect that the markings you do have are going to be fairly
> limited. Things like "READ_ONCE()" vs "smp_read_acquire()" are still
> fairly simple from a compiler standpoint, at least when it comes to
> control flow - they have "side effects". So I guess that's the only
> real difference there - a regular read doesn't have side effects, so
> it could be moved up past a conditional, and/or duplicated for each
> use. That sounds much more complex to the checker than the existing
> things it supports, no?

Indeed!

And those sorts of compiler transformations are one of the things that
has pushed us to the "no data races" model.  If there are no data races,
then those compiler transformations don't affect the outcome, given that
C11 and later compilers are not allowed to introduce data races.

							Thanx, Paul
