Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45755 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHORig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Aug 2019 13:38:36 -0400
Date: Thu, 15 Aug 2019 10:38:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
Message-ID: <20190815173833.GA29763@roeck-us.net>
References: <20190806232917.881-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806232917.881-1-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: akpm@linux-foundation.org, arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com, jgg@ziepe.ca, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190815173833.CevBu8afyF309VEYBmhztDZknKDSa7QHDyNfk4X7yVA@z>

On Tue, Aug 06, 2019 at 07:29:17PM -0400, Qian Cai wrote:
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
> Acked-by: Arnd Bergmann <arnd@arndb.de>

All parisc builds fail with this patch applied.

include/asm-generic/5level-fixup.h:14:18: error:
	unknown type name 'pgd_t'; did you mean 'pid_t'?

Bisect results below.

Guenter

---
# bad: [329120423947e8b36fd2f8b5cf69944405d0aece] Merge tag 'auxdisplay-for-linus-v5.3-rc5' of git://github.com/ojeda/linux
# good: [ee1c7bd33e66376067fd6306b730789ee2ae53e4] Merge tag 'tpmdd-next-20190813' of git://git.infradead.org/users/jjs/linux-tpmdd
git bisect start 'HEAD' 'ee1c7bd33e66'
# bad: [e83b009c5c366b678c7986fa6c1d38fed06c954c] Merge tag 'dma-mapping-5.3-4' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad e83b009c5c366b678c7986fa6c1d38fed06c954c
# bad: [92717d429b38e4f9f934eed7e605cc42858f1839] Revert "Revert "mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask""
git bisect bad 92717d429b38e4f9f934eed7e605cc42858f1839
# good: [b997052bc3ac444a0bceab1093aff7ae71ed419e] mm/z3fold.c: fix z3fold_destroy_pool() race condition
git bisect good b997052bc3ac444a0bceab1093aff7ae71ed419e
# good: [951531691c4bcaa59f56a316e018bc2ff1ddf855] mm/usercopy: use memory range to be accessed for wraparound check
git bisect good 951531691c4bcaa59f56a316e018bc2ff1ddf855
# good: [6a2aeab59e97101b4001bac84388fc49a992f87e] seq_file: fix problem when seeking mid-record
git bisect good 6a2aeab59e97101b4001bac84388fc49a992f87e
# bad: [0cfaee2af3a04c0be5f056cebe5f804dedc59a43] include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used
git bisect bad 0cfaee2af3a04c0be5f056cebe5f804dedc59a43
# first bad commit: [0cfaee2af3a04c0be5f056cebe5f804dedc59a43] include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used
