Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34259 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLVMaw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Dec 2017 07:30:52 -0500
Received: by mail-qk0-f176.google.com with SMTP id g81so4793277qke.1
        for <linux-arch@vger.kernel.org>; Fri, 22 Dec 2017 04:30:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVNF66QSnRvJxkNowMuVKeSoc7PHa+Ep-ojYmA2ywPRxQ@mail.gmail.com>
References: <20171222035518.GC23624@bombadil.infradead.org> <CAMuHMdVNF66QSnRvJxkNowMuVKeSoc7PHa+Ep-ojYmA2ywPRxQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Dec 2017 13:30:51 +0100
Message-ID: <CAMuHMdWM-1VepP2fDxAwG6m+WC33UqPWN=DL7JEYVwSbtU8Xkg@mail.gmail.com>
Subject: Re: Function pointer alignment
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20171222123051.ia6U3UiHg6_ybU91xS1qgnV1AmYNpx4ZdLhephrSRPI@z>

On Fri, Dec 22, 2017 at 1:28 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Dec 22, 2017 at 4:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> What alignment can we rely on for function pointers?
>>
>> Most architectures seem to have settled on 4-byte aligned instructions.
>>
>> While x86 is only byte-aligned, at least x86-64 aligns functions on a
>> 16-byte boundary.  I know s390 has 2-byte alignment on instructions,
>> but does it have greater alignment on functions?
>>
>> The three architectures with function descriptors (parisc, ia64, ppc64)
>> all seem like they'll be 8-byte aligned.
>>
>> (I'm looking to steal the bottom two bits of a function pointer, so
>> that's where my interest comes from).
>
> Only one bit to steal on m68k...

Same on SH.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
