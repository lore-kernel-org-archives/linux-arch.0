Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44984 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBYPTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2019 10:19:15 -0500
MIME-Version: 1.0
References: <20190225140355.4335-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190225140355.4335-1-j.neuschaefer@gmx.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Feb 2019 16:19:02 +0100
Message-ID: <CAMuHMdXEY+ri8QO2AVGzD5vNuYujDNK-k62zz2Qd-ceMgT59tw@mail.gmail.com>
Subject: Re: [PATCH] div64.h: Fix description of do_div parameter
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20190225151902.iMh9Mve56kQYsjof0c_clmY-mn0qdbleZ6hPkiI-je0@z>

Hi Jonathan,

On Mon, Feb 25, 2019 at 3:05 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Contrary to the description, the first parameter (n) should not be
> passed as a pointer, but directly as an lvalue. This is possible because
> do_div is a macro.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Shouldn't the "semantics" at the top of include/asm-generic/div64.h be
updated, too?

As this can't be expressed in a C function, perhaps that should be done
using C++ syntax, like

    uint32_t do_div(uint64_t &n, uint32_t base)
    {
        ...
    }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
