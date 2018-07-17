Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeGQNX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2018 09:23:57 -0400
Date: Tue, 17 Jul 2018 05:51:21 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 05/17] asm-generic: Remove empty asm/unistd.h
Message-ID: <20180717125121.GD25416@infradead.org>
References: <20180716161103.16239-1-arnd@arndb.de>
 <20180716161103.16239-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716161103.16239-6-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: tglx@linutronix.de, y2038@lists.linaro.org, hch@infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, albert.aribaud@3adev.fr, netdev@vger.kernel.org, viro@zeniv.linux.org.uk, peterz@infradead.org, dvhart@infradead.org, ebiederm@xmission.com, linux@dominikbrodowski.net
Message-ID: <20180717125121.G4h916qYKp_BTliVDd3oLCw-lte4BrHlWrN9lb7fizQ@z>

On Mon, Jul 16, 2018 at 06:10:51PM +0200, Arnd Bergmann wrote:
> Nothing is left in asm/unistd.h except for the redirect to
> uapi/asm/unistd.h, so removing the file simply leads to that one being
> used directly.  The linux/export.h inclusion is a leftover from commit
> e1b5bb6d1236 ("consolidate cond_syscall and SYSCALL_ALIAS declarations")
> and should not be used anyway.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
