From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Tue, 29 Dec 2015 12:02:33 +0100
Message-ID: <2936028.iA62kEhLnJ@wuerfel>
References: <1451381195-9315-1-git-send-email-ynorov@caviumnetworks.com> <1451381195-9315-3-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:51959 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbbL2LCq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Dec 2015 06:02:46 -0500
In-Reply-To: <1451381195-9315-3-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: cmetcalf@ezchip.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com

On Tuesday 29 December 2015 12:26:35 Yury Norov wrote:
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
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Should we merge the two patches through my asm-generic tree now, or should
we keep them in the ilp32 series, any preferences?

I think either way works.

	Arnd
