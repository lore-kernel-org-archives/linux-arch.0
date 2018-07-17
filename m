Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbeGQNZT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2018 09:25:19 -0400
Date: Tue, 17 Jul 2018 05:52:43 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 06/17] y2038: Change sys_utimensat() to use
 __kernel_timespec
Message-ID: <20180717125243.GE25416@infradead.org>
References: <20180716161103.16239-1-arnd@arndb.de>
 <20180716161103.16239-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716161103.16239-7-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: tglx@linutronix.de, y2038@lists.linaro.org, hch@infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, albert.aribaud@3adev.fr, netdev@vger.kernel.org, viro@zeniv.linux.org.uk, peterz@infradead.org, dvhart@infradead.org, ebiederm@xmission.com, linux@dominikbrodowski.net
Message-ID: <20180717125243.ZDX0p1F19Z0Ya_5OXxkjl5E22thxb5eCp9AeSvteUUI@z>

On Mon, Jul 16, 2018 at 06:10:52PM +0200, Arnd Bergmann wrote:
> When 32-bit architectures get changed to support 64-bit time_t,
> utimensat() needs to use the new __kernel_timespec structure as its
> argument.
> 
> The older utime(), utimes() and futimesat() system calls don't need a
> corresponding change as they are no longer used on C libraries that have
> 64-bit time support.
> 
> As we do for the other syscalls that have timespec arguments, we reuse
> the 'compat' syscall entry points to implement the traditional four
> interfaces, and only leave the new utimensat() as a native handler,
> so that the same code gets used on both 32-bit and 64-bit kernels
> on each syscall.

I wonder about the direction here:  wouldn't it be easier to just
leave th existing syscall names as-is and introduce a new utimesat64
which uses the new timespec?  We can then drop the old legacy utimesat
for new architectures added after the cutover.
