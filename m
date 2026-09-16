Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737184A2E2E;
	Wed, 16 Sep 2026 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568675; cv=none; b=rqWmXUy9y8y7L6ylrCwiytUpwBtFY/BLpqa/b6QJ4fp5k5djkpbLwHHfi2wAYViU2ihf475aQQOIvDgHu9lh+LuRmHkwvICzx70w8cLOs5o4JobXEmkn7TBNOwaT8dmDi9yl6B4A0fflVDD6Yc3Jfti+JVA9S7EffsUuJApB30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568675; c=relaxed/simple;
	bh=y5EcF/bDhZcEM0MZ71FZRncO8e+ADBprizKCsXz5T/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0inzK9LSkPwrdF/xPjW5DhpbNRAAWX3eKYp9xEcHZ88sRXVuXMKfJ1XTAfGGQH2AFZRwYP8QrYKW281ZvdrkKhvgAkL5Pgu+fLDr+Df+hLydyak9EEOGf+wjqcnwBETZG1mZq+BMUKP4nvEpB5O2NnuqNfBmVHVCpXiSVwN6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XFwGhLhd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XFwGhLhd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E627C143D;
	Wed, 16 Sep 2026 07:24:28 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B2F3F7B4;
	Wed, 16 Sep 2026 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789568672; bh=y5EcF/bDhZcEM0MZ71FZRncO8e+ADBprizKCsXz5T/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFwGhLhdM0FUDVlGeDxONnYI05qsWbPanwiPxV7rUn1ovngADP+E+OqTp0JTNNG9u
	 IhD4negOLdgD55P0ZSDuKVRdVawQbCJ+TX+t/bCkZBtuigg7fOj6WvbtHalrJHIunz
	 PVs5cThOhvok9bST1s7Hk6X1unFr6OdbAAHwDidM=
Date: Wed, 16 Sep 2026 15:24:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 1/4] arm64: vdso: Prepare for robust futex unlock
 support
Message-ID: <aqqmmNTDnzT5d-ZT@J2N7QTR9R3>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-1-077707b6f1c7@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821-tonyk-robust_arm-v8-1-077707b6f1c7@igalia.com>

Hi André,

I have a few comments here; mostly minor nits.

On Fri, Aug 21, 2026 at 06:50:42PM -0300, André Almeida wrote:
> To solve the robust futex's list_pending_op clearing race condition,
> prepare for implement __vdso_futex_robust_try_unlock() for arm64 with the
> following steps:
> 
> - Create a helper function that sets the struct futex_mm_data with the
> VDSO's labels addresses. The robust futex fixup mechanism needs to
> compare the current instruction pointer to the VDSO instructions range.
> 
> - Split vdso_mremap() in vdso_mremap() and aarch32_mremap(), this allows
> the VDSO to be setup correctly regarding the instructions addresses for
> both ABIs when a mremap happens.

When I commented back on v5, I'd meant that the mremap changes should be
a separate patch. I've included a patch for that below; are you're happy
to take that as a prefix of this series?

> - Implement arch_futex_robust_unlock_get_pop() for arm64, checking for r2
> and r3 registers values for the fixup function. The role of this registers
> is explained in the commit that implement the assembly portion of the VDSO.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v6:
>  - Restructured this commit. Move the arch bits away, kept just the
>  generic/helper functions.
> 
> v4:
> - Guard symbols from vdso.lds.S with ifdef
> - drop update_ips() from sigpage remap function
> 
> v3:
>  - Fix adding vdso base addr twice
>  - Call vdso_futex_robust_unlock_update_ips() on remap as well
> v2:
>  - Fixed linker not finding VDSO symbols
> ---
> ---
>  arch/arm64/include/asm/futex_robust.h | 19 +++++++++++++++++++
>  arch/arm64/kernel/vdso.c              | 27 ++++++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/futex_robust.h b/arch/arm64/include/asm/futex_robust.h
> new file mode 100644
> index 000000000000..4ff783bb2dc3
> --- /dev/null
> +++ b/arch/arm64/include/asm/futex_robust.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_FUTEX_ROBUST_H
> +#define _ASM_ARM64_FUTEX_ROBUST_H
> +
> +#include <asm/ptrace.h>
> +
> +static __always_inline void __user *arm64_futex_robust_unlock_get_pop(struct pt_regs *regs)
> +{
> +	/*
> +	 * w3 stores the result of the stlxr instruction. If it's zero, the then
> +	 * the ll/sc cmpxchg succeeded and the pending op pointer needs to be cleared.
> +	 */

It would be good if the comment could refer to the functions with the
critical sections, e.g.

	/*
	 * In the asm for __vdso_futex_robust_list{64,32}_try_unlock(), ...
	 */

That way it will be easier for folk to cross-reference this later.

> +	return (regs->user_regs.regs[3]) ? NULL : (void __user *) regs->user_regs.regs[2];

You can use 'regs->regs[n]' in place of 'regs->user_regs.regs[n]' here,
which will make this a bit shorter and easier to read.

I reckon this might also be clearer as:

| 	if (regs->regs[3])
| 		return NULL;
| 	
| 	return (void __user *)regs->regs[2];

Do we need a __force cast here, or is sparse happy without that?

> +}
> +
> +#define arch_futex_robust_unlock_get_pop(regs) \
> +	arm64_futex_robust_unlock_get_pop(regs)
> +
> +#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 592dd8668de4..3ef331b5b240 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -11,6 +11,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/elf.h>
>  #include <linux/err.h>
> +#include <linux/futex.h>
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
> @@ -57,6 +58,22 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
>  #endif /* CONFIG_COMPAT_VDSO */
>  };
>  
> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
> +static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit, void *startp,
> +					   void *endp)
> +{
> +	unsigned long start = (unsigned long) startp;
> +	unsigned long end = (unsigned long) endp;

Nit: there shouldn't be a space between the cast and the expression:

	unsigned long start = (unsigned long)startp;
	unsigned long end = (unsigned long)endp;

> +	struct futex_mm_data *fd = &mm->futex;
> +
> +	futex_set_vdso_cs_range(fd, is_32bit ? 1 : 0, start, end, is_32bit);

On arm64 (and every architecture other than x86, AFAICT), the
native/compat VDSOs are mutually exclusive, and a single mm can only
have one of them.

Given that, I think we can make this:

	futex_set_vdso_cs_range(fd, 0, start, end, is_32bit);

That way we'll avoid confusing/bikesheeding over 'is_32bit ? 1 : 0',
without having to add mnemnonics for the native/compat CS indices.

That said, what's the plan for 32-bit robust lists on a 64-bit host?
IIUC you wanted that for emulation, and AFAICT you have no way to call
__vdso_futex_robust_list32_try_unlock() from a native task.

> +}
> +
> +#else
> +static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit, void *startp,
> +					   void *endp)
> +#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
> +
>  static int vdso_mremap(const struct vm_special_mapping *sm,
>  		struct vm_area_struct *new_vma)
>  {
> @@ -162,6 +179,14 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
>  	return 0;
>  }
>  
> +static int aarch32_mremap(const struct vm_special_mapping *sm,
> +		struct vm_area_struct *new_vma)
> +{
> +	current->mm->context.vdso = (void *)new_vma->vm_start;
> +
> +	return 0;
> +}
> +
>  static struct vm_special_mapping aarch32_vdso_maps[] = {
>  	[AA32_MAP_VECTORS] = {
>  		.name	= "[vectors]", /* ABI */
> @@ -174,7 +199,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
>  	},
>  	[AA32_MAP_VDSO] = {
>  		.name = "[vdso]",
> -		.mremap = vdso_mremap,
> +		.mremap = aarch32_mremap,
>  	},
>  };

As above, I'd prefer if the mremap changes were a separate patch, e.g.
as below.

Mark.

---->8----
From 39029dfea82a54bd7b511cc036d10ef8e8ee4ccd Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 16 Sep 2026 11:03:32 +0100
Subject: [PATCH] arm64: vdso: Split native/compat mremap callbacks

Currently the native and compat VDSOs share a common vdso_mremap()
function which is used as their vm_special_mapping::mremap callback.

In subsequent patches the native and compat VDSOs will need distinct
mremap logic, which will be easier to manage with separate functions.

Give the compat VDSO its own aarch32_vdso_mremap() function. For now
this is identical to vdso_mremap().

At the same time, fix the odd whitespace in the vdso_mremap() prototype.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/vdso.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 592dd8668de46..089a70d962204 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -58,7 +58,7 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 };
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
+		       struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
@@ -162,6 +162,14 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+			       struct vm_area_struct *new_vma)
+{
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
 static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VECTORS] = {
 		.name	= "[vectors]", /* ABI */
@@ -174,7 +182,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
+		.mremap = aarch32_vdso_mremap,
 	},
 };
 
-- 
2.30.2

