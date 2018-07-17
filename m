Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeGQNXx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2018 09:23:53 -0400
Date: Tue, 17 Jul 2018 05:51:04 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 04/17] asm-generic: Remove unneeded
 __ARCH_WANT_SYS_LLSEEK macro
Message-ID: <20180717125104.GC25416@infradead.org>
References: <20180716161103.16239-1-arnd@arndb.de>
 <20180716161103.16239-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716161103.16239-5-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: tglx@linutronix.de, y2038@lists.linaro.org, hch@infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, albert.aribaud@3adev.fr, netdev@vger.kernel.org, viro@zeniv.linux.org.uk, peterz@infradead.org, dvhart@infradead.org, ebiederm@xmission.com, linux@dominikbrodowski.net
Message-ID: <20180717125104.jq_xww-I5ydqaTJhjh7Yzcf94isjJNNchuM-9j9CFm4@z>

On Mon, Jul 16, 2018 at 06:10:50PM +0200, Arnd Bergmann wrote:
> The sys_llseek sytem call is needed on all 32-bit architectures and
> none of the 64-bit ones, so we can remove the __ARCH_WANT_SYS_LLSEEK guard
> and simplify the include/asm-generic/unistd.h header further.
> 
> Since 32-bit tasks can run either natively or in compat mode on 64-bit
> architectures, we have to check for both !CONFIG_64BIT and CONFIG_COMPAT.
> 
> There are a few 64-bit architectures that also reference sys_llseek
> in their 64-bit ABI (e.g. sparc), but I verified that those all
> select CONFIG_COMPAT, so the #if check is still correct here. It's
> a bit odd to include it in the syscall table though, as it's the
> same as sys_lseek() on 64-bit, but with strange calling conventions.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
