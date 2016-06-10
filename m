Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9635 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932296AbcFJR7J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jun 2016 13:59:09 -0400
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5AHwt7k000570
	for <linux-arch@vger.kernel.org>; Fri, 10 Jun 2016 13:59:08 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23g1eehc7e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 10 Jun 2016 13:59:08 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 10 Jun 2016 13:59:07 -0400
Date: Fri, 10 Jun 2016 09:39:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC 10/12] x86, rwsem: simplify __down_write
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160603223417.GB3892@twins.programming.kicks-ass.net>
 <1454444369-2146-1-git-send-email-mhocko@kernel.org>
 <1454444369-2146-11-git-send-email-mhocko@kernel.org>
 <20160203081016.GD32652@gmail.com>
 <20160603161339.GC3693@twins.programming.kicks-ass.net>
 <29355.1465483258@warthog.procyon.org.uk>
 <20160609173640.GX30154@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160609173640.GX30154@twins.programming.kicks-ass.net>
Message-ID: <20160610163941.GC3868@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jason Low <jason.low2@hpe.com>
Message-ID: <20160610163941.3rNRerR3wnDXB5npTAGTlSUnyPlLm-Lm-jJzufF0CPQ@z>

On Thu, Jun 09, 2016 at 07:36:40PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 09, 2016 at 03:40:58PM +0100, David Howells wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Blergh; so looking at more asm there's still a few tricks we cannot do.
> > > So while overall size is down, some paths do end up more expensive. (It
> > > typically boils down to creative use of condition flags, which is very
> > > hard in C)
> > 
> > It can be done using ISO __atomic_fetch_add() and suchlike.
> 
> (ISO-C11, ISO as such is a bad abbreviation I think)
> 
> Maybe, but we're almost there with __GCC_ASM_FLAG_OUTPUTS__.
> 
> atomic_long_add_negative() can be made to do inc;j(n)s for __down_read.
> 
> the try_cmpxchg family you wanted to add independent from the ISO-C11
> bits can do the cmpxchg-j(n)z for __down_{read,write}_trylock.
> 
> That only leaves us wanting an atomic_long_fetch_add_negative() for
> __up_{read,write}().
> 
> Although I suppose, for this to be of use for our weakly ordered
> friends, we need _relaxed versions of all that (so that _acquire and
> _release variants are generated).

Historically, the compilers have won this sort of contest over the
long term.  That said, there is nothing quite like raising the bar for
them to help them generate decent code.  So, David and Peter, I am behind
both of you 100%.  ;-)

							Thanx, Paul

