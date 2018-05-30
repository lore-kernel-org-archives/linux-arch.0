Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753686AbeE3ToR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 15:44:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UJhxwS090345
        for <linux-arch@vger.kernel.org>; Wed, 30 May 2018 15:44:16 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ja131kf8k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 30 May 2018 15:44:16 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 30 May 2018 15:44:15 -0400
Date: Wed, 30 May 2018 12:45:54 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
Message-ID: <20180530194554.GM7063@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
Message-ID: <20180530194554._wUOOHZq23KgEMNBDhECtAt3clGdzrb3nJLFN68zOoY@z>

On Wed, May 30, 2018 at 03:08:43PM -0400, Alan Stern wrote:
> On Wed, 30 May 2018, Paul E. McKenney wrote:
> 
> > On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
> > > On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> > > wrote:
> > > 
> > > > >
> > > > > Can't we simplify the whole sequence as basically
> > > > >
> > > > >      A
> > > > >      if (!B)
> > > > >          D
> > > > >
> > > > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > > > whole "not executed" code.
> > > 
> > > > Your listing is slightly misleading.
> > > 
> > > No. You're confused.
> > > 
> > > You're confused because you're conflating two *entirely* different things.
> > > 
> > > You're conflating the static source code with the dynamic execution. They
> > > are NOT THE SAME.
> > 
> > I am going to go out on a limb and assert that Linus is talking about
> > what gcc and hardware do, while Alan is talking about what the tool and
> > memory model do.
> 
> Indeed.  The very first line Linus quoted in his first reply to me
> (elided above) was:
> 
> 	Putting this into herd would be extremely difficult, if not impossible,
> 	because it involves analyzing code that was not executed.
> 
> It should be clear from this that I was talking about herd.  Not gcc or
> real hardware.
> 
> (After rereading his message a few times, I'm not sure exactly what 
> Linus was talking about...)
