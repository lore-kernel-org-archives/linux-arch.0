From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: possible problem with generic asm/types.h
Date: Sun, 26 May 2013 09:40:09 +0200
Message-ID: <CAMuHMdWw6D60sAy8X0TMTU8P85JRrH=aLva+-fk-AEF7f30GjA@mail.gmail.com>
References: <1369494858.25297.58.camel@t520.redhat.com>
	<CAMuHMdVqFdbv88qDgHAGB7kmBFEwPZWVhr27KqUgiqhrUrga+A@mail.gmail.com>
	<1369499831.25297.67.camel@t520.redhat.com>
	<CAMuHMdVkz7ToYU39s4daT6fh0ztetZdgaKZqNJDxMcoO==6e4w@mail.gmail.com>
	<1369500237.25297.68.camel@t520.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:45375 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758863Ab3EZHkK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 03:40:10 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so5690218pbc.21
        for <linux-arch@vger.kernel.org>; Sun, 26 May 2013 00:40:09 -0700 (PDT)
In-Reply-To: <1369500237.25297.68.camel@t520.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>

On Sat, May 25, 2013 at 6:43 PM, Mark Salter <msalter@redhat.com> wrote:
> On Sat, 2013-05-25 at 18:39 +0200, Geert Uytterhoeven wrote:
>> On Sat, May 25, 2013 at 6:37 PM, Mark Salter <msalter@redhat.com> wrote:
>> >> No. Inside the kernel, all 64-bit platforms use int-ll64.h.
          ^^^^^^^^^^^^^^^^
>> >
>> > Except for alpha and ia64...
>>
>> Nope:
>>
>> $ git grep int-l arch/{alpha,ia64}/include/asm/types.h
>> arch/alpha/include/asm/types.h:#include <asm-generic/int-ll64.h>
>> arch/ia64/include/asm/types.h:#include <asm-generic/int-ll64.h>
>> $
>
> Hmm.
>
> $ git grep int-l arch/{alpha,ia64}/include/uapi/asm/types.h
> arch/alpha/include/uapi/asm/types.h:#include <asm-generic/int-l64.h>
> arch/ia64/include/uapi/asm/types.h:#include <asm-generic/int-l64.h>

As I wrote before:
> For backwards compatibility, alpha, ia64, mips, and powerpc (unless
> __SANE_USERSPACE_TYPES__ is defined) still use int-l64.h in userspace.
                                                           ^^^^^^^^^^^^

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
