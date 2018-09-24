Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44389 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeIXNBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 09:01:46 -0400
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Sep 2018 09:00:51 +0200
Message-ID: <CAMuHMdWLx6JcVTt0FsCD3rj_kgT8vRWapzApbZT=XGWios5R1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20180924070051.TjMTQBjbgs4GHUND8vSvWaYVhxCxDemovujJ2HzCtDI@z>

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The system call table entries are present in syscalltable.S. One of
> the patch in this patch series will auto-generate the system call
> table entries using the system call table generation script and
> which'll replace the existig table file.
>
> In order to come up with a common naming convention across all
> architecture, we need to change the file name to syscall_table.S.
> This change will unify the implementation across all architecture.
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
