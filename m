Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34322 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZGTMqR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jul 2009 08:46:17 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20090715074952.A36C7DDDB2@ozlabs.org>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
Date: Mon, 20 Jul 2009 13:46:03 +0100
Message-ID: <13548.1248093963@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dhowells@redhat.com, Linux Memory Management <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>, Nick Piggin <npiggin@suse.de>
Message-ID: <20090720124603.5obCBMAMPzGcVeDh7AlNfMAFl8nWcc7RPLsCDcdiklM@z>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Upcoming paches to support the new 64-bit "BookE" powerpc architecture
> will need to have the virtual address corresponding to PTE page when
> freeing it, due to the way the HW table walker works.
> 
> Basically, the TLB can be loaded with "large" pages that cover the whole
> virtual space (well, sort-of, half of it actually) represented by a PTE
> page, and which contain an "indirect" bit indicating that this TLB entry
> RPN points to an array of PTEs from which the TLB can then create direct
> entries. Thus, in order to invalidate those when PTE pages are deleted,
> we need the virtual address to pass to tlbilx or tlbivax instructions.
>
> The old trick of sticking it somewhere in the PTE page struct page sucks
> too much, the address is almost readily available in all call sites and
> almost everybody implemets these as macros, so we may as well add the
> argument everywhere. I added it to the pmd and pud variants for consistency.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: David Howells <dhowells@redhat.com> [MN10300 & FRV]
