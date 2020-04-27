Return-Path: <SRS0=jgxL=6L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0S7m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 14:59:42 -0400
Date: Mon, 27 Apr 2020 20:59:29 +0200
From: Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Message-ID: <20200427185929.GA1768@laniakea>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein>
 <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhawdc6w.fsf@x220.int.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <christian.brauner@ubuntu.com>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun Dhillon <sargun@sargun.me>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20200427185929.u5FREsYh1-lf_u_svFXvekUG49Y-LHEyJuMfiejdyh4@z>

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
