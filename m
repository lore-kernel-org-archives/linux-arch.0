Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44815 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfJHG2g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Oct 2019 02:28:36 -0400
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
 <fa7c91aa-ed82-acd4-8835-d2580ee8232c@roeck-us.net>
In-Reply-To: <fa7c91aa-ed82-acd4-8835-d2580ee8232c@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2019 08:28:23 +0200
Message-ID: <CAMuHMdXN5hL+BvnJDG86RnH4nv0yz+nxJ+Uc7-2V8jQ+dJ5tkA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Cree <mcree@orcon.net.nz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <20191008062823.FXX3kEMlU_36ytZM44T6yeXJFdJXXIw1aVk13Linec0@z>

On Tue, Oct 8, 2019 at 1:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
> m68k:
>
> c2p_iplan2.c:(.text+0x98): undefined reference to `c2p_unsupported'
>
> I don't know the status.

Fall-out from the (non)inline optimization.  Patch available:
https://lore.kernel.org/lkml/20190927094708.11563-1-geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
