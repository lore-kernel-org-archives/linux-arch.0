From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Tue, 13 May 2014 11:10:53 +0200
Message-ID: <CAMuHMdVyCXXZgmEVkbo+cZfQfYspZO4SH+iV-zCLq-6G4m47QQ@mail.gmail.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65441 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759765AbaEMJKx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 May 2014 05:10:53 -0400
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>

Hi,

On Tue, May 13, 2014 at 10:57 AM, Ley Foon Tan <lftan@altera.com> wrote:
> This patchset change default time_t and clock_t to 64 bit in
> include/uapi/asm-generic/posix_types.h. The existing 32 bit architectures override
> these define to 32 bit in arch posix_types.h.

Thanks for your series!

> Ley Foon Tan (25):
>   asm-generic: Change time_t and clock_t to 64 bit

For bisectability, this should be the last change, not the first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
