Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41299 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfAUU20 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2019 15:28:26 -0500
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-15-arnd@arndb.de>
 <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
In-Reply-To: <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 21:28:08 +0100
Message-ID: <CAK8P3a1BxBHfHZCvTM6aoBiiN+EpnD4P9LM=Ked5Sc_QwF7hCg@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers everywhere
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Firoz Khan <firoz.khan@linaro.org>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <20190121202808.otCQwXvBHLbQ7urYEgk_-x04hQmC4zI2R34-_B4LcpQ@z>

On Mon, Jan 21, 2019 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Note that all architectures that already define pkey syscalls, list
> pkey_mprotect first.

It's easy enough to change, so I've reordered them for consistency now.

> Regardless, for m68k:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks,

     Arnd
