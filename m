Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39177 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391933AbfBROMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 09:12:12 -0500
MIME-Version: 1.0
References: <cover.1550485787.git.hle@owl.eu.com>
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 15:11:54 +0100
Message-ID: <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] iomap: fix multiple consistency issues, interface cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190218141154.NCSY8u_VlLFZt0ZzmW68z-A_ij0SQtDSUzmfNiVMV6Q@z>

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
