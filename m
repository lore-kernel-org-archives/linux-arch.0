From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: 64-syscall args on 32-bit vs syscall()
Date: Mon, 15 Mar 2010 15:48:13 +1100
Message-ID: <1268628493.2355.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Munroe <munroesj@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hoy there !

This may have been discussed earlier (I have some vague memories...) but
I just hit a problem with that again (Mark: hint, it's in hdparm's
fallocate) so I'd like a bit of a refresh here on what is the "right
thing" to do...

So some syscalls want a 64-bit argument. Let's take fallocate() as our
example. So we already know that we have to be extra careful since some
32-bit arch will pass this into 2 registers (or stack slots) which need
to be aligned, and so we tend to already take care of making sure that
the said 64-bit argument is either defined as 2x32-bit arguments, or
defined as 1x64 bit argument aligned to 2x32-bit in the argument list.

So far so good...

The problem is when user space tries to use the same trick for calling
those functions using glibc-provided syscall() function. In this
example, hdparm does:

err = syscall(SYS_fallocate, fd, mode, offset, len);

With "offset" being a 64-bit argument.

This will break because the first argument to syscall now shifts
everything by one register, which breaks the register pair alignment
(and I suppose archs with stack based calling convention can have
similar alignment issues even if x86 doesn't).

Ulrich, Steven, shouldn't we have glibc's syscall() take a long long as
it's first argument to correct that ? Either that or making it some kind
of macro wrapper around a __syscall(int dummy, int sysno, ...) ?

As it is, any 32-bit app using syscall() on any of the syscalls that
takes 64-bit arguments will be broken, unless the app itself breaks up
the argument, but the the order of the hi and lo part is different
between BE and LE architectures ;-)

So is there a more "correct" solution than another here ? Should powerpc
glibc be fixed at least so that syscall() keeps the alignment ?

Cheers,
Ben.
