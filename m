From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/28] mm: preemptibility -v3
Date: Mon, 07 Jun 2010 17:02:11 +0200
Message-ID: <1275922931.1645.570.camel@laptop>
References: <20100607110654.606530953@chello.nl>
	 <20100607135753.GA16657@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:45069 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab0FGPCO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2010 11:02:14 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1OLdq9-0004mx-NX
	for linux-arch@vger.kernel.org; Mon, 07 Jun 2010 15:02:13 +0000
In-Reply-To: <20100607135753.GA16657@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Mon, 2010-06-07 at 15:57 +0200, Sam Ravnborg wrote:
> > 
> > There are no known architectures left unconverted, although some arch code
> > never did see a compiler (superh and um come to mind).
> 
> um is easy.
> On your x86 box you just do "make ARCH=um"

Right, seems to build.
