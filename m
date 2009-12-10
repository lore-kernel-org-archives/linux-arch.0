From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 07:40:20 +0300
Message-ID: <20091210074020.a7c36c32.isloginov@gmail.com>
References: <1260398346.14369.45.camel@mulgrave.site>
	<20091210020309.36742c7f.isloginov@gmail.com>
	<1260400273.14369.52.camel@mulgrave.site>
	<20091210023609.b8c9bd34.isloginov@gmail.com>
	<1260402471.14369.60.camel@mulgrave.site>
	<20091210030638.db4cfd8a.isloginov@gmail.com>
	<1260404395.14369.68.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:42061 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759927AbZLJEkQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 23:40:16 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1827801eyd.19
        for <linux-arch@vger.kernel.org>; Wed, 09 Dec 2009 20:40:22 -0800 (PST)
In-Reply-To: <1260404395.14369.68.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Wed, 09 Dec 2009 18:19:55 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> OK, but the point I'm making is that it's a very heavyweight function on
> a lot of architectures.  It sounds like mips should just have a
> flush_kernel_dcache_page() ... has anyone tested fuse on mips; if that
> fails, then it's a must.

Yes, it works. There are many embedded systems which are based on MIPS.
For example, there is MIPS in my router. I use fuse on it(it is required
by ntfs-3g). OpenWRT.
 
> The problem seems to be defined as one of ensuring coherency on PIO
> block devices in the most efficient manner possible.

> Like I said previously, I still think some extension to the DMA API to
> map the areas correctly might be the best way forwards.

What do you mean under DMA API? Do you mean that we should fix memcpy?

-- 
Ilya Loginov <isloginov@gmail.com>
