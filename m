Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610468;
	b=JKrMv3W9ys6MXcLOJV8AUHhctaB9V3H+WBEB1BYZdGW2nBcmL70rkYgD2I9t9M0bFnHI
	 0e2SvaOxjz7+BAXh0+JhPYoHHvfmP04k/Pj24iRl2fAhHyubolrblSnsjNB30HPWgT3ha
	 hwXXeRugptS90SMdoi0DWt4MOcmtFsLVuHcWwMhPuHoWhBikdbJ7N8t4WDqQbp/7DYHNu
	 NYOxqpzCw2ctM1w6qM9G5AMkUt1NSX3zZ6jdJWjZQeqPszHopA5JiXrVl5nDGqf731/k4
	 OIWfejYyzrhbo2oC02i96bca5u4EXpTeCV8G0MScMGur3mkhhe11v1DBpfHr1Du4E3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610468;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KfUOxpLQJkovw7z2Qf0Qn6lhPyS9idJ1/zdVB8+NA18=;
	b=jQgsfD2nEh/MbSUs0iaGIvh/OjEtab6nGPuc+QEhsDreJj2Bd8qVIWIFH78HwpDZudN2
	 c5X1OzC4xGQJ/W1g85bK6mdGuAT0omtdJmHIO1MxjMURo77/w3diYCiRU9uxh0x+RlFGs
	 +W2LdcE/BE2Upj8OsZyiuHtj08SwstI/PlovrfHwwojm/do0OGrjwTJZSFU+hUjy2+RLT
	 WnDQ0IduTvYQEBJK8WX2JYTCTZwPJIYCzNRMkh+SNpgjuiJFtMt3eP2U/Ji8phKpOeYuX
	 4xtckl5osJNwJn68kg1Zuay4nMq9CHilZQUzsvOuBRG7Ly32iMY9KNbcfQT3FeWYdOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378C606A31E;
	Wed, 25 Nov 2026 12:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4FA1F000C0;
	Wed, 25 Nov 2026 12:41:05 +0000 (UTC)
Message-ID: <9ffb268e-d7db-4908-b9be-35b1807dfd2c@linux-m68k.org>
Date: Wed, 25 Nov 2026 22:41:02 +1000
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: coldfire: Use the builtin fls() and __fls() on
 ISA_A+ and ISA_C
To: Tzu-Ching Yang <shingekinocore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261123131101.639643-1-shingekinocore@gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20261123131101.639643-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tzu-Ching,


On 23/11/26 23:11, Tzu-Ching Yang wrote:
> Let fls() and __fls() use the ff1 instruction on ColdFire ISA_A+ and
> ISA_C cores instead of the generic binary search in C, as __ffs() and
> ffs() already do. GCC emits ff1 for __builtin_clz() on exactly the cores
> for which it defines __mcfisaaplus__ or __mcfisac__, the macros that
> already select the ff1 versions of __ffs() and ffs(), so no new
> condition is needed. Commit a6260ef84103 ("m68knommu: add ffs and __ffs
> plattform which support ISA A+ or ISA C") added the ff1 versions of
> __ffs() and ffs() in 2008 and kept the generic fls(); the generic
> __fls() followed in 2009.
> 
> Use the asm-generic builtin versions of fls() and __fls() when
> __mcfisaaplus__ or __mcfisac__ is defined, and keep the generic C
> versions for ISA_A, ISA_B and 68000. The bitrev/ff1 asm of __ffs() and
> ffs() stays, as this asm is shorter than the code GCC generates for
> the builtin versions of __ffs() and ffs().
> 
> With GCC 12 to 16, fls() shrinks from 28 instructions to 8 or 9 and
> __fls() from 24 to 6. With GCC 8 to 16, the functions of each ISA_A+ or
> ISA_C defconfig kernel shrink in total by at least 8676 and at most
> 13266 bytes (scripts/bloat-o-meter -t), depending on the defconfig and
> the compiler. In lib/find_bit.c, only _find_last_bit() changes, from 55
> to 35 instructions for m5208evb with GCC 16.
> 
> fls(0) still returns 0, and __fls() still returns unsigned int.
> __fls(0), which is undefined, now returns ~0 instead of 0. For other
> CPUs, the preprocessed source changes only in its line numbers.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com/
> Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>

Looks good to me. I tested it on a ColdFire 5271, which is ISA_A+, and it
checked out good. I don't have my 54418 board handy at the moment (its ISA_C)
but when I get a chance I will double check that too.

Applied to the for-next branch of the m68knommu git tree.

Thanks
Greg




> ---
> I have no ColdFire hardware. On QEMU mcf5208evb (ISA_A+), the ffs and
> bitops KUnit tests pass before and after with GCC 8.3 to 16.2. In
> find_bit_benchmark on that machine, with the bitmaps drawn from a fixed
> seed so that the kernels before and after use the same bitmaps, and the
> executed instructions counted by a TCG plugin, find_last_bit goes from
> 52.3 to 38.3 instructions per iteration on the random bitmap with GCC
> 16, and bitmap_find_next_zero_area_off, which calls find_last_bit(),
> from 3302 to 2864; the tests of the other helpers do not change. The
> ISA_C kernels were only built, as QEMU has no ISA_C machine.
> 
> Under QEMU user mode, with the kernel's flags for -mcpu=5208, 532x and
> 54455 and each GCC at -O2 and -Os, old and new fls(), __fls() and
> fls64() agree on all 2^32 inputs (fls64() in either 32-bit half)
> except the undefined __fls(0).
> 
> The seven ISA_A+ and ISA_C defconfigs (m5208evb, m5235evb, m5275evb,
> m5282evb, m5329evb, m54418evb and stmark2) were built with GCC 8.3 to
> 16.2 before and after, with the same .config before and after. A W=1
> build of these seven and of twenty other ColdFire and m68k defconfigs,
> each with at least GCC 8.3, 12.5 and 16.2, has no new warning.
> 
> The new out-of-line fls() for m5208evb with GCC 16.2:
> 
> 	movel %sp@(4),%d0
> 	tstl %d0
> 	beqs 1f
> 	movel %d0,%d1
> 	ff1 %d1
> 	moveq #32,%d0
> 	subl %d1,%d0
> 1:	rts
> 
> Against v7.4-rc1; also applies to the m68knommu and m68k for-next
> branches and to next-20261113.
> 
>  arch/m68k/include/asm/bitops.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index e9639e48c6c3c..81923a9fa4494 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -506,13 +506,14 @@ static inline __attribute_const__ int ffs(int x)
>  	return __ffs(x) + 1;
>  }
>  
> +#include <asm-generic/bitops/builtin-fls.h>
> +#include <asm-generic/bitops/builtin-__fls.h>
>  #else
>  #include <asm-generic/bitops/ffs.h>
>  #include <asm-generic/bitops/__ffs.h>
> -#endif
> -
>  #include <asm-generic/bitops/fls.h>
>  #include <asm-generic/bitops/__fls.h>
> +#endif
>  
>  #else
>  
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

