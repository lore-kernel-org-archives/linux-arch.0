Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:58105 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbeHHEJG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Aug 2018 00:09:06 -0400
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
 <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
 <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
 <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com> <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net>
In-Reply-To: <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 7 Aug 2018 18:51:39 -0700
Message-ID: <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, "Daniel J . Bernstein" <djb@cr.yp.to>, Tanja Lange <tanja@hyperelliptic.org>, Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>, Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Message-ID: <20180808015139.4iJ6tMUqopW4kZAy2ZiX2eOPM4pDoNHq8cdb0wQkkdY@z>

On Tue, Aug 7, 2018 at 6:49 PM Andy Lutomirski <luto@amacapital.net> wrote:
> I really wish we had a way to see that we use asm-generic=E2=80=99s copy =
of a header in all cases except where an arch opts out.

It's really not that hard to do -- symlink asm-generic to a target
called "asm" inside an otherwise empty directory, and add that
otherwise empty directory to the -I paths just after arch/include.
Since it's searched second, it's only used if the first fails. Maybe
I'm missing something though, as this seems a bit too obvious. Perhaps
a project for another day.
