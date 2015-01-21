From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 03/16] h8300: defconfigs
Date: Wed, 21 Jan 2015 09:47:23 +0100
Message-ID: <4623269.GpWS2F7uJC@wuerfel>
References: <cover.1421813622.git.ysato@users.sourceforge.jp> <87vbk0vk0b.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54553 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbAUIri (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 03:47:38 -0500
In-Reply-To: <87vbk0vk0b.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org

On Wednesday 21 January 2015 13:24:20 Yoshinori Sato wrote:
> --- /dev/null
> +++ b/arch/h8300/configs/h8300h-sim_defconfig
> @@ -0,0 +1,603 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/h8300 3.19.0-rc3 Kernel Configuration
> +#
> 

Please use 'make savedefconfig' to generate smaller files.

	Arnd
