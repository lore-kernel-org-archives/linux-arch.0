Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36482 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXNGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 09:06:22 -0400
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-5-git-send-email-firoz.khan@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Sep 2018 09:05:31 +0200
Message-ID: <CAMuHMdWZv7eKt+2CSXQ3kgPXc-Vvm7o7zED9afXxnG8dh6+nFA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] m68k: uapi header and system call table file generation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20180924070531.lLptD1PFyDJ-smId8wWHdifybFZ7dnOelCtuR--fDsM@z>

Hi Firoz,

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> System call table generation script must be run to generate
> unistd_32.h and syscall_table.h files. This patch will have
> changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> arch/m68k/Makefile and the generated files against the
> removed files will be identical.
>
> The generated uapi header file will be included in
> uapi/asm/unistd.h and generated system call table support
> file will be included by arch/m68k/kernel/syscall_table.S
> file.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Thanks for your patch!

> --- a/arch/m68k/include/asm/Kbuild
> +++ b/arch/m68k/include/asm/Kbuild
> @@ -24,3 +24,4 @@ generic-y += topology.h
>  generic-y += trace_clock.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +generic-y += syscall_table.h
> \ No newline at end of file

Please add the missing newline.

> diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
> index c2e26a4..6d600e9 100644
> --- a/arch/m68k/include/uapi/asm/Kbuild
> +++ b/arch/m68k/include/uapi/asm/Kbuild
> @@ -21,3 +21,4 @@ generic-y += statfs.h
>  generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += types.h
> +generic-y += unistd_32.h
> \ No newline at end of file

Likewise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
