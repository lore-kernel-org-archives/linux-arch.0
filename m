Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020103.outbound.protection.outlook.com [52.101.196.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF363F4830;
	Thu,  6 Aug 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040695; cv=fail; b=rHMfvu2mslt6uyp9+FVRmQjf7f4nbRbh0TwvmSJAGv+MnVsWWglmQEByQrazzbb1wyCLScpQkfBYOOl15gZHn/ACxgMrse+SnqaBuly3VCdHTcZDyCc/oV0I0rZejiyyhG5jEkq7OukvCxwoput/J4qesY4MjgrX4x4gDtSOpzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040695; c=relaxed/simple;
	bh=a/3ZYD3SIUg9P24vDx/kxDGKI+PwM4HBdlF/QdaIA1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vv4dwhA2OTas5N3Cc9lI8/cjdJJI1FPz/Mxo+D3YskkbFVA9DE1zBeBEQWcRoUNZnzQUpIftuy25dceF4vuuZQGd7DG6f33GEw9sCxro6LdKICc96s7IxPS2sc5yX67ujwJbmjvSzr5rGteqpPZ3jInp7+J5zuyZTEZ1x7MdaPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKYUnD1tOH83IkxytVkMO9GQlABE94dsPDyRxUr9dvZpMbmpPd/+cZ4qqWL9mmdO/Ns5zN9/L3WV2WErX4BnxKnF1KHlWOxLJuda+CpFJXaQTh/3OaV3OYqfn0o8omUvWDSnWSGjfH25OXq+MbmNqBzq92kKyYrWxHTCSW51EL49a53BdkONdjx9/K9fcV196w2sItqoOLGlI8umGIGBOIikYZx1molkF8yEZK02s1R/anp/XV/DHGsLqLjjgkh3DYs1W9rMqkJXT6l4osqAPsBw9f8Hub8qvfJub/MdAwcwt6dlG4yIGqvRp6ve5s5POKvIZpaa/FrQB00NwLRD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=dMfaAvnPbY6Bvd3NHGwnerDym0DvJkEmN7yG+ARCAWs=;
 b=BhRV5LnCn3IkCCute6djI6xm0Rv7+IcvScYXu18ILzMTX4roLfRsfuFI9Rmfg1c7olq6qsT45U57X6dBl8UOxaeM9p8B9canCF57zttPyqyVnOsYoyOk4Yn3kHfSfcIoyI632umeoKdSGzgOQ6bZFqqluFQlvIHtQTAVRhY9OY3iqgOLKC8PHTWsLSZby6XQ2cNbSNm8C11mzrz5RFtLf/1nvWXu/hxgvXtmSJS9myAz3dk+g4H/3Pojc4jwLZaziXqszuUSHEs/4MJ1zHisNH8fBrVYpBA0tyqRCOLn5XQmrjpAUfLY+vRRbce/0b+6HoXvmdIpSGFQnzOCo0wFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3423.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:118::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 18:24:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 18:24:49 +0000
Date: Thu, 6 Aug 2026 14:24:45 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org, 
	samitolvanen@google.com, peterz@infradead.org, akpm@linux-foundation.org, 
	mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <4zrv4zwnx4ezqpodow5yplxd6femvpuo57ymbic2yqsv7nvsdr@gz4e2gnnlbtv>
References: <20260724024744.616286-1-atomlin@atomlin.com>
 <20260724024744.616286-2-atomlin@atomlin.com>
 <47e20ce1-c328-4491-b366-c23d5f55a8cc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47e20ce1-c328-4491-b366-c23d5f55a8cc@suse.com>
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3423:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f189c1-a2b2-4e73-de82-08def3e7ffef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|3023799007|56012099006|5023799004|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	44ksk5TRNx8Kf3pySeIDkyOViynJzeaKOm3a7sThTSFdS8WBZ2I0qVHz8iXesxL/Y4eLrCWRVQjvtyNcQFrJcSlfc8HXr+cOp0KUuyxi6a2wI/lSqeeIcwpkxx7EgEyHIGwBXFmXLF3ftnWz48ZXk8VyDkO4VCbSNobYkMcav4sVSG2FxJXrfp9q1PMyCWSqgfYdLbNEWNNLlQW9QKJGT5hKb36FrThbNAbynADuvxIh72DhApRsIULSa8ERVEtJ5rrzJmyKWBpgpXWKTOxzuFlprwbS7Qf2GK8nQzQhNtC1HUJ+YrB02egv0/nRSBrZ+tv1+pHqXkeRE9RtYoi4jktew/1NjPuGBucyCH+cPkLJ54AfwEr1Yvig+mZwW6zRDKIMWBW74w+RaEXE5cQxGt0vorOmMKASZNGGHZiq+WjgFc0w2iv26t8InIVWdwkXc9y8HXGSWWxymn2jFk1u6z7w/T0eg+AdseZ0hi1q8PKxyaXHbwBTK+NistkvMzWSH5clnwdizsu5+YAJFzr1xXq3rufXNQ6yO4FFPklP9NwwdbJ7ZA2Vj4rgLYE+N9ErnX2pdP8s8aZw5m80sI9HHJXuwLcjju+IbHdYHE1YSoGPDY0amdAcv6ScdtFpJ961skbAyRFLrW37auSICvSkXoIgY4pwX9uRui8zM6iiWXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(3023799007)(56012099006)(5023799004)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUlOaU1vWXJFS0txcTh6Qkh2R3ZOS3UrTWx3Q0hCb3ZBZ1NpMDJhN2Z4N3Z3?=
 =?utf-8?B?M0EyRWZLbTJqbUFkbWplUVd3RW53SmcrWnFVQUgrS2Z4cE5mZkNLWVlPcHUv?=
 =?utf-8?B?SUhkajRpb0JsTjNRNENscWxQYk5UQ3c0MWtzNjZxSlh4c2IwcDZkcGpncEFk?=
 =?utf-8?B?LzlUdnFEczhyVVJsSGxRdnJPRU9oSXEwLzYzMUZWQVpzc1I3c3BMb3NPREo4?=
 =?utf-8?B?dGhtUXlSRE1rUXNYcVM3U1I3T3Z5Mmd1UDFtYmxxNTlqWVhlZkNFMG1ibVUx?=
 =?utf-8?B?dVFyS3M1cGMwZWkwT24zcGFhR3RvWkFsb3VKQ3p1V0dHbjFLZTlzV1A3UEdq?=
 =?utf-8?B?aUJmZ3F3eHZDSVhqeTlqL05Ib1Y4Y0FXWFBySHM4eEhYZ29aR2tNUGVKREV6?=
 =?utf-8?B?UUtUK1BTaW40T2VjZzlWaVBKRXZNS0NWaXZOcXYyYmR6SUdBemtKbGVXUWhB?=
 =?utf-8?B?b1ovYXV4Tmw3QmJuK29zdW1GdDdsNWlSc0xmTmtKMC8vVEdyVkxuM0U4TW05?=
 =?utf-8?B?WGN2MWlpMXpnM0h5YUd5WExKVjNRck00blYwTURBY05OM09MOGRYMGRwOWZl?=
 =?utf-8?B?L3RiZTQ4VGdTUHBiK2FvYldobmJEUkZsTkVNQnN1cDVEanpkcFlzV002b0lm?=
 =?utf-8?B?UkRVOGhZa0lBQzdEUTFBblVtZDRybTFQY0VJcDd1eVA1elNDZGdpdGlDZVVq?=
 =?utf-8?B?amd0ZHR5SEpqZmFLYkFHYnVUSGwySXhraDM0RUFTWTlxemJVeDNpUlZ2K2x1?=
 =?utf-8?B?S1RIT2cwSWhjZENVSGUrWjVuYU9lZmpKUzBXTWgvbW9EY2tTRjNrMUNTbVJT?=
 =?utf-8?B?SWhRS1Z4bU8rWHJYbnY1Uy80M2lsNWg1UWhPVDNMUGZQWjQ4WkZYTFA4bGhK?=
 =?utf-8?B?cTFBeUJyYWFvc1NaK0RRWWc1a1pxMzBNSUNIKzRlWEZWTE1yQTVwR2ZOa2hW?=
 =?utf-8?B?eitkQVRUdmtvbWhNNWZqN29KeXRaTlhhNWppd0hBeUlwZUdRU0J6VVpKK3F1?=
 =?utf-8?B?VDFpaTZ2TkJZNlFCR2dNSEFJcnRQYnZsbGxiRFZHUDlTZjR1UEJRUldoSnZv?=
 =?utf-8?B?NEllMGFiZVBUYzN0WlRrbnU5YkREbStmSnpHRmpZL2pUS2Z1Y2hKMlFvSDlF?=
 =?utf-8?B?bkYrb28xaE5KS0QrVWNDL2lFUVdHWmNVU3dBdWs5bzFkMndLa2FBdElUU3BG?=
 =?utf-8?B?TUp1TWwya0w3bTNFRWVtMjVqeHBXam5ZSnRvclpNQnZlOWZ2VGNmbFhvN2V3?=
 =?utf-8?B?NEhyeDZYU3BpbUM5N24yRTFlWkJaeTZYTWUwZzFiSnp1VU9RUXBVaHdmNENq?=
 =?utf-8?B?cHZMdHRMTFBMbDZ4NGREZzlJczJ6QS9PSlZXcGhoaHc0MHJ0TENEQmVyemQr?=
 =?utf-8?B?bUVyVzlTOHlONUVVdU1mY3V2Z05xWFJWNFZXMVp1bzFrbFhJVUptYkw3ZWox?=
 =?utf-8?B?S0w0aWt4VHNYS2RjcGxVaTdlTDNDTnpyeVRpUlZoenI5bVRXR0VSQmJGTVcv?=
 =?utf-8?B?WitQZFJIVW5WS2s4RzkvVS83RVNtbG1iTWJNanNEdWNDZmZkOXphZ0V6dXox?=
 =?utf-8?B?bjU0cHZIREtMR1d4Ty92a1NZNkg1YkF0TTg2eEJRbkVxem84Zlp6SVE0Y2Vv?=
 =?utf-8?B?L09CNmx3eGM4dW90cldDN0dvMHhvSUVYTEtrWDBhZjFvaXFPanBVM2lzM2pi?=
 =?utf-8?B?SXBUd1pDV0Q2RVNMODd0NGZwZVJoU3ByYlRHOVplMHlwRnR3RFpwNzlkZTQv?=
 =?utf-8?B?WTNpSjhVYVBBWWt3SitXN1hWQnp6ZEVxQ3VuaWhPNWIwaG1qY1o1VGFicllv?=
 =?utf-8?B?bS9hS0VpS2hzNVBaQ01IOUlQYlM1WURBVDcrMGFSTXZnb2ZSQzd0QkFCazhH?=
 =?utf-8?B?TkRkVEFOVENhYmZxT1ZZa0taTEJRMjBLZE5CWU9yTmg5NTdLa3VNQUN6WDlZ?=
 =?utf-8?B?dk5kYTVFVWx3UUwzQUczSWF5akJyYUlMSmVNSXpJejZlOFozUmlzY3VqVDI2?=
 =?utf-8?B?a1drb2swSzNaRktFTDYyd3NQVGVnWkRKODNwMHk0dUQwUTNSMXdwaWNSYXRv?=
 =?utf-8?B?UmVaTHR1cUtnRmZsaG1jR0ZzaFNQbEZVVURFSFF0ZlgvYllYaGpTdjNNbnpt?=
 =?utf-8?B?VmEwTkdNQVJ5SUVleGYxQkNQejVzVW90YXFKMm90UWtkSGtwNjdseTJsQUI3?=
 =?utf-8?B?UnNSUG0yVjdLNTdtY3YyT21Na1FueEd6NjdjMG5pc3huTkhzdDZHakw2bnk2?=
 =?utf-8?B?L1pFV1dTQ25zNU5Na2lsUWxuSmJQYTRkQUFGNUFBRjdFaFl6dzcxRlVCam1W?=
 =?utf-8?B?UzMvVVozT0ZBOTA3V29nUXdIS1UvUHI0a1JUK0VmYWIrazkrUWVjZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f189c1-a2b2-4e73-de82-08def3e7ffef
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:24:49.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYgrJmB1sOJnvZOeEZUH9I9J5aTSjFRNkd0LfPc38lYvPJCC5QiQw7hgmWroQJCfXkh2LwnFgEHr0jlNZtyUPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3423

On Mon, Aug 03, 2026 at 05:55:28PM +0200, Petr Pavlu wrote:
> > Design Considerations and Trade-offs:
> > 
> >     1.  LTO and CFI Compatibility vs. PREL32
> > 
> >         Previous iterations of this patch attempted to use top-level
> >         inline assembly to generate 32-bit relative offsets (PREL32) to
> >         save memory. However, raw inline assembly operates blindly
> >         outside of the C compiler's visibility. When compiled with
> >         CONFIG_LTO_CLANG or CONFIG_CFI_CLANG, the compiler applies
> >         symbol renaming and generates Control Flow Integrity stubs.
> >         The raw assembly string-matching fails to track these changes,
> >         resulting in undefined references or runtime address mismatches.
> > 
> >         To resolve this, we strictly use standard C structures to hold
> >         the function pointers. This natively allows the compiler to
> >         resolve LTO renaming and map CFI stubs correctly. We trade the
> >         minor spatial optimisation of PREL32 (using absolute 64-bit
> >         pointers instead) to guarantee architectural safety under modern
> >         compiler protections. Because this metadata is placed in an
> >         ".init" section and freed entirely after boot, the temporary
> >         memory overhead is negligible.
> > 
> >     2.  Architectural Safety and Elimination of Runtime Vulnerabilities:
> > 
> >         By embedding the boot-time blacklist check inside the
> >         do_one_initcall_builtin() __init wrapper function, we ensure
> >         the metadata lookup logic is exclusively invoked during early
> >         boot. This approach provides strict structural guarantees:
> >         - It inherently eliminates Use-After-Free (UAF) and race conditions
> >           since loadable modules (which execute post-boot and invoke
> >           do_one_initcall() directly) bypass this __init wrapper entirely.
> >         - It prevents modpost section mismatch warnings since the __init
> >           metadata is strictly accessed by other __init functions.
> >         - It mitigates Spectre v1 speculative execution vulnerabilities
> >           by guaranteeing the unprivileged runtime module loading path
> >           cannot speculatively branch into reclaimed .init.text instructions.
> 
> I suggest moving these design notes below the --- separator, together
> with the diffstat.

Acknowledged.

> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h |  4 ++-
> >  include/linux/init.h              | 27 +++++++++++++++-
> >  include/linux/module.h            |  4 ++-
> >  init/main.c                       | 54 +++++++++++++++++++++++++++++--
> >  kernel/module/main.c              | 22 +------------
> 
> The Rust module support in rust/macros/module.rs should be updated
> similarly to maintain feature parity.

Acknowledged.

> > +#define ___define_initcall_modname(fn, id, __sec)			\
> > +	____define_initcall_modname(fn, id, __sec, __initcall_id(fn))
> > +
> > +#define __define_initcall_modname(fn, id)				\
> > +	___define_initcall_modname(fn, id, .initcall##id)
> 
> These two macros can be merged into:

Acknowledged.

> #define __define_initcall_modname(fn, id)				\
> 	___define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))
> 
> > +
> > +#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
> > +
> > +#define ___define_initcall(fn, id, __sec)				\
> >  	__unique_initcall(fn, id, __sec, __initcall_id(fn))
> >  
> >  #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 7566815fabbe..ecc4db15ff4a 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -86,7 +86,7 @@ extern void cleanup_module(void);
> >   * builtin) or at module insertion time (if a module).  There can only
> >   * be one per module.
> >   */
> > -#define module_init(x)	__initcall(x);
> > +#define module_init(initfn)	__builtin_module_initcall(initfn);
> 
> Renaming the macro parameter from `x` to `initfn` is unnecessary in this
> patchset and also makes the preceding comment inconsistent, since it
> still refers to `x`.

Acknowledged.

> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 46dd8d25a605..5c90ebedbf68 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2919,26 +2919,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
> >  	return 0;
> >  }
> >  
> > -/* module_blacklist is a comma-separated list of module names */
> > -static char *module_blacklist;
> > -static bool blacklisted(const char *module_name)
> > -{
> > -	const char *p;
> > -	size_t len;
> > -
> > -	if (!module_blacklist)
> > -		return false;
> > -
> > -	for (p = module_blacklist; *p; p += len) {
> > -		len = strcspn(p, ",");
> > -		if (strlen(module_name) == len && !memcmp(module_name, p, len))
> > -			return true;
> > -		if (p[len] == ',')
> > -			len++;
> > -	}
> > -	return false;
> > -}
> > -core_param(module_blacklist, module_blacklist, charp, 0400);
> >  
> 
> This still leaves two blank lines between module_frob_arch_sections()
> and layout_and_allocate(), instead of just one.

Acknowledged.


Kind regards,
-- 
Aaron Tomlin
