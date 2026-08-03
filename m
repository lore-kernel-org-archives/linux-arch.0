Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05C340401
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772535; cv=none; b=N6FQHhySn3KY0zbACdd43fX+VD8i09iPRLyiwMuS92eBwvvQpxSM254xpgMC445njuhPaXOGRoe6Qp8rn2NCrnbCHB36dBdxkEDMBMJ6L0VyDDkPpkE3naAyVJe5TCKRUN/5RsZR3BQmp+S3+TJKPWSyiIHj6YjKWSAhhsu69gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772535; c=relaxed/simple;
	bh=YTL/Upm3fjjpjk1SYCRiepmxcCeGGHaBPf3AWKvJ2l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp/hA1zdhpGuoRovSbVam0JmhfTfIamwwA3FTBqwlOL0bwMIpPKqvbu8NFsVwZWWjBIzXS/zY4FH+YIBmk3/hJvv+z+7h/9rPR/mmwRnJybQVx2EE26BZ3/fcMLzwDylThJdBkw+fcueCC5qGLOUZZIZ7+mEF0Fzx2jdxfqqr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EKx3hH/V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKx3hH/V"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2258139f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 03 Aug 2026 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785772530; x=1786377330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P69p6azdHyND98/PhZ78+ELHt+uzxczZd0Oxm0ds8EQ=;
        b=EKx3hH/VYLE+T0pz6iJXxm9JfZsvPVYxQIX9eU5kCZtje2FRx7Y5ZNdJz0OG+CLP1Y
         yZCOvCCGpuiP7vXml0zeKEzSNoLaxJblV0usYR9SXRsJfomX6iO28zKQntmaPpr630qx
         n+wh12NsN1/+3Rj1UjUbBe8yTlovPbuAn3jRYym7BERPY03fctmCH6OpLYINcGhROQ1I
         mTdyyROs7dEqkgRezwGaqY7CoYy0kMlpmWFyanm/nZtYRxjL62dNVlKpOuB1gmhF8/6T
         UCXnkOUlUcBelRIchCiHOt8alsm5bmzy4W3tW3iS3PhEV2zPDggoTOlH8uS5NGLrZNuP
         T26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772530; x=1786377330;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P69p6azdHyND98/PhZ78+ELHt+uzxczZd0Oxm0ds8EQ=;
        b=P5V6s4qPLKpz6ZI3xCKU6WYHA4KAHajaYhsWrV3Ay/e3EhLLKAEnWdIa66VPsYI3+v
         UVxruu3mxCKBtpvkK+dSyJHaBr3uVqNMACfWx6ohwLFXHbIp1JoZnH2tlaCZUDxTkfTE
         mB157PQCay+4ayZ8FoB8LFqjAHSmjz1QP+7YxCfPm0FIoxdAdI+GqgCOiBzjHRnSQ0CV
         NizFPFgKDWZqvQztJeS0H0u2bRaJuUaIr7wG5GXP2dtV33N3C3TMtDMUPtlN+lN4l3jP
         YPSHdSJNFAENlEx0yyKEsJm3Rk1UuS8TOCDOpo0ACX9SCAT6sQO4Ht+JFsGDNfzlzJWp
         iCvg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Vsp4hsHMQb3MTAY//S7YGx4m/WSPcoxjTftU8f1NkXGUB/58qS+XFMPlJRy7gvhkaFWW2HUt4Kjv@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9X+sYghMGJmbs0vourKjhdw7BynupbLg3rXbewnyZSnnW1+l
	BIUaEiSmfi78m1ZkDj8EihtxHhSY9KSlLM8NfR2hobvKDNV/5CcF7FFpKx06jCbXuhg=
X-Gm-Gg: AR+sD13n8RwVjUlNDacg+3fkpaN2bn/MPAF+lDbUSsAluYzRQ5fTd7fqfjPSE7psNs7
	O3N69pEQHH0OoNyHAixpuSWuFbkLhxhPAMkgrTXsD0c33/TTXyP9687MCLciFbLopcakR8vIYPT
	jC/x4E196OL2TTcbzDyX3ZhACWc11O/Xx7VIrWz3CUcc6AwZs5aZSicvbs/+nyPvXV5us43bR6Y
	vi3wz5PD8BFflCnIo60up7N4420rIPLpi1oUsd7qEt0jEC9/mnCaqobnl9A53soAj6UfGyn8ANd
	OsQCITdswzYqjGk0t3z/kuD0YN25qnwg2l6H0VEEehzmTY9ojByM0xpyrSkr4I9Tnlyoukxq+eM
	zUiG7Y2VrDDcuO3FZ2XFLKdQ4vOVyXOaccsbA1SWVbnWY3L1cjHvFGb7pYnNEEORB3ZIrCWmTmA
	l1/NI0yPk9Q3iHWXtksyB/3nfw9ZDOIhu4ABDSYumGxbiARQWeI9LWyLtj4fmrSzpsl5au/RWfI
	66c0FJVHZ9V4AvTcX0FrMGQFz1Ts+g6nNtJtjqOVAfIi+ylf1hlrR29QF9wj9E/GI9Nz+QPI98G
	oUIYsk/AfOPgRlA/ImpxhfQ7vFQPLX82Jz0AgFajBg==
X-Received: by 2002:a05:6000:46cb:b0:47f:8abb:7476 with SMTP id ffacd0b85a97d-47fd72d47cbmr20671637f8f.19.1785772530043;
        Mon, 03 Aug 2026 08:55:30 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cf404sm33422968f8f.1.2026.08.03.08.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 08:55:29 -0700 (PDT)
Message-ID: <47e20ce1-c328-4491-b366-c23d5f55a8cc@suse.com>
Date: Mon, 3 Aug 2026 17:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] module: Extend module_blacklist parameter to
 built-in modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, peterz@infradead.org, akpm@linux-foundation.org,
 mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io,
 chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724024744.616286-1-atomlin@atomlin.com>
 <20260724024744.616286-2-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260724024744.616286-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 4:47 AM, Aaron Tomlin wrote:
> Currently, the "module_blacklist=" command-line parameter only applies
> to loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch extends the blacklisting functionality to built-in
> modules by intercepting their initialisation routines during early boot.
> 
> To achieve this, we introduce a new ".initcall.modnames" memory section.
> For each built-in module, we use a standard C structure (i.e., struct
> initcall_modname) to map its initcall function pointer to its associated
> KBUILD_MODNAME string. This mapping is restricted only to files implementing
> built-in modules via module_init() to avoid mapping core kernel subsystems
> and save memory.
> 
> During boot, built-in initcalls are executed sequentially via
> do_initcall_level() and do_pre_smp_initcalls(). We introduce a new
> wrapper function, do_one_initcall_builtin(), to cross-reference the
> initcall function pointer against the ".initcall.modnames" table. If
> a match is found and the module is present in the blacklist, the
> initcall is skipped.
> 
> To make the blacklist functional on monolithic kernels, the command-line
> parameter parsing and the module_is_blacklisted() lookup function are
> decoupled from the loadable module subsystem and moved to init/main.c.
> This enables "module_blacklist=" to intercept built-in modules even on
> kernels built with CONFIG_MODULES=n.
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
>     2.  Architectural Safety and Elimination of Runtime Vulnerabilities:
> 
>         By embedding the boot-time blacklist check inside the
>         do_one_initcall_builtin() __init wrapper function, we ensure
>         the metadata lookup logic is exclusively invoked during early
>         boot. This approach provides strict structural guarantees:
>         - It inherently eliminates Use-After-Free (UAF) and race conditions
>           since loadable modules (which execute post-boot and invoke
>           do_one_initcall() directly) bypass this __init wrapper entirely.
>         - It prevents modpost section mismatch warnings since the __init
>           metadata is strictly accessed by other __init functions.
>         - It mitigates Spectre v1 speculative execution vulnerabilities
>           by guaranteeing the unprivileged runtime module loading path
>           cannot speculatively branch into reclaimed .init.text instructions.

I suggest moving these design notes below the --- separator, together
with the diffstat.

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  4 ++-
>  include/linux/init.h              | 27 +++++++++++++++-
>  include/linux/module.h            |  4 ++-
>  init/main.c                       | 54 +++++++++++++++++++++++++++++--
>  kernel/module/main.c              | 22 +------------

The Rust module support in rust/macros/module.rs should be updated
similarly to maintain feature parity.

>  5 files changed, 85 insertions(+), 26 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5659f4b5a125..799d912dcbc0 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -734,7 +734,9 @@
>  	EARLYCON_TABLE()						\
>  	LSM_TABLE()							\
>  	EARLY_LSM_TABLE()						\
> -	KUNIT_INIT_TABLE()
> +	KUNIT_INIT_TABLE()						\
> +	STRUCT_ALIGN();							\
> +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 40331923b9f4..623d8642797c 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -252,6 +252,7 @@ extern struct module __this_module;
>  #endif
>  
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
>  #define ____define_initcall(fn, __stub, __name, __sec)		\
>  	__define_initcall_stub(__stub, fn)			\
>  	asm(".section	\"" __sec "\", \"a\"		\n"	\
> @@ -260,6 +261,7 @@ extern struct module __this_module;
>  	    ".previous					\n");	\
>  	static_assert(__same_type(initcall_t, &fn));
>  #else
> +#define __initcall_fn_ptr(fn, __iid, id)	fn
>  #define ____define_initcall(fn, __unused, __name, __sec)	\
>  	static initcall_t __name __used 			\
>  		__attribute__((__section__(__sec))) = fn;
> @@ -271,7 +273,30 @@ extern struct module __this_module;
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
>  
> -#define ___define_initcall(fn, id, __sec)			\
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
> +			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
> +			.modname = __initstr_##fn			\
> +		};
> +
> +#define ___define_initcall_modname(fn, id, __sec)			\
> +	____define_initcall_modname(fn, id, __sec, __initcall_id(fn))
> +
> +#define __define_initcall_modname(fn, id)				\
> +	___define_initcall_modname(fn, id, .initcall##id)

These two macros can be merged into:

#define __define_initcall_modname(fn, id)				\
	___define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))

> +
> +#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
> +
> +#define ___define_initcall(fn, id, __sec)				\
>  	__unique_initcall(fn, id, __sec, __initcall_id(fn))
>  
>  #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..ecc4db15ff4a 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -86,7 +86,7 @@ extern void cleanup_module(void);
>   * builtin) or at module insertion time (if a module).  There can only
>   * be one per module.
>   */
> -#define module_init(x)	__initcall(x);
> +#define module_init(initfn)	__builtin_module_initcall(initfn);

Renaming the macro parameter from `x` to `initfn` is unnecessary in this
patchset and also makes the preceding comment inconsistent, since it
still refers to `x`.

>  
>  /**
>   * module_exit() - driver exit entry point
> @@ -883,6 +883,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
>  }
>  #endif /* CONFIG_MODULES */
>  
> +bool module_is_blacklisted(const char *module_name);
> +
>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> diff --git a/init/main.c b/init/main.c
> index e363232b428b..3747ccaeef42 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1334,6 +1334,56 @@ static inline void do_trace_initcall_level(const char *level)
>  }
>  #endif /* !TRACEPOINTS_ENABLED */
>  
> +extern struct initcall_modname __start_initcall_modnames[];
> +extern struct initcall_modname __stop_initcall_modnames[];
> +
> +/* module_blacklist is a comma-separated list of module names */
> +static char *module_blacklist;
> +bool __init_or_module module_is_blacklisted(const char *module_name)
> +{
> +	const char *p;
> +	size_t len;
> +
> +	if (!module_blacklist)
> +		return false;
> +
> +	for (p = module_blacklist; *p; p += len) {
> +		len = strcspn(p, ",");
> +		if (strlen(module_name) == len && !memcmp(module_name, p, len))
> +			return true;
> +		if (p[len] == ',')
> +			len++;
> +	}
> +	return false;
> +}
> +core_param(module_blacklist, module_blacklist, charp, 0400);
> +
> +static const char *__init get_builtin_modname(initcall_t fn)
> +{
> +	struct initcall_modname *p;
> +
> +	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
> +		if (p->initcall_fn == fn)
> +			return p->modname;
> +	}
> +	return NULL;
> +}
> +
> +static void __init do_one_initcall_builtin(initcall_t fn)
> +{
> +	const char *modname;
> +
> +	if (module_blacklist) {
> +		modname = get_builtin_modname(fn);
> +		if (modname && module_is_blacklisted(modname)) {
> +			pr_info("Skipping initcall for blacklisted built-in module %s\n",
> +				modname);
> +			return;
> +		}
> +	}
> +	do_one_initcall(fn);
> +}
> +
>  int __init_or_module do_one_initcall(initcall_t fn)
>  {
>  	int count = preempt_count();
> @@ -1406,7 +1456,7 @@ static void __init do_initcall_level(int level, char *command_line)
>  
>  	do_trace_initcall_level(initcall_level_names[level]);
>  	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
> -		do_one_initcall(initcall_from_entry(fn));
> +		do_one_initcall_builtin(initcall_from_entry(fn));
>  }
>  
>  static void __init do_initcalls(void)
> @@ -1451,7 +1501,7 @@ static void __init do_pre_smp_initcalls(void)
>  
>  	do_trace_initcall_level("early");
>  	for (fn = __initcall_start; fn < __initcall0_start; fn++)
> -		do_one_initcall(initcall_from_entry(fn));
> +		do_one_initcall_builtin(initcall_from_entry(fn));
>  }
>  
>  static int run_init_process(const char *init_filename)
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..5c90ebedbf68 100644
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

This still leaves two blank lines between module_frob_arch_sections()
and layout_and_allocate(), instead of just one.

>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
> @@ -3391,7 +3371,7 @@ static int early_mod_check(struct load_info *info, int flags)
>  	 * Now that we know we have the correct module name, check
>  	 * if it's blacklisted.
>  	 */
> -	if (blacklisted(info->name)) {
> +	if (module_is_blacklisted(info->name)) {
>  		pr_err("Module %s is blacklisted\n", info->name);
>  		return -EPERM;
>  	}

-- 
Thanks,
Petr
