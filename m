From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/13] mm: preemptibility -v2
Date: Fri, 09 Apr 2010 11:22:54 +0200
Message-ID: <1270804974.20295.3296.camel@laptop>
References: <20100408191737.296180458@chello.nl>
	 <23453.1270803837@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:51046 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0DIJW6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 05:22:58 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O0AQT-0005jP-Pl
	for linux-arch@vger.kernel.org; Fri, 09 Apr 2010 09:22:57 +0000
In-Reply-To: <23453.1270803837@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On Fri, 2010-04-09 at 10:03 +0100, David Howells wrote:
> Have you tried compiling this for NOMMU?

No, I will eventually, I'm sure there's something to fix.
