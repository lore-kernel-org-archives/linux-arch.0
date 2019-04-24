Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33003 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfDXEGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Apr 2019 00:06:53 -0400
Received: by mail-lj1-f182.google.com with SMTP id f23so15515210ljc.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 21:06:52 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 10sm409836ljc.48.2019.04.23.21.06.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 21:06:50 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t11so13436104lfl.12
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 21:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
 <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com> <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
In-Reply-To: <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Apr 2019 21:06:33 -0700
Message-ID: <CAHk-=whMd+O1Dqvp-=fHWW195AhWKPcvDm=Oe6PaHvg+orScgw@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190424040633.TvKImqfpTzp35bWUDKg2xS0lZtAXQ8hQMl4SlsIx378@z>

On Tue, Apr 23, 2019 at 4:57 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> To clarify, this is =E2=80=9Cfail if you can=E2=80=99t find the files to =
install, but don=E2=80=99t even try to check whether those files are up to =
date=E2=80=9D, right?

Ack. Exactly because the whole "check whether the files are
up-to-date" is generally part of the very complex dance of doing all
the version stuff etc.

               Linus
