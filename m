From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Mon, 27 Apr 2020 21:17:26 -0700
Message-ID: <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1ER3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 00:17:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E93C09B050
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:17:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a31so564301pje.1
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:17:29 -0700 (PDT)
In-Reply-To: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <christian.brauner@ubuntu.com>, Arnd Bergmann <arnd@arndb.de>, Hagen Paul Pfeifer <hagen@jauu.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun



> On Apr 27, 2020, at 6:36 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 27, 2020 at 5:46 PM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
>>=20
>> I agree. It would be a shame to add a new ptrace syscall and not take
>> the opportunity to fix the multitude of problems with the existing API.
>> But that's a Pandora's box which we shouldn't open unless we want to
>> wait a long time to get an API everyone is okay with -- a pretty high
>> price to just get pidfds support in ptrace.
>=20
> We should really be very very careful with some "smarter ptrace".
> We've had _so_ many security issues with ptrace that it's not even
> funny.
>=20
> And that's ignoring all the practical issues we've had.
>=20
> I would definitely not want to have anything that looks like ptrace AT
> ALL using pidfd. If we have a file descriptor to specify the target
> process, then we should probably take advantage of that file
> descriptor to actually make it more of a asynchronous interface that
> doesn't cause the kinds of deadlocks that we've had with ptrace.
>=20
> The synchronous nature of ptrace() means that not only do we have
> those nasty deadlocks, it's also very very expensive to use. It also
> has some other fundamental problems, like the whole "take over parent"
> and the SIGCHLD behavior.
>=20
> It also is hard to ptrace a ptracer. Which is annoying when you're
> debugging gdb or strace or whatever.
>=20
> So I think the thing to do is ask the gdb (and strace) people if they
> have any _very_ particular painpoints that we could perhaps help with.
>=20
> And then very carefully think things through and not repeat all the
> mistakes ptrace did.
>=20
> I'm not very optimistic.

I hate to say this, but I=E2=80=99m not convinced that asking the gdb folks i=
s the right approach. GDB has an ancient architecture and is *incredibly* bu=
ggy.  I=E2=80=99m sure ptrace is somewhere on the pain point list, but I sus=
pect it=E2=80=99s utterly dwarfed by everything else.

Maybe the LLDB people would have a better perspective?  The rr folks would b=
e a good bet, too. Or, and I know this is sacrilege, the VSCode people?


I think one requirement for a better ptrace is that it should work if you tr=
y to debug, simultaneously, a debugger and its debugee. Maybe not perfectly,=
 but it should work. And you should be able to debug init.

Another major pain point I=E2=80=99ve seen is compat. A 64-bit debugger shou=
ld be able to debug a program that switches back and forth between 32-bit an=
d 64-bit.  A debugger that is entirely unaware of a set of registers should b=
e able to debug a process using those registers.
