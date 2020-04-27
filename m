From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Mon, 27 Apr 2020 20:59:29 +0200
Message-ID: <20200427185929.GA1768@laniakea>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein>
 <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87zhawdc6w.fsf-JOvCrm2gF+uungPnsOpG7nhyD016LWXt@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Christian Brauner <christian.brauner-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christian Brauner <christian-STijNZzMWpgWenYVfaLwtA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Gerst <brgerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sami Tolvanen <samitolvanen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aleksa Sarai <cyphar-gVpy/LI/lHzQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sargun Dhillon <sargun-GaZTRHToo+CzQB+pC5nmwQ@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux-arch <linu>
List-Id: linux-arch.vger.kernel.org

* Eric W. Biederman | 2020-04-27 13:18:47 [-0500]:

>I am conflicted about that but I have to agree.    Instead of
>duplicating everything it would be good enough to duplicate the once
>that cause the process to be attached to use.  Then there would be no
>more pid races to worry about.

>How does this differ using the tracing related infrastructure we have
>for the kernel on a userspace process?  I suspect augmenting the tracing
>infrastructure with the ability to set breakpoints and watchpoints (aka
>stopping userspace threads and processes might be a more fertile
>direction to go).
>
>But I agree either we want to just address the races in PTRACE_ATTACH
>and PTRACE_SIEZE or we want to take a good hard look at things.
>
>There is a good case for minimal changes because one of the cases that
>comes up is how much work will it take to change existing programs.  But
>ultimately ptrace pretty much sucks so a very good set of test cases and
>documentation for what we want to implement would be a very good idea.

Hey Eric, Jann, Christian, Arnd,

thank you for your valuable input! IMHO I think we have exactly two choices
here:

a) we go with my patchset that is 100% ptrace feature compatible - except the
   pidfd thing - now and in the future. If ptrace is extended pidfd_ptrace is
   automatically extended and vice versa. Both APIs are feature identical
   without any headaches.
b) leave ptrace completely behind us and design ptrace that we have always
   dreamed of! eBPF filters, ftrace kernel architecture, k/uprobe goodness,
   a speedy API to copy & modify large chunks of data, io_uring/epoll support
   and of course: pidfd based (missed likely thousands of other dreams)
	
I think a solution in between is not worth the effort! It will not be
compatible in any way for the userspace and the benefit will be negligible.
Ptrace is horrible API - everybody knows that but developers get comfy with
it. You find examples everywhere, why should we make it harder for the user for
no or little benefit (except that stable handle with pidfd and some cleanups)?

Any thoughts on this?

Hagen
