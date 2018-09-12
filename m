Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:59191 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeILXQh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Sep 2018 19:16:37 -0400
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78>
In-Reply-To: <20180912061433.GA8484@ip-172-31-15-78>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 12 Sep 2018 20:10:41 +0200
Message-ID: <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kevin@guarana.org
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Message-ID: <20180912181041.f5xdFpRnxWD-TNRVLtociS50fL5kS3y1OTD8vpDYhFg@z>

On Wed, Sep 12, 2018 at 8:14 AM Kevin Easton <kevin@guarana.org> wrote:
> Given that it's always supposed to be used like that, mightn't it be
> better if simd_relax() took a pointer to the context, so the call is
> just
>
>     simd_relax(&simd_context);
>
> ?
>
> The inlining means that there won't actually be a pointer dereference in
> the emitted code.
>
> If simd_put() also took a pointer then it could set the context back to
> HAVE_NO_SIMD as well?

That's sort of a neat idea. I guess in this scheme, you'd envision:

   simd_context_t simd_context;

   simd_get(&simd_context);
   simd_relax(&simd_context);
   simd_put(&simd_context);

And this way, if simd_context ever becomes a heavier struct, it can be
modified in place rather than returned by value from the function. On
the other hand, it's a little bit more annoying to type and makes it
harder to do declaration and initialization on the same line.
