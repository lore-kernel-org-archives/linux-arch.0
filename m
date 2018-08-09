Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbeHIUes (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Aug 2018 16:34:48 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C71322398
        for <linux-arch@vger.kernel.org>; Thu,  9 Aug 2018 18:08:48 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id c13-v6so5950802wrt.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Aug 2018 11:08:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
 <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
 <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
 <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
 <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net> <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 9 Aug 2018 11:08:25 -0700
Message-ID: <CALCETrUgOk7veQavAWayY7vQUY0fJkwGsYxNhLxK-v3F-BEmsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Eric Biggers <ebiggers3@gmail.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, "Daniel J . Bernstein" <djb@cr.yp.to>, Tanja Lange <tanja@hyperelliptic.org>, Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>, Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Message-ID: <20180809180825.H_f9CDbp8q0Akqk_tWewQ1GSgHElq4GTzOXw7pxSBZA@z>

On Tue, Aug 7, 2018 at 6:51 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Aug 7, 2018 at 6:49 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> I really wish we had a way to see that we use asm-generic=E2=80=99s copy=
 of a header in all cases except where an arch opts out.
>
> It's really not that hard to do -- symlink asm-generic to a target
> called "asm" inside an otherwise empty directory, and add that
> otherwise empty directory to the -I paths just after arch/include.
> Since it's searched second, it's only used if the first fails. Maybe
> I'm missing something though, as this seems a bit too obvious. Perhaps
> a project for another day.

The problem here (I think) is that it's preferable for stray files in
the kernel tree to have no effect and, with this scheme, stray files
in arch/*/include/asm could affect the build.  So something explicit
has an advantage.  I just think there should be way to say "this
asm-generic file should affect all arches unless they generic-n or
override-generic-y it or whatever".
