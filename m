Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45868 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfETO7e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 10:59:34 -0400
MIME-Version: 1.0
References: <20190520134605.29116-1-christian@brauner.io> <CAK8P3a1cZZ6SQe5mGjhga=MgTvCGF6OKyjvosR8J6z6EpH+rVA@mail.gmail.com>
 <20190520144822.xfaifawi65jus6ng@brauner.io>
In-Reply-To: <20190520144822.xfaifawi65jus6ng@brauner.io>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 May 2019 16:59:16 +0200
Message-ID: <CAK8P3a2u2gftAuzTfspAUCvWPPE0YVNOATFPN__tEQoO4GXg-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pid: add pidfd_open()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, David Howells <dhowells@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Daniel Colascione <dancol@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, Suren Baghdasaryan <surenb@google.com>, Android Kernel Team <kernel-team@android.com>
Message-ID: <20190520145916.UjzY49OlKGrmCz3UQ4duLBzwnLBX2Q-0R6i3wvC_CS0@z>

On Mon, May 20, 2019 at 4:48 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, May 20, 2019 at 04:37:03PM +0200, Arnd Bergmann wrote:
> > On Mon, May 20, 2019 at 3:46 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > In line with Arnd's recent changes to consolidate syscall numbers across
> > > architectures, I have added the pidfd_open() syscall to all architectures
> > > at the same time.
> >
> > Thanks! I've checked that the ones you have added are all
> > done correctly. However, double-checking that you got all of them,
> > I noticed that you missed mips-o32 and mips-n64. With those added:
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Perfect, will plumb mips-o32 and mips-n64 and resend once more with your
> ack added.
> Sidenote: You plan on merging the common syscall tables or will there be
> a script to do this work per-arch in the future?

David Howells also asked about this. I think having a common table will
be best in the long run, patches welcome.

As you noticed, there are still a few minor differences between the files
on mips, arm, x86, alpha and s390, and we are missing the .tbl files
for arm-compat and asm-generic, as well as an architecture independent
script.

Once that is all taken care of, we can move the entries for syscall
403 and higher into a common file, and change the script to pick
up the contents from there in addition to the architecture specific
file.

      Arnd
