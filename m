Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39752 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbbGOQBS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jul 2015 12:01:18 -0400
Date: Wed, 15 Jul 2015 17:01:09 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 04/24] arm64: Provide atomic_{or,xor,and}
Message-ID: <20150715160109.GB17107@arm.com>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.361407648@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150709175308.361407648@infradead.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>, "mingo@kernel.org" <mingo@kernel.org>
Message-ID: <20150715160109.VrEg4TBJDsYNktQJR1wSjG1iq7O9f_IyWO8qwCs6Rvc@z>

On Thu, Jul 09, 2015 at 06:28:59PM +0100, Peter Zijlstra wrote:
> Implement atomic logic ops -- atomic_{or,xor,and}.
> 
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.
> 
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/atomic.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/arch/arm64/include/asm/atomic.h
> +++ b/arch/arm64/include/asm/atomic.h
> @@ -84,6 +84,9 @@ static inline int atomic_##op##_return(i
>  
>  ATOMIC_OPS(add, add)
>  ATOMIC_OPS(sub, sub)
> +ATOMIC_OP(and, and)
> +ATOMIC_OP(or, orr)

FYI, but without selecting CONFIG_ARCH_HAS_ATOMIC_OR this change leads to
build errors:

                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/uapi/linux/timex.h:56,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
include/linux/atomic.h:115:20: error: redefinition of ‘atomic_or’
 static inline void atomic_or(int i, atomic_t *v)
                    ^
In file included from include/linux/atomic.h:4:0,
                 from include/linux/spinlock.h:416,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/uapi/linux/timex.h:56,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
arch/arm64/include/asm/atomic.h:48:20: note: previous definition of ‘atomic_or’ was here
 static inline void atomic_##op(int i, atomic_t *v)   \
                    ^
arch/arm64/include/asm/atomic.h:88:1: note: in expansion of macro ‘ATOMIC_OP’
 ATOMIC_OP(or, orr)
 ^
make[2]: *** [arch/arm64/kernel/asm-offsets.s] Error 1

Will
