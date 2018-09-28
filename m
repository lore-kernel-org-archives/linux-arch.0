Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:53461 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeI1ULT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Sep 2018 16:11:19 -0400
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com> <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 28 Sep 2018 15:47:14 +0200
Message-ID: <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, Andrew Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
Message-ID: <20180928134714.JEufg_PjFkPWyjm2pDH0YAoX6-EpMOu4VOEsO3PxqaE@z>

On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> >> +typedef enum {
> >> +       HAVE_NO_SIMD = 1 << 0,
> >> +       HAVE_FULL_SIMD = 1 << 1,
> >> +       HAVE_SIMD_IN_USE = 1 << 31
> >> +} simd_context_t;
> >> +
>
> Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
> about it): the use of typedef in new code is strongly discouraged.
> This policy predates my involvement, so perhaps Joe can elaborate on
> the rationale?

In case it matters, the motivation for making this a typedef is I
could imagine this at some point turning into a more complicated
struct on certain platforms and that would make refactoring easier. I
could just make it `struct simd_context` now with 1 member though...
