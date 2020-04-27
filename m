Return-Path: <SRS0=jgxL=6L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbgD0RxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 13:53:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D94C03C1A8
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 10:53:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t11so14578893lfe.4
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 10:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein>
In-Reply-To: <20200427170826.mdklazcrn4xaeafm@wittgenstein>
From: Jann Horn <jannh@google.com>
Date: Mon, 27 Apr 2020 19:52:45 +0200
Message-ID: <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun Dhillon <sargun@sargun.me>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200427175245.DAjrQwr6wVNvOMToazD85Nmnxp-JaoEFK1Baktz0TpI@z>

On Mon, Apr 27, 2020 at 7:08 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Sun, Apr 26, 2020 at 06:34:30PM +0200, Hagen Paul Pfeifer wrote:
> > Working on a safety-critical stress testing tool, using ptrace in an
> > rather uncommon way (stop, peeking memory, ...) for a bunch of
> > applications in an automated way I realized that once opened processes
> > where restarted and PIDs recycled.  Resulting in monitoring and
> > manipulating the wrong processes.
> >
> > With the advent of pidfd we are now able to stick with one stable handle
> > to identifying processes exactly. We now have the ability to get this
> > race free. Sending signals now works like a charm, next step is to
> > extend the functionality also for ptrace.
> >
> > API:
> >          long pidfd_ptrace(int pidfd, enum __ptrace_request request,
> >                            void *addr, void *data, unsigned flags);
>
> I'm in general not opposed to this if there's a clear need for this and
> users that are interested. But I think if people really prefer having
> this a new syscall then we should probably try to improve on the old
> one. Things that come to mind right away without doing a deep review are
> replacing the void *addr pointer with a dedicated struct ptract_args or
> union ptrace_args and a size argument. If we're not doing something
> like this or something more fundamental we can equally well either just
> duplicate all enums in the old ptrace syscall and append a _PIDFD to it
> where it makes sense.

Yeah, it seems like just adding pidfd flavors of PTRACE_ATTACH and
PTRACE_SEIZE should do the job.


And if we do make a new syscall, there is a bunch of de-crufting that
can be done... for example, just as some low-hanging fruit, a new
ptrace API probably shouldn't have
PTRACE_PEEKTEXT/PTRACE_PEEKDATA/PTRACE_POKETEXT/PTRACE_POKEDATA (we
have /proc/$pid/mem for that, which is much saner than doing peek/poke
in word-size units), and probably also shouldn't support all the weird
arch-specific register-accessing requests (e.g.
PTRACE_PEEKUSR/PTRACE_POKEUSR/PTRACE_GETREGS/PTRACE_SETREGS/PTRACE_GETFPREGS/...)
that are nowadays accessible via PTRACE_GETREGSET/PTRACE_SETREGSET.

(And there are also some more major changes that I think would be
sensible; for example, it'd be neat if you could have notifications
about the tracee delivered through a pollable file descriptor, and if
you could get the kernel to tell you in each notification which type
of ptrace stop you're dealing with (e.g. distinguishing
syscall-entry-stop vs syscall-exit-stop), and it would be great to be
able to directly inject syscalls into the child instead of having to
figure out where a syscall instruction you can abuse is and then
setting the instruction pointer to that, and it'd be helpful to be
able to have multiple tracers attached to a single process so that you
can e.g. have strace and gdb active on the same process
concurrently...)
