Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81698480977
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040386; cv=none; b=b2SPfwBNsbsvbpYBGdCJMFjoxutuz9glaSsPNReCEvpF0k649IdfniIvd6OvTJNZ+1OzZ8fKWKHX0yWmM7crhfpeIFow9M1vVUh202mvMYgcqSRzlAmV8D8hmoN5xi1YWQxNaAEL9ZdE/lqKl5sx2GGug+U/H2L2OQh4H1PHXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040386; c=relaxed/simple;
	bh=AUTivevuHT+LWNN5BHW9UosmFAPBokuOor74liBDnJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSPonova4Ql4gp0jZWkyB4i31kecIQ2LwLJfLh0gciicf44NPJET5TVBQKKJE8GbGvnStOZa2oVpqeqEvZdl4++HDo5y2po5UNzxfXmW6aueL2hUu3LD1RTvVzABqSUzgIz6aAl4YVF6AiDQam5pdkDsR5WDuxUxI3LTQJvmbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TR61+wVz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TR61+wVz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso2580916f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784040370; x=1784645170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HIZ7KFcyUDy5zuN+gTCldgqin/H/XZMtG/RCojCl6M=;
        b=TR61+wVz50yOzm/LzPn9bIXnHgS8C/VwYWHEDmoQ0CBFXscULQJzZL7noZGnB8Fpce
         zmON3CjnXpsnajtGU+m28/lexwooCR5pqxteTbhgH2DCNEFUndKykaGaAdBJiVpPpcYB
         qNCo/REOLiE5TSUC4YWRnlwSY6woOFltNi2O4+H98nYTE8JXlIf514aIA9D2cJXcs4tJ
         CYLqtrURQXaVDocy+IkiKFjAPhULk8eOST0BhvLXH6JpCwXFR/arKR9pZP3UV7txlbp9
         4BbIW/wj025Jn51eji1C/61nVNe0ksq0M06r8wQFOPaT3PoCTl/2lvvsJNgetlBpkUFh
         Iv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040370; x=1784645170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HIZ7KFcyUDy5zuN+gTCldgqin/H/XZMtG/RCojCl6M=;
        b=bRXo+9/o0B8BtlcJ6U6Vk5QCeenrsSbU45WU2bJ6JgCEIhdQe7Nh2jV0gHa0+/axlU
         PIESQbppJNb0Fr7GnyCvMSBWzB9hxn0iiOhVBNdQ6+a9k2B0QKoPuzQvTkElmj3tyzvz
         pFtUFHPkD3grKtjWj581S5RZ9YTzMJT7KqLfzNAWl1v3QyKZCBvv7LBnS18311lPXQAd
         v71KUkPvPsyx3oou94c4hgE8ed/EgtO+LKdAGPUzbotb3jUcaQM3OfURaCMO/xzYhZ2n
         wj1OEn8wu4Baf3FuH0ipwyji1tocmM/8TXirQSDe5OHI8MREj3/2MeIgoSYj8xllJwE8
         nHsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqhp9dccD8W+ASu4W5kFOc5LKoPiMGQc8XZGyEjhcrGko3jnFwNWs86AH1l8TD1ZbyGGe9cGPLsZgOk@vger.kernel.org
X-Gm-Message-State: AOJu0YyToiq8LiQPNg/LMicB2Gax2X4sDYtbE5+dj1QnMlpVD7T6IY9T
	7P1almz24sfiYfJZkz13R+B5yvSEO6jkFJlnsGMwhB/dcZCiCxd3ZErx3xo3zY4KxN6V1pOKEZ+
	3EK6jMH8=
X-Gm-Gg: AfdE7cnVAJi4UqZtq/ksH53d5afiKsJeLgqwUTzQlTYtSMW14WHrIrAIRsOpuWJKub7
	DZ6wDht1APrJ9mRc0N1lio8q5rL4NRIJcY1AeOonBUd7HH0o8t0s7zqOchtQX22fluuiqKMHFNd
	cjpX4le/3SNlM2TDcfHrV26f8L58KjGQsSWkK6/FI949EbAA9QTVUcchconPvhRc5xJvSw1SoGJ
	BV3CCPy21e0QuRy0w1en0sZ96HeQYA0EllATnlOg7xV4S1xFdKs5i28BnMlKB/ROIv8mfafCzNC
	wJS56MwlrRuhR8vz7ZVur/WQ+1fMXI3Z7U6SOgH8inna230Yl89/074gMomoUz2oTrblHBf60hE
	X30a5FmbG7kEE79Zw2l4tcClMRqyWdakDSDU45ADV5oOPDtZvaK3W0eA0ISdginWtEqQg0KHEuE
	7RkOhTteFYd8W98xOFOyaBUFOJ8gZvSMBflw==
X-Received: by 2002:a05:6000:250e:b0:46e:37a6:c762 with SMTP id ffacd0b85a97d-47f2dced15emr14731137f8f.32.1784040369853;
        Tue, 14 Jul 2026 07:46:09 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a940sm8424256f8f.12.2026.07.14.07.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 07:46:09 -0700 (PDT)
Message-ID: <7a946c5a-5bad-4e10-8633-0d593f3ab5a7@suse.com>
Date: Tue, 14 Jul 2026 16:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in
 modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, peterz@infradead.org, akpm@linux-foundation.org,
 mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io,
 chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708020007.55728-1-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260708020007.55728-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 4:00 AM, Aaron Tomlin wrote:
> Currently, the "module_blacklist=" command-line parameter only applies
> to loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch extends the blacklisting functionality to built-in
> modules by intercepting their initialisation routines during early boot.
> 
> To preserve the existing user-space ABI, "module_blacklist=" is kept
> as a legacy alias pointing to the same module_denylist variable.
> 
> To achieve this, we introduce a new ".initcall.modnames" memory section.
> For each built-in module, we use a standard C structure (i.e., struct
> initcall_modname) to map its initcall function pointer to its associated
> KBUILD_MODNAME string.
> 
> During boot, do_one_initcall() cross-references the initcall function
> pointer against this table. If a match is found and the module is
> present in the denylist, the initcall is skipped.
> 
> To make the denylist functional on monolithic kernels, the command-line
> parameter parsing and the module_is_denylisted() lookup function are
> decoupled from the loadable module subsystem and moved to init/main.c.
> This enables "module_denylist=" and "module_blacklist=" to intercept
> built-in modules even on kernels built with CONFIG_MODULES=n.
> 
> Design Considerations and Trade-offs:
> 
>     1.  LTO and CFI Compatibility vs. PREL32
> 
>         Previous iterations of this patch attempted to use top-level
>         inline assembly to generate 32-bit relative offsets (PREL32) to
>         save memory. However, raw inline assembly operates blindly
>         outside of the C compiler's visibility. When compiled with
>         CONFIG_LTO_CLANG or CONFIG_CFI_CLANG, the compiler applies
>         symbol renaming and generates Control Flow Integrity stubs.
>         The raw assembly string-matching fails to track these changes,
>         resulting in undefined references or runtime address mismatches.
> 
>         To resolve this, we strictly use standard C structures to hold
>         the function pointers. This natively allows the compiler to
>         resolve LTO renaming and map CFI stubs correctly. We trade the
>         minor spatial optimisation of PREL32 (using absolute 64-bit
>         pointers instead) to guarantee architectural safety under modern
>         compiler protections. Because this metadata is placed in an
>         ".init" section and freed entirely after boot, the temporary
>         memory overhead is negligible.
> 
>     2.  Prevention of UAF (Use-After-Free) via temporal and spatial
>         boundaries:
> 
>         Because do_one_initcall() is a shared path invoked by both the
>         early boot process and runtime module loading (i.e.,
>         do_init_module()), we must prevent loadable modules from
>         attempting to scan the ".initcall.modnames" section after it has
>         been reclaimed by free_initmem().
> 
>         To ensure safety, we employ a two-fold validation check:
>         - A temporal check using 'system_state >= SYSTEM_FREEING_INITMEM'
>           to immediately return NULL once init memory is freed.
>         - A spatial check using 'is_kernel_text()' and
>           'is_kernel_inittext()' to confirm the function resides in core
>           kernel text.
> 
>         Since dynamically loaded modules reside in separately allocated
>         module memory outside these ranges, they bypass the table lookup
>         entirely. This makes the lookup lockless, race-free, and safe
>         from UAF vulnerabilities.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> Changes since v3:
> 
>  - Renamed the external function prototype and internal helper to
>    module_is_denylisted(), while updating the backing variable in
>    main.c to module_denylist. To preserve user-space compatibility
>    while adopting modern terminology, separate core_param entries have
>    been introduced, allowing both the preferred module_denylist=
>    parameter and the legacy module_blacklist= parameter to resolve to
>    the same underlying variable (Andrew Morton)
> 
>  - I introduced the __initcall_fn_ptr() macro helper to dynamically
>    resolve the initcall pointer configuration:
>     - For architectures with relative 32-bit relocations
>       (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y), it resolves to the
>       relocation stub pointer  __initcall_stub(fn, __iid, id)
>     - For architectures without PREL32 relocations, it resolves
>       directly to the function pointer fn
> 
>  - Decoupled the module_denylist parameter parsing and the
>    module_is_denylisted() function from CONFIG_MODULES, moving the
>    logic to init/main.c. This ensures the denylist works for built-in
>    modules even on monolithic kernels built without loadable module
>    support (CONFIG_MODULES=n)
> 
>  - Removed the conditional stub implementation of
>    module_is_denylisted() in module.h and replaced it with a single,
>    unconditional declaration outside of the #ifdef CONFIG_MODULES block.
>    This prevents compiler warnings about missing prototypes and ensures
>    visibility under a monolithic configuration
> 
>  - Replaced the initmem_freed state variable and its synchronisation
>    logic in kernel_init() with race-free spatial boundary checks using
>    is_kernel_text() and is_kernel_inittext() in initcall_get_modname()
> 
>  - Aligned the .initcall_modnames table with relocations by assigning
>    .initcall_fn using the __initcall_stub() helper in
>    ___define_initcall(). This ensures the lookup matches the actual stub
>    pointer passed to do_one_initcall() when
>    CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is enabled. Passed the preprocessor
>    __iid argument to ____define_initcall_modname once to avoid double
>    evaluation of __COUNTER__ (which caused build failures with LTO)
> 
>  - Updated initcall_get_modname() in main.c to resolve the function
>    pointer fn using dereference_function_descriptor(fn) prior to
>    checking the .text and .init.text boundaries, and dereference both
>    fn and p->initcall_fn in the comparison loop to support descriptor-based
>    architectures (e.g., PPC64)
> 
>  - Linked to v3: https://lore.kernel.org/lkml/20260706050337.7613-1-atomlin@atomlin.com/
> 
> Changes since v2:
> 
>  - Avoided relative 32-bit offsets (PREL32) with inline assembly, opting
>    instead for standard C structures with absolute pointers. This fixes LTO
>    and CFI compatibility issues (e.g., under Clang) where raw inline assembly
>    fails to track compiler-generated symbols and CFI stubs
> 
>  - Placed module name strings into the ".init.rodata" section via a dedicated
>    static array to ensure they are freed from memory after boot
> 
>  - Avoided Use-After-Free (UAF) bugs post-boot when loading dynamic modules:
>    - Added an 'initmem_freed' flag, marked as '__ro_after_init', set after
>      free_initmem() to skip table lookups for dynamically loaded modules
>    - Added a blacklist check in do_init_module() for dynamic modules
> 
>  - Simplified the linker script using the BOUNDED_SECTION_PRE_LABEL() macro
>    to define the ".initcall.modnames" section boundary
> 
>  - Added a dummy/stub implementation of module_is_blacklisted() when
>    CONFIG_MODULES is disabled to avoid build errors
> 
>  - Linked to v2: https://lore.kernel.org/lkml/20260622140259.2974-1-atomlin@atomlin.com/
> 
> Changes since v1:
> 
>  - Pivoted entirely from exposing built-in initcalls and their blacklist
>    status via a debugfs interface to directly extending the existing
>    "module_blacklist=" and new "module_blacklist=" to intercept built-in
>    modules at boot (Petr Pavlu)
> 
>  - Implemented 32-bit relative offsets (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
>    to store the mappings, preventing binary bloat and preserving KASLR
>    efficacy
> 
>  - Linked to v1: https://lore.kernel.org/lkml/20260510061301.41341-1-atomlin@atomlin.com/
> ---
>  include/asm-generic/vmlinux.lds.h |  4 ++-
>  include/linux/init.h              | 26 +++++++++++++--
>  include/linux/module.h            |  2 ++
>  init/main.c                       | 53 +++++++++++++++++++++++++++++++
>  kernel/module/main.c              | 24 ++------------
>  5 files changed, 84 insertions(+), 25 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5659f4b5a125..fc863595743e 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -734,7 +734,9 @@
>  	EARLYCON_TABLE()						\
>  	LSM_TABLE()							\
>  	EARLY_LSM_TABLE()						\
> -	KUNIT_INIT_TABLE()
> +	KUNIT_INIT_TABLE()						\
> +	. = ALIGN(8);							\

Is ALIGN(8) sufficient, or is STRUCT_ALIGN() needed instead?

> +	BOUNDED_SECTION_PRE_LABEL(.initcall.modnames, initcall_modnames, __start_, __stop_)

Nit: I think this can be shortened to:

BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)

>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 40331923b9f4..9c78b6c30361 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -271,8 +271,30 @@ extern struct module __this_module;
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
>  
> -#define ___define_initcall(fn, id, __sec)			\
> -	__unique_initcall(fn, id, __sec, __initcall_id(fn))
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
> +#else
> +#define __initcall_fn_ptr(fn, __iid, id)	fn
> +#endif
> +
> +struct initcall_modname {
> +	initcall_t initcall_fn;
> +	const char *modname;
> +};
> +
> +#define ____define_initcall_modname(fn, id, __sec, __iid)		\
> +	__unique_initcall(fn, id, __sec, __iid)				\
> +	static const char __initstr_##fn[] __used __aligned(1)		\
> +		__section(".init.rodata") = KBUILD_MODNAME;		\
> +	static const struct initcall_modname __modname_##fn __used	\
> +		__section(".initcall.modnames") = {			\
> +			.initcall_fn = __initcall_fn_ptr(fn, __iid, id), \
> +			.modname = __initstr_##fn			\
> +		};

All initcalls are ultimately defined via ____define_initcall_modname(),
including initcalls in vmlinux code that can never be built as modules.
In such a case, KBUILD_MODNAME is set to the target's basename (same as
KBUILD_BASENAME).

This wastes memory and also allows the module_blacklist parameter to
match initcalls that are unrelated to built-in modules.

> +
> +#define ___define_initcall(fn, id, __sec)				\
> +	____define_initcall_modname(fn, id, __sec, __initcall_id(fn))
> +
>  
>  #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
>  
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..bc2968c225e1 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -883,6 +883,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
>  }
>  #endif /* CONFIG_MODULES */
>  
> +extern bool module_is_denylisted(const char *module_name);
> +

Nit: The extern keyword in function declarations is unnecessary. See
Documentation/process/coding-style.rst.

>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> diff --git a/init/main.c b/init/main.c
> index e363232b428b..af71811d24e3 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1334,12 +1334,65 @@ static inline void do_trace_initcall_level(const char *level)
>  }
>  #endif /* !TRACEPOINTS_ENABLED */
>  
> +extern struct initcall_modname __start_initcall_modnames[];
> +extern struct initcall_modname __stop_initcall_modnames[];
> +
> +/* module_denylist is a comma-separated list of module names */
> +static char *module_denylist;
> +bool module_is_denylisted(const char *module_name)

module_is_denylisted() should be __init_or_module.

> +{
> +	const char *p;
> +	size_t len;
> +
> +	if (!module_denylist)
> +		return false;
> +
> +	for (p = module_denylist; *p; p += len) {
> +		len = strcspn(p, ",");
> +		if (strlen(module_name) == len && !memcmp(module_name, p, len))
> +			return true;
> +		if (p[len] == ',')
> +			len++;
> +	}
> +	return false;
> +}
> +core_param(module_denylist, module_denylist, charp, 0400);
> +core_param(module_blacklist, module_denylist, charp, 0400);
> +
> +static const char *initcall_get_modname(initcall_t fn)

initcall_get_modname() should ideally be __init.

Nit: I think a better name would be something like get_builtin_modname()
to make clear that the function returns a module name only for built-in
modules, not regular ones.

> +{
> +	struct initcall_modname *p;
> +	unsigned long addr = (unsigned long)dereference_function_descriptor(fn);
> +
> +	if (system_state >= SYSTEM_FREEING_INITMEM)
> +		return NULL;
> +
> +	if (!is_kernel_text(addr) &&
> +	    !is_kernel_inittext(addr))
> +		return NULL;

I believe these checks could be avoided if the code was reorganized to
avoid reaching this logic on the do_init_module() path in the first
place.

> +
> +	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
> +		if (dereference_function_descriptor(p->initcall_fn) ==
> +		    dereference_function_descriptor(fn))
> +			return p->modname;
> +	}
> +	return NULL;
> +}
> +
>  int __init_or_module do_one_initcall(initcall_t fn)
>  {
>  	int count = preempt_count();
>  	char msgbuf[64];
> +	const char *modname;
>  	int ret;
>  
> +	modname = initcall_get_modname(fn);
> +	if (modname && module_is_denylisted(modname)) {
> +		pr_info("Skipping initcall for blacklisted built-in module %s\n",
> +			modname);
> +		return 0;
> +	}
> +
>  	if (initcall_blacklisted(fn))
>  		return -EPERM;
>  
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..e6d9c52b9786 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2919,26 +2919,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
>  	return 0;
>  }
>  
> -/* module_blacklist is a comma-separated list of module names */
> -static char *module_blacklist;
> -static bool blacklisted(const char *module_name)
> -{
> -	const char *p;
> -	size_t len;
> -
> -	if (!module_blacklist)
> -		return false;
> -
> -	for (p = module_blacklist; *p; p += len) {
> -		len = strcspn(p, ",");
> -		if (strlen(module_name) == len && !memcmp(module_name, p, len))
> -			return true;
> -		if (p[len] == ',')
> -			len++;
> -	}
> -	return false;
> -}
> -core_param(module_blacklist, module_blacklist, charp, 0400);
>  
>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
> @@ -3389,9 +3369,9 @@ static int early_mod_check(struct load_info *info, int flags)
>  
>  	/*
>  	 * Now that we know we have the correct module name, check
> -	 * if it's blacklisted.
> +	 * if it's denylisted.
>  	 */
> -	if (blacklisted(info->name)) {
> +	if (module_is_denylisted(info->name)) {
>  		pr_err("Module %s is blacklisted\n", info->name);
>  		return -EPERM;
>  	}

-- 
Cheers,
Petr
