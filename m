Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50245 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbXE1Mi1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 08:38:27 -0400
Date: Mon, 28 May 2007 14:38:25 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070528123825.GA31744@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070527104930.GB25023@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 27, 2007 at 11:49:30AM +0100, Russell King wrote:

> * - the hole is:
> 
> void do_generic_mapping_read(struct address_space *mapping,
>                              struct file_ra_state *_ra,
>                              struct file *filp,
>                              loff_t *ppos,
>                              read_descriptor_t *desc,
>                              read_actor_t actor)
> {
> ...
>                 /* If users can be writing to this page using arbitrary
>                  * virtual addresses, take care about potential aliasing
>                  * before reading the page on the kernel side.
>                  */
>                 if (mapping_writably_mapped(mapping))
>                         flush_dcache_page(page);
> 
> is false for both read calls, since at the time this test is done, there
> are no shared writable mappings.  However, that's not to say that there
> haven't _been_ shared writable mappings.

If I make the flush_dcache_page() call above unconditional, then
the program I posted to this list previously[*] starts reliably
printing secondsecondsec as the third line.

David's check_dcache_page() suggestion makes a lot of sense to me.

Whether this solves the db4 corruption issues I've been seeing is
another matter...


[*] http://www.wantstofly.org/~buytenh/cache-issue2.c
