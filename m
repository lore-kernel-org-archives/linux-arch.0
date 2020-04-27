From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date: Mon, 27 Apr 2020 10:30:58 +0200
Message-ID: <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:37097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0IbS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 04:31:18 -0400
In-Reply-To: <20200426163430.22743-1-hagen@jauu.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun Dhillon <sargun@sargun.me>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/syscalls.h               |   2 +
>  include/uapi/asm-generic/unistd.h      |   4 +-

When you add a new system call, please add it to all architectures.
See the patches for the last few additions on how to do it, in
particular the bit around adding the arm64 compat entry that is
a bit tricky.

It may be best to split out the patch changing all architectures from
the one adding the new syscall.

> +SYSCALL_DEFINE5(pidfd_ptrace, int, pidfd, long, request, unsigned long, addr,
> +               unsigned long, data, unsigned int, flags)
> +{

When you add a new variant of ptrace, there also needs to be the
corresponding COMPAT_SYSCLAL_DEFINE5(...) calling
compat_ptrace_request().

If you want, you could unify the native and compat code paths more by
merging compat_ptrace_request() into ptrace_request() and using
in_compat_syscall() checks for the ones that are different. This also
would best be done as a separate cleanup patch upfront.

      Arnd
