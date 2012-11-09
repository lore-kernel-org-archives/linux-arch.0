From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 32/40] i8042: don't build on METAG
Date: Fri, 9 Nov 2012 14:28:42 +0000
Message-ID: <201211091428.42998.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-33-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64659 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab2KIO2p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 09:28:45 -0500
In-Reply-To: <1351700061-7203-33-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 31 October 2012, James Hogan wrote:
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 55f2c22..60b2a09 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -22,7 +22,7 @@ config SERIO_I8042
>         tristate "i8042 PC Keyboard controller" if EXPERT || !X86
>         default y
>         depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && \
> -                  (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN
> +                  (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !METAG
>         help
>           i8042 is the chip over which the standard AT keyboard and PS/2
>           mouse are connected to the computer. If you use these devices,

Maybe you can turn that list around and introduce a new symbol
ARCH_HAS_SERIO_I8042 or similar that architectures can select.
I suspect that actually most don't have this, but they have not
bothered to update this list.

	Arnd
