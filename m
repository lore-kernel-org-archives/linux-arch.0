Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbfBZPEo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 10:04:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QF01rb029061
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 10:04:42 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw6g05mvx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 10:04:39 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Feb 2019 15:04:33 -0000
Date: Tue, 26 Feb 2019 07:04:27 -0800
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
 <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
Message-ID: <20190226150427.GM4072@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226150427.MdcQ1q8n8Wer-3p1Aclt1EzJTq8HEG0EA1_Nh3ao9G4@z>

On Tue, Feb 26, 2019 at 11:56:57PM +0900, Akira Yokosawa wrote:
> Hi Paul,
> 
> On Tue, 26 Feb 2019 06:28:45 -0800, Paul E. McKenney wrote:
> > On Tue, Feb 26, 2019 at 02:49:06PM +0100, Peter Zijlstra wrote:
> >> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
> >>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> >>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> >>>> still broken.
> >>>
> >>> As requested on IRC:
> >>
> >> What I asked was if you could get your GCC developer friends to have a
> >> look at this :-)
> > 
> > Yes, this all is a bit on the insane side from a kernel viewpoint.
> > But the paper you found does not impose this; it has instead been there
> > for about 20 years, back before C and C++ admitted to the existence
> > of concurrency.
> 
> By "it", do you mean the concept of "pointer provenance"?
> 
> I'm asking because the paper's header reads:
> 
>         "ISO/IEC JTC1/SC22/WG14 N2311, 2018-11-09"
> 
> Just wanted to make sure.

This paper introduces neither pointer provenance nor indeterminate-on-free,
but rather proposes modification.  These things have been around for a
few decades.

							Thanx, Paul

>         Thanks, Akira
> 
> >                  But of course compilers are getting more aggressive,
> > and yes, some of the problems show up in single-threaded code.
> > 
> > The usual response is "then cast the pointers to intptr_t!" but of
> > course that breaks type checking.
> > 
> > There is an effort to claw back the concurrency pieces, and I would
> > be happy to run the resulting paper past you guys.
> > 
> > I must confess to not being all that sympathetic to code that takes
> > advantage of happenstance stack-frame layout.  Is there some reason
> > we need that?
> > 
> > 							Thanx, Paul
> > 
> 
