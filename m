Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:53307 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbbBEXtJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Feb 2015 18:49:09 -0500
Received: by mail-oi0-f51.google.com with SMTP id x69so9219682oia.10
        for <linux-arch@vger.kernel.org>; Thu, 05 Feb 2015 15:49:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150205233945.GA31540@altlinux.org>
References: <cover.1409954077.git.luto@amacapital.net>
	<2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
	<20150205211916.GA31367@altlinux.org>
	<CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
	<20150205214027.GB31367@altlinux.org>
	<CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
	<CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
	<20150205233945.GA31540@altlinux.org>
Date: Thu, 5 Feb 2015 15:49:08 -0800
Message-ID: <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker <fweisbec@gmail.com>
Message-ID: <20150205234908.gyH669ANWCsIzQ9uAdF1rDPuXkDkt_zLYCI1qK7B7pg@z>

On Thu, Feb 5, 2015 at 3:39 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Thu, Feb 05, 2015 at 03:12:39PM -0800, Kees Cook wrote:
>> On Thu, Feb 5, 2015 at 1:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Thu, Feb 5, 2015 at 1:40 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> >> On Thu, Feb 05, 2015 at 01:27:16PM -0800, Kees Cook wrote:
>> >>> On Thu, Feb 5, 2015 at 1:19 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> >>> > Hi,
>> >>> >
>> >>> > On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
>> >>> >> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
>> >>> >> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
>> >>> >> phase 2 is permitted to modify any of pt_regs except for orig_ax.
>> >>> >
>> >>> > This breaks ptrace, see below.
>> >>> >
> [...]
>> >>> >> +             ret = seccomp_phase1(&sd);
>> >>> >> +             if (ret == SECCOMP_PHASE1_SKIP) {
>> >>> >> +                     regs->orig_ax = -1;
>> >>> >
>> >>> > How the tracer is expected to get the correct syscall number after that?
>> >>>
>> >>> There shouldn't be a tracer if a skip is encountered. (A seccomp skip
>> >>> would skip ptrace.) This behavior hasn't changed, but maybe I don't
>> >>> see what you mean? (I haven't encountered any problems with syscall
>> >>> tracing as a result of these changes.)
>> >>
>> >> SECCOMP_RET_ERRNO leads to SECCOMP_PHASE1_SKIP, and if there is a tracer,
>> >> it will get -1 as a syscall number.
>> >>
>> >> I've found this while testing a strace parser for
>> >> SECCOMP_MODE_FILTER/SECCOMP_SET_MODE_FILTER, so the problem is quite real.
>> >
>> > Hasn't it always been this way?
>>
>> As far as I know, yes, it's always been this way. The point is to the
>> skip the syscall, which is what the -1 signals. Userspace then reads
>> back the errno.
>
> There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
> to keep the syscall number unchanged and suppress syscall-exit-stop event,
> which was awful because userspace cannot distinguish syscall-enter-stop
> from syscall-exit-stop and therefore relies on the kernel that
> syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).
>
> After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
> events to be suppressed, but now the syscall number is lost.

Ah-ha! Okay, thanks, I understand now. I think this means seccomp
phase1 should not treat RET_ERRNO as a "skip" event. Andy, what do you
think here?

-Kees

-- 
Kees Cook
Chrome OS Security
