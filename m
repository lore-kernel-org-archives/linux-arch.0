Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49924 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab1EZMpI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2011 08:45:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] unicore32: using generic-y format for one line asm-generic files
Date: Thu, 26 May 2011 14:45:01 +0200
References: <cover.1306408804.git.gxt@mprc.pku.edu.cn> <48ec206f634cad2019c92eef7ba1a87566c743fe.1306408804.git.gxt@mprc.pku.edu.cn>
In-Reply-To: <48ec206f634cad2019c92eef7ba1a87566c743fe.1306408804.git.gxt@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201105261445.01390.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: GuanXuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20110526124501.Dbgc4k6FfjZQcXjiLc9oe8cu_EB1rS6NVS9JNRR4y9E@z>

On Thursday 26 May 2011, GuanXuetao wrote:
> From: Guan Xuetao <gxt@mprc.pku.edu.cn>
> 
> see commit from Sam Ravnborg <d8ecc5cd8e227bc318513b5306ae88a474b8886d>
>   kbuild: asm-generic support
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---
>  arch/unicore32/Makefile           |   35 ----------------------
>  arch/unicore32/include/asm/Kbuild |   59 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 35 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

This reminds me that I should do the same for ARM and maybe some others.
