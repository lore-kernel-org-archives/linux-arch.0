Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C16418359;
	Thu,  3 Sep 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467034; cv=fail; b=lllndtE45y+JQnun0igC9Rp/5ELKX96u3VFUJexafmnpB3Lg6LliGncWUKjxD7mFHC3O90Hjjb2H5IMx6g2FeJQn+hQLSOFFIkuMGiJrbgy059jO/HeONRZh4HIdWaZlYpZcqzfrEhsmw0Lu59SaeAUlqlyNnYp6J42rf81xvlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467034; c=relaxed/simple;
	bh=yY6T77L+EQCqHnxH1VihWvy7upT87yrc5aa45W0CXfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uWkT3kKur+G08De+0IegTVcOFI4anC2bHQG29XcT94CQ4G0gKH+QCpnu15HnsbLy5giDJtQInILFizDGyAiCwTptACLpfweD5O9wG4VW5nUkT3/32z09t1uVQJLadpLh/YwN7Jk9cDKTgAHzo2h+AiRPJS5GcYRWdd3QiCyDkUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxCblksKdXtcUIiNMQa9aCU8litadcZivU9TSEYbKWt6+JJM+ueczy2CjxJaDZ1jeOPUSUIlW4Ca+YW1dbXJwy05mBUwBdpwJNaFv1ldA9dNMIvqyGUhrwodZFLl+58opHnLQATSpEw1K1BJPl+PS7eQTgD16jNjJ+JrNbWQTwd/mXuj4hX1ZO7LCNPN5WfJogaIan/LzNy1J7JpIJH0P85FHgI/Mgl6KognxqixQfilHQFFRXcNpVz3Ljti81TzxHMXNviai/IxMfTBfo0UazB68p6eyilEEdCRwBTcKQNZ3W9zg5/rbNk/561gjUooC8uyBCC5RJa/3rlTf3bI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ExDStCdSdIwdvPe2h74qyICOm2DHwmLkm5s4FqzrsIU=;
 b=t596l4rCW5fi3tBPsU2m7e7vcpJc7B1HGQx0DfRIaAcHnXYR7z9cUE7McAg4N6RXENGvEc3NYrZN4S7AVmKIP2REeNmUbA1bUQTWhALGodR8rxQSxLndziURcDhYFultzgHvcMZLbEaII6qE9+eH/DBl8wiTFS7zGXk7Qx5QAJasbpvfCQ00G7S+a/KVxx1vXYvWSAzf3mN2tWSM0snstsgQ9PLJe0m/ZLfOZXW7K8+kWpNSMXCRJ3R1ImAzDHE9L3O198X7ArfurA/n/GWu0ldg9wV2m+QA4piz9vEtimmJkM4C6H6GaUkg+9bh2mB08mLJNgEv3bBYXHnQSgSjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6407.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:23:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:23:28 +0000
Date: Thu, 3 Sep 2026 16:23:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, boqun@kernel.org, 
	neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, 
	steve@abita.co, mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <zsisetrjfhbe776r2mpm3voikucpsdquvjydrgb4lgu5dfpzqc@pk5hpjpsscwz>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903185557.183224-2-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0516.namprd03.prod.outlook.com
 (2603:10b6:408:131::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4f9308-1574-4baa-2a13-08df09f936a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qpu7SSziaOgRrQIoGK2EcVut1+87kbQSZPW3OkPYFEW81GWVbOR0GUK+V48lmnlL4PGkzGEhW/Na9GhYbJQ7GRgnp2lArP4dqhT3x+M3WobV3uEh1C9ta1G+f2/jPj5ThKd2UQyay7TynHUS+NTcUxEWwFgs0Zwgwl1/dtp8iydZQS55GtI7igG+Aj+eIBRkdiBSBMXn5xpeqhIvhrLU/01erVI4BIa1Vzgo3WAtg6EPcKYErMNTrGc2okcsVgnfOPLQeDrym9QqRLa/VKnxjCeAdGuIrsYZi87DQF+2KKs9zbOaIClXqEqj+eHTOOJKWW2G3tgE7CrUIY2yoNXpH6h36m/K+9UBl8cB6rtHSsK1lvDUEO8GBgBXrX5X5/9P7pNtsUDzeDx76m2Tv3wY3v62wTmM62Lk2wfLmu3b9IB2wFiXHuaYRQFK9kzG95MWDtCwLpvUw23OY+TiHBcj+mZamNNi7RfmIraXfRWJXXQ1YBq6y4C4P8mijFp8lGfSszVSLlwPrPkAzBIGuhPtp7+KnexmlpebEWF3X6icCha2U9usH8xEWnU6ZxywzxjSCR253SnwGbURqUToPlb9xMsowiMbt9Z4SxuyGXKd+F6VODs9GlXvIIKTsrS2r7kXGXLhQZdgrqWxTyWZ6x5OOyQC5n5NPTWUQ9xvcwzxMa4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBLWEIrN3EzaGhHWWNaS044UHJjejNxWUpYazBaaXdpdHp5bDJ5WWxPUFpy?=
 =?utf-8?B?RE5rcWxZMDJsMDczRGVMUWNRcklZKzNobit5ODdGMllDSHFuTjIwb1NSNmhp?=
 =?utf-8?B?NGMrT243dFVXOGpOTzdJdEZnUE8wZVdmRUs4RDMxVlRCMmQ2VDJ2NDJ5cXc2?=
 =?utf-8?B?UDlBL1dDeHlXSVRYaFowbmh6OWZzbVRHb1ZHeTM5dldJTTF1YS9ka1lEcFJR?=
 =?utf-8?B?RFExRjZMb2tHcGN2NDhzUnEyeXVvWllQUmFkRTdXK1dyOFlUeVpoZkxUZkQr?=
 =?utf-8?B?VkczV2lvL054MzlteFZQL2RmejQwZ0IrKzRBdFNkWkVVRXFTYW4vanc2OWlY?=
 =?utf-8?B?K25Vd21yVyt2VlNHb1Y0eE5OcnRIdVFFdC9qZDJneUl0Y0d1eEVDL0RLV1JL?=
 =?utf-8?B?MUtkQ09ySzV6MjFUa2p6UWkwRnkzWXJHc0owTnRXM0cwQlptNTRheGI4TG9h?=
 =?utf-8?B?bTJnMmNkRmZUWGRDcnhwak8vSFNWTzdweFNkOWM4dGdUbGx3MTdaWE00NlFH?=
 =?utf-8?B?QjhVUlZlSGFvaXlPM08vYnlYc3NhVnh5dWNnQzBmb0xnZUR3Rkh1MXBwU2Jp?=
 =?utf-8?B?NmMySGtEcVRLcFVZelBKSlh6Q2hHbDl2S0I5NkxjNytHVUdvMDRkTFJ4R25u?=
 =?utf-8?B?RlVVQXZ2ZlB4Y1RwczdhMmUvT245V2cwMWtQckNOT3UvcWJzWm80blFnWkRE?=
 =?utf-8?B?MmoySldHTlM5RE1PaTFyQTV2Z0lNQkpNa3owTVhublNHNndXdlRTbGIzRDJl?=
 =?utf-8?B?TnpQdnZHTXNMTWxOSEE4UFFyNnpQNWRGTnNDeUl4T2RpeUprSnVDQ2NpZHJL?=
 =?utf-8?B?RndvTmx1RlhtYkNHVmdTZkh4a3RqVE1mQTh1Q2NOVlF5UGlGSE9zN3pRQWpu?=
 =?utf-8?B?c3FnTVd1enYxZHdwRE9neVBMSGM5Qms3ek1SRHBMWjdpTDBhYlRpMlJ5Tkps?=
 =?utf-8?B?N0RGTUQ0L0xFaHdrVXNMQW1kWFdOQUJmRU5rSm1IV0NPTkpBT3lBY2IwZ1Zs?=
 =?utf-8?B?ekY4OUZXSUFQWlkrNjFlTlBjdzJ4TFczeFNTSjBRQ2tzMEZGcHJWd2M1SHBI?=
 =?utf-8?B?USt6cUpEMkEvemlSem1BTytZZ0JGVFpJRkVGeGtTbWVOUUJSTzB0QWo4SUp6?=
 =?utf-8?B?VE1MaG4ralJoV3Bmdk1mUDY0M3BvZTF2c1ExT0NQcTJ0eEhhSnZmNkJSYURN?=
 =?utf-8?B?b1VKdnllcHdlMi9RNjZxQzRxWkErVGI2Ry9CdElJVXRLTzU0dzlJVkpYZndI?=
 =?utf-8?B?YU5rYkdEdFRYb3lLVWxCZG9OT1JXbm16b1VjSzAxMldUTWIwMEoxNGptRGgv?=
 =?utf-8?B?cjNwdndERFJuSWJFK3diYTdOTERQZzVCVzQ3QVB5aEp0OStsc0VzZkhPdzN3?=
 =?utf-8?B?TTRMalpFZ3NqMHJjMVdMYlZSckhlQTdHUk1FRW11dnRHdXAvNUNQVjlacWJE?=
 =?utf-8?B?M3k2Q1YvQ2dlNWdQbUdPVFNqNW5IMkRkR1FKdHRXdVpXc3hjdXducWt0WlN2?=
 =?utf-8?B?VjFuREttbjBWSXhuYXJ2b2dQYTFGYURaZTd2aVNXOGZ3c1gxOFc0UXB0dzBa?=
 =?utf-8?B?akYvWE8ybnlBNE9HY3BHVGdpTVZsZkROU2hnczlWdThlRDFUellqOTdHclEz?=
 =?utf-8?B?TE9raGJJaWJCbU5Xc25XTFlrQ0k1SldPbGNSYmcwRVNNaHFDZWJzbHIzY2JQ?=
 =?utf-8?B?aEFxUGdJSzFmOW9NeWNKZ0NtVzNGQ3ZETjVvSHI4NmJLaUx0ZzV1N21IcGNp?=
 =?utf-8?B?MUk1ZVVJT01sa0MyMGp4R1NQS2FrV0RqK1JGT1dVU1JSNlpaNFBTVUM0b3JL?=
 =?utf-8?B?SVJhNGh0NEplUlRlZ21YbFRRVHlVWWs5a3VXay90bUJsTW1UenNwbjRMRGgx?=
 =?utf-8?B?NkVMZUtNR09Vb1hDbHJ3SGp6SExST2dzTSs3L212a24rc0VCSjFvNXo5Skg1?=
 =?utf-8?B?SHNDWmoyTGlxbmllK3JtYXRucmVCWFpKVzJMWk11OEgvbk5ramQ5UWJIZnNN?=
 =?utf-8?B?TjlpMkNwSlFYbzdVQitEZWcxb3lsRVdjVGFRTTZvT2VmUjdtdU5DN0Q5N1li?=
 =?utf-8?B?OTJ2WlpPWjBJMWxWNWMzc2MrNS9CbG1CN3FZckFkUmFBQnlJT2loejdPdDNj?=
 =?utf-8?B?Vy9aeTRQUFkyQktPbS9IaDVyM1l5aFB5azMxdjVCa0Y5SXYwZFNvbWhBSk5o?=
 =?utf-8?B?QnRiZHFUQkQ1S2hma3NLTWJHNkx5eWgwMGtna29OSC9EenFnVXEwbFZidkZy?=
 =?utf-8?B?MXZDNHhMMUhBWnhNNWorL2I5Vm1vamdTMEFwaTF4d1FHREEyVlZDcmhHV2tL?=
 =?utf-8?B?TlJldnc1U2thNUxxLzdKdlNWRUtKNThIREJMeFlwWmVncUZOTkxmUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f9308-1574-4baa-2a13-08df09f936a2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:23:27.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c1TCL6iPl/Hik4aJTSdiXtd7EoAOMu8I5ozNCuAYtTsFAmPaZQO0vxTOewYeeOKQfwyrXFdL+9HjNmR6zFpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6407

On Thu, Sep 03, 2026 at 02:55:56PM -0400, Aaron Tomlin wrote:
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
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  3 +-
>  include/linux/init.h              | 25 +++++++++++++-
>  include/linux/module.h            |  4 ++-
>  init/main.c                       | 54 +++++++++++++++++++++++++++++--
>  kernel/module/main.c              | 23 +------------
>  rust/bindings/bindings_helper.h   |  1 +
>  rust/macros/module.rs             | 17 ++++++++++
>  7 files changed, 100 insertions(+), 27 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f66..7490278b7a2d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -734,7 +734,8 @@
>  	EARLYCON_TABLE()						\
>  	LSM_TABLE()							\
>  	EARLY_LSM_TABLE()						\
> -	KUNIT_INIT_TABLE()
> +	KUNIT_INIT_TABLE()						\
> +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 6326c61e2332..833b837ce11d 100644
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
> @@ -271,7 +273,28 @@ extern struct module __this_module;
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
> +		__section(".initcall.modnames")				\
> +		__aligned(__alignof__(struct initcall_modname)) = {	\
> +			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
> +			.modname = __initstr_##fn			\
> +		};
> +
> +#define __define_initcall_modname(fn, id)				\
> +	____define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))
> +
> +#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
> +
> +#define ___define_initcall(fn, id, __sec)				\
>  	__unique_initcall(fn, id, __sec, __initcall_id(fn))
>  
>  #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..bcc54edbde7d 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -86,7 +86,7 @@ extern void cleanup_module(void);
>   * builtin) or at module insertion time (if a module).  There can only
>   * be one per module.
>   */
> -#define module_init(x)	__initcall(x);
> +#define module_init(x)	__builtin_module_initcall(x);
>  
>  /**
>   * module_exit() - driver exit entry point
> @@ -879,6 +879,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
>  }
>  #endif /* CONFIG_MODULES */
>  
> +bool module_is_blacklisted(const char *module_name);
> +
>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> diff --git a/init/main.c b/init/main.c
> index 2613d3f9b3ce..0ee3b23bcd2b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1344,6 +1344,56 @@ static inline void do_trace_initcall_level(const char *level)
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
> @@ -1416,7 +1466,7 @@ static void __init do_initcall_level(int level, char *command_line)
>  
>  	do_trace_initcall_level(initcall_level_names[level]);
>  	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
> -		do_one_initcall(initcall_from_entry(fn));
> +		do_one_initcall_builtin(initcall_from_entry(fn));
>  }
>  
>  static void __init do_initcalls(void)
> @@ -1461,7 +1511,7 @@ static void __init do_pre_smp_initcalls(void)
>  
>  	do_trace_initcall_level("early");
>  	for (fn = __initcall_start; fn < __initcall0_start; fn++)
> -		do_one_initcall(initcall_from_entry(fn));
> +		do_one_initcall_builtin(initcall_from_entry(fn));
>  }
>  
>  static int run_init_process(const char *init_filename)
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..a9fd6aaedc69 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2930,27 +2930,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
> -
>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
>  	struct module *mod;
> @@ -3402,7 +3381,7 @@ static int early_mod_check(struct load_info *info, int flags)
>  	 * Now that we know we have the correct module name, check
>  	 * if it's blacklisted.
>  	 */
> -	if (blacklisted(info->name)) {
> +	if (module_is_blacklisted(info->name)) {
>  		pr_err("Module %s is blacklisted\n", info->name);
>  		return -EPERM;
>  	}
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 4b31aa7f432f..1075b26e53ac 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -63,6 +63,7 @@
>  #include <linux/fwctl.h>
>  #include <linux/fs.h>
>  #include <linux/i2c.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io-pgtable.h>
>  #include <linux/ioport.h>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index bc7027f8dbb2..a96157598197 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -480,6 +480,8 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>      let ident_init = format_ident!("__{ident}_init");
>      let ident_exit = format_ident!("__{ident}_exit");
>      let ident_initcall = format_ident!("__{ident}_initcall");
> +    let ident_modname = format_ident!("__{ident}_modname");
> +    let ident_modname_str = format_ident!("__{ident}_modname_str");
>      let initcall_section = ".initcall6.init";
>  
>      let global_asm = format!(
> @@ -491,6 +493,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>      );
>  
>      let name_cstr = CString::new(name.value()).expect("name contains NUL-terminator");
> +    let name_len = name_cstr.to_bytes_with_nul().len();
>  
>      Ok(quote! {
>          /// The module name.
> @@ -591,6 +594,20 @@ pub extern "C" fn cleanup_module() {
>                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>                  ::core::arch::global_asm!(#global_asm);
>  
> +                #[cfg(not(MODULE))]
> +                #[used(compiler)]
> +                #[link_section = ".init.rodata"]
> +                static #ident_modname_str: [u8; #name_len] = *#name_cstr.to_bytes_with_nul();
> +
> +                #[cfg(not(MODULE))]
> +                #[used(compiler)]
> +                #[link_section = ".initcall.modnames"]
> +                static #ident_modname: ::kernel::bindings::initcall_modname =
> +                    ::kernel::bindings::initcall_modname {
> +                        initcall_fn: Some(#ident_init),
> +                        modname: #ident_modname_str.as_ptr().cast(),
> +                    };
> +
>                  #[cfg(not(MODULE))]
>                  #[no_mangle]
>                  pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
> -- 
> 2.55.0
> 

Hi Petr,

Please ignore.

I forgot to restore ". = ALIGN(8)" to ensures that the location counter
within .init.data is aligned to an 8-byte boundary immediately before
__start_initcall_modnames is captured.

I will send another iteration.


Kind regards,
-- 
Aaron Tomlin
