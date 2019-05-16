Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42624 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfEPO6X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 10:58:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so5675863eda.9
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 07:58:22 -0700 (PDT)
Date: Thu, 16 May 2019 16:58:19 +0200
From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516145819.ofqkv6ozfpumhhuk@brauner.io>
References: <20190516135944.7205-1-christian@brauner.io>
 <CAMuHMdVbUJ0+28Lc2wHPah8UUk8Ou9m81KzLvhrcMsJzz2bX2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVbUJ0+28Lc2wHPah8UUk8Ou9m81KzLvhrcMsJzz2bX2A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-mips@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, elena.reshetova@intel.com, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Colascione <dancol@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, cyphar@cyphar.com, Andy Lutomirski <luto@amacapital.net>, "Eric W. Biederman" <ebiederm@xmission.com>, alpha <linux-alpha@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20190516145819.mrSxZPuOoep_PEbgFLqgpzZOFlzbKPD_TPGxLdbuhUU@z>

On Thu, May 16, 2019 at 04:56:08PM +0200, Geert Uytterhoeven wrote:
> Hi Christian, David,
> 
> On Thu, May 16, 2019 at 4:00 PM Christian Brauner <christian@brauner.io> wrote:
> > This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
> > pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
> > process that is created via traditional fork()/clone() calls that is only
> > referenced by a PID:
> >
> > int pidfd = pidfd_open(1234, 0);
> > ret = pidfd_send_signal(pidfd, SIGSTOP, NULL, 0);
> >
> > With the introduction of pidfds through CLONE_PIDFD it is possible to
> > created pidfds at process creation time.
> > However, a lot of processes get created with traditional PID-based calls
> > such as fork() or clone() (without CLONE_PIDFD). For these processes a
> > caller can currently not create a pollable pidfd. This is a huge problem
> > for Android's low memory killer (LMK) and service managers such as systemd.
> > Both are examples of tools that want to make use of pidfds to get reliable
> > notification of process exit for non-parents (pidfd polling) and race-free
> > signal sending (pidfd_send_signal()). They intend to switch to this API for
> > process supervision/management as soon as possible. Having no way to get
> > pollable pidfds from PID-only processes is one of the biggest blockers for
> > them in adopting this api. With pidfd_open() making it possible to retrieve
> > pidfd for PID-based processes we enable them to adopt this api.
> >
> > In line with Arnd's recent changes to consolidate syscall numbers across
> > architectures, I have added the pidfd_open() syscall to all architectures
> > at the same time.
> 
> > +428    common  pidfd_open                      sys_pidfd_open
> 
> This number conflicts with "[PATCH 4/4] uapi: Wire up the mount API
> syscalls on non-x86 arches", which is requested to be included before
> rc1.

Yep, already spotted this thanks to Arnd! Will change the syscall
numbers.

Thanks!
Christian

> 
> Note that none of this is part of linux-next.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
