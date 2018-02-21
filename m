Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbeBUWZR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Feb 2018 17:25:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LMOgtG135878
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 17:25:16 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9cpruqhk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 17:25:16 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 17:25:15 -0500
Date: Wed, 21 Feb 2018 14:25:34 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180221190543.GM3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211419350.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211419350.2032-100000@iolanthe.rowland.org>
Message-Id: <20180221222534.GP3617@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, Feb 21, 2018 at 02:27:04PM -0500, Alan Stern wrote:
> On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> 
> > > > +ISA2+pooncelock+pooncelock+pombonce.litmus
> > > > +	Tests whether the ordering provided by a lock-protected S litmus
> > > 
> > > Call it an ISA2 litmus test, not an S litmus test!
> > 
> > Given the structure of the test, the relationship to S is important
> > because it helps motivate why anyone might care.  But yes, having ISA2
> > only in the filename is a bit obtuse.  How about the following?
> > 
> > ISA2+pooncelock+pooncelock+pombonce.litmus
> > 	Tests whether the ordering provided by a lock-protected S
> > 	litmus test is visible to an external process whose accesses are
> > 	separated by smp_mb().	This addition of an external process to
> > 	S is otherwise known as ISA2.
> 
> Okay, that's somewhat better.
> 
> However, I still don't understand why you think of this as a form of S.  
> In S, the first variable written by P0 is the same as the variable
> written by P1.  In this test, no variable other than the spinlock gets
> written twice.  To me that seems like a pretty fundamental difference.

There is a chain of processes connected by variables, similar to
a snap-together toy.  If you "disconnect" S at the end and snap in
a process having a pair of reads separated by a full memory barrier,
you get ISA2.  And yes, this does rename one of S's variables, but that
is OK because in this view, each variable is defined by the connection
between a given pair of pair of processes.

Unconventional perhaps, but then again remember who you are emailing
with.  ;-)

Another (perhaps more conventional) way to think of this is in terms of
Andrea's python script that identified equivalent litmus tests.  For that
script, both the variable names and process numbers are irrelevant.

							Thanx, Paul
