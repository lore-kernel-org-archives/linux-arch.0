Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45930 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeIXNCJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 09:02:09 -0400
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Sep 2018 09:01:19 +0200
Message-ID: <CAMuHMdWST+PJM8EChBpbToycmXWyt6icNM0x6H9FWtHOMQK7aQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] m68k: Replace NR_syscalls macro from asm/unistd.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20180924070119.BdMejW-ZddMoE0j7iebNhDtaIt-F1jheHBCM7Wungr8@z>

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> NR_syscalls macro holds the number of system call exist in m68k
> architecture. This macro is currently the part of asm/unistd.h file.
> We have to change the value of NR_syscalls, if we add or delete a
> system call.
>
> One of patch in this patch series has a script which will generate
> a uapi header based on syscall.tbl file. The syscall.tbl file
> contains the number of system call information. So we have two
> option to update NR_syscalls value.
>
> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>    no.of system calls. No need to update NR_syscalls untill
>    we either add a new system call or delete an existing system
>    call.
>
> 2. We can keep this feature it above mentioned script, that'll
>    count the number of syscalls and keep it in a generated file.
>    In this case we don't need to explicitly update NR_syscalls
>    in asm/unistd.h file.
>
> The 2nd option will be the recommended one. For that, I come up
> with another macro - __NR_syscalls which will be updated by the
> script and it will be present in api/asm/unistd.h. While __NR_syscalls
> isn't strictly part of the uapi, having it as part of the generated
> header to simplifies the implementation. So we need to enclose this
> macro with #ifdef __KERNEL__ to avoid side effects.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
