From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/27] score: create Kconfig Kconfig.debug Makefile
Date: Tue, 9 Jun 2009 18:47:12 +0200
Message-ID: <200906091847.13539.arnd@arndb.de>
References: <OF2086513E.4B4F803C-ON482575D0.0022E294-482575D0.0023688F@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62324 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZFIQrz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 12:47:55 -0400
In-Reply-To: <OF2086513E.4B4F803C-ON482575D0.0022E294-482575D0.0023688F@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:

> +++ b/arch/score/Kconfig
> @@ -0,0 +1,243 @@
> +config SCORE
> +       bool
> +       default y
> +       select EMBEDDED

I don't think you should select EMBEDDED. The option is slightly
misnamed and just enables some other config options. If you need
any of those that are protected by EMBEDDED, then maybe select those
directly.

> +config NO_DMA
> +       bool
> +       default y

Are you planning to implement DMA support? We just had a lenghty
discussion about how to do it generically. While we did not find
a solution, you can probably easily take the
asm-generic/dma-mapping-linear.h I posted and adapt that to your
needs.

> +config SCORE_L1_CACHE_SHIFT
> +       int
> +       default "5"

Your arch/score/include/asm/cache.h contains

#define L1_CACHE_SHIFT         4

One of the two looks wrong ;-)

If you have different cache implementations, this value
should probably be the maximum of all CPUs that are configured
in the kernel.

> +config HZ
> +       int
> +       default 100

Have you looked into implementing NO_HZ? It is not required in any
way, but can probably reduce your power consumption, which may be
interesting for embedded systems.

> +config KEXEC
> +       bool "Kexec system call (EXPERIMENTAL)"
> +       depends on EXPERIMENTAL
> +       help

Do you actually support this? I did not look very closely,
but could not find anything about kexec in the other patches.
If not, just drop the config option.

	Arnd <><
