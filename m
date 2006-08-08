Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:35980 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964961AbWHHPhq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Aug 2006 11:37:46 -0400
Subject: Re: [PATCH 9/13] Generic ioremap_page_range: parisc conversion
From: James Bottomley <James.Bottomley@steeleye.com>
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
Content-Type: text/plain
Date: Tue, 08 Aug 2006 10:37:25 -0500
Message-Id: <1155051445.26517.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-08-08 at 10:48 -0400, Kyle McMartin wrote:
> On second thought, you've compressed two different flushes into
> flush_cache_vmap[1] where flush_tlb_all used to be...
> 
> I don't think this would be a problem because we're creating a
> new mapping, but James will probably prove my assumption wrong
> as usual. :)
> 
> [1 - flush_cache_vmap is just a flush_cache_all on the arches
>  I've looked at with VI-caches.]

The problem the flush_tlb_all() is trying to solve is to avoid stale tlb
entries in the ioremap area.  We're just being conservative by flushing
on both map and unmap.  Technically what vmalloc/vfree does (only flush
the tlb on unmap) is just fine because it means that the only tlb
entries in the remap area must belong to in-use mappings.

James


