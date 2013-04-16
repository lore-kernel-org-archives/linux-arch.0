Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:55898 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240Ab3DPJkj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:40:39 -0400
Received: by mail-we0-f171.google.com with SMTP id i48so206548wef.30
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 02:40:38 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/4] gpio: update gpio Chinese documentation
In-Reply-To: <1365445950-5736-5-git-send-email-gnurou@gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <1365445950-5736-5-git-send-email-gnurou@gmail.com>
Date: Tue, 16 Apr 2013 10:40:35 +0100
Message-ID: <20130416094035.28E163E14C0@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Chen Baozi <baozich@gmail.com>
Message-ID: <20130416094035.EGxh4NWQR7xWVI3G3R_DRd0vsp4ZsoQkQycqr9C9tsc@z>

On Mon,  8 Apr 2013 11:32:30 -0700, Alexandre Courbot <gnurou@gmail.com> wrote:
> From: Chen Baozi <baozich@gmail.com>
> 
> Since the GENERIC_GPIO has been removed and the documentation of it
> has been modified, this patch updates the corresponding documentation of
> gpio in Chinese.
> 
> Signed-off-by: Chen Baozi <baozich@gmail.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  Documentation/zh_CN/gpio.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/zh_CN/gpio.txt b/Documentation/zh_CN/gpio.txt
> index 99dbb69..8c8c712 100644
> --- a/Documentation/zh_CN/gpio.txt
> +++ b/Documentation/zh_CN/gpio.txt
> @@ -84,10 +84,10 @@ GPIO 公约
>  控制器的抽象函数来实现它。(有一些可选的代码能支持这种策略的实现,本文档
>  后面会介绍，但作为 GPIO 接口的客户端驱动程序必须与它的实现无关。)
>  
> -也就是说,如果在他们的平台上支持这个公约，驱动应尽可能的使用它。平台
> -必须在 Kconfig 中声明对 GENERIC_GPIO的支持 (布尔型 true)，并提供
> -一个 <asm/gpio.h> 文件。那些调用标准 GPIO 函数的驱动应该在 Kconfig
> -入口中声明依赖GENERIC_GPIO。当驱动包含文件:
> +也就是说,如果在他们的平台上支持这个公约，驱动应尽可能的使用它。同时，平台
> +必须在 Kconfig 中选择 ARCH_REQUIRE_GPIOLIB 或者 ARCH_WANT_OPTIONAL_GPIOLIB
> +选项。那些调用标准 GPIO 函数的驱动应该在 Kconfig 入口中声明依赖GENERIC_GPIO。
> +当驱动包含文件:
>  
>  	#include <linux/gpio.h>
>  
> -- 
> 1.8.2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
