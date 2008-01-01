Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:24236 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbYAAO5k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jan 2008 09:57:40 -0500
Received: by py-out-1112.google.com with SMTP id u52so9466572pyb.10
        for <linux-arch@vger.kernel.org>; Tue, 01 Jan 2008 06:57:39 -0800 (PST)
Message-ID: <386072610801010657o59fd2aboee90e29f8a637a7f@mail.gmail.com>
Date: Tue, 1 Jan 2008 22:57:38 +0800
From: "Bryan Wu" <cooloney.lkml@gmail.com>
Subject: Re: [RFC: 2.6 patch] make BINFMT_FLAT a bool
In-Reply-To: <20080101134831.GM2360@does.not.exist>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080101134831.GM2360@does.not.exist>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Jan 1, 2008 9:48 PM, Adrian Bunk <bunk@kernel.org> wrote:
> I have not yet seen anyone saying he has a reasonable use case for using
> BINFMT_FLAT modular on his embedded device.
>
> Considering that fs/binfmt_flat.c even lacks a MODULE_LICENSE() I really
> doubt there is any, and this patch therefore makes BINFMT_FLAT a bool.
>

It is OK for Blackfin. There is no application using FLAT binary
format as module.

Thanks
-Bryan

> Signed-off-by: Adrian Bunk <bunk@kernel.org>
>
> ---
>
>  fs/Kconfig.binfmt |    2 +-
>  fs/binfmt_flat.c  |    6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> 5437fb7517380d1b93dde3c09dbd3a2efaf276c3
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index d4fc609..c16a16c 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -37,7 +37,7 @@ config BINFMT_ELF_FDPIC
>           It is also possible to run FDPIC ELF binaries on MMU linux also.
>
>  config BINFMT_FLAT
> -       tristate "Kernel support for flat binaries"
> +       bool "Kernel support for flat binaries"
>         depends on !MMU
>         help
>           Support uClinux FLAT format binaries.
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 33764fd..274d723 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -933,14 +933,8 @@ static int __init init_flat_binfmt(void)
>         return register_binfmt(&flat_format);
>  }
>
> -static void __exit exit_flat_binfmt(void)
> -{
> -       unregister_binfmt(&flat_format);
> -}
> -
>  /****************************************************************************/
>
>  core_initcall(init_flat_binfmt);
> -module_exit(exit_flat_binfmt);
>
>  /****************************************************************************/
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
