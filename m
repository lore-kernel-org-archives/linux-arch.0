Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37744 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfAUPyM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2019 10:54:12 -0500
MIME-Version: 1.0
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org> <20190119235650.GC26876@brain-police>
In-Reply-To: <20190119235650.GC26876@brain-police>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 16:53:54 +0100
Message-ID: <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Agner <stefan@agner.ch>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Russell King <rmk+kernel@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190121155354.pY96owh1-stNw_wquLyzADCiNzc3_Cl0X_mlMHmxN3A@z>

n Sun, Jan 20, 2019 at 12:57 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> > This will be an automated scripts to provide easy support
> > for add/modify/delete the system call entry by add in
> > respective *.tbl file.
> >
> > System call table generation support for asm-generic is
> > provide for arm64 architecture which will use the common
> > scripts resides in scripts directory and use syscall.tbl
> > syscall_arm32.tbl files as inputs. This implementation
> > will replace asm-generic/unistd.h.
> >
> > This patch depends on:
> >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
> >  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/
>
> I'm having a hard time understanding what the benefit of this series is,
> given that we only support EABI compat tasks. When adding a new compat
> system call, you can't just blindly hook it up without checking whether it
> needs a wrapper to deal with any type conversion etc, so really we're just
> replacing one table with another as far as I can tell. What am I missing?

The point that is missing in the description above is that all unistd.h
and syscall.S files are now being generated from a .tbl file, across
all architectures. This was already done on arm32, x86 and s390
before 4.20, but is now done on all architectures that don't use
the uapi/asm-generic/unistd.h header, and the arm32 compat version for
arm64.

The newly added file has the same format as all other tables, and
will be easier to synchronize with the arm32 version, which has
almost the same contents (arm32 has oabi support, arm64 has
compat support).

> I also really don't think we should be generating the 32-bit UAPI headers
> from the 64-bit compat system call support (if that's what you're trying to
> do -- make headers_check fails with your patches applied). arch/arm/ is the
> canonical place for the 32-bit UAPI, and we're just implementing that.

I think you just misread what Firoz was trying to say here: The
arm64 uapi/asm/unistd.h file is now being generated from the
generic syscall.tbl file, while the compat asm/unistd32.h file is not
part of the UAPI. In both cases though, the data from the old files
is being replaced with data in the more compact and (hopefully)
more readable format.


    Arnd
