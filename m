Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44641 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHEGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Aug 2018 00:06:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so279048pgp.11
        for <linux-arch@vger.kernel.org>; Tue, 07 Aug 2018 18:49:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
Date: Tue, 7 Aug 2018 18:48:59 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net>
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com> <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com> <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com> <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com> <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com> <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com> <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, "Daniel J . Bernstein" <djb@cr.yp.to>, Tanja Lange <tanja@hyperelliptic.org>, Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>, Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Message-ID: <20180808014859.vgyYWlsDHKgrtlIjRthgwSEuoAHYrQjrNXHKXn9QhfY@z>



> On Aug 7, 2018, at 4:48 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> Hey Andy,
>=20
>> On Tue, Aug 7, 2018 at 12:43 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> For "zinc: add simd helper", I think it should be in include/linux,
>> and include/linux/simd.h should (immediately or maybe in the future)
>> include <asm/simd.h> to pick up arch-specific stuff.  And the patch
>> should get sent to linux-arch@vger.kernel.org.
>=20
> I guess you saw my prompt about that in the previous commit message?
> Based on your encouragement, I implemented it:
> https://git.zx2c4.com/linux-dev/commit/?h=3Dsimd This is _far_ more
> invasive than I wanted to be, as I don't want this patch submission to
> grow unwieldy and never be merged, but I guess we can roll with this
> for now...
>=20

I really wish we had a way to see that we use asm-generic=E2=80=99s copy of a=
 header in all cases except where an arch opts out.

>> In your blake2s_arch() implementation, you're not passing in a
>> simd_context_t.  Is that still a work in progress?  I thought the plan
>> was to pass it in rather than doing the check in the _arch()
>> functions.
>=20
> I'm inclined to do the explicit context passing only when a function
> is likely to be used in that kind of environment, and adjust as
> needed. Long term, anyway, that API will be removed once the x86 guys
> figure out lazy FPU restoration and the amortization doesn't add
> anything.

Fair enough.

>=20
> Jason
