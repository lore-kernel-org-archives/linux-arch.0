From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 00/21] mm: Preemptibility -v6
Date: Tue, 18 Jan 2011 11:50:01 +0100
Message-ID: <1295347801.30950.505.camel@laptop>
References: <20101126143843.801484792@chello.nl>
	 <alpine.LSU.2.00.1101172301340.2899@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45102 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab1ARKt1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2011 05:49:27 -0500
In-Reply-To: <alpine.LSU.2.00.1101172301340.2899@sister.anvils>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Nick Piggin <npiggin@kernel.dk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org

On Mon, 2011-01-17 at 23:12 -0800, Hugh Dickins wrote:
> 21/21 mm-optimize_page_lock_anon_vma_fast-path.patch
>       I certainly see the call for this patch, I want to eliminate those
>       doubled atomics too.  This appears correct to me, and I've not dreamt
>       up an alternative; but I do dislike it, and I suspect you don't like
>       it much either.  I'm ambivalent about it, would love a better patch. 

Spot on, maybe a one of our keen readers will have a bright idea.. :-)
