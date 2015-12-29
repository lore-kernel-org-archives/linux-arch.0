From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 2/2] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Tue, 29 Dec 2015 14:43:41 +0300
Message-ID: <20151229114341.GA15657@yury-N73SV>
References: <1451381195-9315-1-git-send-email-ynorov@caviumnetworks.com>
 <1451381195-9315-3-git-send-email-ynorov@caviumnetworks.com>
 <2936028.iA62kEhLnJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0089.outbound.protection.outlook.com ([157.56.111.89]:51236
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751538AbbL2LoA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Dec 2015 06:44:00 -0500
Content-Disposition: inline
In-Reply-To: <2936028.iA62kEhLnJ@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: cmetcalf@ezchip.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com

On Tue, Dec 29, 2015 at 12:02:33PM +0100, Arnd Bergmann wrote:
> On Tuesday 29 December 2015 12:26:35 Yury Norov wrote:
> > All new 32-bit architectures should have 64-bit off_t type, but existing
> > architectures has 32-bit ones.
> > 
> > To handle it, new config option is added to arch/Kconfig that defaults
> > ARCH_32BIT_OFF_T to be disabled for non-64 bit architectures. All existing
> > 32-bit architectures enable it explicitly here.
> > 
> > New option affects force_o_largefile() behaviour. Namely, if off_t is
> > 64-bits long, we have no reason to reject user to open big files.
> > 
> > Note that even if architectures has only 64-bit off_t in the kernel
> > (arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
> > a libc may use 32-bit off_t, and therefore want to limit the file size
> > to 4GB unless specified differently in the open flags.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Should we merge the two patches through my asm-generic tree now, or should
> we keep them in the ilp32 series, any preferences?
> 
> I think either way works.
> 
> 	Arnd

I'd prefer asm-generic tree because they are not related to ILP32 only.

Yury.
