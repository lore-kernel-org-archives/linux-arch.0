From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC][PATCH 4/6] arm, mm: Convert arm to generic tlb
Date: Wed, 09 Mar 2011 16:34:15 +0000
Message-ID: <1299688455.19820.401.camel@e102109-lin.cambridge.arm.com>
References: <20110302175928.022902359@chello.nl>
	 <20110302180259.109909335@chello.nl>
	 <AANLkTimbRS++SCcKGrUcL5xKsCO+1ygkg+83x7F+2S4i@mail.gmail.com>
	 <1299683964.2308.3075.camel@twins>
	 <1299684963.19820.344.camel@e102109-lin.cambridge.arm.com>
	 <1299685150.2308.3097.camel@twins>  <1299685689.2308.3113.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:40750 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755663Ab1CIQei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2011 11:34:38 -0500
In-Reply-To: <1299685689.2308.3113.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Russell King <rmk@arm.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, 2011-03-09 at 15:48 +0000, Peter Zijlstra wrote:
> On Wed, 2011-03-09 at 16:39 +0100, Peter Zijlstra wrote:
> >
> > Ok, will try and sort that out.
> 
> We could do something like the below and use the end passed down, which
> because it goes top down should be clipped at the appropriate size, just
> means touching all the p??_free_tlb() implementations ;-)

Looks fine to me (apart from the hassle to change the p??_free_tlb()
definitions).

-- 
Catalin
