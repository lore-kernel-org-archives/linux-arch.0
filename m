From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] Add ARCH_MIGHT_HAVE_VGA_CONSOLE
Date: Wed, 04 Feb 2015 08:37:16 +0100
Message-ID: <2520649.mPxvSuP2QL@wuerfel>
References: <877fw093oa.wl-ysato@users.sourceforge.jp> <87a90ujjrf.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54131 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbBDHhW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Feb 2015 02:37:22 -0500
In-Reply-To: <87a90ujjrf.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 04 February 2015 15:03:32 Yoshinori Sato wrote:
> @@ -2,14 +2,14 @@
>  # Video configuration
>  #
>  
> +config ARCH_MIGHT_HAVE_VGA_CONSOLE
> +        bool
> +
>  menu "Console display driver support"
>  
> 

I just noticed one more problem: The file that you add the option to is
conditional on CONFIG_VT, and that option is user-selectable. If
VT is disabled, you will get a warning from architectures that select
the symbol.

I think you should move the statement above into drivers/video/Kconfig,
outside of the 'if VT'.

	Arnd
