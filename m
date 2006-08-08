Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:58077 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964902AbWHHPOC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 11:14:02 -0400
Date: Tue, 8 Aug 2006 17:13:52 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH 9/13] Generic ioremap_page_range: parisc conversion
Message-ID: <20060808171352.415900a3@cad-250-152.norway.atmel.com>
In-Reply-To: <20060808144850.GD4896@athena.road.mcmartin.ca>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com>
	<11550397954098-git-send-email-hskinnemoen@atmel.com>
	<11550397954093-git-send-email-hskinnemoen@atmel.com>
	<11550397963310-git-send-email-hskinnemoen@atmel.com>
	<11550397962723-git-send-email-hskinnemoen@atmel.com>
	<1155039796165-git-send-email-hskinnemoen@atmel.com>
	<11550397964177-git-send-email-hskinnemoen@atmel.com>
	<1155039796529-git-send-email-hskinnemoen@atmel.com>
	<11550397963281-git-send-email-hskinnemoen@atmel.com>
	<11550397961615-git-send-email-hskinnemoen@atmel.com>
	<20060808144850.GD4896@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 8 Aug 2006 10:48:50 -0400
Kyle McMartin <kyle@mcmartin.ca> wrote:

> On second thought, you've compressed two different flushes into
> flush_cache_vmap[1] where flush_tlb_all used to be...

Yes, that's intentional. I did mention this as one of the differences
from i386 in the "implementation" part of this series, but I should
perhaps have mentioned it explicitly in each of the arch-specific
patches as well?

> I don't think this would be a problem because we're creating a
> new mapping, but James will probably prove my assumption wrong
> as usual. :)

That's indeed the reasoning behind the change -- ioremap_pte_range()
contains BUG_ON(!pte_none(*pte)) so we should never touch existing
mappings.

Also, the only difference I can see between ioremap() and vmap() is
that ioremap() maps a contiguous range of physical addresses while
vmap() maps an array of 'struct page's. So the cache- and tlb-flushing
requirements should be the same, right?

Haavard
