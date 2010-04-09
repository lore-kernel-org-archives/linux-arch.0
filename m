From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/13] mm: preemptibility -v2
Date: Fri, 09 Apr 2010 11:53:01 +0200
Message-ID: <1270806781.20295.3297.camel@laptop>
References: <20100408191737.296180458@chello.nl>
	 <20100409105800.0d0f93ac@mschwide.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43255 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0DIJxI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 05:53:08 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O0Atd-0002hl-4H
	for linux-arch@vger.kernel.org; Fri, 09 Apr 2010 09:53:05 +0000
In-Reply-To: <20100409105800.0d0f93ac@mschwide.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On Fri, 2010-04-09 at 10:58 +0200, Martin Schwidefsky wrote:
> [PATCH] s390: preemptible mmu_gather
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Adapt the stand-alone s390 mmu_gather implementation to the new
> preemptible mmu_gather interface.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com> 


Thanks a lot Martin!
