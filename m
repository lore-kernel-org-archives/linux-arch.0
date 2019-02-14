Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35289 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfBNKwx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2019 05:52:53 -0500
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-4-hch@lst.de>
In-Reply-To: <20190213174005.28785-4-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 11:52:38 +0100
Message-ID: <CAMuHMdW4C1McxL-e7ZSiSOiiE5D=xbBK8FZOwuJ1w0kK3CR1Hg@mail.gmail.com>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Waiman Long <longman@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20190214105238.TaWgsU9LTP_cg0CLy6SV0FRC5OA7XqiOqdWj2kbvtkM@z>

On Thu, Feb 14, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
> Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
> RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
> select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
> the spinlock version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Note that this conflicts with "[PATCH v4 2/3] locking/rwsem: Remove
rwsem-spinlock.c & use rwsem-xadd.c for all archs"
https://lore.kernel.org/lkml/1550095217-12047-3-git-send-email-longman@redhat.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
