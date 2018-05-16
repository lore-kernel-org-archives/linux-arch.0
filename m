Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:55742 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeEPODw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 May 2018 10:03:52 -0400
Received: by mail-it0-f67.google.com with SMTP id 144-v6so2079643iti.5
        for <linux-arch@vger.kernel.org>; Wed, 16 May 2018 07:03:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1526400945.git.vilhelm.gray@gmail.com>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 16:03:51 +0200
Message-ID: <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20180516140351.UDZaR8b2wyEvCRTbTf10Y_Vs-6VEEtRM34JgZMUjiS0@z>

On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> For example, suppose you would like to iterate over a 16-bit integer 4
> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
> represents the current 4-bit group:
>
>     Example:        1011 1110 0000 1111
>     First loop:     1011 1110 0000 XXXX
>     Second loop:    1011 XXXX 0000 1111
>     Third loop:     XXXX 1110 0000 1111
>
> Each iteration of the loop returns the next 4-bit group that has at
> least one set bit.
>
> The for_each_set_clump macro has six parameters:
>
>     * clump: set to current clump index for the iteration
>     * index: set to current bitmap word index for the iteration
>     * offset: bits offset of the found clump in the bitmap word
>     * bits: bitmap to search within
>     * size: bitmap size in number of clumps
>     * clump_size: clump size in number of bits
>
> The clump_size argument can be an arbitrary number of bits and is not
> required to be a multiple of 2.

I must say I'm impressed. Very nice arithmetics going on there.

If I can get some ACK for the bitops patch I'd be happy to merge
it all through the GPIO tree. The users are pretty clear cut.

BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
to see what he has to say about the subject, but I don't have
that book as it turns out.

Yours,
Linus Walleij
