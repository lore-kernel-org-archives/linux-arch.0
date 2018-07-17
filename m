Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbeGQNWC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2018 09:22:02 -0400
Date: Tue, 17 Jul 2018 05:49:25 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/17] y2038: compat: Move common compat types to
 asm-generic/compat.h
Message-ID: <20180717124925.GA25416@infradead.org>
References: <20180716161103.16239-1-arnd@arndb.de>
 <20180716161103.16239-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716161103.16239-2-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: tglx@linutronix.de, y2038@lists.linaro.org, hch@infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, albert.aribaud@3adev.fr, netdev@vger.kernel.org, viro@zeniv.linux.org.uk, peterz@infradead.org, dvhart@infradead.org, ebiederm@xmission.com, linux@dominikbrodowski.net
Message-ID: <20180717124925.uuoz7lbq2syxm6ecvWiah_ysc_jxbJc6J83UPZUbhVE@z>

On Mon, Jul 16, 2018 at 06:10:47PM +0200, Arnd Bergmann wrote:
> While converting compat system call handlers to work on 32-bit
> architectures, I found a number of types used in those handlers
> that are identical between all architectures.
> 
> Let's move all the identical ones into asm-generic/compat.h to avoid
> having to add even more identical definitions of those types.
> 
> For unknown reasons, mips defines __compat_gid32_t, __compat_uid32_t
> and compat_caddr_t as signed, while all others have them unsigned.
> This seems to be a mistake, but I'm leaving it alone here. The other
> types all differ by size or alignment on at least on architecture.
> 
> compat_aio_context_t is currently defined in linux/compat.h but
> also needed for compat_sys_io_getevents(), so let's move it into
> the same place.
> 
> While we still have not decided whether the 32-bit time handling
> will always use the compat syscalls, or in which form, I think this
> is a useful cleanup that we can merge regardless.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
