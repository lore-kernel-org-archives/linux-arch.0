From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] 32-bit ABI: introduce ARCH_32BIT_OFF_T config
 option
Date: Tue, 29 Dec 2015 12:49:33 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512291249030.28591@nanos>
References: <1451381195-9315-1-git-send-email-ynorov@caviumnetworks.com> <1451381195-9315-3-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42281 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbL2Luc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Dec 2015 06:50:32 -0500
In-Reply-To: <1451381195-9315-3-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, cmetcalf@ezchip.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com

On Tue, 29 Dec 2015, Yury Norov wrote:

> All new 32-bit architectures should have 64-bit off_t type, but existing
> architectures has 32-bit ones.
> 
> To handle it, new config option is added to arch/Kconfig that defaults
> ARCH_32BIT_OFF_T to be disabled for non-64 bit architectures. All existing
> 32-bit architectures enable it explicitly here.
> 
> New option affects force_o_largefile() behaviour. Namely, if off_t is
> 64-bits long, we have no reason to reject user to open big files.
> 
> Note that even if architectures has only 64-bit off_t in the kernel
> (arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
> a libc may use 32-bit off_t, and therefore want to limit the file size
> to 4GB unless specified differently in the open flags.

For the x86 part: Acked-by: Thomas Gleixner <tglx@linutronix.de>
