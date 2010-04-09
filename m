From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/13] mm: preemptibility -v2
Date: Fri, 09 Apr 2010 10:58:41 +0200
Message-ID: <1270803521.20295.3274.camel@laptop>
References: <20100408191737.296180458@chello.nl>
	 <20100409041421.GM5683@laptop> <1270802131.20295.3270.camel@laptop>
	 <20100409085050.GO5683@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54785 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060Ab0DII6q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 04:58:46 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O0A33-0001Qq-8g
	for linux-arch@vger.kernel.org; Fri, 09 Apr 2010 08:58:45 +0000
In-Reply-To: <20100409085050.GO5683@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>

On Fri, 2010-04-09 at 18:50 +1000, Nick Piggin wrote:
> I have some microbenchmarks like this and the page fault test I
> could try.
> 
If you don't mind, please. If you send them my way I'll run them on my
machines too.
