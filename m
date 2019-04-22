Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:47270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKO3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Apr 2019 06:14:29 -0400
Date: Mon, 22 Apr 2019 12:14:20 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 11/11] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Message-ID: <20190422101420.GA21457@zn.tnic>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
 <20190419094754.24667-12-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419094754.24667-12-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <20190422101420.Xb2-t9I4TnLpWRP6D1q_jiXyzjXF0uKbFKNf82lWZkQ@z>

On Fri, Apr 19, 2019 at 06:47:54PM +0900, Masahiro Yamada wrote:
> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> 
> The idea is obviously arch-agnostic. This commit moves the config
> entry from arch/x86/Kconfig.debug to lib/Kconfig.debug so that all
> architectures can benefit from it.
> 
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> 
> For example, I got 3.5% smaller arm64 kernel for v5.1-rc1.
> 
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
> 
> This also slightly improves the "Kernel hacking" Kconfig menu as
> e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen') suggested;
> this config option would be a good fit in the "compiler option" menu.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - split into a separate patch
> 
>  arch/x86/Kconfig               |  3 ---
>  arch/x86/Kconfig.debug         | 14 --------------
>  include/linux/compiler_types.h |  3 +--
>  lib/Kconfig.debug              | 14 ++++++++++++++
>  4 files changed, 15 insertions(+), 19 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
