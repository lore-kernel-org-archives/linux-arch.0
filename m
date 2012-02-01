From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: on memory barriers and cachelines
Date: Wed, 1 Feb 2012 06:22:19 -0800
Message-ID: <20120201142218.GF2488@linux.vnet.ibm.com>
References: <1328088838.2760.21.camel@laptop>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:59578 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab2BAOWl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2012 09:22:41 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 1 Feb 2012 07:22:40 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B74A81FF004B
	for <linux-arch@vger.kernel.org>; Wed,  1 Feb 2012 07:22:37 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q11EMQCS040032
	for <linux-arch@vger.kernel.org>; Wed, 1 Feb 2012 07:22:26 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q11EMLAq022915
	for <linux-arch@vger.kernel.org>; Wed, 1 Feb 2012 07:22:22 -0700
Content-Disposition: inline
In-Reply-To: <1328088838.2760.21.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

On Wed, Feb 01, 2012 at 10:33:58AM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> So I was talking to Paul yesterday and he mentioned how the SRCU sync
> primitive has to use extra synchronize_sched() calls in order to avoid
> smp_rmb() calls in the srcu_read_{un,}lock() calls.
> 
> Now memory barriers are usually explained as observable order between
> two (or more) unrelated variables, as Documentation/memory-barriers.txt
> does in great detail.
> 
> What I couldn't find in there though, is what happens when both
> variables are on the same cacheline. The "The effects of the CPU cache"
> and "Cache coherency" sections are closest but leave me wanting on this
> point.
> 
> Can we get some implicit behaviour from being on the same cacheline? Or
> can this memory access queue still totally wreck the game?

I don't know of any guarantees in this area, but am checking with
hardware architects for a couple of architectures.

							Thanx, Paul
