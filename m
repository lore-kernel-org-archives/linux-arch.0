From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] ARM: Delete asm/system.h
Date: Wed, 12 Feb 2014 17:54:42 +0100
Message-ID: <1559240.V3DW7mAybD@wuerfel>
References: <20140212154544.2405.2992.stgit@warthog.procyon.org.uk> <20140212154615.2405.88996.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51854 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaBLQyz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2014 11:54:55 -0500
In-Reply-To: <20140212154615.2405.88996.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 12 February 2014 15:46:15 David Howells wrote:
> Delete ARM's asm/system.h.  It's the last holdout and should be got rid of.
> 
> This builds for defconfig, lpc32xx_defconfig, exynos_defconfig + XEN, the
> previous changed to a Gemini system and an omap3 config with TI_DAVINCI_EMAC.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Russell King <linux@arm.linux.org.uk>
> cc: linux-arm-kernel@lists.infradead.org

Acked-by: Arnd Bergmann <arnd@arndb.de>

I've added this to my randconfig builder, will let you know when unexpected
bugs show up (probably won't).

	Arnd
