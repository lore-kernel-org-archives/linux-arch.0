Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40717 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfAUIzy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2019 03:55:54 -0500
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-9-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-9-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:55:38 +0100
Message-ID: <CAMuHMdUH+vJ89O6-Qm1p9r6h30z2ZRred1aQd6=h0sk6xXULMQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/29] m68k: assign syscall number for seccomp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Firoz Khan <firoz.khan@linaro.org>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <20190121085538.KgHQsOhbF5jZkd9Y5ylGHVrPRvqdsTV7YM4flD7bXG8@z>

On Fri, Jan 18, 2019 at 5:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures have assigned a numbers for the seccomp syscall
> even when they do not implement it.
>
> m68k is an exception here, so for consistency lets add the number.
> Unless CONFIG_SECCOMP is implemented, the system call just
> returns -ENOSYS.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
