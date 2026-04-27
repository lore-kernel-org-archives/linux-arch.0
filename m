Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516123D9048;
	Mon, 27 Apr 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308520; cv=none; b=ade0MHX0/KQ3S6t8J7jCkQdGAS143aeff3ItOeHgphie/lIgTVkiZ/ws4cE3Rbb3wz5CcvjOLSo3nwjDrLlo6aYCnZkw318BmC8yApekxKdVI637l/LYzRlUl+vFID+hLeBp7h59pRRKp+BePuzrsVlMvbH+dFEPSse3ecFwx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308520; c=relaxed/simple;
	bh=sVSZw7rfv3RZEveFHpTPIrQUrZzIlZFJ2lOEnjhGaOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYOMLlYtFmub+t5rry7Y+RasOcZo3LRlBjvOfJP+S4j2lPZe/cDBd7GWAT8vc4phIVL2itPXEnAGNq8As8351BNLXio9vFbAB9iA/RS/OH09NxphyuULbmcag+1p38UiRvEBHZSxHOV2vby8BrS2lHxG5PyM6oNPsWxFYJWUTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=r7BABrsf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="r7BABrsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777308517;
	bh=sVSZw7rfv3RZEveFHpTPIrQUrZzIlZFJ2lOEnjhGaOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7BABrsfQ2uuA4PfuCAalkA8RIWxwiI/xlrM6PT+weF6In/uOapTCbMNKPQxCGDXL
	 rR3mx8nweJNBcNfWy+MF0jEQpwyLfE2oz82yCdKm7RGNacFzfYiTO0bxCZfdCzQpSy
	 08bWJNE+jPaGpmL2F6BHE9JvOhEhRZYJJ+BdQ9WM=
Date: Mon, 27 Apr 2026 18:48:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Carlos O'Donell <carlos@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
	Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>, 
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Uros Bizjak <ubizjak@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH RFC v2 2/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <0e1ff958-8550-4380-99c7-499a4ad511a4@t-8ch.de>
References: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
 <20260424-tonyk-robust_arm-v2-2-db4e46f752cf@igalia.com>
 <7ddc1c74-c504-44c6-8d51-d10d436c0db8@t-8ch.de>
 <f14b2297-9b6b-46a6-ac9c-57377aaf9031@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f14b2297-9b6b-46a6-ac9c-57377aaf9031@igalia.com>

On 2026-04-27 13:26:41-0300, André Almeida wrote:
> Em 26/04/2026 15:30, Thomas Weißschuh escreveu:
> > On 2026-04-24 15:56:01-0300, André Almeida wrote:
> > (...)
> > 
> > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > ---
> > > RFC:
> > >   - Should I duplicate the explanation found in the x86 commit or can I just
> > >   point to it?
> > >   - Only LL/SC for now but I can add LSE later if this looks good
> > >   - It the objdump I see that op_pending is store at x2. But how stable is this,
> > >   how can I write it in a way that's always x2?
> > > ---
> > >   arch/arm64/Kconfig                                 |  1 +
> > >   arch/arm64/include/asm/futex_robust.h              | 35 +++++++++++++
> > >   arch/arm64/kernel/vdso/Makefile                    |  9 +++-
> > >   arch/arm64/kernel/vdso/vdso.lds.S                  |  4 ++
> > >   .../kernel/vdso/vfutex_robust_list_try_unlock.c    | 59 ++++++++++++++++++++++
> > >   5 files changed, 107 insertions(+), 1 deletion(-)
> > 
> > What about the actual 32-bit vDSO in arch/arm64/kernel/vdso32/ ?
> > 
> 
> Right, I missed that. Then I should move
> __vdso_futex_robust_list32_try_unlock() to arch/arm64/kernel/vdso32/ right?

Are 64-bit processes supposed to have the list32 variant already?
If so, you need this function, *with the same name* in both vDSOs.
In any case for the 32-bit vDSO you'll need to extend the build system
to create a vdso32-offsets.h. If you have the list32 variant twice, use
differently named VDSO{,32}_ constants to refer to them from kernel code.

> > (...)
> > 
> > > diff --git a/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
> > > new file mode 100644
> > > index 000000000000..e8a8fb22a2fa
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
> > > @@ -0,0 +1,59 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +#include <vdso/futex.h>
> > > +#include <linux/stringify.h>
> > > +
> > > +#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)
> > 
> > We should have some defines for these symbols. While they are not
> > userspace ABI, they will be used by the selftests.
> > 
> 
> Do you mean to have this defined at include/uapi/linux/futex.h?

No, they are not UAPI. It should go into include/vdso/futex.h.

> > > +#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
> > > +
> > > +__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
> > > +{
> > > +	__u32 val, result;
> > > +
> > > +	asm volatile (
> > > +		GLOBLS(64)
> > > +		"	prfm pstl1strm, %[lock]			\n"
> > > +		LABEL(start, 64)":				\n"
> > > +		"	ldxr %[val], %[lock]			\n"
> > > +		"	cmp %[tid], %[val]			\n"
> > > +		"	bne " LABEL(end, 64)"			\n"
> > > +		"	stlxr %w[result], xzr, %[lock]		\n"
> > > +		"	cbnz %w[result], " LABEL(start, 64)"	\n"
> > > +		LABEL(success, 64)":				\n"
> > > +		"	str xzr, %[pop]				\n"
> > > +		LABEL(end, 64)":				\n"
> > > +
> > > +		: [val] "=&r" (val), [result] "=r" (result)
> > > +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
> > > +		: "memory"
> > > +	);
> > 
> > My clang 22.1.3 chokes on the assembly in this patch.
> > 
> 
> Do you mind sharing the output?

arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:26:18: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
   26 |                 : [val] "=&r" (val), [result] "=r" (result)
      |                                ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:17:10: note: use constraint modifier "w"
   17 |                 "       ldxr %[val], %[lock]                    \n"
      |                              ^~~~~~
      |                              %w[val]
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:27:16: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
   27 |                 : [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
      |                              ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:18:9: note: use constraint modifier "w"
   18 |                 "       cmp %[tid], %[val]                      \n"
      |                             ^~~~~~
      |                             %w[tid]
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:26:18: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
   26 |                 : [val] "=&r" (val), [result] "=r" (result)
      |                                ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:18:17: note: use constraint modifier "w"
   18 |                 "       cmp %[tid], %[val]                      \n"
      |                                     ^~~~~~
      |                                     %w[val]
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:40:3: error: invalid operand in inline asm: '.globl __futex_list32_try_unlock_cs_start, __futex_list32_try_unlock_cs_success, __futex_list32_try_unlock_cs_end
	prfm pstl1strm, $3			
__futex_list32_try_unlock_cs_start:				
	ldxr ${0:w}, $3			
	cmp ${2:w}, ${0:w}			
	bne __futex_list32_try_unlock_cs_end			
	stlxr ${1:w}, wzr, ${3:w}		
	cbnz ${1:w}, __futex_list32_try_unlock_cs_start	
__futex_list32_try_unlock_cs_success:				
	str wzr, ${4:w}			
__futex_list32_try_unlock_cs_end:				
'
   40 |                 GLOBLS(32)
      |                 ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:7:20: note: expanded from macro 'GLOBLS'
    7 | #define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
      |                    ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:40:3: error: invalid operand in inline asm: '.globl __futex_list32_try_unlock_cs_start, __futex_list32_try_unlock_cs_success, __futex_list32_try_unlock_cs_end
	prfm pstl1strm, $3			
__futex_list32_try_unlock_cs_start:				
	ldxr ${0:w}, $3			
	cmp ${2:w}, ${0:w}			
	bne __futex_list32_try_unlock_cs_end			
	stlxr ${1:w}, wzr, ${3:w}		
	cbnz ${1:w}, __futex_list32_try_unlock_cs_start	
__futex_list32_try_unlock_cs_success:				
	str wzr, ${4:w}			
__futex_list32_try_unlock_cs_end:				
'
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:7:20: note: expanded from macro 'GLOBLS'
    7 | #define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
      |                    ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:46:4: error: unknown token in expression
   46 |                 "       stlxr %w[result], wzr, %w[lock]         \n"
      |                  ^
<inline asm>:7:19: note: instantiated into assembly here
    7 |         stlxr w9, wzr,          
      |                                 ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:46:4: error: invalid operand
   46 |                 "       stlxr %w[result], wzr, %w[lock]         \n"
      |                  ^
<inline asm>:7:19: note: instantiated into assembly here
    7 |         stlxr w9, wzr,          
      |                                 ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:49:4: error: unknown token in expression
   49 |                 "       str wzr, %w[pop]                        \n"
      |                  ^
<inline asm>:10:14: note: instantiated into assembly here
   10 |         str wzr,                        
      |                                         ^
arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c:49:4: error: invalid operand
   49 |                 "       str wzr, %w[pop]                        \n"
      |                  ^
<inline asm>:10:14: note: instantiated into assembly here
   10 |         str wzr,                        
      |                                         ^
3 warnings and 6 errors generated.

> > > +
> > > +	return val;
> > > +}
> > > +
> > > +#ifdef CONFIG_COMPAT_VDSO
> > 
> > I am wondering about the CONFIG_COMPAT{,_VDSO} dependency here.
> > As far as I know the list32 variant is meant to be used by code
> > emulators which run 32-bit code on a 64-bit kernel, for example FEX.
> > But these emulators don't actually seem to need CONFIG_COMPAT.
> > So the dependency does not look correct.
> > The space savings also should be irrelevant.
> 
> Right, good catch. In the new syscall I had to do something similar[1], to
> expose the 32-bit functions to 64-bit kernels as well, and not hide them
> behind CONFIG_COMPAT.
> 
> [1] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-2-05fea005a0fd@igalia.com/

If the regular system calls don't currently support a 32-bit robust list
on 64-bit systems I am wondering why tglx added them to the x86_64 vDSO.
They seem pointless for now. Maybe to be ready for your series?

Also on x86_64, if wine WoW64 should end up using the 32-bit robust list
from a 64-bit process, the CONFIG_COMPAT dependency looks incorrect.

> > The x86 series from Thomas does the same, maybe he will read this
> > comment, otherwise I'll bring it up on his series, too.
> > 
> > > +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
> > > +{
> > > +	__u32 val, result;
> > > +
> > > +	asm volatile (
> > > +		GLOBLS(32)
> > > +		"	prfm pstl1strm, %[lock]			\n"
> > > +		LABEL(start, 32)":				\n"
> > > +		"	ldxr %w[val], %[lock]			\n"
> > > +		"	cmp %w[tid], %w[val]			\n"
> > > +		"	bne " LABEL(end, 32)"			\n"
> > > +		"	stlxr %w[result], wzr, %w[lock]		\n"
> > > +		"	cbnz %w[result], " LABEL(start, 32)"	\n"
> > > +		LABEL(success, 32)":				\n"
> > > +		"	str wzr, %w[pop]			\n"
> > > +		LABEL(end, 32)":				\n"
> > > +
> > > +		: [val] "=&r" (val), [result] "=r" (result)
> > > +		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
> > > +		: "memory"
> > > +	);
> > > +
> > > +	return val;
> > > +}
> > > +#endif
> 
