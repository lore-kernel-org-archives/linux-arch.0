Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47586 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998AbYAGLOs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 7 Jan 2008 06:14:48 -0500
Date: Mon, 7 Jan 2008 12:14:45 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch] mm: use a pte bit to flag normal pages
Message-ID: <20080107111445.GB19872@wotan.suse.de>
References: <20071221104701.GE28484@wotan.suse.de> <OFEC52C590.33A28896-ONC12573B8.0069F07E-C12573B8.006B1A41@de.ibm.com> <20080107044355.GA11222@wotan.suse.de> <20080107103028.GA9325@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080107103028.GA9325@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <martin.schwidefsky@de.ibm.com>, carsteno@linux.vnet.ibm.com, Heiko Carstens <h.carstens@de.ibm.com>, Jared Hulbert <jaredeh@gmail.com>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

On Mon, Jan 07, 2008 at 10:30:29AM +0000, Russell King wrote:
> On Mon, Jan 07, 2008 at 05:43:55AM +0100, Nick Piggin wrote:
> > We initially wanted to do the whole vm_normal_page thing this way, with
> > another pte bit, but we thought there were one or two archs with no spare
> > bits. BTW. I also need this bit in order to implement my lockless
> > get_user_pages, so I do hope to get it in. I'd like to know what
> > architectures cannot spare a software bit in their pte_present ptes...
> 
> ARM is going to have to use the three remaining bits we have in the PTE
> to store the memory type to resolve bugs on later platforms.  Once they're
> used, ARM will no longer have any room for any further PTE expansion.

OK, it is good to have a negative confirmed. So I think we should definitely
get the non-pte-bit based mapping schemes working and tested on all platforms
before using a pte bit mapping...

FWIW, it might be possible for platforms to implement lockless get_user_pages
in other ways too. But that's getting ahead of myself.

Thanks.

