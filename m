From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 11/18] arm64: ilp32: share aarch32 syscall handlers
Date: Mon, 5 Dec 2016 17:12:43 +0000
Message-ID: <20161205171242.GH14429@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-12-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbcLERMu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Dec 2016 12:12:50 -0500
Content-Disposition: inline
In-Reply-To: <1477081997-4770-12-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com

On Fri, Oct 21, 2016 at 11:33:10PM +0300, Yury Norov wrote:
> off_t is  passed in register pair just like in aarch32.
> In this patch corresponding aarch32 handlers are shared to
> ilp32 code.
[...]
> +/*
> + * Note: off_4k (w5) is always in units of 4K. If we can't do the
> + * requested offset because it is not page-aligned, we return -EINVAL.
> + */
> +ENTRY(compat_sys_mmap2_wrapper)
> +#if PAGE_SHIFT > 12
> +	tst	w5, #~PAGE_MASK >> 12
> +	b.ne	1f
> +	lsr	w5, w5, #PAGE_SHIFT - 12
> +#endif
> +	b	sys_mmap_pgoff
> +1:	mov	x0, #-EINVAL
> +	ret
> +ENDPROC(compat_sys_mmap2_wrapper)

For compat sys_mmap2, the pgoff argument is in multiples of 4K. This was
traditionally used for architectures where off_t is 32-bit to allow
mapping files to 2^44.

Since off_t is 64-bit with AArch64/ILP32, should we just pass the off_t
as a 64-bit value in two different registers (w5 and w6)?

-- 
Catalin
