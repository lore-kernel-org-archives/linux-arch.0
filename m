Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34378 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751559AbeBUT1F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2018 14:27:05 -0500
Date: Wed, 21 Feb 2018 14:27:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S lock-based
 external-view litmus test
In-Reply-To: <20180221190543.GM3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802211419350.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, 21 Feb 2018, Paul E. McKenney wrote:

> > > +ISA2+pooncelock+pooncelock+pombonce.litmus
> > > +	Tests whether the ordering provided by a lock-protected S litmus
> > 
> > Call it an ISA2 litmus test, not an S litmus test!
> 
> Given the structure of the test, the relationship to S is important
> because it helps motivate why anyone might care.  But yes, having ISA2
> only in the filename is a bit obtuse.  How about the following?
> 
> ISA2+pooncelock+pooncelock+pombonce.litmus
> 	Tests whether the ordering provided by a lock-protected S
> 	litmus test is visible to an external process whose accesses are
> 	separated by smp_mb().	This addition of an external process to
> 	S is otherwise known as ISA2.

Okay, that's somewhat better.

However, I still don't understand why you think of this as a form of S.  
In S, the first variable written by P0 is the same as the variable
written by P1.  In this test, no variable other than the spinlock gets
written twice.  To me that seems like a pretty fundamental difference.

Alan
