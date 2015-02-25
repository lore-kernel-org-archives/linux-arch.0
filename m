From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: How best to write a series of related test_bit() calls?
Date: Wed, 25 Feb 2015 09:32:40 +0100
Message-ID: <CAMuHMdUEfBMoKoSuOucP6A5wXkF8d-_tULw9909FBCS_Cxmwsw@mail.gmail.com>
References: <22657.1424789917@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:44143 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbBYIcl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 03:32:41 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so2368179obc.6
        for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2015 00:32:40 -0800 (PST)
In-Reply-To: <22657.1424789917@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Feb 24, 2015 at 3:58 PM, David Howells <dhowells@redhat.com> wrote:
> I have a situation where I want to do something that boils down to:
>
>         if (test_bit(BIT_A, &p->flags) {
>                 ...
>         } else if (test_bit(BIT_B, &p->flags) {
>                 ...
>         } else if (test_bit(BIT_C, &p->flags) {
>                 ...
>         } else if (test_bit(BIT_D, &p->flags) {
>                 ...
>         } else if (test_bit(BIT_E, &p->flags) {
>         }
>
> Note that all bits are in the same unsigned long and I don't necessarily
> expect the contents of p->flags to change whilst I'm looking at it.
>
> Since the address parameter for test_bit() contains a 'volatile' keyword, the
> compiler will emit a separate load (or bit test) for each condition when in
> fact the most efficient way is almost certainly one load and a bunch of
> bitwise-and or bit-test-in-register instructions.
>
> Is it worth adding a __test_bit() that doesn't have the volatile?  Or should I
> just rewrite it manually as?
>
>         unsigned long flags = p->flags;
>         if (test_bit(BIT_A, &flags) {
>                 ...
>         } else if (test_bit(BIT_B, &flags) {
>         ...
>
> Or even:
>
>         unsigned long flags = p->flags;
>         if ((1 << BIT_A) & flags) {
>                 ...
>         } else if ((1 << BIT_B) & flags) {
>         ...

How about using READ_ONCE() and BIT()?

        unsigned long flags = READ_ONCE(p->flags_;
        if (BIT(BIT_A) & flags) {
                ...
        } else ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
