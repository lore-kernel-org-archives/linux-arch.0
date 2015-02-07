Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:60816 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbBGBHm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Feb 2015 20:07:42 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so16666470obc.0
        for <linux-arch@vger.kernel.org>; Fri, 06 Feb 2015 17:07:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150206231720.GB3829@altlinux.org>
References: <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
	<CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
	<20150205233945.GA31540@altlinux.org>
	<CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
	<CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
	<20150206023249.GB31540@altlinux.org>
	<CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com>
	<CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
	<CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com>
	<CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
	<20150206231720.GB3829@altlinux.org>
Date: Fri, 6 Feb 2015 17:07:41 -0800
Message-ID: <CAGXu5jKHkJcnpbiuYY8BVX0-wOEUDFMx7r8_HJJe2ZDT8p3uvQ@mail.gmail.com>
Subject: Re: a method to distinguish between syscall-enter/exit-stop
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker <fweisbec@gmail.com>, Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Message-ID: <20150207010741.nS3zDsysEjHnhbCP1f0qQYMMH898VtHDXAFylPvPCI8@z>

On Fri, Feb 6, 2015 at 3:17 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Fri, Feb 06, 2015 at 12:07:03PM -0800, Kees Cook wrote:
>> On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> [...]
>> >> And an unrelated thought:
>> >>
>> >> 3) Can't we find some way to fix the inability of a ptracer to
>> >> distinguish between syscall-enter-stop and syscall-exit-stop?
>> >
>> > Couldn't we add PTRACE_O_TRACESYSENTRY and PTRACE_O_TRACESYSEXIT along
>> > the lines of PTRACE_O_TRACESYSGOOD?
>>
>> That might be a nice idea. I haven't written a test to see, but what
>> does PTRACE_GETEVENTMSG return on syscall-enter/exit-stop?
>
> The value returned by PTRACE_GETEVENTMSG is the value set along with the
> latest PTRACE_EVENT_*.
> In case of syscall-enter/exit-stop (which is not a PTRACE_EVENT_*),
> there is no particular value set for PTRACE_GETEVENTMSG.

Could we define one to help distinguish?

-Kees

-- 
Kees Cook
Chrome OS Security
