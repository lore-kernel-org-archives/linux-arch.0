From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/24] C6X: specific board support
Date: Tue, 9 Aug 2011 19:04:42 +0200
Message-ID: <201108091904.43047.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-23-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60131 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab1HIREs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 13:04:48 -0400
In-Reply-To: <1312839879-13592-23-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/platforms/board-dsk6455.c |  102 ++++++++++++++++++++++++++++++++++++
>  arch/c6x/platforms/board-evm6457.c |   51 ++++++++++++++++++
>  arch/c6x/platforms/board-evm6472.c |   51 ++++++++++++++++++
>  arch/c6x/platforms/board-evm6474.c |   53 +++++++++++++++++++
>  4 files changed, 257 insertions(+), 0 deletions(-)

I would argue that none of these should exist. When you have device tree probing,
you should be able to do all the initialization according to the device tree contents.

>
>+       c6455_setup_arch();
>+
>+       /* CPLD */
>+       emif_config_ce(2, EMIFA_CFG_ASYNC |
>+                      EMIFA_CFG_W_SETUP(1)   |
>+                      EMIFA_CFG_W_STROBE(10) |
>+                      EMIFA_CFG_W_HOLD(1)    |
>+                      EMIFA_CFG_R_SETUP(1)   |
>+                      EMIFA_CFG_R_STROBE(10) |
>+                      EMIFA_CFG_R_HOLD(1)    |
>+                      EMIFA_CFG_WIDTH_8);
>+
>+       /* NOR Flash */
>+       emif_config_ce(3, EMIFA_CFG_ASYNC |
>+                      EMIFA_CFG_W_SETUP(1)   |
>+                      EMIFA_CFG_W_STROBE(10) |
>+                      EMIFA_CFG_W_HOLD(1)    |
>+                      EMIFA_CFG_R_SETUP(1)   |
>+                      EMIFA_CFG_R_STROBE(10) |
>+                      EMIFA_CFG_R_HOLD(1)    |
>+                      EMIFA_CFG_WIDTH_8);
>+
>+       /* Daughter Card */
>+       emif_config_ce(4, EMIFA_CFG_ASYNC |
>+                      EMIFA_CFG_W_SETUP(1)   |
>+                      EMIFA_CFG_W_STROBE(10) |
>+                      EMIFA_CFG_W_HOLD(1)    |
>+                      EMIFA_CFG_R_SETUP(1)   |
>+                      EMIFA_CFG_R_STROBE(10) |
>+                      EMIFA_CFG_R_HOLD(1)    |
>+                      EMIFA_CFG_WIDTH_32);
>+
>+       /* Daughter Card */
>+       emif_config_ce(5, EMIFA_CFG_ASYNC |
>+                      EMIFA_CFG_W_SETUP(1)   |
>+                      EMIFA_CFG_W_STROBE(10) |
>+                      EMIFA_CFG_W_HOLD(1)    |
>+                      EMIFA_CFG_R_SETUP(1)   |
>+                      EMIFA_CFG_R_STROBE(10) |
>+                      EMIFA_CFG_R_HOLD(1)    |
>+                      EMIFA_CFG_WIDTH_32);
>+
>+       /* Raise priority of waiting bus commands after 255 transfers */
>+       emif_set_burst_prio(255);

This code definitely needs more explanation. Why is this all done in Linux instead of
the boot loader? If it's device specific, why not do it in the device driver?

	Arnd
