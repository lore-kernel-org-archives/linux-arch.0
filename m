From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: on memory barriers and cachelines
Date: Wed, 01 Feb 2012 18:29:16 +0100
Message-ID: <1328117356.2446.260.camel@twins>
References: <1328088838.2760.21.camel@laptop>
	 <CA+55aFx2pZtabFS54xfiLRcWnXi2NJjCHxdn-NLzFOqg7HNtmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41858 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab2BAR3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2012 12:29:36 -0500
In-Reply-To: <CA+55aFx2pZtabFS54xfiLRcWnXi2NJjCHxdn-NLzFOqg7HNtmg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

On Wed, 2012-02-01 at 09:17 -0800, Linus Torvalds wrote:
> 
> Also, even if you were to find an atomic sub-chunk, if you need a
> "smp_rmb()", what else would guarantee that the CPU core wouldn't
> re-order things to do the second read first, then lose the cacheline,
> re-read it, and then do the first read? 

Fair enough.. Thanks!
