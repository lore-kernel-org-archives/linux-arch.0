Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37297 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfDWX5j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 19:57:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so8302590pfr.4
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 16:57:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Date: Tue, 23 Apr 2019 16:57:36 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <A160B301-5F50-4E0C-B995-A626886A91E7@amacapital.net>
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com> <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com> <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190423235736.A2AQLggMx55MG3gbbDxiB4D3dyboTVu84vyteOGzwyM@z>



> On Apr 23, 2019, at 4:38 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Tue, Apr 23, 2019 at 11:47 AM Andy Lutomirski <luto@kernel.org> wrote:=

>>=20
>> Hmm.  I suppose an alternative would be for vdso_install to fail if
>> the vdso isn't built?
>=20
> I absolutely abhor even the concept of building the kernel as root,
> and I think it should be actively disallowed. Our build system is
> good, but it's good as in "clever and complex" rather than necessarily
> good as in "very secure".
>=20
> So anybody who builds the kernel as root is doing something seriously
> wrong, in my opinion.
>=20
> That's partly exactly _because_ we have a lot of magical and very
> powerful build rules, and complicated implicit things going on.
>=20
> For example, our dependencies aren't even about just the files in the
> kernel repository itself, we have clever things like "if the compiler
> has been updated and features or version changes, we'll automatically
> rebuild, because it's part of our clever build system checks".
>=20
> But that is also part of the reason why I absolutely do *not* want any
> root-building to happen, because our build setup is simply way too
> clever.
>=20
> If root builds stuff, you'll end up with root-owned generated
> subdirectories or various config files etc, and even if you don't have
> security issues, it can complicate the build later as a regular user.
>=20
> I've had the build occasionally fail in odd ways, because some
> root-owned file was now no longer removable (usually it's the
> auto-generated header files in the directory, and the root-generated
> and owned directory is now not writable by the developer any more).
> And every time it happens, I shudder.
>=20
> So all of that simply boils down to "root should not be running those
> complex rules for our config and dependency magic".
>=20
> At the same time, "make install" obviously needs to be done as root.
>=20
> All of which is why I opine that "make install" should never build
> anything at all, it should purely be used as a "install previously
> built files".
>=20
> So yes, I'd much prefer just failing over trying to build as root (or
> even trying to figure out dependencies as root).
>=20
>> What's the ideal outcome here?
>=20
> I'd basically like the rule for "make install" to be that it never
> ever generates a single file in the build tree, so that there are
> never any root-owned (or root-overwritten) files there.
>=20
> So "make install" should even avoid all dependency checking, for the
> simple reason that if you happen to do a system update between "make"
> and "make install", our smart dependencies should never say "oh, the
> compiler version has changed, so now I'll rebuild everything as root
> just because 'make install'".
>=20
> So I think the ideal outcome is just "fail if you can't find the files
> to install".
>=20
>=20

To clarify, this is =E2=80=9Cfail if you can=E2=80=99t find the files to ins=
tall, but don=E2=80=99t even try to check whether those files are up to date=
=E2=80=9D, right?=
