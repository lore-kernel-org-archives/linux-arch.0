Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:4950
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755032AbcLNJjk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Dec 2016 04:39:40 -0500
Date: Wed, 14 Dec 2016 15:09:22 +0530
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 09/18] arm64: introduce binfmt_elf32.c
Message-ID: <20161214093922.GA27720@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
 <20161205151018.GD14429@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161205151018.GD14429@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20161214093922.bSEObJnCbrHRSYyScmPn_sY9Jk5wE2qHV1LlBEKRUso@z>

On Mon, Dec 05, 2016 at 03:10:19PM +0000, Catalin Marinas wrote:
> On Fri, Oct 21, 2016 at 11:33:08PM +0300, Yury Norov wrote:
> > As we support more than one compat formats, it looks more reasonable
> > to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
> > specific definitions there and make code more maintainable and readable.
> 
> Can you remind me why we need this patch (rather than using the default
> fs/compat_binfmt_elf.c which you include here anyway)?

https://patchwork.kernel.org/patch/8756121/

This is mostly to avoid runtime checks and hide some re-definitions
for aarch32 from ilp32, to avoid re-re-definition.

> 
> > --- /dev/null
> > +++ b/arch/arm64/kernel/binfmt_elf32.c
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Support for AArch32 Linux ELF binaries.
> > + */
> > +
> > +/* AArch32 EABI. */
> > +#define EF_ARM_EABI_MASK		0xff000000
> > +
> > +#define compat_start_thread		compat_start_thread
> > +#define COMPAT_SET_PERSONALITY(ex)		\
> > +do {						\
> > +	clear_thread_flag(TIF_32BIT_AARCH64);	\
> > +	set_thread_flag(TIF_32BIT);		\
> > +} while (0)
> 
> You introduce this here but it seems to still be present in asm/elf.h.

Hmm... Maybe chunk that delete it from asm/elf.h was dropped at some
rebase. Thank you for the catch. I'll check it again.

Yury
