From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file
 generation
Date: Tue, 2 Oct 2018 16:06:56 +0200
Message-ID: <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538397784-4214-4-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On 1.10.2018 14:43, Firoz Khan wrote:
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
> file will be included by kernel/syscall_table.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/microblaze/Makefile                  |   3 +
>  arch/microblaze/include/asm/Kbuild        |   1 +
>  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
>  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>  5 files changed, 10 insertions(+), 812 deletions(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 4f3ab57..cda5e03 100644
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
> index 569ba9e..d64f5e7 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -31,3 +31,4 @@ generic-y += trace_clock.h
>  generic-y += vga.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +generic-y += syscall_table.h
> \ No newline at end of file

Still the problem with "No newline at end of file"

> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> index 2c6a6bf..3a40659 100644
> --- a/arch/microblaze/include/uapi/asm/Kbuild
> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> @@ -28,3 +28,4 @@ generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += types.h
>  generic-y += ucontext.h
> +generic-y += unistd_32.h
> \ No newline at end of file

and here too.

M
