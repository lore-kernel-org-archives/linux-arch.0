Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021118.outbound.protection.outlook.com [52.101.100.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF343F0B5;
	Sat, 18 Jul 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784347411; cv=fail; b=DYVrnhn/LrXBXZsXzvwBOkwDWaomzCl39jv6GmHLpdn3elQlomzFSIFMc1aNuRIfKchpVjPTGkMyI5JroIVSL19NPfKT6sBy6iwISSd8Rbs9mEeIbyfklyqUP5fGBdBRA7cKfsyb0/DtCNyb+t4+AY/xzJWBsddaGxfLXRaKMpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784347411; c=relaxed/simple;
	bh=RgSHJ1PsEBMz3gq+TUQpLy2ryb2gyvFFHhzO9Noxcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RrL5coZkg8HNCB120EW7GmQ+3UYkW22972sNspCETyZP2dAIaRduO6v7MteQrf25VwWWD1a3+4W++6L579NRehESRAi3u7QZLUaDCkHre9iOPikzGf2tVsjf+Uw5hQqQfyfOhZaw9jwdjihHP3DcqnvegJT8zJCpPidNuhyjipg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9DmlLu5crbzvIMYD8yRBI0Axblh32WUuJ0Kx8lgxYrYpzpRyw0ywsLOriKGPxuy+TUPYUH0M8tL97RwUnOi3cIIQ3VeGkjTNz2tILqmfFYXu4oe7dsLgavjrENgkxGJVQUDXbb4RyRYomkDAR9chdjJNPrCa8dF9l75ug1JgH9xpyYG2GoFZ9V526NH8MHQ6SJViTZnhxC315UGReHo8RLiQU+SpFhb3OegNBKRHmJDfsl4f8r58Unj2aorygpvy9rIO/lH3qA6GiL1ydpQ0Ct24nsVRxxeZtV0DO9IDfRpom6+WqOOXVqnUG4ClJeLYPnCHnODtWQrA86ECDqusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bNiToSsC5ccTCt+nvQwCyFfvd5IyM6Fqp8EXVgiBd10=;
 b=D/8CrtPNfaFuc8VQoYMPEEOIktskBSVbWP9qxREQnehvks/cxmYAstsZgn+5nlp28kva4ARZsRryZ0pvquGXtsZHNviIUvtBY0vgmpbpxpkAhofDk6Xyk5e9x05AHWLAk/85nSfT93IY1bw7j0gjUQafifJOWwewLZO2iNQynDcrjKv5QBDjUtRQidMCbR51n5Jab/R3Hl8+x54WmqUnCweZCHCanKiOitfnBCF9mUYLMxRXiWzMtxMdcosH6T/S7dY0SM/eyCsQkZP2AKNQZQQ4kBDUUVLDy79+L/Qgak002joEJb0QxsRS1eSx2HwjXKy3Qcz6pvBGzA5+WU1bmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8923.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:482::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 04:03:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 04:03:24 +0000
Date: Sat, 18 Jul 2026 00:03:20 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org, 
	samitolvanen@google.com, peterz@infradead.org, akpm@linux-foundation.org, 
	mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <vcnw3a4v7tfe7yhxu6myy2cxhxqcx4sbc44n3g7wrhweutaxiz@px23o6r6wahq>
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <7a946c5a-5bad-4e10-8633-0d593f3ab5a7@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a946c5a-5bad-4e10-8633-0d593f3ab5a7@suse.com>
X-ClientProxiedBy: BN9PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:408:f4::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afacfeb-8299-4124-438d-08dee48183a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VFoV1B5zZBBwpYlI8fdDyQEzZhef2j2lYEWyq2htOrYthAsoQLa1Nsos9TK59Ou2KSqJvZVRQ+INg79BBHnS0IlMk2viovqf+Ztupj/mZNZJl2INyjXJw1IPTtRJrRGFHKX15YXwRVZz3zGl3jaGu14jVf/QsLQi252W9pjSJ3NCfnHht1tx1DHxYQNB1+f/upK/C+1R0DIeKGexDKmVPJp7zloI7STNau6q16wBA01tA/HmUMWziGhwJvvGQPxrS39RW+ZAh4mCJQ23/VsuNzAVUJa2kD4Vb/GlH2VMVvtFLV4L/OvwS3jOUD8ZqjTJMc2fqHcqm/hHN8e4aU5LxsAOaWH1yTXK56xnRKvXVlOSUL61gMX+TzBhyjHJjn4lYwQ6s6xtevvcgEQqj7m8QdV3dhsb/W+14ZDHmt9GhqONNTUylHpg/FiNXEAp0IMDQe1IxOG0BWb+uydnv7fbSOTD2bwImzZIajW8Q0LWf+zP1RxJ6B8fuCZ1DkGJsbqjFKMQC1cXfTTgmO/4G225ntaEoUpVsVxYW9GjZ+BYkSmYih24MEdhsG4SZb/NyvDf5yfllRDbzk8W3xfTcCZf9r8iUjG2IgeuuPHNLOCOaFEmaA2jI+Z9TytGHrFQsv6oQqcPggKAWejzReujAI0IDC9+vTOb6Azle0uYaNfTCGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGc3czJlL2FCSFIxK3ZiTDhwWThlblREYnVpUUxXWjBIeEZPRFUvL1pCcURz?=
 =?utf-8?B?Mm1SYlg5R3JEVzlMZ3JsaGxUVXBTcWVNL2ZqMHpvTTViSWpjMmlUY2tFQjNG?=
 =?utf-8?B?NHkvclNaai9nK0dEL2hDMCtISzNmNVIreHkyNFNac2t1Q21OYi9HcUpUdncv?=
 =?utf-8?B?anJwcmM5NlJqMTJXRDhoNXdRTUdnQVBOTEpiQ1RBQ0RaMWNWSWtmR2YwNlZZ?=
 =?utf-8?B?dUNDUFhLNkRiQjUwMFJQUnZqZGpDNldvME1ySGpCcnlVZmpWQWVHREc4S2tv?=
 =?utf-8?B?V2RmSkJFYVhyK09zMDFtemY4NXBXaXNFZVdMMHdDb2NreVJjWDZ3T21kdTFW?=
 =?utf-8?B?bG81U2J2M0Z0OTNVS1I0KzRtLzlQV1E0WEIybkZXdUh2SGk2MzhGRDA2U0lH?=
 =?utf-8?B?eUNyTUlzNGhkb2Rwa0gzSUNKV3g2WGVGR3MzdnIvVDU2cThBMUp2M09DRGd4?=
 =?utf-8?B?bTFjZm1laVozZElkRURjTzh2YnYralFlNnB4WmZqYlN5M2IzOGRBcFJTQ3Nx?=
 =?utf-8?B?Nm04bnlJZmNZdENsTWVBYmRMODM1QnFwN1l4LzVwSndMa0R6M0JUdWlOd1Uv?=
 =?utf-8?B?YWJDL1NCYVV2K1RHSWFnL3F1ZkhOZUM0Tmo2MTVnOXA2VkRzOVphTTFxZ3Jl?=
 =?utf-8?B?Q3dOY2lRVFJrNGIybDJhZjBxUWxzQUxmcmczbHRTb0hEQURTOU0ranVlaWEr?=
 =?utf-8?B?OTJwcCtWcW1YZDh3Y3FXeEFza3lnRHozVVVZclJSUTAxUElHc0J0emwzc3BQ?=
 =?utf-8?B?eFZmMUh4WXUzOTRWQUM1c1M2SzFpa3MraGJ2bERRWk5yeUhRRWZNM1V5Tmdx?=
 =?utf-8?B?NEovaUFnTGpnSnZzWW04MGU1aGt2bWJCRm1BSGJOdy94ei9GOUFnYkg5Yzgz?=
 =?utf-8?B?V3Y3TnBSM1JGT2dCcHRiY1llcTNhT1FFTkh0bkNJMUx4L2VBYVZSU2huMzBG?=
 =?utf-8?B?ZXhyL25HSlh0ckJ3Z25CdXBIR0czWGtHN3MvNm1ibllISi9WV1c2Q1hRWTFF?=
 =?utf-8?B?eTFPd2IyY1A4bGtnQy9ldGEyVEhCMTY3VGJxSWliQ0lLZHVmaE1xL1BwL0oy?=
 =?utf-8?B?dVc0K2xiSjUvNjVQNGU3YmtNRFhFS283ZDIxOUsvcjVRRGkxZ1l2WHlobzVx?=
 =?utf-8?B?dTAyUFJLUDNvK1NGSGMrdUVqSFJ6UnQ0Q1VRblRiQm5GSE1EUkRHV2todTl0?=
 =?utf-8?B?cnRzZ0dOMjl2a3hjRVhrdHJuTjlHN2JVRWo2SnNoem9HWkNqUmh1eWtuclF3?=
 =?utf-8?B?amVrUmxsUE5MeVJSNUw1NDZ5SmtvKzhxYkhxbW5tZWNCNWovMURkdEJZM3pT?=
 =?utf-8?B?Rmp5M2lKVmNLWmtIZUJyWmN4bHA4d3gzNnRuU0ZFdmVlUldaVkFsQmZ4b3Bw?=
 =?utf-8?B?QVFYajg5bUVxM3dSczRLaTFURzdUajJpNm80c2VnbXdPVXc4TWEzWmZxQ2I2?=
 =?utf-8?B?cE1OMjBTeUtCeGQ3RUxNMUxoWUFNQUR2cjlKY0RqNkxVS2UzUDdMNFUyVHVj?=
 =?utf-8?B?MUJ6aWp2cnR4OWs1ckVKdXF5dGp4WW95M0JFUlNxRVNMb1l1dzB3OGhBUmxE?=
 =?utf-8?B?TUdBK0d6blpPVEdtZDhEby9EZ3JwQjY5anJqL3laNm1PTldnajRVaEpUSk5z?=
 =?utf-8?B?amNWa0xtSEVqL2FtajJvYWU2RTVFQUNaUzRsVXd0dFpxRm5nSkU4UzF4VmpW?=
 =?utf-8?B?bGZ5UlQya1VlcWxQUG9BYThqcDEzOVhLZFovRW5obWMwcXVNbS9MMnpERDJn?=
 =?utf-8?B?MzA2ejQ5eFE4ZkRUZDBESzlzMzI4L2NPMGkrdWMyVGUzcnV3VkpUckswa2d4?=
 =?utf-8?B?azBxQ3Y2YnlDbEQxNklNVERENmYwYkNBMWNMOEcrdWxzTFE5bklLK1lCaldt?=
 =?utf-8?B?ZlNQR2J6V29KUGQzdzcyQW9rWFpNVHU1eHlGSmduME5VUk1mcHd2UG5MakdD?=
 =?utf-8?B?djFEVk1zZnl1WmVMNlgyM1RxbTdBRm1KUDV0c2cvZkxuWWhya1BrWElCMU5X?=
 =?utf-8?B?RXRYNzRxY3pTcHpZTU9GWnF6RnBURytJOXRWTVE1c0pxUjNkRlhKUmNZL21G?=
 =?utf-8?B?Umg4QzhleDBuTEQ0cFRRQTBnZEdqMUJpN1FoMnQ4d0t4M1VZdk9CUExPejgw?=
 =?utf-8?B?T09kK20zSVdva0ZKTkYrbzIzOUFGWkFKdzduYk1OYkpMVnpscDlBdE41U2xz?=
 =?utf-8?B?YWV6SThLWC9UckFjSm84RzRXUUZQNGNQc25OZ0JGT1lkQ3pENk1mUmszRjZo?=
 =?utf-8?B?QW1xc2VMZ1RtZkpuaUdzd0MrUitJSDlwdm4rcXBWRjJORkhRNEhjUVJIRG5r?=
 =?utf-8?B?c0pPbzNDMzNtd1EycmpQRTMzY1o1ZmJXdVoxdnJzQ01jb3BKTENBQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afacfeb-8299-4124-438d-08dee48183a4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 04:03:24.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeMEO1JtbVHmljJ1JtMVP55/BgFSX4BJr0dcQAU5nBf20+RHaMaVjGJmIKDCv6PbZ0PxUA7BD1TmsoJj53nqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8923

On Tue, Jul 14, 2026 at 04:46:08PM +0200, Petr Pavlu wrote:
> > @@ -734,7 +734,9 @@
> >  	EARLYCON_TABLE()						\
> >  	LSM_TABLE()							\
> >  	EARLY_LSM_TABLE()						\
> > -	KUNIT_INIT_TABLE()
> > +	KUNIT_INIT_TABLE()						\
> > +	. = ALIGN(8);							\
> 
> Is ALIGN(8) sufficient, or is STRUCT_ALIGN() needed instead?

Hi Petr,

Thank you for your feedback.

I can use STRUCT_ALIGN() instead of ALIGN(8) to match structure alignment.

> > +	BOUNDED_SECTION_PRE_LABEL(.initcall.modnames, initcall_modnames, __start_, __stop_)
> 
> Nit: I think this can be shortened to:
> 
> BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)

Acknowledged.

> >  #define INIT_TEXT							\
> >  	*(.init.text .init.text.*)					\
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 40331923b9f4..9c78b6c30361 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -271,8 +271,30 @@ extern struct module __this_module;
> >  		__initcall_name(initcall, __iid, id),		\
> >  		__initcall_section(__sec, __iid))
> >  
> > -#define ___define_initcall(fn, id, __sec)			\
> > -	__unique_initcall(fn, id, __sec, __initcall_id(fn))
> > +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> > +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
> > +#else
> > +#define __initcall_fn_ptr(fn, __iid, id)	fn
> > +#endif
> > +
> > +struct initcall_modname {
> > +	initcall_t initcall_fn;
> > +	const char *modname;
> > +};
> > +
> > +#define ____define_initcall_modname(fn, id, __sec, __iid)		\
> > +	__unique_initcall(fn, id, __sec, __iid)				\
> > +	static const char __initstr_##fn[] __used __aligned(1)		\
> > +		__section(".init.rodata") = KBUILD_MODNAME;		\
> > +	static const struct initcall_modname __modname_##fn __used	\
> > +		__section(".initcall.modnames") = {			\
> > +			.initcall_fn = __initcall_fn_ptr(fn, __iid, id), \
> > +			.modname = __initstr_##fn			\
> > +		};
> 
> All initcalls are ultimately defined via ____define_initcall_modname(),
> including initcalls in vmlinux code that can never be built as modules.
> In such a case, KBUILD_MODNAME is set to the target's basename (same as
> KBUILD_BASENAME).
> 
> This wastes memory and also allows the module_blacklist parameter to
> match initcalls that are unrelated to built-in modules.

Agreed.

In the next iteration, I restored the default ___define_initcall definition
in include/linux/init.h back to using the standard __unique_initcall
without mapping.

To restrict the mapping strictly to actual built-in modules, I redefined
module_init() under #ifndef MODULE in include/linux/module.h to expand to
____define_initcall_modname().        
  
Indeed since core vmlinux code that can never be built as modules does not
use module_init(), the next iteration ensures that:
  
    1.  No mapping metadata is generated for core subsystem initcalls

    2.  The module_blacklist (or module_denylist) parameters can no longer
        accidentally match or skip unrelated core kernel initcalls

> > +
> > +#define ___define_initcall(fn, id, __sec)				\
> > +	____define_initcall_modname(fn, id, __sec, __initcall_id(fn))
> > +
> >  
> >  #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
> >  
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 7566815fabbe..bc2968c225e1 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -883,6 +883,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
> >  }
> >  #endif /* CONFIG_MODULES */
> >  
> > +extern bool module_is_denylisted(const char *module_name);
> > +
> 
> Nit: The extern keyword in function declarations is unnecessary. See
> Documentation/process/coding-style.rst.

Acknowledged.

> 
> >  #ifdef CONFIG_SYSFS
> >  extern struct kset *module_kset;
> >  extern const struct kobj_type module_ktype;
> > diff --git a/init/main.c b/init/main.c
> > index e363232b428b..af71811d24e3 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1334,12 +1334,65 @@ static inline void do_trace_initcall_level(const char *level)
> >  }
> >  #endif /* !TRACEPOINTS_ENABLED */
> >  
> > +extern struct initcall_modname __start_initcall_modnames[];
> > +extern struct initcall_modname __stop_initcall_modnames[];
> > +
> > +/* module_denylist is a comma-separated list of module names */
> > +static char *module_denylist;
> > +bool module_is_denylisted(const char *module_name)
> 
> module_is_denylisted() should be __init_or_module.

Acknowledged.

> > +{
> > +	const char *p;
> > +	size_t len;
> > +
> > +	if (!module_denylist)
> > +		return false;
> > +
> > +	for (p = module_denylist; *p; p += len) {
> > +		len = strcspn(p, ",");
> > +		if (strlen(module_name) == len && !memcmp(module_name, p, len))
> > +			return true;
> > +		if (p[len] == ',')
> > +			len++;
> > +	}
> > +	return false;
> > +}
> > +core_param(module_denylist, module_denylist, charp, 0400);
> > +core_param(module_blacklist, module_denylist, charp, 0400);
> > +
> > +static const char *initcall_get_modname(initcall_t fn)
> 
> initcall_get_modname() should ideally be __init.

Acknowledged.

> 
> Nit: I think a better name would be something like get_builtin_modname()
> to make clear that the function returns a module name only for built-in
> modules, not regular ones.

Agreed.

> > +{
> > +	struct initcall_modname *p;
> > +	unsigned long addr = (unsigned long)dereference_function_descriptor(fn);
> > +
> > +	if (system_state >= SYSTEM_FREEING_INITMEM)
> > +		return NULL;
> > +
> > +	if (!is_kernel_text(addr) &&
> > +	    !is_kernel_inittext(addr))
> > +		return NULL;
> 
> I believe these checks could be avoided if the code was reorganized to
> avoid reaching this logic on the do_init_module() path in the first
> place.

Agreed.


Kind regards,
-- 
Aaron Tomlin
