Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0KCz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2019 06:02:55 -0400
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <20190526102612.6970-2-christian@brauner.io>
In-Reply-To: <20190526102612.6970-2-christian@brauner.io>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 May 2019 12:02:37 +0200
Message-ID: <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Adrian Reber <adrian@lisas.de>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20190527100237.oVsbp1VNRfiXPhuBcvDyatPeGOrS3v14GuJeaOFPAyQ@z>

On Sun, May 26, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
>
> Wire up the clone6() call on x86.
>
> This patch only wires up clone6() on x86. Some of the arches look like they
> need special assembly massaging and it is probably smarter if the
> appropriate arch maintainers would do the actual wiring.

Why do some architectures need special cases here? I'd prefer to have
new system calls always get defined in a way that avoids this, and
have a common entry point for everyone.

Looking at the m68k sys_clone comment in
arch/m68k/kernel/process.c, it seems that this was done as an
optimization to deal with an inferior ABI. Similar code is present
in h8300, ia64, nios2, and sparc. If all of them just do this to
shave off a few cycles from the system call entry, I really
couldn't care less.

       Arnd
