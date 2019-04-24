From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
Date: Tue, 23 Apr 2019 21:06:33 -0700
Message-ID: <CAHk-=whMd+O1Dqvp-=fHWW195AhWKPcvDm=Oe6PaHvg+orScgw@mail.gmail.com>
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
 <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com> <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

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
