From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Date: Tue, 14 Jul 2020 08:29:43 -0700
Message-ID: <CAHk-=whvwd9AWMCoUidO8pT3iw6e6NXCKThqbpDQOoz1=WTP7g@mail.gmail.com>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGNPaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 11:30:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF4FC061755
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:30:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so23300003ljo.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:30:02 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 193sm7266523lfa.90.2020.07.14.08.29.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id d17so23310475ljl.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
In-Reply-To: <20200714105505.935079-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Jul 14, 2020 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add helpers to wrap the get_fs/set_fs magic for undoing any damange done
> by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.

It would perhaps have been nicer to rename the save variabel too
(neither "seg" nor "oldfs" make much sense once you get rid of the old
x86-inspired name).

But from a greppability standpoint and a doc standpoint, I guess just
renaming the function is sufficient (and certainly easier).

               Linus
