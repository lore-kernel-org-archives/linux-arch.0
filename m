From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
Date: Fri, 6 Feb 2015 02:39:45 +0300
Message-ID: <20150205233945.GA31540@altlinux.org>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net> <20150205211916.GA31367@altlinux.org> <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com> <20150205214027.GB31367@altlinux.org> <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com> <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegasus3.altlinux.org ([194.107.17.103]:44757 "EHLO
	pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbbBEXjs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Feb 2015 18:39:48 -0500
Content-Disposition: inline
In-Reply-To: <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Thu, Feb 05, 2015 at 03:12:39PM -0800, Kees Cook wrote:
> On Thu, Feb 5, 2015 at 1:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Thu, Feb 5, 2015 at 1:40 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> >> On Thu, Feb 05, 2015 at 01:27:16PM -0800, Kees Cook wrote:
> >>> On Thu, Feb 5, 2015 at 1:19 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> >>> > Hi,
> >>> >
> >>> > On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
> >>> >> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
> >>> >> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
> >>> >> phase 2 is permitted to modify any of pt_regs except for orig_ax.
> >>> >
> >>> > This breaks ptrace, see below.
> >>> >
[...]
> >>> >> +             ret = seccomp_phase1(&sd);
> >>> >> +             if (ret == SECCOMP_PHASE1_SKIP) {
> >>> >> +                     regs->orig_ax = -1;
> >>> >
> >>> > How the tracer is expected to get the correct syscall number after that?
> >>>
> >>> There shouldn't be a tracer if a skip is encountered. (A seccomp skip
> >>> would skip ptrace.) This behavior hasn't changed, but maybe I don't
> >>> see what you mean? (I haven't encountered any problems with syscall
> >>> tracing as a result of these changes.)
> >>
> >> SECCOMP_RET_ERRNO leads to SECCOMP_PHASE1_SKIP, and if there is a tracer,
> >> it will get -1 as a syscall number.
> >>
> >> I've found this while testing a strace parser for
> >> SECCOMP_MODE_FILTER/SECCOMP_SET_MODE_FILTER, so the problem is quite real.
> >
> > Hasn't it always been this way?
> 
> As far as I know, yes, it's always been this way. The point is to the
> skip the syscall, which is what the -1 signals. Userspace then reads
> back the errno.

There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
to keep the syscall number unchanged and suppress syscall-exit-stop event,
which was awful because userspace cannot distinguish syscall-enter-stop
from syscall-exit-stop and therefore relies on the kernel that
syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).

After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
events to be suppressed, but now the syscall number is lost.


-- 
ldv
