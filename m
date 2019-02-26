Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbfBZPkG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 10:40:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QFOswq137807
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 10:40:04 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw6bb85x6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 10:40:04 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Feb 2019 15:40:03 -0000
Date: Tue, 26 Feb 2019 07:39:57 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <20190226144730.GV32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226144730.GV32477@hirez.programming.kicks-ass.net>
Message-ID: <20190226153957.GN4072@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226153957.5LXiPyNHV3pHqKDGjp8oKi_7mLEfurnx8NGYLI3xksE@z>

On Tue, Feb 26, 2019 at 03:47:30PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 06:28:45AM -0800, Paul E. McKenney wrote:
> > I must confess to not being all that sympathetic to code that takes
> > advantage of happenstance stack-frame layout.  Is there some reason
> > we need that?
> 
> Not that I'm aware; but if it gets this 'obvious' case wrong, I worry
> what else it gets wrong.
> 
> At the very least we should get this fixed and compile a kernel with the
> fixed compiler to see what (if anything) changes in the generated code
> and analyse the changes (if any) to make sure we were ok (or not).
> 
> I mean; yes that example is UB, but the result is also clearly batshit
> insane.

My understanding is that their goal is better analysis of pointer
aliasing, and that this case is a side effect.

							Thanx, Paul
