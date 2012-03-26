From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] compat: use sys_sendfile64() implementation for sendfile syscall
Date: Mon, 26 Mar 2012 20:45:15 +0000
Message-ID: <201203262045.16243.arnd@arndb.de>
References: <201203262036.q2QKaZ7U009929@farm-0012.internal.tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53132 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab2CZUpV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Mar 2012 16:45:21 -0400
In-Reply-To: <201203262036.q2QKaZ7U009929@farm-0012.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 26 March 2012, Chris Metcalf wrote:
> <asm-generic/unistd.h> was set up to use sys_sendfile() for the 32-bit
> compat API instead of sys_sendfile64(), but in fact the right thing to
> do is to use sys_sendfile64() in all cases.  The 32-bit sendfile64() API
> in glibc uses the sendfile64 syscall, so it has to be capable of doing
> full 64-bit operations.  But the sys_sendfile() kernel implementation
> has a MAX_NON_LFS test in it which explicitly limits the offset to 2^32.
> So, we need to use the sys_sendfile64() implementation in the kernel
> for this case.
> 
> Cc: <stable@kernel.org>
> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
