From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Function pointer alignment
Date: Fri, 22 Dec 2017 13:28:23 +0100
Message-ID: <CAMuHMdVNF66QSnRvJxkNowMuVKeSoc7PHa+Ep-ojYmA2ywPRxQ@mail.gmail.com>
References: <20171222035518.GC23624@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:40522 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbdLVM2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Dec 2017 07:28:25 -0500
Received: by mail-qk0-f170.google.com with SMTP id q14so21805025qke.7
        for <linux-arch@vger.kernel.org>; Fri, 22 Dec 2017 04:28:24 -0800 (PST)
In-Reply-To: <20171222035518.GC23624@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>

Hi Willy,

On Fri, Dec 22, 2017 at 4:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
> What alignment can we rely on for function pointers?
>
> Most architectures seem to have settled on 4-byte aligned instructions.
>
> While x86 is only byte-aligned, at least x86-64 aligns functions on a
> 16-byte boundary.  I know s390 has 2-byte alignment on instructions,
> but does it have greater alignment on functions?
>
> The three architectures with function descriptors (parisc, ia64, ppc64)
> all seem like they'll be 8-byte aligned.
>
> (I'm looking to steal the bottom two bits of a function pointer, so
> that's where my interest comes from).

Only one bit to steal on m68k...

Gr{oetje,eeting}s,

                        Geert
