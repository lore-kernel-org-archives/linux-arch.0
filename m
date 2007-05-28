Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50251 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbXE1MoN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 08:44:13 -0400
Date: Mon, 28 May 2007 14:44:11 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070528124411.GA31764@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <1180275384.3711.12.camel@mulgrave.il.steeleye.com> <20070527.160551.59654871.davem@davemloft.net> <1180312287.3711.32.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180312287.3711.32.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: David Miller <davem@davemloft.net>, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 27, 2007 at 07:31:27PM -0500, James Bottomley wrote:

> On munmap we do a flush_cache_range for the unmapped vmas ... we
> have to, otherwise the data might be lost as the user mapping is
> zapped and we wouldn't be able to guarantee coherency writing it
> to the backing store.

As far as I understand it, the munmap() does flush out the copy of
the data at the user virtual address, but the subsequent read() call
reads from an address in the kernel direct mapped window, for which
there is still data in the cache due to the earlier read() syscall,
and the mapping_writably_mapped() test fails so we don't end up
calling flush_dcache_page().
