Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr710059.outbound.protection.outlook.com ([40.107.71.59]:56083
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeHIJgd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Aug 2018 05:36:33 -0400
Subject: Re: [PATCH 3/3] microblaze: uapi header and system call table file
 generation
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-4-git-send-email-firoz.khan@linaro.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
Date: Thu, 9 Aug 2018 09:12:31 +0200
MIME-Version: 1.0
In-Reply-To: <1533792466-4227-4-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20180809071231.bPRO0h89iXGR6I58EdYN8tcuFr5zUtk2xAe0yXQi0GM@z>

On 9.8.2018 07:27, Firoz Khan wrote:
> System call table generation script must be run to generate
> unistd_32.h and syscall_table.h files. This patch will have
> changes which will invokes the script.
> 
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> arch/microblaze/Makefile and the generated files against the
> removed files will be identical.
> 
> The generated uapi header file will be included in
> uapi/asm/unistd.h and generated system call table support
> file will be included by microblaze/kernel/syscall.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/microblaze/Makefile                  |   3 +
>  arch/microblaze/include/asm/Kbuild        |   2 +
>  arch/microblaze/include/uapi/asm/Kbuild   |   2 +
>  arch/microblaze/include/uapi/asm/unistd.h | 409 +-----------------------------
>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>  5 files changed, 12 insertions(+), 810 deletions(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..6121a2b 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -81,6 +81,9 @@ all: linux.bin
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
>  
> +archheaders:
> +	$(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> +
>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  
> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> index fe6a6c6..99225ab 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -30,3 +30,5 @@ generic-y += trace_clock.h
>  generic-y += vga.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +
> +generated-y += syscall_table.h
> \ No newline at end of file

This doesn't look right.


> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> index 2c6a6bf..8fe26a3 100644
> --- a/arch/microblaze/include/uapi/asm/Kbuild
> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> @@ -28,3 +28,5 @@ generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += types.h
>  generic-y += ucontext.h
> +
> +generated-y += unistd_32.h
> \ No newline at end of file

ditto.

Thanks,
Michal
