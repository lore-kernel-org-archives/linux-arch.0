Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316F2D73BD
	for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460035; cv=none; b=qVVf0mMQVOfMU9xwA05wfdplvvWZl+rpD1v3F0jsY3I0aH5ehskSBStl3UYpgY/guiuhewmLs5YwrLdth75//WKKD+msexIkAB5wBIg9WZE1xRWsyVzdaWLtgn9G4uj5STTgUOphNw+MSeVjvxWBPuGrKAIed+bWbAKdGiLb3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460035; c=relaxed/simple;
	bh=aoGpvrsYD8w5a452qvKD8qfj7v0SBwYk6GvPHlbXAj4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWltkHIf2ZklUeT6QBMbJfZt6vDuyQly/zZwJggKyKeneYlalgpf+s55XU0yqVybH9Skw/iYOpNh0uwVrgPqO1iaYCWhi2B5Gg+OHbEkC0B7ZM+OiWfhC7Pcy07GDw1CjrPtkR/XqIbxCH+rvNSNdA/79VmZ99As5h2HtAgd97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=M9u6mR3/; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="M9u6mR3/"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b74f839bdfso1544693eec.1
        for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 12:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1769460031; x=1770064831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUBpOm0QvKE2389W2MiwDwXvLMg/CnIs37/EZYwRaJU=;
        b=M9u6mR3/aNK8BZmBX78WRAbvwN6YX+AmG7e/U+MCt8zXKX1hABGR7GOGFerBOXgjZX
         77/CVaYNuKSne6efVmMpmK+r+QQdDY2SzRWBMaogGde05d4ZyQmWmMfdavW7+M1fSmdl
         g0F4nSB2D+NWEb7n4HSJOZUTbT0PrY/zD5giiSQns9V4Cuu4eWsyymBYrq0D8CxWDXY8
         eaDPWrkOwbiB0Iukb/pte+2ncblEALdrNUbm7ImZktGVZjzquWfB/mhaCPL29vnyAWQm
         v3nRGDzCeYlc3rShPpFbmwuZAPuk/xNUCrv7u4OmGEtpPAJPyhY3ABcNashxgffl+32X
         2niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460031; x=1770064831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EUBpOm0QvKE2389W2MiwDwXvLMg/CnIs37/EZYwRaJU=;
        b=EhFhs3UWzL4hX8zIjKofqYpWttgw26whXZNJPZ1nuOox1DcMCXH2XZx9Nr4FGR0nMm
         ZUAGbEunPbJYCVCPmml6Bz9ZajFN0Xa+TvQaELmt492q3VpicSQZeT9j35QGusGtweHK
         rJ5EfdtZpX5lSZnGegtNR+rvtqcmWXpZRHJnbRukwOVlR0CN2hFGt/i+6eBnjTpz5/py
         7HFHghGQYyVouHZaWp3RQ1JKE4cLIaOnOIpAoUmVIZiLAQoOKQruNdrmGwoPYwmfp59S
         vzpi7IdZ5iT0/Pd0enMSBcrszlAejJEgVvGAC6cOWV/dW+9xEPDi/q97qOtU8/5swUlC
         i8tg==
X-Forwarded-Encrypted: i=1; AJvYcCUBSCudUf/yVD4oR8cnZqTT8MAg+TyGbkY3XySTS19Zvw5XjRx5qSRjJq+/yUR72YBqN4lLRfAXi7YP@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjg0l0jg8zf54B9pqGjR9lfsn3gOAwS1wKDvUZvF2bhMJgs0e
	FZGHmK4GH0EP9ypjBYVJKSs23Cy1fyldhK2yyfSh+uPLDflhDcTTf04GuarXURxrjcs=
X-Gm-Gg: AZuq6aIevEe8pBCOdaIBFpoOaJIOOwnln5L7UISpRzPoPaYIiKd3PwUF5TeTWnJgzAe
	LxosjhpdssWJk3AU3enS7oybufaOB43O4I011NuWcbbU95bxedga8iCS+zM68/wqhossMZY541R
	3uOtcK51JIHlHvTrhy7W7PxrsGDEWU54QOrx8Xa4m1EGE3XBhUXRoUt0i2TK1lRPdIH4hqORwhC
	Kh1+Ht4g0hkCBXHiqxzuc89S7SWsG4q2MzX3qdOoQJDuauBqtG0p/JbOY6t5rOmgrU1yRooRYnC
	z7yM0yD6aoPwIAJy76JCJ1GllgX/+0Hp7oKrbyt0j+w2GIrUN4yaaM0ugmSvmWDGi6tiSD5Uf+T
	/GvyecwZONHtObXaenjUFOZLwsgNVmpgSnfgiZ6gQZ9YIKFT5FmG9DXzsIWuLs4+g2ntxE22hti
	bE9kiCmnyXzSoduyvvUCms6WMQ3eSRExc=
X-Received: by 2002:a05:693c:6218:b0:2ae:5a2e:de70 with SMTP id 5a478bee46e88-2b7638d6573mr2604064eec.8.1769460031398;
        Mon, 26 Jan 2026 12:40:31 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa03fd0sm15037214eec.23.2026.01.26.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:40:30 -0800 (PST)
Date: Mon, 26 Jan 2026 12:40:28 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v26 10/28] riscv/mm: Implement map_shadow_stack() syscall
Message-ID: <aXfRPJvoSsOW8AwM@debug.ba.rivosinc.com>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <20251211-v5_user_cfi_series-v26-10-f0f419e81ac0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251211-v5_user_cfi_series-v26-10-f0f419e81ac0@rivosinc.com>

Hi Paul/Zong,

Can you apply following diff on `allocate_shadow_stack` function in this patch.
This fixes the bug that I earlier mentioned. We shouldn't be returning location
to token and instead return base address of shadow stack. Userspace consumer
should be determining token location itself. This matches the ABI of other
arches. Sorry for being late on this.

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 27b36034ea85..a8530e6afb1e 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -232,7 +232,7 @@ static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long siz
  {
         int flags = MAP_ANONYMOUS | MAP_PRIVATE;
         struct mm_struct *mm = current->mm;
-       unsigned long populate, tok_loc = 0;
+       unsigned long populate;

         if (addr)
                 flags |= MAP_FIXED_NOREPLACE;
@@ -245,13 +245,11 @@ static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long siz
         if (!set_tok || IS_ERR_VALUE(addr))
                 goto out;

-       if (create_rstor_token(addr + token_offset, &tok_loc)) {
+       if (create_rstor_token(addr + token_offset, NULL)) {
                 vm_munmap(addr, size);
                 return -EINVAL;
         }

-       addr = tok_loc;
-
  out:
         return addr;
  }

On Thu, Dec 11, 2025 at 09:20:43AM -0800, Deepak Gupta via B4 Relay wrote:
>From: Deepak Gupta <debug@rivosinc.com>
>
>As discussed extensively in the changelog for the addition of this
>syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>existing mmap() and madvise() syscalls do not map entirely well onto the
>security requirements for shadow stack memory since they lead to windows
>where memory is allocated but not yet protected or stacks which are not
>properly and safely initialised. Instead a new syscall map_shadow_stack()
>has been defined which allocates and initialises a shadow stack page.
>
>This patch implements this syscall for riscv. riscv doesn't require token
>to be setup by kernel because user mode can do that by itself. However to
>provide compatibility and portability with other architectues, user mode
>can specify token set flag.
>
>Reviewed-by: Zong Li <zong.li@sifive.com>
>Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
>Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>---
> arch/riscv/kernel/Makefile  |   1 +
> arch/riscv/kernel/usercfi.c | 142 ++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 143 insertions(+)
>
>diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>index f60fce69b725..2d0e0dcedbd3 100644
>--- a/arch/riscv/kernel/Makefile
>+++ b/arch/riscv/kernel/Makefile
>@@ -125,3 +125,4 @@ obj-$(CONFIG_ACPI)		+= acpi.o
> obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
>
> obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
>+obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
>diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>new file mode 100644
>index 000000000000..251c3faccbf8
>--- /dev/null
>+++ b/arch/riscv/kernel/usercfi.c
>@@ -0,0 +1,142 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (C) 2024 Rivos, Inc.
>+ * Deepak Gupta <debug@rivosinc.com>
>+ */
>+
>+#include <linux/sched.h>
>+#include <linux/bitops.h>
>+#include <linux/types.h>
>+#include <linux/mm.h>
>+#include <linux/mman.h>
>+#include <linux/uaccess.h>
>+#include <linux/sizes.h>
>+#include <linux/user.h>
>+#include <linux/syscalls.h>
>+#include <linux/prctl.h>
>+#include <asm/csr.h>
>+#include <asm/usercfi.h>
>+
>+#define SHSTK_ENTRY_SIZE sizeof(void *)
>+
>+/*
>+ * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
>+ * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
>+ * shadow stack. To keep it simple, we plan to use `ssamoswap` to perform writes on shadow
>+ * stack.
>+ */
>+static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
>+{
>+	/*
>+	 * Never expect -1 on shadow stack. Expect return addresses and zero
>+	 */
>+	unsigned long swap = -1;
>+
>+	__enable_user_access();
>+	asm goto(".option push\n"
>+		".option arch, +zicfiss\n"
>+		"1: ssamoswap.d %[swap], %[val], %[addr]\n"
>+		_ASM_EXTABLE(1b, %l[fault])
>+		".option pop\n"
>+		: [swap] "=r" (swap), [addr] "+A" (*addr)
>+		: [val] "r" (val)
>+		: "memory"
>+		: fault
>+		);
>+	__disable_user_access();
>+	return swap;
>+fault:
>+	__disable_user_access();
>+	return -1;
>+}
>+
>+/*
>+ * Create a restore token on the shadow stack.  A token is always XLEN wide
>+ * and aligned to XLEN.
>+ */
>+static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>+{
>+	unsigned long addr;
>+
>+	/* Token must be aligned */
>+	if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
>+		return -EINVAL;
>+
>+	/* On RISC-V we're constructing token to be function of address itself */
>+	addr = ssp - SHSTK_ENTRY_SIZE;
>+
>+	if (amo_user_shstk((unsigned long __user *)addr, (unsigned long)ssp) == -1)
>+		return -EFAULT;
>+
>+	if (token_addr)
>+		*token_addr = addr;
>+
>+	return 0;
>+}
>+
>+static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
>+					   unsigned long token_offset, bool set_tok)
>+{
>+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>+	struct mm_struct *mm = current->mm;
>+	unsigned long populate, tok_loc = 0;
>+
>+	if (addr)
>+		flags |= MAP_FIXED_NOREPLACE;
>+
>+	mmap_write_lock(mm);
>+	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
>+		       VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
>+	mmap_write_unlock(mm);
>+
>+	if (!set_tok || IS_ERR_VALUE(addr))
>+		goto out;
>+
>+	if (create_rstor_token(addr + token_offset, &tok_loc)) {
>+		vm_munmap(addr, size);
>+		return -EINVAL;
>+	}
>+
>+	addr = tok_loc;
>+
>+out:
>+	return addr;
>+}
>+
>+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>+{
>+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
>+	unsigned long aligned_size = 0;
>+
>+	if (!cpu_supports_shadow_stack())
>+		return -EOPNOTSUPP;
>+
>+	/* Anything other than set token should result in invalid param */
>+	if (flags & ~SHADOW_STACK_SET_TOKEN)
>+		return -EINVAL;
>+
>+	/*
>+	 * Unlike other architectures, on RISC-V, SSP pointer is held in CSR_SSP and is available
>+	 * CSR in all modes. CSR accesses are performed using 12bit index programmed in instruction
>+	 * itself. This provides static property on register programming and writes to CSR can't
>+	 * be unintentional from programmer's perspective. As long as programmer has guarded areas
>+	 * which perform writes to CSR_SSP properly, shadow stack pivoting is not possible. Since
>+	 * CSR_SSP is writeable by user mode, it itself can setup a shadow stack token subsequent
>+	 * to allocation. Although in order to provide portablity with other architecture (because
>+	 * `map_shadow_stack` is arch agnostic syscall), RISC-V will follow expectation of a token
>+	 * flag in flags and if provided in flags, setup a token at the base.
>+	 */
>+
>+	/* If there isn't space for a token */
>+	if (set_tok && size < SHSTK_ENTRY_SIZE)
>+		return -ENOSPC;
>+
>+	if (addr && (addr & (PAGE_SIZE - 1)))
>+		return -EINVAL;
>+
>+	aligned_size = PAGE_ALIGN(size);
>+	if (aligned_size < size)
>+		return -EOVERFLOW;
>+
>+	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
>+}
>
>-- 
>2.43.0
>
>
