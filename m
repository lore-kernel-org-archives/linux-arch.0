Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:24257 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S964935AbWHHOt3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Aug 2006 10:49:29 -0400
Date: Tue, 8 Aug 2006 10:48:50 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 9/13] Generic ioremap_page_range: parisc conversion
Message-ID: <20060808144850.GD4896@athena.road.mcmartin.ca>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com> <1155039796529-git-send-email-hskinnemoen@atmel.com> <11550397963281-git-send-email-hskinnemoen@atmel.com> <11550397961615-git-send-email-hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11550397961615-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 08, 2006 at 02:23:11PM +0200, Haavard Skinnemoen wrote:
> Convert parisc to use generic ioremap_page_range()
> 
> -static int 
> -remap_area_pages(unsigned long address, unsigned long phys_addr,
> -		 unsigned long size, unsigned long flags)
> -{
[...]
> -	flush_cache_all();
> -
[..]
> -	} while (address && (address < end));
> -
> -	flush_tlb_all();
> 

On second thought, you've compressed two different flushes into
flush_cache_vmap[1] where flush_tlb_all used to be...

I don't think this would be a problem because we're creating a
new mapping, but James will probably prove my assumption wrong
as usual. :)

[1 - flush_cache_vmap is just a flush_cache_all on the arches
 I've looked at with VI-caches.]

Cheers,
	Kyle M.
