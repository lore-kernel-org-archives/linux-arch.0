Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54909 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGSK3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 06:29:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so28272756wme.4
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2019 03:29:49 -0700 (PDT)
Date: Fri, 19 Jul 2019 12:29:41 +0200
From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190719102932.274pvmxnrbjcc6gu@brauner.io>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
 <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
 <20190718161231.xcno272nvqpln3wj@yavin>
 <CAK8P3a3MiYK4bJiA3G_m5H-TpfN5__--b+=szsJBhG7_it+NQg@mail.gmail.com>
 <20190719021218.GB18022@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190719021218.GB18022@altlinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, alpha <linux-alpha@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux <sparclinux@vger.kernel.org>
Message-ID: <20190719102941.C867JSrr9rVttZmb4CSOyw_gXRJr0IWEG3QkHlYSZ2I@z>

On Fri, Jul 19, 2019 at 05:12:18AM +0300, Dmitry V. Levin wrote:
> On Thu, Jul 18, 2019 at 11:29:50PM +0200, Arnd Bergmann wrote:
> [...]
> > 5. you get the same problem with seccomp and strace that
> >    clone3() has -- these and others only track the register
> >    arguments by default.
> 
> Just for the record, this is definitely not the case for strace:
> it decodes arrays, structures, netlink messages, and so on by default.

There sure is value in trying to design syscalls that can be handled
nicely by seccomp but that shouldn't become a burden on designing
extensible syscalls.
I suggested a session for Ksummit where we can discuss if and how we can
make seccomp more compatible with pointer-args in syscalls.

Christian
