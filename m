Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46207 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfHGHao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Aug 2019 03:30:44 -0400
MIME-Version: 1.0
References: <20190806232917.881-1-cai@lca.pw>
In-Reply-To: <20190806232917.881-1-cai@lca.pw>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Aug 2019 09:30:26 +0200
Message-ID: <CAK8P3a12VZHvX+rTDYenONwjBDbBvi2cT-FaqBcTpHbX8Gz4Bg@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190807073026.n5oQwBRfg9N2UJBjiBC0Ui_g_W6oMQEJ-sG4Cp7CXPw@z>

On Wed, Aug 7, 2019 at 1:29 AM Qian Cai <cai@lca.pw> wrote:
>
> A compiler throws a warning on an arm64 system since the
> commit 9849a5697d3d ("arch, mm: convert all architectures to use
> 5level-fixup.h"),
>
> mm/kasan/init.c: In function 'kasan_free_p4d':
> mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
> [-Wunused-but-set-variable]
>  p4d_t *p4d;
>         ^~~
>
> because p4d_none() in "5level-fixup.h" is compiled away while it is a
> static inline function in "pgtable-nopud.h". However, if converted
> p4d_none() to a static inline there, powerpc would be unhappy as it
> reads those in assembler language in
> "arch/powerpc/include/asm/book3s/64/pgtable.h", so it needs to skip
> assembly include for the static inline C function. While at it,
> converted a few similar functions to be consistent with the ones in
> "pgtable-nopud.h".
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Arnd Bergmann <arnd@arndb.de>
