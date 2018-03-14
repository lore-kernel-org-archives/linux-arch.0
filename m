Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:58700 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeCNUbJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 16:31:09 -0400
Date: Wed, 14 Mar 2018 21:31:08 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Message-ID: <20180314203108.GA18775@isilmar-4.linta.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314144614.1632190-1-arnd@arndb.de>
 <20180314144614.1632190-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314144614.1632190-2-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180314203108.XQKgKlfG2N2BN-j54FzQHVzCEEHZZrsJnBGdpBfOBu8@z>

On Wed, Mar 14, 2018 at 03:43:47PM +0100, Arnd Bergmann wrote:
> The frv, tile and blackfin architectures are being removed, so
> we can clean up this header by removing all the special cases
> except those for ia64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

AFAICS, score is the only architecture which still defines

	__ARCH_WANT_SYSCALL_NO_FLAGS
	__ARCH_WANT_SYSCALL_OFF_T
	__ARCH_WANT_SYSCALL_DEPRECATED .

So maybe you want to clean up include/uapi/asm-generic/unistd.h as well?

Thanks,
	Dominik
