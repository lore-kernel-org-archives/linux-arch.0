From: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Mon, 27 Apr 2020 19:52:45 +0200
Message-ID: <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200427170826.mdklazcrn4xaeafm@wittgenstein>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Brauner <christian.brauner-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Cc: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christian Brauner <christian-STijNZzMWpgWenYVfaLwtA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Gerst <brgerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sami Tolvanen <samitolvanen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aleksa Sarai <cyphar-gVpy/LI/lHzQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Eric W . Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sargun Dhillon <sargun-GaZTRHToo+CzQB+pC5nmwQ@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux-arch <l>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 27, 2020 at 7:08 PM Christian Brauner
<christian.brauner-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org> wrote:
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
