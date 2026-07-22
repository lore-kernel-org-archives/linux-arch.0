Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8234BA5A
	for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2026 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728680; cv=none; b=GeXLwyRB41t2nr45hJiltv4kLjFF6rJtWnrNlY0Bi7VdBofLcRu/IwCPjqBCrw1qjc1hyAKWZOAGIon3fjGw5khDk7aO3zUfg2IqieoIocX/Jrg2H7bd+LYstMYEIMBQjEZd0w9K5PBfSIB+S8XC1L5cN+8YiMgsZKfCmXuXDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728680; c=relaxed/simple;
	bh=37pwSbanOfW/t9/S0tEcJAxSmzsiOsd5kHF/B3ALuIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuMDMuxeJkGznDgI5CqZLccm5v3ydoKMv0NULrgDrhTsDicyrkVpfQ6VIRPZZF3xOhMeQkVtDctfPSlhnAkl3LYslhakjT4UqwkyxUdtk6ooPo2cCZpaL63zL2NkfQhcF5EuIMv4HlyS4RR6sEiVzYUWjIFdeUNKO/+lEVfP5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RdZwol4E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RdZwol4E"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954afac04bso48749365e9.0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2026 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784728676; x=1785333476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/qklng4hpP6/mtqoqkk+HCU4WExZ0+PbntZxvEgzaU=;
        b=RdZwol4EolsukQVpk92KZRBnRQvllHD96WUTIPbl7Yhl9bGawyYISakRDxuEJPShXy
         rOdbEQAf90iiQ63H6paaf73JfKWqu9mT/zYk1+vmf7v67+OUtPzgqL6+uNAnkL9bvQmU
         +go+Gw5cfS6FWP9/RDvpdohFPfa6GlEDdZoCLd8bjDP95d14C0+9DffGExekY46nAeNF
         KccSHIOdmO4Bybg+33zkJ2KQnvgQ5JQK2WHyPYwvieJgWvMa9MY+W3yuEOZ1ng/KXH/3
         DGVBcvhN7K85QJoBjH09rBi6etCL7LwMm/Eg+HVTOgQ8Uth8W72HugL7OS9xbd/dILkL
         PDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728676; x=1785333476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/qklng4hpP6/mtqoqkk+HCU4WExZ0+PbntZxvEgzaU=;
        b=SfYh876uCq6hwWf1718sJKtZB8FNt9AGVSOqZ7r+nuPP+5bKOZASe465ggwnKe9tOI
         3RF5p4OQWRvdqKbk5mjV0OEJmtCVOBs9lGKOjjGlfdGw7umUyGse0ZLu35yUz6nMlJJK
         EtR/jaU+29i5yuZMgQ0GAhd5oV9ET44qpadyZfqAGzgJzGVbq/jrj1VBHW7OkuHARU+H
         ZuRDs9h9mkpfsNrBjKZwmgaPw+0KtEuZNAg/GAIpGB7GevQT52vMSypo+Si3PKJeHw6y
         0aFS8MK7P2NslUxKruOFPYRTbBabVbVAuq8LbnmhnZEUISquVJRfB+b9jz5EqM5l/mOG
         aUKA==
X-Forwarded-Encrypted: i=1; AHgh+RqrU7HMuLT3AMpZ6ylCJKD7mpquYW3NqQZ2RxJ/T90OrE3ctE+UZRp0uO8FqHKCHrzAIImB/EGCujDq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm79DicRQrzRBl2p3jV9Mzte3EeBSDFMl3cVPWRZcPQHyRu1Ir
	vN381d6u2eNizUEQm+kgwmOQnE75Fhxd9de6/bTxJvV4kvN6PEQqFP9UUvgGSZjWTOc=
X-Gm-Gg: AR+sD10s2k9iRgDUOiXJBTpSnMZ5KDTVdRB+2uOc8JmK8SQbQAM7ou3mMM0pb9GmYac
	wWluniJd5WufYUFdtMo9w/cR2cbenoRmVjaZhFZnmDJQrUQ02S7sqocXGhAOACa8+Wn+xOSWhoN
	QTZRriRUtEiPexQoakpAmuydngye03Czr/bZcWzjqqbGQTxkmbMENZbWgRoEzPwLpa60B1UWzaw
	ld8imOfyhiqHaL1B7DE0FcI6AX/x0MPhU4cK71IQtxLro3/VkCyZbBWQNlzL1aDQIPvfKmdNs+h
	jQSSpa7RlkzSDllmTWCFZAqSjTtq27cov3r03Aoi3DjlHSvzIb82XLQpJNPMP6x/UDttYG0CTQF
	83yrTE6Bvyhm3I9xMkBctNTqsUsoMsjaqFkaywTUk6fccFe0l34nFAcpJmxvt6Cp9HlIqIuwuoj
	GVHZ79WGScfVDd2C3Y8s9OxDMJ15UG0xVSpb/a2Jo=
X-Received: by 2002:a7b:ce84:0:b0:495:4487:61af with SMTP id 5b1f17b1804b1-4954a51659emr183702725e9.36.1784728676403;
        Wed, 22 Jul 2026 06:57:56 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm130525395e9.8.2026.07.22.06.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:57:55 -0700 (PDT)
Message-ID: <2cada244-171d-45cb-a6f0-46e6a09375c7@suse.com>
Date: Wed, 22 Jul 2026 15:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] module: Extend module_blacklist parameter to
 built-in modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, peterz@infradead.org, akpm@linux-foundation.org,
 mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io,
 chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260718190121.378314-1-atomlin@atomlin.com>
 <20260718190121.378314-2-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260718190121.378314-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/26 9:01 PM, Aaron Tomlin wrote:
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
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  4 ++-
>  include/linux/init.h              | 23 ++++++++++++-
>  include/linux/module.h            |  5 ++-
>  init/main.c                       | 55 +++++++++++++++++++++++++++++--
>  kernel/module/main.c              | 21 +-----------
>  5 files changed, 83 insertions(+), 25 deletions(-)
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
> index 40331923b9f4..1cf163715264 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -271,7 +271,28 @@ extern struct module __this_module;
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
>  
> -#define ___define_initcall(fn, id, __sec)			\
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
> +#else
> +#define __initcall_fn_ptr(fn, __iid, id)	fn
> +#endif

Nit: I suggest moving the __initcall_fn_ptr() definition into the
existing '#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS' block that defines
____define_initcall() to make the code shorter and group the related
implementations.

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
> +
> +#define ___define_initcall(fn, id, __sec)				\
>  	__unique_initcall(fn, id, __sec, __initcall_id(fn))
>  
>  #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..fc1525e8f63c 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -86,7 +86,8 @@ extern void cleanup_module(void);
>   * builtin) or at module insertion time (if a module).  There can only
>   * be one per module.
>   */
> -#define module_init(x)	__initcall(x);
> +#define module_init(initfn)					\
> +	____define_initcall_modname(initfn, 6, .initcall6, __initcall_id(initfn))

The initcall numbering and section naming should remain defined only in
one place, in include/linux/init.h.

Could something like the following work?

In include/linux/module.h:

#define module_init(initfn) __builtin_module_initcall(initfn);

In include/linux/init.h:

#define __define_initcall_modname(fn, id)				\
	__define_initcall(fn, id)					\
	static const char __initstr_##fn[] __used __aligned(1)		\
		__section(".init.rodata") = KBUILD_MODNAME;		\
	static const struct initcall_modname __modname_##fn __used	\
		__section(".initcall.modnames") = {			\
			.initcall_fn = __initcall_fn_ptr(		\
			    fn, .initcall##id, id),			\
			.modname = __initstr_##fn			\
		};

#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)

>  
>  /**
>   * module_exit() - driver exit entry point
> @@ -883,6 +884,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
>  }
>  #endif /* CONFIG_MODULES */
>  
> +bool module_is_blacklisted(const char *module_name);
> +
>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> diff --git a/init/main.c b/init/main.c
> index e363232b428b..ee6d7db212d5 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1334,6 +1334,57 @@ static inline void do_trace_initcall_level(const char *level)
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
> +		if (dereference_function_descriptor(p->initcall_fn) ==
> +		    dereference_function_descriptor(fn))

Using dereference_function_descriptor() looks unnecessary.

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
> @@ -1406,7 +1457,7 @@ static void __init do_initcall_level(int level, char *command_line)
>  
>  	do_trace_initcall_level(initcall_level_names[level]);
>  	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
> -		do_one_initcall(initcall_from_entry(fn));
> +		do_one_initcall_builtin(initcall_from_entry(fn));
>  }
>  
>  static void __init do_initcalls(void)
> @@ -1451,7 +1502,7 @@ static void __init do_pre_smp_initcalls(void)
>  
>  	do_trace_initcall_level("early");
>  	for (fn = __initcall_start; fn < __initcall0_start; fn++)
> -		do_one_initcall(initcall_from_entry(fn));
> +		do_one_initcall_builtin(initcall_from_entry(fn));
>  }
>  
>  static int run_init_process(const char *init_filename)
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..a8021039d44b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2919,26 +2919,7 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
>  
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

Nit: This hunk leaves three consecutive blank lines after
module_frob_arch_sections().

>  
>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
> @@ -3391,7 +3372,7 @@ static int early_mod_check(struct load_info *info, int flags)
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
