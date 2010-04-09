From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/13] mm: Make use of the anon_vma ref count
Date: Fri, 09 Apr 2010 11:57:00 +0200
Message-ID: <1270807020.20295.3299.camel@laptop>
References: <20100408191737.296180458@chello.nl>
	 <20100408192722.815377075@chello.nl>
	 <20100409070416.GA14118@lisa.in-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:55174 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0DIJ5E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 05:57:04 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O0AxU-0007G0-1o
	for linux-arch@vger.kernel.org; Fri, 09 Apr 2010 09:57:04 +0000
In-Reply-To: <20100409070416.GA14118@lisa.in-ulm.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Ehrhardt <uni@c--e.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On Fri, 2010-04-09 at 09:04 +0200, Christian Ehrhardt wrote:
> Hi,
> 
> On Thu, Apr 08, 2010 at 09:17:42PM +0200, Peter Zijlstra wrote:
> > @@ -302,23 +307,33 @@ again:
> >  		goto out;
> >  
> >  	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
> > -	spin_lock(&anon_vma->lock);
> > +	if (!atomic_inc_not_zero(&anon_vma->ref))
> > +		anon_vma = NULL;
> >  
> >  	if (page_rmapping(page) != anon_vma) {
> > -		spin_unlock(&anon_vma->lock);
> > +		anon_vma_put(anon_vma);
> >  		goto again;
> >  	}
> 
> AFAICS anon_vma_put might be called with anon_vma == NULL here which
> will oops on the ref count. Not sure if
> 
>      page_rmapping(page) == anon_vma == NULL 
> 
> is possible, too.

Gah, you're right, thanks!
