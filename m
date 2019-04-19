Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36062 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfDSSnd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Apr 2019 14:43:33 -0400
MIME-Version: 1.0
References: <20190419094754.24667-1-yamada.masahiro@socionext.com> <20190419094754.24667-7-yamada.masahiro@socionext.com>
In-Reply-To: <20190419094754.24667-7-yamada.masahiro@socionext.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 19 Apr 2019 17:45:31 +0200
Message-ID: <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] MIPS: mark __fls() as __always_inline
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20190419154531.knoDSPv_dulmaEW6lRlF22A2sTUWxd7HMn_tKFhicI8@z>

Hi,

On Fri, Apr 19, 2019 at 12:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.
>
> If it is enabled for mips, the following errors are reported:
>
> arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined references to `mips_gcr_base'

Tested with success on ppc32/G4. But on CI20 (ci20_defconfig from
master), I get:

  MODPOST vmlinux.o
mipsel-linux-gnu-ld: arch/mips/kernel/traps.o: in function
`addr_gcr_err_control':
/home/mathieu/tmp/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld: arch/mips/mm/sc-mips.o: in function
`addr_gcr_l2_pft_control':
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
arch/mips/mm/sc-mips.o:/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
more undefined references to `mips_gcr_base' follow


> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - new patch
>
>  arch/mips/include/asm/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index 830c93a010c3..6a26ead1c2b6 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -482,7 +482,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
>   * Return the bit position (0..63) of the most significant 1 bit in a word
>   * Returns -1 if no 1 bit exists
>   */
> -static inline unsigned long __fls(unsigned long word)
> +static __always_inline unsigned long __fls(unsigned long word)
>  {
>         int num;
>
> --
> 2.17.1
>
