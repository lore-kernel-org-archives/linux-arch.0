Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:44218 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753414Ab2KLQJm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 11:09:42 -0500
Received: from mail426.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id C0852DC3A0A
	for <linux-arch@vger.kernel.org>; Mon, 12 Nov 2012 15:59:38 +0100 (CET)
Date: Mon, 12 Nov 2012 15:49:36 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 05/11] ARM: at91: convert timer suspend/resume to
 clock_event_device
Message-ID: <20121112144936.GL4576@game.jcrosoft.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-7-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1352408516-21988-7-git-send-email-swarren@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>
Message-ID: <20121112144936.N7ofYsGAcPuhINRUr_Y0GWUd6pyJuBeJoq0t2P8xWqY@z>

On 14:01 Thu 08 Nov     , Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move at91's timer suspend/resume functions from struct sys_timer
> at91sam926x_timer into struct clock_event_device pit_clkevt. This
> will allow the sys_timer suspend/resume fields to be removed, and
> eventually lead to a complete removal of struct sys_timer.
> 
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
look fine

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
