Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:57571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfKEJtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 04:49:32 -0500
MIME-Version: 1.0
References: <20191105022928.517526-1-farnasirim@gmail.com> <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Nov 2019 10:49:12 +0100
Message-ID: <CAK8P3a0wyw=CwhiU34t1zBiSesf+HGBLeaV+=JVko_TjnvATHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] syscalls: Fix references to filenames containing
 syscall defs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mohammad Nasirifar <far.nasiri.m@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Mohammad Nasirifar <farnasirim@gmail.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Valdis Kletnieks <valdis.kletnieks@vt.edu>
Message-ID: <20191105094912.ObPkoGVx5Rmu2PeB-fqIt8mjksmT1ayBtFZnKcLvNuE@z>

On Tue, Nov 5, 2019 at 10:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 4 Nov 2019, Mohammad Nasirifar wrote:
> > Fix stale references to files containing syscall definitions in
> > 'include/linux/syscalls.h' and 'include/uapi/asm-generic/unistd.h',
> > pointing to 'kernel/itimer.c', 'kernel/hrtimer.c', and 'kernel/time.c'.
> > They are now under 'kernel/time'.
> >
> > Also definitions of 'getpid', 'getppid', 'getuid', 'geteuid', 'getgid',
> > 'getegid', 'gettid', and 'sysinfo' are now in 'kernel/sys.c'.
>
> Can we please remove these file references completely. They are going to be
> stale sooner than later again and they really do not provide any value.

+1

Good idea!

In the long run, I'd prefer to have a parsable format that can be used to
generate both the header file and the stubs that we currently provide
using SYSCALL_DEFINEx(), but before that I'd like the remaining two
unistd.h files to be converted to syscall.tbl format (Nitesh is still working
on that).

      Arnd
