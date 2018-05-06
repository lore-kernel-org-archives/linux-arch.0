Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:42538 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeEFTdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 May 2018 15:33:42 -0400
MIME-Version: 1.0
In-Reply-To: <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
 <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 May 2018 12:33:21 -0700
Message-ID: <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha <linux-alpha@vger.kernel.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180506193321.9m7vrddu-3-J7brj3gOo_uDVeq8hbANKR3NniDnZLNs@z>

On Tue, Apr 17, 2018 at 3:11 AM, James Hogan <jhogan@kernel.org> wrote:
> Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
> instead of undefining the inline macros in the alpha specific
> asm/compiler.h. This is to allow asm/compiler.h to become a general
> header that can be used for overriding linux/compiler*.h.
>
> A build of alpha's defconfig on GCC 7.3 before and after this series
> (i.e. this commit and "compiler.h: Allow arch-specific overrides" which
> includes asm/compiler.h from linux/compiler_types.h) results in the
> following size differences, which appear harmless to me:
>
> $ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
> Function                                     old     new   delta
> cap_bprm_set_creds                          1496    1664    +168
> cap_issubset                                   -      68     +68
> flex_array_put                               328     344     +16
> cap_capset                                   488     500     +12
> nonroot_raised_pE.constprop                  348       -    -348
> Total: Before=5823709, After=5823625, chg -0.00%
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org

Looks fine to me.

Acked-by: Matt Turner <mattst88@gmail.com>

Should I take it through the alpha tree?
