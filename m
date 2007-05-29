Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58810
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750950AbXE2F64 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 May 2007 01:58:56 -0400
Date: Mon, 28 May 2007 22:35:50 -0700 (PDT)
Message-Id: <20070528.223550.39158516.davem@davemloft.net>
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070528124411.GA31764@xi.wantstofly.org>
References: <20070527.160551.59654871.davem@davemloft.net>
	<1180312287.3711.32.camel@mulgrave.il.steeleye.com>
	<20070528124411.GA31764@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: buytenh@wantstofly.org
Cc: James.Bottomley@steeleye.com, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Mon, 28 May 2007 14:44:11 +0200

> On Sun, May 27, 2007 at 07:31:27PM -0500, James Bottomley wrote:
> 
> > On munmap we do a flush_cache_range for the unmapped vmas ... we
> > have to, otherwise the data might be lost as the user mapping is
> > zapped and we wouldn't be able to guarantee coherency writing it
> > to the backing store.
> 
> As far as I understand it, the munmap() does flush out the copy of
> the data at the user virtual address, but the subsequent read() call
> reads from an address in the kernel direct mapped window, for which
> there is still data in the cache due to the earlier read() syscall,
> and the mapping_writably_mapped() test fails so we don't end up
> calling flush_dcache_page().

That is what is happening for sure.

That mapping_writably_mapped() check depends upon munmap()
flush out the lines from the cache on the user side at
least enough to make them coherent on the kernel side.

As I said my flush_cache_range() on sparc64 used to do this,
but I removed it for whatever reason, perhaps I did not
consider this case back then.

I'm not advocating a full flush on flush_cache_range(), but rather to
set a page state bit, which will force a flush on the
"check_dcache_page()" call which we could replace this conditionalized
flush_dcache_page() call with.
