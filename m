From: Christian Brauner <christian.brauner-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Tue, 28 Apr 2020 10:21:33 +0200
Message-ID: <20200428082133.kusyjofgg7w2lchg@wittgenstein>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
 <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Aleksa Sarai <cyphar-gVpy/LI/lHzQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christian Brauner <christian-STijNZzMWpgWenYVfaLwtA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Brian Gerst <brgerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sami Tolvanen <samitolvanen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sargun Dhillon <sar>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 27, 2020 at 09:28:14PM -0700, Linus Torvalds wrote:
> On Mon, Apr 27, 2020 at 9:17 PM Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org> wrote:
> >
> > I hate to say this, but I’m not convinced that asking the gdb folks is
> > the right approach. GDB has an ancient architecture and is
> > *incredibly* buggy. I’m sure ptrace is somewhere on the pain point
> > list, but I suspect it’s utterly dwarfed by everything else.
> 
> You may be right. However, if gdbn isn't going to use it, then I
> seriously don't think it's worth changing much.
> 
> It might be worth looking at people who don't use ptrace() for
> debugging, but for "incidental" reasons. IOW sandboxing, tracing,
> things like that.
> 
> Maybe those people want things that are simpler and don't actually
> need the kinds of hard serialization that ptrace() wants.
> 
> I'd rather add a few really simple things that might not be a full
> complement of operations for a debugger, but exactly because they
> aren't a full debugger, maybe they are things that we can tell are
> obviously secure and simple?

I think the biggest non-anecdotal user of ptrace() besides debuggers
is actually criu (and strace of course). They use it to inject parasite
code (their phrasing not mine) into another task to handle restoring the
parts of a task that can't be restored from the outside. Looking through
their repo they make quite a bit of use of ptrace functionality including
some arch specific bits:
PTRACE_GETREGSET
PTRACE_GETFPREGS
PTRACE_PEEKUSER
PTRACE_POKEUSER
PTRACE_CONT
PTRACE_SETREGSET
PTRACE_GETVFPREGS /* arm/arm64 */
PTRACE_GETVRREGS /* powerpc */
PTRACE_GETVSRREGS /* powerpc */
PTRACE_EVENT_STOP
PTRACE_GETSIGMASK
PTRACE_INTERRUPT
PTRACE_DETACH
PTRACE_GETSIGINFO
PTRACE_SEIZE
PTRACE_SETSIGMASK
PTRACE_SI_EVENT
PTRACE_SYSCALL
PTRACE_SETOPTIONS
PTRACE_ATTACH
PTRACE_O_SUSPEND_SECCOMP
PTRACE_PEEKSIGINFO
PTRACE_SECCOMP_GET_FILTER
PTRACE_SECCOMP_GET_METADATA

So I guess strace and criu would be the ones to go and ask and if they
don't care enough we already need to start squinting for other larg-ish
users. proot comes to mind
https://github.com/proot-me/proot

(From personal experience, most of the time when ptrace is used in a
 non-debugger codebase it's either to plug a security hole exploitable
 through ptracing the task and the fix is ptracing that very task to
 prevent the attacker from ptracing it (where non-dumpability alone
 doesn't cut it) or the idea is dropped immediately to not lose the
 ability to use a debugger on the program.)

Christian
