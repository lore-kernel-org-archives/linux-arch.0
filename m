Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:24976 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262964AbUCPBMn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 20:12:43 -0500
Subject: Re: More DMA API junk
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1079398383.1968.205.camel@gaston>
References: <1079398383.1968.205.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 15 Mar 2004 20:12:33 -0500
Message-Id: <1079399555.1804.232.camel@mulgrave>
Mime-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-15 at 19:53, Benjamin Herrenschmidt wrote:
>  - dma_is_consistent(dma_addr_t address) : Did somebody actually expect
> anything useful out of this function ? AFAIK, it makes no sense. There
> is simply no way an arch like ppc that use per-page cache-inhibit
> mappings to do consistent memory will be able to tell you if a given
> _DMA_ address is consistent... that makes no sense.

>  - dma_cache_sync(): What is that function supposed to do ? It's a
> duplicate of the other sync() functions and David didn't even bother
> turning it into _for_device/for_cpu... which is fine since it doesn't
> even takes a struct device argument.

They are both used.  Look at section II of DMA-API.txt.cd ..

They have to do with incoherent platforms which I assume you don't have,
but just leave them alone for those of use who are so burdened.

Actually, I was planning to update dma_cache_sync to take a device and
to conform to the new style (except I was thinking of an ownership flag
rather than introducing two more APIs).  The lack of device to
dma_cache_sync is probably irrelevant since they only apply to older
arch's which don't have bus caches.

James
