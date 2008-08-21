From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Thu, 21 Aug 2008 08:13:14 -0500
Message-ID: <48AD69EA.9090202@linux-foundation.org>
References: <20080818133224.GA5258@wotan.suse.de>	<48AADBDC.2000608@linux-foundation.org>	<20080820090234.GA7018@wotan.suse.de>	<48AC244F.1030104@linux-foundation.org> <87y72q3kem.fsf@skyscraper.fehenstaub.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32990 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755454AbYHUNOK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Aug 2008 09:14:10 -0400
In-Reply-To: <87y72q3kem.fsf@skyscraper.fehenstaub.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

Johannes Weiner wrote:

> I have not much clue about the users but shouldn't you use vmalloc
> anyway if you don't need physically contiguous pages?

physical memory has the advantage that it does not need a page table and its
therefore more efficient to access. Plus the overhead of having to maintain a
mapping is gone. Memory is suitable for I/O without scatter gather etc etc.

> So while it would be usable then to have both vmap and vunmap work in
> atomic context, I don't really get the fallback use case..?

Classic example: A network driver wants contiguous memory for a jumbo frame.

Fallback to scatter gather is possible but not as effective.
