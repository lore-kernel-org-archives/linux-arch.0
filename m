Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:40680 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbfKEJeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 04:34:11 -0500
Date: Tue, 5 Nov 2019 10:34:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] syscalls: Fix references to filenames containing
 syscall defs
In-Reply-To: <20191105022928.517526-1-farnasirim@gmail.com>
Message-ID: <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de>
References: <20191105022928.517526-1-farnasirim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mohammad Nasirifar <far.nasiri.m@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Mohammad Nasirifar <farnasirim@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>
Message-ID: <20191105093407.bjrPEJwCVhMIEsuQ-JOCBH_MPoh2WX-t2Jo-Ak4ZiLo@z>

On Mon, 4 Nov 2019, Mohammad Nasirifar wrote:

> Fix stale references to files containing syscall definitions in
> 'include/linux/syscalls.h' and 'include/uapi/asm-generic/unistd.h',
> pointing to 'kernel/itimer.c', 'kernel/hrtimer.c', and 'kernel/time.c'.
> They are now under 'kernel/time'.
> 
> Also definitions of 'getpid', 'getppid', 'getuid', 'geteuid', 'getgid',
> 'getegid', 'gettid', and 'sysinfo' are now in 'kernel/sys.c'.

Can we please remove these file references completely. They are going to be
stale sooner than later again and they really do not provide any value.

Thanks,

	tglx
