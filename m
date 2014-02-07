Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:42747 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbaBGQuf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Feb 2014 11:50:35 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 7 Feb 2014 09:50:34 -0700
Date: Fri, 7 Feb 2014 08:50:28 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Message-ID: <20140207165028.GO4250@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20140206134825.305510953@infradead.org>
 <21984.1391711149@warthog.procyon.org.uk>
 <52F3DA85.1060209@arm.com>
 <20140206185910.GE27276@mudshark.cambridge.arm.com>
 <20140206192743.GH4250@linux.vnet.ibm.com>
 <1391721423.23421.3898.camel@triegel.csb>
 <20140206221117.GJ4250@linux.vnet.ibm.com>
 <1391730288.23421.4102.camel@triegel.csb>
 <20140207042051.GL4250@linux.vnet.ibm.com>
 <20140207074405.GM5002@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140207074405.GM5002@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Message-ID: <20140207165028.tM6zA6DbWvFvJ07qWD3SYWuTAlb3c8ZQhaeyvHAXdcc@z>

On Fri, Feb 07, 2014 at 08:44:05AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2014 at 08:20:51PM -0800, Paul E. McKenney wrote:
> > Hopefully some discussion of out-of-thin-air values as well.
> 
> Yes, absolutely shoot store speculation in the head already. Then drive
> a wooden stake through its hart.
> 
> C11/C++11 should not be allowed to claim itself a memory model until that
> is sorted.

There actually is a proposal being put forward, but it might not make ARM
and Power people happy because it involves adding a compare, a branch,
and an ISB/isync after every relaxed load...  Me, I agree with you,
much preferring the no-store-speculation approach.

							Thanx, Paul

