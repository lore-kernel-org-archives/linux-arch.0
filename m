From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
Date: Tue, 8 Jan 2019 20:10:32 +0900
Message-ID: <20190108111032.GP3235@lianli.shorne-pla.net>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, linux-arch@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, uclinux-h8-devel@lists.sourceforge.jp, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Mark Salter <msalter@redhat.com>
List-Id: linux-arch.vger.kernel.org

Hi Masahiro,

On Tue, Jan 08, 2019 at 08:38:27AM +0900, Masahiro Yamada wrote:
> Most architectures do not export shmparam.h to user-space.
> 
>   $ find arch -name shmparam.h  | sort
>   arch/alpha/include/asm/shmparam.h
>   arch/arc/include/asm/shmparam.h
>   arch/arm64/include/asm/shmparam.h
>   arch/arm/include/asm/shmparam.h
>   arch/csky/include/asm/shmparam.h
>   arch/ia64/include/asm/shmparam.h
>   arch/mips/include/asm/shmparam.h
>   arch/nds32/include/asm/shmparam.h
>   arch/nios2/include/asm/shmparam.h
>   arch/parisc/include/asm/shmparam.h
>   arch/powerpc/include/asm/shmparam.h
>   arch/s390/include/asm/shmparam.h
>   arch/sh/include/asm/shmparam.h
>   arch/sparc/include/asm/shmparam.h
>   arch/x86/include/asm/shmparam.h
>   arch/xtensa/include/asm/shmparam.h
> 
> Strangely, some users of the asm-generic wrapper export shmparam.h
> 
>   $ git grep 'generic-y += shmparam.h'
>   arch/c6x/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/h8300/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/hexagon/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/m68k/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/microblaze/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/openrisc/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/riscv/include/asm/Kbuild:generic-y += shmparam.h
>   arch/unicore32/include/uapi/asm/Kbuild:generic-y += shmparam.h
> 
> The newly added riscv correctly creates the asm-generic wrapper
> in the kernel space, but the others (c6x, h8300, hexagon, m68k,
> microblaze, openrisc, unicore32) create the one in the uapi directory.
> 
> Digging into the git history, now I guess fcc8487d477a ("uapi:
> export all headers under uapi directories") was the misconversion.
> Prior to that commit, no architecture exported to shmparam.h
> As its commit description said, that commit exported shmparam.h
> for c6x, h8300, hexagon, m68k, openrisc, unicore32.
> 
> 83f0124ad81e ("microblaze: remove asm-generic wrapper headers")
> accidentally exported shmparam.h for microblaze.
> 
> This commit unexports shmparam.h for those architectures.
> 
> There is no more reason to export include/uapi/asm-generic/shmparam.h,
> so it has been moved to include/asm-generic/shmparam.h
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/c6x/include/asm/Kbuild               | 1 +
>  arch/c6x/include/uapi/asm/Kbuild          | 1 -
>  arch/h8300/include/asm/Kbuild             | 1 +
>  arch/h8300/include/uapi/asm/Kbuild        | 1 -
>  arch/hexagon/include/asm/Kbuild           | 1 +
>  arch/hexagon/include/uapi/asm/Kbuild      | 1 -
>  arch/m68k/include/asm/Kbuild              | 1 +
>  arch/m68k/include/uapi/asm/Kbuild         | 1 -
>  arch/microblaze/include/asm/Kbuild        | 1 +
>  arch/microblaze/include/uapi/asm/Kbuild   | 1 -
>  arch/openrisc/include/asm/Kbuild          | 1 +
>  arch/openrisc/include/uapi/asm/Kbuild     | 1 -
>  arch/unicore32/include/asm/Kbuild         | 1 +
>  arch/unicore32/include/uapi/asm/Kbuild    | 1 -
>  include/{uapi => }/asm-generic/shmparam.h | 0
>  15 files changed, 7 insertions(+), 7 deletions(-)
>  rename include/{uapi => }/asm-generic/shmparam.h (100%)
> 

[...]

> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index eb87cd8..1f04844b 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -34,6 +34,7 @@ generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += sections.h
>  generic-y += segment.h
> +generic-y += shmparam.h
>  generic-y += string.h
>  generic-y += switch_to.h
>  generic-y += topology.h
> diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
> index 6c6f630..0febf1a 100644
> --- a/arch/openrisc/include/uapi/asm/Kbuild
> +++ b/arch/openrisc/include/uapi/asm/Kbuild
> @@ -1,5 +1,4 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generic-y += kvm_para.h
> -generic-y += shmparam.h
>  generic-y += ucontext.h

What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.

    $ ~/work/bin/am-incoming PATCH_arch_unexport_asm-shmparam.h_for_all_architectures.patch
    Applying: arch: unexport asm/shmparam.h for all architectures
    error: patch failed: arch/c6x/include/uapi/asm/Kbuild:1
    error: arch/c6x/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/h8300/include/uapi/asm/Kbuild:1
    error: arch/h8300/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/hexagon/include/uapi/asm/Kbuild:1
    error: arch/hexagon/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/m68k/include/uapi/asm/Kbuild:2
    error: arch/m68k/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/microblaze/include/uapi/asm/Kbuild:2
    error: arch/microblaze/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/openrisc/include/uapi/asm/Kbuild:1
    error: arch/openrisc/include/uapi/asm/Kbuild: patch does not apply
    error: patch failed: arch/unicore32/include/uapi/asm/Kbuild:1
    error: arch/unicore32/include/uapi/asm/Kbuild: patch does not apply
    Patch failed at 0001 arch: unexport asm/shmparam.h for all architectures
    hint: Use 'git am --show-current-patch' to see the failed patch

It seems shmparam.h is not there. It was removed with the others in your
("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
days ago.

Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
get it merged asap :)

-Stafford
