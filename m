Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:44986 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaXRy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jan 2014 18:17:54 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so4863866pdj.1
        for <linux-arch@vger.kernel.org>; Fri, 31 Jan 2014 15:17:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1390339396-3479-28-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-28-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20140131231737.4167.80136@quantum>
Subject: Re: [PATCH 27/73] drivers/clk: don't use module_init in clk-nomadik.c which
 is non-modular
Date: Fri, 31 Jan 2014 15:17:37 -0800
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20140131231737.KFTb1be0JiM151gw87Lzdd2Hlcxe856uDL7jcCRcz9A@z>

Quoting Paul Gortmaker (2014-01-21 13:22:30)
> The clk-nomadik.o is built for ARCH_NOMADIK -- which is bool, and
> hence this code is either present or absent.  It will never be
> modular, so using module_init as an alias for __initcall can be
> somewhat misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of device_initcall
> directly in this change means that the runtime impact is
> zero -- it will remain at level 6 in initcall ordering.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Looks good to me.

Regards,
Mike

> ---
>  drivers/clk/clk-nomadik.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> index 6a934a5..5be9b9f 100644
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -500,8 +500,7 @@ static int __init nomadik_src_clk_init_debugfs(void)
>                             NULL, NULL, &nomadik_src_clk_debugfs_ops);
>         return 0;
>  }
> -
> -module_init(nomadik_src_clk_init_debugfs);
> +device_initcall(nomadik_src_clk_init_debugfs);
>  
>  #endif
>  
> -- 
> 1.8.4.1
> 
