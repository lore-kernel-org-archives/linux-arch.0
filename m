Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55689
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932116AbWH2Gg7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 02:36:59 -0400
Date: Mon, 28 Aug 2006 23:36:56 -0700 (PDT)
Message-Id: <20060828.233656.59469351.davem@davemloft.net>
Subject: Re: Cache alias handling in copy_user_page / copy_user_highpage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060819122520.GA18180@linux-mips.org>
References: <20060819122520.GA18180@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: Ralf Baechle <ralf@linux-mips.org>
Date: Sat, 19 Aug 2006 13:25:20 +0100

> So here are two alterantive fixes for the API:
> 
> 1) Move copy_user_highpage into the arch code.  This will allow the arch code
> to create any sort of crazy mapping it wants.  The old copy_user_page as
> kernel API is only called from copy_user_highpage and would therefore be
> obsoleted.
> 
> 2) Introduce a new kmap_atomic variant to create a congruent mapping.

I think you will find that copy_user_highpage() and
clear_user_highpage() are performance critical enough
that you will want to implement it totally in hand-crafted
assembler which disables preemption, loads up the TLB
entries by hand, does the copy, and flushes out the
temp mappings.

This is essentially what the code in arch/sparc64/lib/copy_page.S and
clear_page.S is all about.

So I'd lean towards #1.  That's the reason copy_user_page() gets
a virtual address in the first place.  It's just HIGHMEM configs
that make it difficult and try to do the mapping for you.

You're definitely right that if you try to use a cache flush to
implement clear_user_page() and copy_user_page(), you will risk
data corruption.
