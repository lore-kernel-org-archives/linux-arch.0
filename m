Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbfETOhX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 10:37:23 -0400
MIME-Version: 1.0
References: <20190520134605.29116-1-christian@brauner.io>
In-Reply-To: <20190520134605.29116-1-christian@brauner.io>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 May 2019 16:37:03 +0200
Message-ID: <CAK8P3a1cZZ6SQe5mGjhga=MgTvCGF6OKyjvosR8J6z6EpH+rVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pid: add pidfd_open()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, David Howells <dhowells@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Daniel Colascione <dancol@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, Suren Baghdasaryan <surenb@google.com>, Android Kernel Team <kernel-team@android.com>
Message-ID: <20190520143703.c59VIkFuyYTFbwBvhUUeqGIar2nU4wBqqole1OHYlaI@z>

On Mon, May 20, 2019 at 3:46 PM Christian Brauner <christian@brauner.io> wrote:
>
> In line with Arnd's recent changes to consolidate syscall numbers across
> architectures, I have added the pidfd_open() syscall to all architectures
> at the same time.

Thanks! I've checked that the ones you have added are all
done correctly. However, double-checking that you got all of them,
I noticed that you missed mips-o32 and mips-n64. With those added:

Acked-by: Arnd Bergmann <arnd@arndb.de>
