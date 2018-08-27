From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Date: Mon, 27 Aug 2018 12:50:34 -0700 (PDT)
Message-ID: <mhng-7989f094-cc42-4d36-9db5-a6e6a7747048@palmer-si-x1c4>
References: <20180824213849.23647-2-Jason@zx2c4.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824213849.23647-2-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, Jason@zx2c4.com, luto@kernel.org, Greg KH <gregkh@linuxfoundation.org>, sneves@dei.uc.pt, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 24 Aug 2018 14:38:33 PDT (-0700), Jason@zx2c4.com wrote:
> Sometimes it's useful to amortize calls to XSAVE/XRSTOR and the related
> FPU/SIMD functions over a number of calls, because FPU restoration is
> quite expensive. This adds a simple header for carrying out this pattern:
>
>     simd_context_t simd_context = simd_get();
>     while ((item = get_item_from_queue()) != NULL) {
>         encrypt_item(item, simd_context);
>         simd_context = simd_relax(simd_context);
>     }
>     simd_put(simd_context);
>
> The relaxation step ensures that we don't trample over preemption, and
> the get/put API should be a familiar paradigm in the kernel.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Samuel Neves <sneves@dei.uc.pt>
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/alpha/include/asm/Kbuild      |  5 ++--
>  arch/arc/include/asm/Kbuild        |  1 +
>  arch/arm/include/asm/simd.h        | 42 ++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/simd.h      | 37 +++++++++++++++++++++-----
>  arch/c6x/include/asm/Kbuild        |  3 ++-
>  arch/h8300/include/asm/Kbuild      |  3 ++-
>  arch/hexagon/include/asm/Kbuild    |  1 +
>  arch/ia64/include/asm/Kbuild       |  1 +
>  arch/m68k/include/asm/Kbuild       |  1 +
>  arch/microblaze/include/asm/Kbuild |  1 +
>  arch/mips/include/asm/Kbuild       |  1 +
>  arch/nds32/include/asm/Kbuild      |  7 ++---
>  arch/nios2/include/asm/Kbuild      |  1 +
>  arch/openrisc/include/asm/Kbuild   |  7 ++---
>  arch/parisc/include/asm/Kbuild     |  1 +
>  arch/powerpc/include/asm/Kbuild    |  3 ++-
>  arch/riscv/include/asm/Kbuild      |  3 ++-
>  arch/s390/include/asm/Kbuild       |  3 ++-
>  arch/sh/include/asm/Kbuild         |  1 +
>  arch/sparc/include/asm/Kbuild      |  1 +
>  arch/um/include/asm/Kbuild         |  3 ++-
>  arch/unicore32/include/asm/Kbuild  |  1 +
>  arch/x86/include/asm/simd.h        | 30 ++++++++++++++++++++-
>  arch/xtensa/include/asm/Kbuild     |  1 +
>  include/asm-generic/simd.h         | 15 +++++++++++
>  include/linux/simd.h               | 28 ++++++++++++++++++++
>  26 files changed, 180 insertions(+), 21 deletions(-)
>  create mode 100644 arch/arm/include/asm/simd.h
>  create mode 100644 include/linux/simd.h

...

> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 576ffdca06ba..8d3e7aef3234 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -4,9 +4,9 @@ generic-y += checksum.h
>  generic-y += cputime.h
>  generic-y += device.h
>  generic-y += div64.h
> -generic-y += dma.h
>  generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
> +generic-y += dma.h
>  generic-y += emergency-restart.h
>  generic-y += errno.h
>  generic-y += exec.h

If this is the canonical ordering and doing so makes your life easier then I'm 
OK taking this as a separate patch into the RISC-V tree, but if not then feel 
free to roll something like this up into your next patch set.

> @@ -45,6 +45,7 @@ generic-y += setup.h
>  generic-y += shmbuf.h
>  generic-y += shmparam.h
>  generic-y += signal.h
> +generic-y += simd.h
>  generic-y += socket.h
>  generic-y += sockios.h
>  generic-y += stat.h

Either way, this looks fine for as far as the RISC-V stuff goes as it's pretty 
much a NOP.  As long as it stays a NOP then feel free to add a 

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

as far as the RISC-V parts are conceded.  It looks like there's a lot of other 
issues, though, so it's not much of a review :)
