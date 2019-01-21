Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40842 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfAULkK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2019 06:40:10 -0500
MIME-Version: 1.0
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com> <20190102202938.GA26600@linux-8ccs>
In-Reply-To: <20190102202938.GA26600@linux-8ccs>
From: Mathias Krause <minipli@googlemail.com>
Date: Mon, 21 Jan 2019 12:39:57 +0100
Message-ID: <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Jessica Yu <jeyu@kernel.org>
Message-ID: <20190121113957.1AS7keqyRx8RZ2CXOWNShLHmXQh8SEKDIpFNp-u2JE0@z>

On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Mathias Krause [30/12/18 13:40 +0100]:
> >The reference to '__vermagic' is a relict from v2.5 times. And even
> >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
> >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
> >67ac5b866bda ("[PATCH] complete modinfo section")).
> >
> >Neither current kernels nor modules contain a '__vermagic' section any
> >more, so get rid of it.
> >
> >Signed-off-by: Mathias Krause <minipli@googlemail.com>
> >Cc: Rusty Russell <rusty@rustcorp.com.au>
> >Cc: Jessica Yu <jeyu@kernel.org>
>
> Thanks for the cleanup.
>
> Reviewed-by: Jessica Yu <jeyu@kernel.org>
>

Arnd, will you carry this patch through your asm-generic tree or did
the MAINTAINERS file mislead me here?

Thanks,
Mathias

> >---
> > include/asm-generic/vmlinux.lds.h | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> >index 3d7a6a9c2370..530ce1e7a1ec 100644
> >--- a/include/asm-generic/vmlinux.lds.h
> >+++ b/include/asm-generic/vmlinux.lds.h
> >@@ -332,7 +332,6 @@
> >               __start_rodata = .;                                     \
> >               *(.rodata) *(.rodata.*)                                 \
> >               RO_AFTER_INIT_DATA      /* Read only after init */      \
> >-              KEEP(*(__vermagic))     /* Kernel version magic */      \
> >               . = ALIGN(8);                                           \
> >               __start___tracepoints_ptrs = .;                         \
> >               KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >--
> >2.19.2
> >
