From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
Date: Mon, 20 Apr 2020 07:43:21 +0900
Message-ID: <CAK7LNAQmdxmk7_fxo0v6T92GwXpXbmukcMBD_4Dp+L89ymM7=A@mail.gmail.com>
References: <20200419222804.483191-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57963 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSWoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Apr 2020 18:44:25 -0400
In-Reply-To: <20200419222804.483191-1-masahiroy@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jessica Yu <jeyu@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Leon Romanovsky <leonro@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Apr 20, 2020 at 7:28 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> As the bug report [1] pointed out, <linux/vermagic.h> must be included
> after <linux/module.h>.
>
> I believe we should be able to include headers in any order. We often
> sort include directives alphabetically, but it is just coding style
> convention. Technically, we can get rid of the include order restriction
> by making every header self-contained.
>
> Currently, arch-specific MODULE_ARCH_VERMAGIC is defined in
> <asm/module.h>, but it is not included from <linux/vermagic.h>.
>
> Hence, the straight-forward fix-up would be as follows:
>
> |--- a/include/linux/vermagic.h
> |+++ b/include/linux/vermagic.h
> |@@ -1,5 +1,6 @@
> | /* SPDX-License-Identifier: GPL-2.0 */
> | #include <generated/utsrelease.h>
> |+#include <linux/module.h>
> |
> | /* Simply sanity version stamp for modules. */
> | #ifdef CONFIG_SMP
>
> This works enough, but for further cleanups, I split MODULE_ARCH_VERMAGIC
> definitions into <asm/vermagic.h>.
>
> With this, <linux/module.h> and <linux/vermagic.h> will be orthogonal,
> and the location of MODULE_ARCH_VERMAGIC definitions will be consistent.
>
> For arc and ia64, MODULE_PROC_FAMILY is only used for defining
> MODULE_ARCH_VERMAGIC. I squashed it.
>
> FOR hexagon, nds32, and xtensa, I removed <asm/modules.h> entirely
> because they contained nothing but MODULE_ARCH_VERMAGIC definition.
> Kbuild will automatically generate <asm/modules.h> at build-time,
> wrapping <asm-generic/module.h>.
>
> [1] https://lore.kernel.org/lkml/20200411155623.GA22175@zn.tnic
>

I forgot to add this:

Reported-by: Borislav Petkov <bp@suse.de>



> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I do not mean to replace the work by Leon Romanovsky:
> https://lkml.org/lkml/2020/4/19/201
>
> His work intends to hide <linux/vermagic.h> from driver writers.
> It is solving a different problem.
> It does not solve the include order restriction reported by [1].
> It still relies on kernel/module.c and *.mod.c
> include <linux/vermagic.h> after <linux/module.h>.
>
> I believe we should not impose any restriction about the include order.
> So, this patch is the direct answer to the bug report [1].
>
> BTW, I think commit f58dd03b1157bdf3b64c36e9525f8d7f69c25df2
> was a bad way to suppress the problem, but that is another story.
>


-- 
Best Regards
Masahiro Yamada
