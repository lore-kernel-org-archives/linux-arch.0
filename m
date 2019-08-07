From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
Date: Wed, 7 Aug 2019 09:30:26 +0200
Message-ID: <CAK8P3a12VZHvX+rTDYenONwjBDbBvi2cT-FaqBcTpHbX8Gz4Bg@mail.gmail.com>
References: <20190806232917.881-1-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806232917.881-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
