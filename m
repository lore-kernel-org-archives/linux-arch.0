From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: possible problem with generic asm/types.h
Date: Sat, 25 May 2013 18:39:11 +0200
Message-ID: <CAMuHMdVkz7ToYU39s4daT6fh0ztetZdgaKZqNJDxMcoO==6e4w@mail.gmail.com>
References: <1369494858.25297.58.camel@t520.redhat.com>
	<CAMuHMdVqFdbv88qDgHAGB7kmBFEwPZWVhr27KqUgiqhrUrga+A@mail.gmail.com>
	<1369499831.25297.67.camel@t520.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37438 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab3EYQjM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 May 2013 12:39:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so15194046iea.18
        for <linux-arch@vger.kernel.org>; Sat, 25 May 2013 09:39:11 -0700 (PDT)
In-Reply-To: <1369499831.25297.67.camel@t520.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>

On Sat, May 25, 2013 at 6:37 PM, Mark Salter <msalter@redhat.com> wrote:
>> No. Inside the kernel, all 64-bit platforms use int-ll64.h.
>
> Except for alpha and ia64...

Nope:

$ git grep int-l arch/{alpha,ia64}/include/asm/types.h
arch/alpha/include/asm/types.h:#include <asm-generic/int-ll64.h>
arch/ia64/include/asm/types.h:#include <asm-generic/int-ll64.h>
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
