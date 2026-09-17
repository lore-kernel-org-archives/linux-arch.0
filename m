Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2102386568;
	Thu, 17 Sep 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670664; cv=none; b=PW/8S56tzm0kO8/xAPrzN31ZhtsrfqgJtT6LETumAvYMnSp30ZmkS9UyBG+Vm/2RYQSBV/E0kqKmthX9fJDR57hZ69yvUurK0quH9Sn0SlikM+or5GzPq7d2DguQifvE2S6BCk2x0oLNCgxTOZojrKYc5t0N89/jP+VClZuTX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670664; c=relaxed/simple;
	bh=5sEXQ/TVqr6DaEgRRknTczm78ae9lTtT8E2T816euuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bh9Jko1/GuW52SDdzC2Oq9wwGvI9K91QTH1vT4DYNrQOMBFU18K8OdsS7RXO0muBTwKG1BZcDzVz/oQX+9jx+pY8mGLIt5eTC9MfG233S4TGDsfyiIXBpK6vyXHun85iIc1DJd3Xnouq5oBUzDlIc79LoKJfi+fNVZ+aBSvtvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E0YDd7yu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E0YDd7yu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35621476;
	Thu, 17 Sep 2026 11:44:18 -0700 (PDT)
Received: from [10.57.7.135] (unknown [10.57.7.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851983F86F;
	Thu, 17 Sep 2026 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789670662; bh=5sEXQ/TVqr6DaEgRRknTczm78ae9lTtT8E2T816euuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E0YDd7yuyfeafuBJmywYnkQq1vipHbvrEQ8RIdc4YF05U9+jNo+zI3jT+MUoYMCFJ
	 b2lckqmq9hm8UJswVBa7bb2bdz553UGHL+2u5LhVi+NltWwgVTz6jFqlsqj/fkPOO+
	 7rciS+Dx5sX5kfXcuhkrAbQsjC2j9cBCCyK707VQ=
Message-ID: <2817ca55-cf04-4874-bed6-8408606e1a41@arm.com>
Date: Thu, 17 Sep 2026 20:44:17 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/mm: describe set_memory() and set_direct_map() APIs
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260909-set-memory-docs-v1-1-6065d3f208e4@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260909-set-memory-docs-v1-1-6065d3f208e4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/2026 11:45, Mike Rapoport (Microsoft) wrote:
> The set_memory() and set_direct_map() APIs change permissions of existing
> kernel mappings, but their semantics are only described by the code, and
> that code differs from architecture to architecture.
>
> Add Documentation/mm/kernel-page-tables.rst that briefly describes what the
> kernel page tables consist of, defines the semantics both APIs have in
> common, including the parts that are easy to get wrong, and lists the
> differences between the architecture implementations.
>
> Add kernel-doc comments for the generic set_memory() and set_direct_map()
> stubs and link them into Documentation/core-api/mm-api.rst.
>
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for doing this Mike, I wish there had been such a document when I
started using those APIs!

Much of that document feels like an excruciating FIXME list... which is
exactly the state of set_memory/set_direct_map, and better to have it
documented than letting every new user stumble upon the same gotchas.

Overall looks good to me, some minor comments below.

> [...]
>
> +Modifying the kernel page tables
> +================================
> +
> +Except for the vmalloc area, the kernel page tables are mostly static. Still,
> +there are cases when the permissions of existing kernel mappings have to be
> +updated, for instance when a module is loaded and its text becomes read-only
> +and executable, or when a page is temporarily removed from the direct map to
> +reduce its exposure.
> +
> +There are two families of functions for this, both declared in
> +`include/linux/set_memory.h`:
> +
> +* `set_memory_*()` change permissions of an arbitrary kernel mapping. They
> +  take a kernel virtual address and the number of pages.
> +
> +* `set_direct_map_*()` change permissions of the direct map alias of a
> +  `struct page`. They take a `struct page` pointer and the number of
> +  pages.

"direct map alias of a struct page" is rather confusing, are we talking
about the mapping of struct page itself?

> +
> +Architectures that implement `set_memory()` select `CONFIG_ARCH_HAS_SET_MEMORY`
> +
> +Architectures that implement `set_direct_map()` select
> +`CONFIG_ARCH_HAS_SET_DIRECT_MAP`.
> [...]
>
> +Architecture specific differences
> +=================================
> +
> +The APIs are implemented by seven architectures and, beyond the common
> +semantics described above, their behaviour differs in several respects.
> +
> +Which of the APIs are implemented:
> +
> +=========  =====================  =========================
> +Arch       `ARCH_HAS_SET_MEMORY`  `ARCH_HAS_SET_DIRECT_MAP`
> +=========  =====================  =========================
> +arm        yes                    no
> +arm64      yes                    yes
> +loongarch  yes                    yes
> +powerpc    yes                    no
> +riscv      yes (MMU only)         yes (MMU only)
> +s390       yes                    yes
> +x86        yes                    yes
> +=========  =====================  =========================
> +
> +Only set_memory_ro(), set_memory_rw(), set_memory_x() and set_memory_nx() are
> +available everywhere, and even these are not universal: some architectures do
> +not implement any of them for the direct map, and the architectures that may

"do not implement any of them for the direct map" feels ambiguous - I
think what we really mean is that they reject direct map addresses, e.g.
what arm64 does (only accept addresses to kernel VMAs)?

> +run on hardware without an execute permission bit, like x86 and s390, silently
> +skip the update of the executable bit there.
> +
> +set_memory_rox() has a generic implementation that calls set_memory_ro() and
> +set_memory_x() in turn; PowerPC, s390 and x86 override it with a single-pass
> +version.
> +
> +Making a mapping present or not present is spelled differently: set_memory_p()
> +and set_memory_np() on x86 and PowerPC, set_memory_valid() on arm64 and arm.

I'm not sure we should even document set_memory_valid(). It doesn't at
all behave like the other set_memory_* on amr64 (no check whatsoever, no
handling of aliases) and is (fortunately) only used from arch code. I've
been meaning to make its name scarier (__set_memory_valid?) for that reason.

> +
> +The direct map and the kernel image are normally mapped with the largest
> +possible pages, and changing the permissions of a single page inside such a
> +mapping requires splitting it, which not every architecture can do.
> +
> +arm
> +---
> +
> +* Does not implement `set_direct_map()`.
> +* Provides set_memory_valid().
> +* set_memory_ro(), set_memory_rw(), set_memory_x() and set_memory_nx() accept
> +  only vmalloc and module addresses.
> +* set_memory_valid() accepts any address.
> +* Does not update mapping aliases.
> +
> +arm64
> +-----
> +
> +* Provides set_memory_valid().
> +* Provides the memory encryption helpers, which are effective only when the
> +  kernel runs as a confidential guest.
> +* set_memory_ro(), set_memory_rw(), set_memory_x() and set_memory_nx() accept
> +  only vmalloc and module addresses:
> +
> +  - the range must fit in the VM area that contains its start
> +  - the VM area must have `VM_ALLOC` set and `VM_ALLOW_HUGE_VMAP` clear
> +
> +* set_memory_valid() accepts any address.
> +* The encryption helpers accept only the direct map addresses.

s/the//

> +* Propagates the read-only and the read-write changes to the direct map alias
> +  when `rodata=full` is in effect.

That is, set_memory_<perms> propagate those changes.

> +* Splits leaf mappings before the update on the hardware that supports it.
> +  Without such support an update that covers a leaf entry only partially fails
> +  with a WARN()ing and `-EINVAL`.

What does "partially fails" mean?  The splitting may be partial, but no
permission change should occur.

> +* The `set_direct_map()` functions return 0 without doing anything when the
> +  direct map cannot be modified, see can_set_direct_map().
> +* Skips the TLB flush in `set_memory()` when the update only turns an invalid
> +  mapping into a valid one.
> +* Does not flush TLB in `set_direct_map()`.
> +
> +LoongArch
> +---------
> +
> +* Accepts only the addresses above the hardware window and silently returns
> +  success for the rest, see `Direct map`_.
> +* Does not update mapping aliases.
> +* Does not split anything: a leaf entry is updated as a whole, which changes
> +  the permissions of the entire large mapping.

Ouch!

> +* Flushes the TLB in `set_direct_map()`.
> +
> +PowerPC
> +-------
> +
> +* Does not implement `set_direct_map()`.
> +* Provides set_memory_np() and set_memory_p().
> +* Rejects huge vmalloc mappings.
> +* With the hash MMU on 64-bit systems accepts nothing but the vmalloc and the
> +  I/O regions.
> +* With the radix MMU accepts direct map addresses, but still cannot split a
> +  large mapping.
> +* Does not update mapping aliases.
> +
> +riscv
> +-----
> +
> +* Implements both APIs only when the MMU is enabled.
> +* Provides set_memory_rw_nx().
> +* The `set_memory()` functions accept any mapped kernel address, including the
> +  direct map, but a vmalloc range must have the `pages` array of its VM area
> +  populated, which rules out vmap() and ioremap() mappings.
> +* On 64-bit systems updates the direct map alias of a vmalloc range, including
> +  the executable bit.
> +* Does not split vmalloc ranges: a leaf entry is updated as a whole, which
> +  changes the permissions of the entire large mapping.
> +* Splits the direct map on 64-bit systems.
> +* Flushes the TLB in `set_direct_map()`.
> +
> +s390
> +----
> +
> +* Provides set_memory_4k(), set_memory_rwnx() and the
> +  `__set_memory_*(start, end)` variants that take a range rather than a page
> +  count.
> +* The `set_memory()` functions accept any mapped kernel address, including the
> +  direct map.
> +* Skips the update of the executable bit when the hardware has no support for
> +  it.
> +* Propagates only the read-only and read-write changes to the direct map alias
> +  of a `VM_ALLOC` area, and deliberately not the executable bit.
> +* Splits leaf PUD and PMD entries when the range is not aligned to them or when
> +  set_memory_4k() is requested.
> +* Updates the page table entries with instructions that invalidate the
> +  corresponding TLB entries, so no separate flush is needed anywhere.
> +
> +x86
> +---
> +
> +* Provides the largest set of operations on top of the common ones:
> +
> +  - the cache attribute helpers: set_memory_uc(), set_memory_wc(),
> +    set_memory_wb()
> +  - presence control: set_memory_np() and set_memory_p()
> +  - set_memory_4k()
> +  - set_memory_global() and set_memory_nonglobal()
> +  - the array variants that operate on `struct page` arrays or arrays of
> +    virtual addresses
> +  - memory encryption: set_memory_encrypted() and set_memory_decrypted()
> +
> +* The `set_memory()` functions accept any mapped kernel address, including the
> +  direct map, and silently succeed for the unmapped holes inside it.
> +* Does nothing in set_memory_x() and set_memory_nx() when the CPU has no
> +  execute permission bit.
> +* Applies the change to the direct map alias and, for the kernel image, to the
> +  high kernel mapping. The NX bit is never propagated, so that the direct map
> +  stays non-executable.

Same as above, bettermake the subject explicit (set_memory()?).

- Kevin

> +* Splits large mappings on demand and can collapse them back when the
> +  permissions become uniform again.
> +* Does not flush the TLB in `set_direct_map()`, but splitting a large
> +  mapping flushes it anyway.
>
> [...]
