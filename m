Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:45823 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeHHCFV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Aug 2018 22:05:21 -0400
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
 <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com> <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
In-Reply-To: <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 7 Aug 2018 16:48:17 -0700
Message-ID: <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, "Daniel J . Bernstein" <djb@cr.yp.to>, Tanja Lange <tanja@hyperelliptic.org>, Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>, Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Message-ID: <20180807234817.UlAMpBOKvnvJElMpkG4RcxpWzpFvMxbAxgdMhuliiu4@z>

Hey Andy,

On Tue, Aug 7, 2018 at 12:43 PM Andy Lutomirski <luto@amacapital.net> wrote:
> For "zinc: add simd helper", I think it should be in include/linux,
> and include/linux/simd.h should (immediately or maybe in the future)
> include <asm/simd.h> to pick up arch-specific stuff.  And the patch
> should get sent to linux-arch@vger.kernel.org.

I guess you saw my prompt about that in the previous commit message?
Based on your encouragement, I implemented it:
https://git.zx2c4.com/linux-dev/commit/?h=simd This is _far_ more
invasive than I wanted to be, as I don't want this patch submission to
grow unwieldy and never be merged, but I guess we can roll with this
for now...

> In your blake2s_arch() implementation, you're not passing in a
> simd_context_t.  Is that still a work in progress?  I thought the plan
> was to pass it in rather than doing the check in the _arch()
> functions.

I'm inclined to do the explicit context passing only when a function
is likely to be used in that kind of environment, and adjust as
needed. Long term, anyway, that API will be removed once the x86 guys
figure out lazy FPU restoration and the amortization doesn't add
anything.

Jason
