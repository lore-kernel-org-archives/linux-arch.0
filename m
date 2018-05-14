Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:46293 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeENAJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2018 20:09:53 -0400
MIME-Version: 1.0
In-Reply-To: <20180509130001.24276-1-npiggin@gmail.com>
References: <20180509130001.24276-1-npiggin@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 14 May 2018 09:08:52 +0900
Message-ID: <CAK7LNARVkvM1deFGbdnaTt41hDqV9pCZ1+OCB0dCqPgspLMVPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling
 for powerpc
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20180514000852.nTzJQ03snZy6pGnf_UklkMN9oqoUa7WMk8abH_t_Ci4@z>

2018-05-09 21:59 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> v2 changes only patch 4, updates the changelog with ppc32 numbers and
> Tested-by tags, and also use TEXT_MAIN in the linker script as
> Christophe suggested.


Replaced with v2.
Thanks!


> Thanks,
> Nick
>
> Nicholas Piggin (4):
>   kbuild: Fix asm-generic/vmlinux.lds.h for
>     LD_DEAD_CODE_DATA_ELIMINATION
>   kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
>     -ffunction-sections/-fdata-sections for module build
>   kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
>     enabled
>   powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected
>
>  Makefile                          |  4 +--
>  arch/Kconfig                      | 15 ----------
>  arch/powerpc/Kconfig              |  1 +
>  arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
>  include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
>  init/Kconfig                      | 27 +++++++++++++++++
>  6 files changed, 70 insertions(+), 48 deletions(-)
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
