Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53871 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752776AbbLGHVE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 02:21:04 -0500
Date: Mon, 7 Dec 2015 08:21:00 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: avoid ARCH_MMAP_RND_BITS for NOMMU
Message-ID: <20151207072100.GQ5072@pengutronix.de>
References: <2874133.c4GDUf0t6t@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2874133.c4GDUf0t6t@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Cashman <dcashman@google.com>
Message-ID: <20151207072100.jLscEMzULiRXN4ZUsPJNfNtKETDlJ705YX9T77KcQ60@z>

On Fri, Nov 27, 2015 at 03:04:03PM +0100, Arnd Bergmann wrote:
> ARM kernels with MMU disabled fail to build because of CONFIG_ARCH_MMAP_RND_BITS:
> 
> kernel/built-in.o:(.data+0x754): undefined reference to `mmap_rnd_bits'
> kernel/built-in.o:(.data+0x76c): undefined reference to `mmap_rnd_bits_min'
> kernel/built-in.o:(.data+0x770): undefined reference to `mmap_rnd_bits_max'
> 
> This changes the newly added line to only select this allow for
> MMU-enabled kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 14570b3fd31a ("arm: mm: support ARCH_MMAP_RND_BITS")
> ---
> Found on yesterday's linux-next with ARM randconfig. The commit that
> introduced this is currently in Andrew's tree.
> 
> If you don't already have a fix, please either apply this patch on top,
> or fold it into the original patch.
hmm, our autobuilder still fails on this one because there has been no
next release since some time. I hope the best for tomorrow's build :-)

Anyhow, it fixes the build for efm32_defconfig, so

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
