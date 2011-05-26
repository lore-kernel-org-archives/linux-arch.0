From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] unicore32: add KBUILD_DEFCONFIG with unicore32_defconfig (old debug_defconfig)
Date: Thu, 26 May 2011 14:45:50 +0200
Message-ID: <201105261445.50905.arnd@arndb.de>
References: <cover.1306408804.git.gxt@mprc.pku.edu.cn> <3edfc75d669888b1732dbcdbecf73c6f7941c1a4.1306408804.git.gxt@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49560 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516Ab1EZMp4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2011 08:45:56 -0400
In-Reply-To: <3edfc75d669888b1732dbcdbecf73c6f7941c1a4.1306408804.git.gxt@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: GuanXuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Thursday 26 May 2011, GuanXuetao wrote:
> From: Guan Xuetao <gxt@mprc.pku.edu.cn>
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---
>  arch/unicore32/Makefile                    |    3 +-
>  arch/unicore32/configs/debug_defconfig     |  215 ----------------------------
>  arch/unicore32/configs/unicore32_defconfig |  215 ++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+), 216 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

Remember to use '-M'
