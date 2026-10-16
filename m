Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FC4772B8;
	Fri, 16 Oct 2026 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153344; cv=none; b=mLTxKEs5k0qHjvdnK7UGt6i/JElzaVaW/mxo6mxkqkIuOrRKjFckjoca1R/w31Od/CXh2+PelQLY7JOBzOyQbCMNFGpaHIdBYyKdm5vGWL2cgfHSTUEqE9qeuhP4mAvTN1OJtphHMTfLIU+3ak4KpIGy76mLA+dZIx5NtsOfp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153344; c=relaxed/simple;
	bh=NULbTvIQZ/oHcmP/aTrGATa4IJHfneiO9zb4SUFhYOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqnnVB4rLz8rEIDGb2O/sgXNEqg+8LAm5G3cHxL1tG1rOasPb+Bfgvb8x8lzMcWE6rvqazE14ZLhaMHDbaRkb8g48cFezRLZNq3Jzi1LT85bjoQgVjEV4IYysip8u/Zy+eGygtFbQL+/RLKpsFqLgqVO9rc9KmP2YjdriM4431k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=shhqUlli; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="shhqUlli"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4C914BF;
	Fri, 16 Oct 2026 05:22:18 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F923F871;
	Fri, 16 Oct 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792153342; bh=NULbTvIQZ/oHcmP/aTrGATa4IJHfneiO9zb4SUFhYOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shhqUlli7w1Npoly5BGrBS9Jy9AZY2n6Qb6sU26nBEEnyq71sbkEQEBxvCyhG8TkX
	 g9tiyckxqyXXZraYz+0AqS9HqbmBj0vPQm+YEl3Fp3yPWsjb16Hsdua5atbQo6HLCb
	 /BewOKm9GMLZuErY0jpDtTffJNkkLeQHDbyrauGg=
Date: Fri, 16 Oct 2026 13:22:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, broonie@kernel.org,
	boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v16 03/16] arm64/delay: move, fixup usecs_to_cycles()
Message-ID: <atIW-GIWaN6-w44R@arm.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016070837.440748-4-ankur.a.arora@oracle.com>

On Fri, Oct 16, 2026 at 12:08:24AM -0700, Ankur Arora wrote:
> diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
> new file mode 100644
> index 000000000000..6ccdfe0a4130
> --- /dev/null
> +++ b/arch/arm64/include/asm/delay-const.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_DELAY_CONST_H
> +#define _ASM_DELAY_CONST_H
> +
> +#include <linux/math64.h>
> +#include <linux/types.h>
> +#include <asm/param.h>	/* For HZ */
> +
> +/* 2**32 / 1000000 (rounded up) */
> +#define __usecs_to_xloops_mult	0x10C7UL
> +
> +/* 2**32 / 1000000000 (rounded up) */
> +#define __nsecs_to_xloops_mult	0x5UL
> +
> +extern unsigned long loops_per_jiffy;
> +static inline u64 xloops_to_cycles(u64 xloops)
> +{
> +	u64 loops_per_sec = (u64)loops_per_jiffy * HZ;
> +
> +	return mul_u64_u64_shr(xloops, loops_per_sec, 32);
> +}
> +
> +static inline u64 usecs_to_cycles(u64 time_usecs)
> +{
> +	return xloops_to_cycles(time_usecs * __usecs_to_xloops_mult);
> +}
> +
> +static inline u64 nsecs_to_cycles(u64 time_nsecs)
> +{
> +	return xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult);
> +}
> +
> +u64 notrace __delay_cycles(void);
> +
> +#endif	/* _ASM_DELAY_CONST_H */

The bot reports are valid, moving these into headers pulled elsewhere
will clash with existing functions with the same name. You fixed one but
there's another. Isn't it easier to just add an arm64_ prefix to these?

Alternatively, I think we only need nsecs_to_cycles(). We have an out of
line call to __delay_cycles() already, so can we not just add a new
function to use directly and avoid polluting the headers:

u64 arm64_wfet_deadline(u64 timeout_ns)
{
        return __delay_cycles() + nsecs_to_cycles(timeout_ns);
}
EXPORT_SYMBOL_GPL(arm64_wfet_deadline);

I prefer the latter if it works.

-- 
Catalin
