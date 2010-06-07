From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/28] mm: preemptibility -v3
Date: Mon, 7 Jun 2010 15:57:53 +0200
Message-ID: <20100607135753.GA16657@merkur.ravnborg.org>
References: <20100607110654.606530953@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:59583 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0FGN57 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2010 09:57:59 -0400
Content-Disposition: inline
In-Reply-To: <20100607110654.606530953@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

> 
> There are no known architectures left unconverted, although some arch code
> never did see a compiler (superh and um come to mind).

um is easy.
On your x86 box you just do "make ARCH=um"

	Sam
