From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Tue, 19 Aug 2008 09:42:36 -0500
Message-ID: <48AADBDC.2000608@linux-foundation.org>
References: <20080818133224.GA5258@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51150 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751192AbYHSOnV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Aug 2008 10:43:21 -0400
In-Reply-To: <20080818133224.GA5258@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

Nick Piggin wrote:

> +static void free_unmap_vmap_area(struct vmap_area *va)
> +{
> +	va->flags |= VM_LAZY_FREE;
> +	atomic_add((va->va_end - va->va_start) >> PAGE_SHIFT, &vmap_lazy_nr);
> +	if (unlikely(atomic_read(&vmap_lazy_nr) > LAZY_MAX))
> +		purge_vmap_area_lazy();
> +}

Could you check here if we are in an atomic context and then simply not purge
the vmap area? That may we may get to a vfree that can be run in an atomic
context.

Or run purge_vma_area_lazy from keventd?
