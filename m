Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44694 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIXNGt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 09:06:49 -0400
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Sep 2018 09:05:57 +0200
Message-ID: <CAMuHMdVbxvQMT9qAaPx8GPjzdM5T52KQ2jTGB6bmA61q9BAXyg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] m68k: added __IGNORE* entries in asm/unistd.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20180924070557.htBAYoYzHYgTX_fp46MfNQi9Yil3Usl38GC7_s3AQRQ@z>

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> Added few __IGNORE* entries for seccomp, pkey_mprotect,
> pkey_alloc, pkey_free, io_pgetevents and rseq in the file
> asm/unistd.h as it is correct to keep __IGNORE* entry in
> non uapi header asm/unistd.h while uapi/asm/unistd.h must
> hold information only useful for user space applications.
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
