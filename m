From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: on memory barriers and cachelines
Date: Fri, 10 Feb 2012 10:47:22 -0800
Message-ID: <20120210184722.GM2458@linux.vnet.ibm.com>
References: <1328088838.2760.21.camel@laptop>
 <20120201142218.GF2488@linux.vnet.ibm.com>
 <20120210025129.GA9135@jl-vm1.vm.bytemark.co.uk>
 <20120210163252.GG2458@linux.vnet.ibm.com>
 <1328897589.25989.30.camel@laptop>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:52601 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab2BJSrd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 13:47:33 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 10 Feb 2012 11:47:32 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B96E419D804C
	for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 11:47:23 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q1AIlOjM182920
	for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 11:47:25 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q1AIlNR7019316
	for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 11:47:24 -0700
Content-Disposition: inline
In-Reply-To: <1328897589.25989.30.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@linux-foundation.org>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

On Fri, Feb 10, 2012 at 07:13:09PM +0100, Peter Zijlstra wrote:
> On Fri, 2012-02-10 at 08:32 -0800, Paul E. McKenney wrote:
> > 
> > Are there SMP blackfin systems now?  There were not last I checked,
> > and these issues matter only on SMP. 
> 
> Those are not cache coherent and a total trainwreck.

Indeed, I was ignoring the cache-incoherent "SMP" blackfin systems.  ;-)

							Thanx, Paul
