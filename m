Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21014 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919Ab0F2Hj7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Jun 2010 03:39:59 -0400
Subject: Re: [PATCH 00/28] mm: preemptibility -v3
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
In-Reply-To: <1277373331.1875.940.camel@laptop>
References: <20100607110654.606530953@chello.nl>
	 <1276134311.2096.438.camel@ymzhang.sh.intel.com>
	 <1276152750.2046.2485.camel@twins>
	 <1276153198.2096.465.camel@ymzhang.sh.intel.com>
	 <1277115718.1875.490.camel@laptop>  <1277373331.1875.940.camel@laptop>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 29 Jun 2010 15:40:19 +0800
Message-ID: <1277797219.2096.884.camel@ymzhang.sh.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20100629074019.iidQQQMb89ExgA1hOCaPDFGvnLVADomZiP5eJNAhWnU@z>

On Thu, 2010-06-24 at 11:55 +0200, Peter Zijlstra wrote:
> On Mon, 2010-06-21 at 12:21 +0200, Peter Zijlstra wrote:
> > On Thu, 2010-06-10 at 14:59 +0800, Zhang, Yanmin wrote:
> > 
> > > > > I applied it against 2.6.35-rc2 on x86_64 machine, but kernel booting panic.
> > 
> > <snip panic>
> > 
> > > > Oi, that's no good. Happen to have your .config handy, I didn't actually
> > > > see my machine do that.
> > 
> > > See the attachment.
> > 
> > That .config build and booted on my x86_64 machine, no funnies there.
> > 
> > I pushed a git tree out to kernel.org but somehow its refusing to show
> > up on git.kernel.org..
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/linux-2.6-mmu_preempt.git mmu_preempt
We tested the tree on many machines with many benchmarks. Comparing with pure kernel 2.6.35-rc3,
there is no clear performance regression/improvement. We didn't run into panic again.

Yanmin


