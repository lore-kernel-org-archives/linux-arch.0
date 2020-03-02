From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
Date: Mon, 2 Mar 2020 09:19:00 +0100
Message-ID: <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Linux MM <linux-mm@kvack.org>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Paul Burton <paulburton@kernel.org>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Parisc List <linux-parisc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Sam
List-Id: linux-arch.vger.kernel.org

Hi Anshuman,

Thanks for your patch!

On Mon, Mar 2, 2020 at 2:56 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Currently there are many platforms that dont enable HAVE_ARCH_PTE_SPECIAL

ARCH_HAS_PTE_SPECIAL

> but required to define quite similar fallback stubs for special page table
> entry helpers such as pte_special() and pte_mkspecial(), as they get build
> in generic MM without a config check. This creates two generic fallback
> stub definitions for these helpers, eliminating much code duplication.
>
> mips platform has a special case where pte_special() and pte_mkspecial()
> visibility is wider than what HAVE_ARCH_PTE_SPECIAL enablement requires.

ARCH_HAS_PTE_SPECIAL

> This restricts those symbol visibility in order to avoid redefinitions
> which is now exposed through this new generic stubs and subsequent build
> failure. arm platform set_pte_at() definition needs to be moved into a C
> file just to prevent a build failure.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h      | 10 ------
>  arch/m68k/include/asm/motorola_pgtable.h |  2 --
>  arch/m68k/include/asm/sun3_pgtable.h     |  2 --

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
