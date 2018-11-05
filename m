From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
Date: Mon, 5 Nov 2018 13:44:39 -0800
Message-ID: <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org> <1541080581-4072-5-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541080581-4072-5-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation script must be run to gener-
> ate unistd_32.h and syscall_table.h files. This patch will
> have changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> xtensa/Makefile and the generated files against the removed
> files must be identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscall.c file.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/xtensa/Makefile                  |   3 +
>  arch/xtensa/include/asm/Kbuild        |   1 +
>  arch/xtensa/include/uapi/asm/Kbuild   |   1 +
>  arch/xtensa/include/uapi/asm/unistd.h | 782 +---------------------------------
>  arch/xtensa/kernel/syscall.c          |   5 +-
>  5 files changed, 10 insertions(+), 782 deletions(-)
>
> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> index d67e30fa..1e7b179 100644
> --- a/arch/xtensa/Makefile
> +++ b/arch/xtensa/Makefile
> @@ -99,6 +99,9 @@ all Image zImage uImage: vmlinux
>  dtbs: scripts
>         $(Q)$(MAKE) $(build)=$(boot)/dts
>
> +archheaders:
> +       $(Q)$(MAKE) $(build)=arch/xtensa/kernel/syscalls all
> +
>  define archhelp
>    @echo '* Image       - Kernel ELF image with reset vector'
>    @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images/zImage.*)'
> diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> index 82c75643..b35d2e6 100644
> --- a/arch/xtensa/include/asm/Kbuild
> +++ b/arch/xtensa/include/asm/Kbuild
> @@ -28,3 +28,4 @@ generic-y += topology.h
>  generic-y += trace_clock.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +generic-y += syscall_table.h

This doesn't look right: syscall_table.h is not asm-generic header.

> diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> index 837d4dd..f826d52 100644
> --- a/arch/xtensa/include/uapi/asm/Kbuild
> +++ b/arch/xtensa/include/uapi/asm/Kbuild
> @@ -11,3 +11,4 @@ generic-y += resource.h
>  generic-y += siginfo.h
>  generic-y += statfs.h
>  generic-y += termios.h
> +generic-y += unistd_32.h

Ditto: unistd32_.h is not asm-generic header.

-- 
Thanks.
-- Max
