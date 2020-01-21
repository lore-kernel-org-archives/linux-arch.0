From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
Date: Wed, 22 Jan 2020 00:43:28 +0900
Message-ID: <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, git@xilinx.com, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, X86 ML <x86@kernel.org>, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>Ralf Baechle <r>
List-Id: linux-arch.vger.kernel.org

Hi.

On Fri, Jan 17, 2020 at 5:03 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.



Currently, <asm/dma-contiguous.h> is present
for only architectures that select HAVE_DMA_CONTIGUOUS.

After this commit, the other architectures will end
up with generating the unused header.

That would not be a big deal, but
it could be mentioned in the commit message?



> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - New patch suggested by Christoph
>
>  arch/arm64/include/asm/Kbuild  | 1 -
>  arch/csky/include/asm/Kbuild   | 1 -
>  arch/mips/include/asm/Kbuild   | 1 -
>  arch/riscv/include/asm/Kbuild  | 1 -
>  arch/s390/include/asm/Kbuild   | 1 -
>  arch/x86/include/asm/Kbuild    | 1 -
>  arch/xtensa/include/asm/Kbuild | 1 -
>
>  include/asm-generic/Kbuild     | 1 +
>  8 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index bd23f87d6c55..d3077c991962 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -3,7 +3,6 @@ generic-y += bugs.h
>  generic-y += delay.h
>  generic-y += div64.h
>  generic-y += dma.h
> -generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += early_ioremap.h
>  generic-y += emergency-restart.h
> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> index 4d4754e6bf89..bc15a26c782f 100644
> --- a/arch/csky/include/asm/Kbuild
> +++ b/arch/csky/include/asm/Kbuild
> @@ -7,7 +7,6 @@ generic-y += delay.h
>  generic-y += device.h
>  generic-y += div64.h
>  generic-y += dma.h
> -generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index 61b0fc2026e6..179403ae5837 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -6,7 +6,6 @@ generated-y += syscall_table_64_n64.h
>  generated-y += syscall_table_64_o32.h
>  generic-y += current.h
>  generic-y += device.h
> -generic-y += dma-contiguous.h
>  generic-y += emergency-restart.h
>  generic-y += export.h
>  generic-y += irq_work.h
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 1efaeddf1e4b..ec0ca8c6ab64 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -7,7 +7,6 @@ generic-y += div64.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += dma.h
> -generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
> diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
> index 2531f673f099..1832ae6442ef 100644
> --- a/arch/s390/include/asm/Kbuild
> +++ b/arch/s390/include/asm/Kbuild
> @@ -7,7 +7,6 @@ generated-y += unistd_nr.h
>  generic-y += asm-offsets.h
>  generic-y += cacheflush.h
>  generic-y += device.h
> -generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += div64.h
>  generic-y += emergency-restart.h
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index 8b52bc5ddf69..ea34464d6221 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -7,7 +7,6 @@ generated-y += unistd_32_ia32.h
>  generated-y += unistd_64_x32.h
>  generated-y += xen-hypercalls.h
>
> -generic-y += dma-contiguous.h
>  generic-y += early_ioremap.h
>  generic-y += export.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> index 3acc31e55e02..271917c24b7f 100644
> --- a/arch/xtensa/include/asm/Kbuild
> +++ b/arch/xtensa/include/asm/Kbuild
> @@ -4,7 +4,6 @@ generic-y += bug.h
>  generic-y += compat.h
>  generic-y += device.h
>  generic-y += div64.h
> -generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index ddfee1bd9dc1..cd17d50697cc 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -4,5 +4,6 @@
>  # (This file is not included when SRCARCH=um since UML borrows several
>  # asm headers from the host architecutre.)
>
> +mandatory-y += dma-contiguous.h
>  mandatory-y += msi.h
>  mandatory-y += simd.h
> --
> 2.25.0
>


-- 
Best Regards
Masahiro Yamada
