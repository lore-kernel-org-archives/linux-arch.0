From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [patch 36/37] tile: Use generic irq Kconfig
Date: Thu, 20 Jan 2011 13:54:27 -0500
Message-ID: <4D3884E3.8050009@tilera.com>
References: <20110119205258.462759212@linutronix.de> <20110119210840.631350392@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([206.83.70.70]:44218 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab1ATSy3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jan 2011 13:54:29 -0500
In-Reply-To: <20110119210840.631350392@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On 1/19/2011 4:50 PM, Thomas Gleixner wrote:
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/tile/Kconfig |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> Index: linux-2.6/arch/tile/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/tile/Kconfig
> +++ linux-2.6/arch/tile/Kconfig
> @@ -1,22 +1,18 @@
>  # For a description of the syntax of this configuration file,
>  # see Documentation/kbuild/config-language.txt.
>  
> +config TILE
> +       def_bool y
> +       select HAVE_GENERIC_HARDIRQS
> +       select GENERIC_IRQ_PROBE
> +       select GENERIC_PENDING_IRQ if SMP
> +
>  [...]

I'm not sure it's legal to have two "config TILE" blocks in this Kconfig
file; there's already one further down.

Looking at other top-level arch Kconfigs, it does seem common to have the
"config $ARCH" block at the top, though, so if you want to move the
existing "config TILE" block to the top of the Kconfig as part of this
change, that's fine too.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
