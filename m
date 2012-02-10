From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: on memory barriers and cachelines
Date: Fri, 10 Feb 2012 19:13:09 +0100
Message-ID: <1328897589.25989.30.camel@laptop>
References: <1328088838.2760.21.camel@laptop>
	 <20120201142218.GF2488@linux.vnet.ibm.com>
	 <20120210025129.GA9135@jl-vm1.vm.bytemark.co.uk>
	 <20120210163252.GG2458@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37706 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab2BJSN1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 13:13:27 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RvuyM-0006Nd-No
	for linux-arch@vger.kernel.org; Fri, 10 Feb 2012 18:13:26 +0000
Received: from 178-85-86-190.dynamic.upc.nl ([178.85.86.190] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1RvuyM-0006Hk-ES
	for linux-arch@vger.kernel.org; Fri, 10 Feb 2012 18:13:26 +0000
In-Reply-To: <20120210163252.GG2458@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@linux-foundation.org>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

On Fri, 2012-02-10 at 08:32 -0800, Paul E. McKenney wrote:
> 
> Are there SMP blackfin systems now?  There were not last I checked,
> and these issues matter only on SMP. 

Those are not cache coherent and a total trainwreck.
