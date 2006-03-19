Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17633
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750910AbWCSVAQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 16:00:16 -0500
Date: Sun, 19 Mar 2006 13:00:09 -0800 (PST)
Message-Id: <20060319.130009.102283514.davem@davemloft.net>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
References: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
	<20060319.123320.71795946.davem@davemloft.net>
	<1142801589.3240.51.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 19 Mar 2006 14:53:08 -0600

> Actually, this is my specific worry.  On parisc, the coherence index
> associated with the DMA is that of the kernel mapping, not the user
> mappings, so DMA only flushes the kernel cache for the line, not the
> user one.  If nothing happens to purge the user line, DMA to anon pages
> won't work on parisc either.

You have physically indexed caches, thus cache coherency transactions
should purge all cache lines with that same physical TAG.

If not, you have much larger problems.

> I do think we need to begin considering it.  The user space device
> managers, like hal, are starting to use SG_IO to interrogate devices,
> making it much more prevalent than before.  It's got to be only a matter
> of time before this issue bites something like hal.
> 
> Is the principle that get_user_pages() should return coherent pages OK?
> If so, I think the fix is to have get_user_pages do a specific user page
> flush for anonymous pages.

Direct I/O is another problematic case.
