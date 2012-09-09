Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo2.mail-out.ovh.net ([178.32.228.2]:34544 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab2IIRwK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Sep 2012 13:52:10 -0400
Received: from mail636.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 80AB9DC4199
	for <linux-arch@vger.kernel.org>; Sun,  9 Sep 2012 18:40:03 +0200 (CEST)
Date: Sun, 9 Sep 2012 18:31:56 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3 31/31] arm64: MAINTAINERS update
Message-ID: <20120909163156.GA31430@game.jcrosoft.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-32-git-send-email-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1347035226-18649-32-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120909163156.xthRP9FjBrC8nKGTkwi4R9zlBX0Tedc6wn2W9EgwLqM@z>

On 17:27 Fri 07 Sep     , Catalin Marinas wrote:
> This patch updates the MAINTAINERS file for the AArch64 Linux kernel
> port.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdc0119..de368a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1209,6 +1209,12 @@ S:	Maintained
>  F:	arch/arm/mach-pxa/z2.c
>  F:	arch/arm/mach-pxa/include/mach/z2.h
>  
> +ARM64 PORT (AARCH64 ARCHITECTURE)
> +M:	Catalin Marinas <catalin.marinas@arm.com>
we should put Russell too

Best Regards,
J.
