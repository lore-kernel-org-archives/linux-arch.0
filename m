Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753979AbeAaXxz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jan 2018 18:53:55 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0VNnwDD034803
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2018 18:53:55 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fukdejkam-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2018 18:53:54 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 Jan 2018 18:53:53 -0500
Date: Wed, 31 Jan 2018 15:53:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180131100822.GL2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131100822.GL2269@hirez.programming.kicks-ass.net>
Message-ID: <20180131235350.GH3741@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180131235350.dXX9KSBOCQt3-zZJoaV6NXBrX7lZ2n3i1pOtLv8CCaM@z>

On Wed, Jan 31, 2018 at 11:08:22AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 31, 2018 at 10:00:06AM +0100, Ingo Molnar wrote:
> > - Similary, some of the high level descriptions in tools/memory-model/README
> >   should probably propagated into the source code files as well: for example
> >   both tools/memory-model/lock.cat and linux-kernel.cat could be improved that
> >   way.
> 
> This is something both Will and me have on our todo list, sadly we've
> not had any time to work on this due to this pesky spectre crap.

Spectre permitting, this would be very cool!

							Thanx, Paul
