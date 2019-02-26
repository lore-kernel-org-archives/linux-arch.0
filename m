Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfBZO2y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 09:28:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QEEw8t097444
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 09:28:53 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw6ksjswg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 09:28:52 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Feb 2019 14:28:51 -0000
Date: Tue, 26 Feb 2019 06:28:45 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226134906.GG32494@hirez.programming.kicks-ass.net>
Message-ID: <20190226142845.GK4072@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226142845.WGAqygFVAeRe0u6SrmKgOWeycdTBpOOSNBRBqmPK97M@z>

On Tue, Feb 26, 2019 at 02:49:06PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
> > On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> > > When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> > > still broken.
> > 
> > As requested on IRC:
> 
> What I asked was if you could get your GCC developer friends to have a
> look at this :-)

Yes, this all is a bit on the insane side from a kernel viewpoint.
But the paper you found does not impose this; it has instead been there
for about 20 years, back before C and C++ admitted to the existence
of concurrency.  But of course compilers are getting more aggressive,
and yes, some of the problems show up in single-threaded code.

The usual response is "then cast the pointers to intptr_t!" but of
course that breaks type checking.

There is an effort to claw back the concurrency pieces, and I would
be happy to run the resulting paper past you guys.

I must confess to not being all that sympathetic to code that takes
advantage of happenstance stack-frame layout.  Is there some reason
we need that?

							Thanx, Paul
