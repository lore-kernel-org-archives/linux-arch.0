Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022105.outbound.protection.outlook.com [52.101.101.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188052DF153;
	Fri, 24 Jul 2026 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854025; cv=fail; b=cj6qdP5mZIz4Kbw4cLpVYx+78BL6n4JMlOhPnYCk6N3Kgr85eGNkIztq2ePYYyje4qlN8bYXSi71iTZXQV5om5JimHVoesNGm4lghjJsNk1CcP8DwDhIYUyGwIYPjbtHij4Kv+lDmQ6STnEtxWen141/3uh5RGgdAmBBU0NqDzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854025; c=relaxed/simple;
	bh=lQfUSQqbJWdf8x8ItuN7vvWQUSV+4NZzNJOyRFd4XoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=or4gZwzynoTszUfgICxOemo3zD2PPgQF5yaYuVLgrIstPk4QxfPNxmJuzbBRYYoI0A7jhLYONJ5XjAzmPCcD6TPkSKP8TwoPtr9ASUkemiJbGQzEvjZzsWHwz5nzssQeAMJY3u6r5aqqOLTBH8CvaKjpbz8EgICttMYUgV9tE6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/PohHr3I3Uoc+S9akWjATt3sYtM031Mk9Am3iRlUcC7hOOBXA+vq561DbV6SbaL+M9GhDneYSpzJkPmYdUYU4STn9LDq9KK9wxYIPR6uD6Cd0P1HDffO2sMtTXWqoymH5+t2TMin+CssLD+zRnj02PspkLXFkN3sjRWw8hNvyhYgOWVaXo26OIupGlMBaELcpkyspjpyaR0JOq8McyYRo/SQWEjrnOcUyK8P1NMyYkOXTy2jkqstmwDv8rkPR5mQ+eg8lS+prypMekJGSMsIe9oLoD1wxXPfXpj5K2ctP+swQkZ3AuOg057YU8C/OcFbeTKch0WSLS4+AUmz5HQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=JVoRuTps+/sJ8nBdG8ttgFCUgdpI4quah9Tqm0/+lhk=;
 b=auN9O+/FcWWEU613YjXgjUfMmD2O9g2jAbcSW/J4tbetaHQLTcMG9fibqSgDeM4fwVXplcVSz1UUM7RsMHdkC/qeqmpI7zqiLuPagjWz6gQYfYZZqeRIP20Cyzr5nOYQd6nDy8tCFyw7BZOuYipwCT/Pzb/lcydHTJcL96tdaxatvNmmL5kcpIkborx6apJc9ZX9tqG6vSoegaBFF42RGwhn1TULGabi2rKrJW1pk+CUr3UZEIBrDdfar+RbF7DCGaIgefoYvbIF5RtLwi9/6BZFZK+T5NVnTF82msPg/77Xe/AJStTq8tffgylJsBA4yGxI44iTzK4Z1jibNCQN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3103.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 00:47:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 00:46:59 +0000
Date: Thu, 23 Jul 2026 20:46:54 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org, 
	samitolvanen@google.com, peterz@infradead.org, akpm@linux-foundation.org, 
	mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <nqjc3us7zcb5c5z4jnvku7eho427lk2buqkcf766ujxev5rh5v@5y7npk6z2lyx>
References: <20260718190121.378314-1-atomlin@atomlin.com>
 <20260718190121.378314-2-atomlin@atomlin.com>
 <2cada244-171d-45cb-a6f0-46e6a09375c7@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cada244-171d-45cb-a6f0-46e6a09375c7@suse.com>
X-ClientProxiedBy: BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::13) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3103:EE_
X-MS-Office365-Filtering-Correlation-Id: 33690e9c-bf9a-43a7-dd6a-08dee91d1183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mWSG5jzNDaYuasR0VrrvKTVtQSqel4rYFp450L0elPC7YVT3PAQUu30oldZfHExsZzmKDWTYq4vE+2FR+EAsUj5ujITXRGiCGRs5yFRFoVm+qYgoUhMYYcpG/b462N/y5sOwRuVtFLEMyEgrqZhnQnBmuMhDxbvAaORlQU+qnu5HDfdw5Lz21Z4gGzccQxPMgi47WAjbQ6S8Wn1Y1aRMWmC2uJSyhUNDIB/+EQ5aAk+T35mN5V0ZfPz8JueGdeUS5HnQuttC4Up+9ACbVQRwL0//eLGQy9WSGGRa2MvEu1eq/GiXc2YAp76TYtD9Ry6NVvNrqlspli3b+Oo/0pQ6igKJnP0xDwX4Ei9qcyOxGv6uVA+9VTzjvAD1PlBZWL6JRf3+cAjO1se/+ZKN3DxCZlLOvVYRay1gQK66JYYHuFq1JEN+GWSRb5fCktQ9YyR6x+sEX6c/BDbisDVdw5X4iooFVWvpWB/RBySxhFKxz/xdRtwgtYuIABt+EXHHy7DHbnxIBx286gq9Wn1Bfi8XiBKsGhMlby7y7QuWafRJa6MGo13XQVKcfzlV2kyHrjbIJWsAU4+LQsQ53TX/51uFnuY0JMQqdwsQ0BFymXjemFHOU49KKlVe1IzeHb+A1aERJwTbaGXlB2yeGKa8hYsJJRf6014nA/LNl3TNQI5EP+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNRQ1hscVc1YVREUkpxYzBWQTZQK0ZNbW5xNS91OVB1L3U1OFFoN3ZuRDgr?=
 =?utf-8?B?ajhjbFRibTg5VTJTbmpTdkZ2VlkyMWdNTG5zZmxlZ1FCZVhOUmQrcjMzMjYy?=
 =?utf-8?B?ME1NSkNyd2VUa0FhUitoVE1YNGhJb1lyZTcrTzdWTGpVUWY1Yzd6aGtobnBS?=
 =?utf-8?B?SjZwcUlISnp4c0NhY1dKNzNVaTZiVFZ0RVVsdjhyRUM2Q3Vxb2NRQlpwdmgw?=
 =?utf-8?B?K01BaGpsQ2tFRHMxQllScjVJYk40bFl3OXUzc1hoU0hpd1MxVWtUeXVjeFpq?=
 =?utf-8?B?YTEvSFg2dVJjNVdYQ0oxWFgrUHhxUE5hVTVCVWZZMWtpeGp0cGloaFJiUlJr?=
 =?utf-8?B?TjNmbk1vUFB5bDFlV0cxbDNVK3B5bHF4N0FlQXNFSFpJWDZNSHc4TlcySkhx?=
 =?utf-8?B?RUxYYXQ2Qm5zTnE4OWk0UTR1NFozQVpWcjRTTENsN0lIYTlBbmtVM05KV2xY?=
 =?utf-8?B?bEptckVxc3BWQUxpRDdrNHlJOExtR2NMcElZQkpmSGZiMklad09MN2hqYnk3?=
 =?utf-8?B?aXBiY2NXeE5TVG5ESDVESDIrN1JFc3VGWHh2TDkzYjZmNTBnelBIS0ZmNnpN?=
 =?utf-8?B?c0hjZEVQSFBzazBSZzRPVDZHaUJtMHJ4QjhiWlc1WXhUdmZWazQ4bitaS3dP?=
 =?utf-8?B?U0lncmNtZXNCdWNjNERtaU1kaU1EcWVhd2tlT0ZiSTRHdjkwU2RhVEdUdFJB?=
 =?utf-8?B?ZkdEVUtrR0xTaVdsYWdCZ0V4czNnZ29HK3cwaE1obXh0U1VFUm1wWkVoQ0VC?=
 =?utf-8?B?NnZMQVJnMFBYRWdORTNyQndFbHhoZ3JiRFI3VmpjbGhOOXdDdURKQWg3Zm9W?=
 =?utf-8?B?R04vZWp1TjBFWFNtVmc3cXo3blFUWHBYLzh0RXZYSDU0Q3pOV2M1cnl3bDRz?=
 =?utf-8?B?MCtXV3plSm5jaUZUVXVsbnBUT1JjSXBoZkZaeGNWS05PRUFkS1c1WERDQ1hj?=
 =?utf-8?B?TTVuK3NvWDQzVVl5S1ozZVpvcTlaQ2pIRUF6RXd5cWs1U1cyWXRnUGMzRjhC?=
 =?utf-8?B?dDg4ZWFiN05TTG9rZnZaZVpaN3V1N2wvRjMwVkFsbEdWamZlSVN4bDU0c1Bi?=
 =?utf-8?B?eVBYTUN4bUdpaHFoK1N3SkhjL05rUDYrUjZqUjlPUVpnUythNGxSaFNNM202?=
 =?utf-8?B?RWw3Q1ZJR2d4ZW9XSUdJSldzZFlhbmpsZ1c2bTVtQzVMTmZZZi9YRndqVCtD?=
 =?utf-8?B?OHNRMUVxRmpiUC81V1RuTGVrcEtyZUVFNnNBWldzY2hyZ3FLRlVLL1lIekl1?=
 =?utf-8?B?RGhmMytna1hlZzZ4UEsrMzhSNUw0ckQ3Y3doa3BWVDRYL291c2trRnI0eXMz?=
 =?utf-8?B?c0Nnb1V6MVVnMmVXV0xqc0pVNEFDQ0Q2NnN6am8vU1lsKzZSekNOTlpaOUVK?=
 =?utf-8?B?V0p1c0kxRG9SdUFXaFFlYnZzZUhnVHNuV3RubFVrVUFzeElZT01WZHJTYWR5?=
 =?utf-8?B?N1FsYUJxQ09HVmlLWHJCWnRrQTJOUC91aVdQbUovdGI1Y3BBcVg0b3FacGJO?=
 =?utf-8?B?c3E1VnNKN3h2WHJqNEdHM01RbTMrMnJ6c3hxODNVS2lpSTNYczVzdE95Z2d2?=
 =?utf-8?B?ZFFhTGF5cGZueEZkbU90ZjR0RDFsMERiSyt4clBEY0JNcXZCQnNDWjJ3T2cz?=
 =?utf-8?B?Vkdlc2F3WVc4NUxFc2pJM0c2bUNobGVBMVRZT2NmcmhWcWsrb2t5OXY5YVh6?=
 =?utf-8?B?dWhWaEFyMXFhRVllemM0OSs4ZWh5MHVSTXI4THJCWkY1UW90TnpHVEh6Ty9J?=
 =?utf-8?B?Wm9RVHduSkM4bUp4M3pzNmlnd2xhU2NMNkR4ZHZDbEoycFY1VHMvc2YrMU81?=
 =?utf-8?B?dG9rSTRqZUZMeVlyamkrYVN2YzhpWWZPc0tHMXRNRHhuQVlqUFhob1FQU3pB?=
 =?utf-8?B?SFcwWkVFWU1ncGlwWTgycVhpdDF2d2ovSVkxcUljbVRUNm1lM2lWVU4yakpS?=
 =?utf-8?B?RDVPckw0ZGpyQlFIdW8vV0YwclRRTjhEd2QxSFBsYmRuMnB2L1NyWnFaUjlR?=
 =?utf-8?B?M3k1UHVSc21rUWJCYy9mTVJtUjNDaWNxSkNSaG41ZXM0eXh2Qk5QK0FwVUcz?=
 =?utf-8?B?OGZubEJJZU9oWXJva2VSeXdueXQyd1daMzBYVkdabEtKMUJjbWg3c3lwWG1v?=
 =?utf-8?B?ejVNcGVXMjNhYldWOHBua3JVYWc5MWpFZkJqa2xvUU9ZQjY2YTlxUTlEUnZN?=
 =?utf-8?B?NkJmZnY0T21IdWhlVUZZQWlkUlBwNTFMakdmTkpocTdhNGZSOEQ4TDgvcy80?=
 =?utf-8?B?Tit2VjZkYnlQa3JyVWsxYnI0QlZzWHdZTkZ0YWk3bnl6MnBwd0FGbys1dTk5?=
 =?utf-8?B?Q0lXNWMzRHlyTGdXQ3dJSlQxd2hZcFdCa1diNTlqdWZRbzlEVHNtdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33690e9c-bf9a-43a7-dd6a-08dee91d1183
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 00:46:59.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsEhrndrRB9+6gdTkP9+t6Mccj0nyl7E42oJMD/fNo0DVQXEhVUBvQ5EEVFgGsq/iRSArMgb+ar+5wUtCmCyZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3103

On Wed, Jul 22, 2026 at 03:57:54PM +0200, Petr Pavlu wrote:
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 40331923b9f4..1cf163715264 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -271,7 +271,28 @@ extern struct module __this_module;
> >  		__initcall_name(initcall, __iid, id),		\
> >  		__initcall_section(__sec, __iid))
> >  
> > -#define ___define_initcall(fn, id, __sec)			\
> > +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> > +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
> > +#else
> > +#define __initcall_fn_ptr(fn, __iid, id)	fn
> > +#endif
> 
> Nit: I suggest moving the __initcall_fn_ptr() definition into the
> existing '#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS' block that defines
> ____define_initcall() to make the code shorter and group the related
> implementations.

Hi Petr,

Thanks for the thorough review.

Done. Moved __initcall_fn_ptr() into the existing #ifdef block in init.h.

> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 7566815fabbe..fc1525e8f63c 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -86,7 +86,8 @@ extern void cleanup_module(void);
> >   * builtin) or at module insertion time (if a module).  There can only
> >   * be one per module.
> >   */
> > -#define module_init(x)	__initcall(x);
> > +#define module_init(initfn)					\
> > +	____define_initcall_modname(initfn, 6, .initcall6, __initcall_id(initfn))
> 
> The initcall numbering and section naming should remain defined only in
> one place, in include/linux/init.h.
> 
> Could something like the following work?
> 
> In include/linux/module.h:
> 
> #define module_init(initfn) __builtin_module_initcall(initfn);
> 
> In include/linux/init.h:
> 
> #define __define_initcall_modname(fn, id)				\
> 	__define_initcall(fn, id)					\
> 	static const char __initstr_##fn[] __used __aligned(1)		\
> 		__section(".init.rodata") = KBUILD_MODNAME;		\
> 	static const struct initcall_modname __modname_##fn __used	\
> 		__section(".initcall.modnames") = {			\
> 			.initcall_fn = __initcall_fn_ptr(		\
> 			    fn, .initcall##id, id),			\
> 			.modname = __initstr_##fn			\
> 		};
> 
> #define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)

Adopted this suggestion. This keeps the initcall section naming and level
numbering localised strictly to include/linux/init.h.

> > +static const char *__init get_builtin_modname(initcall_t fn)
> > +{
> > +	struct initcall_modname *p;
> > +
> > +	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
> > +		if (dereference_function_descriptor(p->initcall_fn) ==
> > +		    dereference_function_descriptor(fn))
> 
> Using dereference_function_descriptor() looks unnecessary.

Agreed, removed dereference_function_descriptor() in get_builtin_modname()
and switched to direct pointer comparison.

> Nit: This hunk leaves three consecutive blank lines after
> module_frob_arch_sections().

Acknowledged.

I will include these updates in v7.


Kind regards,
-- 
Aaron Tomlin
