Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbfCDQJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2019 11:09:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24G5RGw050367
        for <linux-arch@vger.kernel.org>; Mon, 4 Mar 2019 11:09:50 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r14j1h0sf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2019 11:09:50 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 4 Mar 2019 16:09:49 -0000
Date: Mon, 4 Mar 2019 08:09:47 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <8fbdcdc0-1f4e-e268-c183-0d65be3d39c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbdcdc0-1f4e-e268-c183-0d65be3d39c9@gmail.com>
Message-ID: <20190304160947.GB13351@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190304160947.u_9IfL0iCPxjD2Auaisw9oHVX2b_u_18E2tIn_-kNas@z>

On Sun, Mar 03, 2019 at 12:27:12AM +0900, Akira Yokosawa wrote:
> Hello Peter,
> 
> On Tue, 26 Feb 2019 14:49:06 +0100, Peter Zijlstra wrote:
> > On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
> >> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> >>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> >>> still broken.
> >>
> >> As requested on IRC:
> > 
> > What I asked was if you could get your GCC developer friends to have a
> > look at this :-)
> 
> JFYI, there is a bugzilla ticket regarding this behavior of GCC
> at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61502,
> which started on 13 June 2014 and the latest entry was on
> 02 Feb 2019.

And that bug was submitted by none other than Peter Sewell, thank you!

This bug references https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88775,
where someone appears to -want- this sort of optimization.  :-/

							Thanx, Paul
