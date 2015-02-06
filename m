From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
Date: Fri, 6 Feb 2015 05:32:49 +0300
Message-ID: <20150206023249.GB31540@altlinux.org>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net> <20150205211916.GA31367@altlinux.org> <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com> <20150205214027.GB31367@altlinux.org> <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com> <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com> <20150205233945.GA31540@altlinux.org> <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com> <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegasus3.altlinux.org ([194.107.17.103]:34291 "EHLO
	pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbbBFCcw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Feb 2015 21:32:52 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Thu, Feb 05, 2015 at 04:09:06PM -0800, Andy Lutomirski wrote:
> On Thu, Feb 5, 2015 at 3:49 PM, Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Feb 5, 2015 at 3:39 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
[...]
> >> There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
> >> to keep the syscall number unchanged and suppress syscall-exit-stop event,
> >> which was awful because userspace cannot distinguish syscall-enter-stop
> >> from syscall-exit-stop and therefore relies on the kernel that
> >> syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).
> >>
> >> After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
> >> events to be suppressed, but now the syscall number is lost.
> >
> > Ah-ha! Okay, thanks, I understand now. I think this means seccomp
> > phase1 should not treat RET_ERRNO as a "skip" event. Andy, what do you
> > think here?
> 
> I still don't quite see how this change caused this.

I have a test for this at
http://sourceforge.net/p/strace/code/ci/HEAD/~/tree/test/seccomp.c

> I can play with
> it a bit more.  But RET_ERRNO *has* to be some kind of skip event,
> because it needs to skip the syscall.
> 
> We could change this by treating RET_ERRNO as an instruction to enter
> phase 2 and then asking for a skip in phase 2 without changing
> orig_ax, but IMO this is pretty ugly.
> 
> I think this all kind of sucks.  We're trying to run ptrace after
> seccomp, so ptrace is seeing the syscalls as transformed by seccomp.
> That means that if we use RET_TRAP, then ptrace will see the
> possibly-modified syscall, if we use RET_ERRNO, then ptrace is (IMO
> correctly given the current design) showing syscall -1, and if we use
> RET_KILL, then ptrace just sees the process mysteriously die.

Userspace is usually not prepared to see syscall -1.
For example, strace had to be patched, otherwise it just skipped such
syscalls as "not a syscall" events or did other improper things:
http://sourceforge.net/p/strace/code/ci/c3948327717c29b10b5e00a436dc138b4ab1a486
http://sourceforge.net/p/strace/code/ci/8e398b6c4020fb2d33a5b3e40271ebf63199b891

A slightly different but related story: userspace is also not prepared
to handle large errno values produced by seccomp filters like this:
BPF_STMT(BPF_RET, SECCOMP_RET_ERRNO | SECCOMP_RET_DATA)

For example, glibc assumes that syscalls do not return errno values greater than 0xfff:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/sysdep.h#l55
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/syscall.S#l20

If it isn't too late, I'd recommend changing SECCOMP_RET_DATA mask
applied in SECCOMP_RET_ERRNO case from current 0xffff to 0xfff.


-- 
ldv
