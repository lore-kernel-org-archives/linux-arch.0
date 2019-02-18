From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] iomap: fix multiple consistency issues, interface cleanup
Date: Mon, 18 Feb 2019 15:11:54 +0100
Message-ID: <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
References: <cover.1550485787.git.hle@owl.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 18, 2019 at 11:53 AM Hugo Lefeuvre <hle@owl.eu.com> wrote:
>
> Hi,
>
> This patch cleans up the iomap interface.
>
> The first patch makes the include/asm-generic/iomap.h header compliant
> with the kernel style guidelines by adding missing function args
> identifier names.
>
> The second and fourth patches address multiple compilation warnings due
> to missing const qualifiers in mmio_ins* and ioread*/iowrite
> definitions in include/asm-generic/iomap.h and lib/iomap.c.
>
> The third patch modifies io*_rep definitions from asm-generic/io.h to
> take unsigned long count parameter instead of unsigned int which is
> inconsistent with other definitions in the kernel.

Nice cleanup! Applied to my asm-generic tree now.

I notice that you did not add a 'volatile' qualifier in addition to 'const'.
Is that something you considered doing? I think the traditional
readl/writel style accessors have them partly for historic reasons,
and partly to simply the trivial implementation that is based on
a volatile pointer dereference. Neither is needed here, and I don't
think we have any drivers that pass volatile pointers into ioread()/iowrite()
(which would cause a warning), so we can probably leave it at that,
but it's still a bit inconsistent.

    Arnd
