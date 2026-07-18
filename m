Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020081.outbound.protection.outlook.com [52.101.195.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D1175A5;
	Sat, 18 Jul 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339905; cv=fail; b=KKmtC/7BHUqx6vry0n0yGEpLqjyEJoVNbmVPybXiw92Y1tNI0Qxg0vvg9inb0UUN0JT1cpXuzqWLAnBYG91j8mXHAF4c5QinjXS43KCSV5c6LgcpbTAgCJrBhEDap0vhWCna5rSmQVhR32JNrp3uorTXGqu0w1mXHbWYjM+xZBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339905; c=relaxed/simple;
	bh=c1a8bEfUj7IGjDsqQzqYLa6xjwcO2R89/8znhFOgcmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWmNDCIG5RPgtINeAH+k85aqlB5iWijExJ9uNQwzJhflOskvw39S5DXy+cSZh4JFo1n6XoKiLtA9dDe4WPZg9bcC/H0PmDWisR96Y++p6xbB4XBaHhDMFWzvUWpzR7mMFPWEzuXIWz5exAg2MWxvmn7fj9wbJitjDgqCVUJbJi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kChp7lFBXzM3OnaynWKPAf2R1ar0UL6MJZZQIR5io8zZPxp0LGjG/10p44VAOMj3nWH+1saHRUXZlsesJhs18TrKAkPnm6CIic4CA/M5rnnr26zg3puD8Nnz23QWPnjyum9eOipJFfhP5g6kksVCUrZulClZ0DftgDIT6CXuWnXDkk+epIn/12VhwQDNCuoHZlW0oA7y9sMBhrWGc1hkxcVRSY7kE1IxWbF9msHKPHuR9aTBr9l5hX3XZ7i/LN49TFmLsvjJa1zrPf6TAk/wi7jM6yEYr10V7lgP6+HsDSkQDOYFFiXcvI2V/trDV6TYDSlc75mbygp+L5G3f4Vh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tVyn9H+w1f4OkxdFOQNuA+Ps39csuzKwwC82vktUv/Q=;
 b=KwzOa8ssQYV2aO1+/xHFSHRtoc7vke2tAygapsOla6GidSjmGgYrl95/ifG+di5uvRt+LnIu3Htwhj2ohxOfwB8oqWj1MmUMTVql+w4fksDfVv51YHyZSnX+I9TBMDLS3A20LP8apVaZJvjGjt+Rb+nxhMYjcOSc+qyPYUDY3KigCK3acxnpxBKnEVGbrpbm8pjmalPScEMpTvglxpsXLR+TRoaY8AEwlM4Br5rjuOedicoelJEx5pn2gZMznrgmhNqvTAluTMmdfebZE7ixPa0NL22ND6JVTOx1k3p0oUohaAvLTFYcL/gEAJ/GduqukLrSudWMozoU1JQaibwLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8504.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 01:58:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 01:58:20 +0000
Date: Fri, 17 Jul 2026 21:58:16 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <xiclw5xqmrywerkf5tgc6zpu3gcj7gtjadjcqhzw5q7tjdiuvu@f7blmu6erjt3>
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <CABCJKufGH621Vh6JBxmk5XVrFETSvX2tJP1bNiBRg0T-=n+GRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKufGH621Vh6JBxmk5XVrFETSvX2tJP1bNiBRg0T-=n+GRw@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:408:f9::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 607d7d5c-c9e1-4d57-10d9-08dee4700a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|5023799004|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XQ91EtmvBhtF6EgOBh/K6mEnLtFrbSQeWrwzmPWkwyiqtrPkmIE5JtA2qSQ5yFSk6iHIWI/nbJQ2/ViKKtsfcdLK/DKzFpwwjNCpInrUVBsljy9uwgm93KY1s504WbAtkG6DpBGj+57sBaonFvKtQtorvPxt1tp9G8LJxB9gYewuFAD9VLJV/GTJrLkrzjS8ml99VZdWm/gHhszgGP2SmRRQZwSf2k2+k8zxr+efxMDUhu2h2+pROa6rFaAg/XIbcClgsZbFeoAuKlIVtfnpwqUJd941SAxY9Cqf5YV13U2vSjZYrYp1DQ4ObS5jZgzW+alRX0yn30+c1qcZxBhw2WZgMj3qik55k4uEL3g2xxQav5hZ+Ft5WBT/QJ8HB0ncBzGi6hlAHtQA+Dn8BVh3Er+6lTcbF6fT40g2i1A0jgPNeJU5B3GcIUIPPuFokaPTOuYWb+3W8NiSt3Ngy7mViiuh7VzKQ/mbEzu7BstXkUt+O3JreNrb/XLJLXtH3tQ2qsXFnXieG/R/QENYNcldeBc0EyLtoDvgQVdTA44jQ+DwZ5fRls4yJT0icRmHgZGCdEYKjWNN/th6uMJb4W6ZKikq9I0bEs9OXBlDlD50g49DyMTwzb2eLfe9e8VDK8010NJQEDP4CakwNta2o7IcWTZxU8H1JUD0RkTVUs52MO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(5023799004)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXlFbUV2K1NMRzh2Y1NoZWVuNWFFaUVkMlJLTFByVU9zMk42emlsbG4vaGNk?=
 =?utf-8?B?UzdEY1RPSjc3Y0M4dEdFM010YXNlaXRBNURKMVhIQWU2K1N5UGRzMHdjVFgw?=
 =?utf-8?B?VXgwVjA1d2ZXZWVZSHRYQXdkbHpScnhxMXdmMmVzcVBqQ0huSDJmV0tqb0pC?=
 =?utf-8?B?Rzc0QmI5Y0xSbHl6blRRTDNSK3FML3RQeUJvMjZVWUFUTFE2QWJ0M2drRURJ?=
 =?utf-8?B?b2NIS0RJOVUzbThkWjVMRG9zMFc5Sk1pYUt3UldOMjBaYzI1ditpY21wUGxo?=
 =?utf-8?B?a1poV2IrYk1GbFNPZFM1MnlTazl0cVo4UmpzOWlTV09CcFJkbnRHK0ZXdGpr?=
 =?utf-8?B?ZDZNNXZaSnYxcTBDN0ZKQThmbk12U2J3QWZXYVFWTmhEWnFzS3o1S1VTQ1R5?=
 =?utf-8?B?OXVZVm9nZlZWQ0VLSHVmZUZiSUxOUDBERFlVUjlFaWdqayt4T3VLVXVxOGhN?=
 =?utf-8?B?YzZ3SlB3bWthSUh6WkJ3VldLRnpsZ3h2SjUreWpGclJhVU10amcyRFZ0c2FH?=
 =?utf-8?B?NGNNL3FmeDNJZG9LZ0VBcldpZ0x6VUVJc1hyb3hXQ1cxZjRyV2NVeTY1OGZE?=
 =?utf-8?B?SUJ5ZnN3bVRObVBYWDZRZ2V4aTBnVlJ5OW80MGN5d0wvRU9zSnVyaUt4bDJm?=
 =?utf-8?B?dDljOExJaS8yWHZxcVNBWHh6MW93VVBVRGcxS25kUmdQQUtUSHpQeGNJbHc2?=
 =?utf-8?B?aTcrMHFHSy9hYXpOS29Cc1NsWGR6MWExbjNQc3J5eHczNHUxYTNQSzBodWJ5?=
 =?utf-8?B?S05SNTkyZE9rc3pDQ3VSNFVkeTdEMk9QSzhRMW5xVFBySzZ5ZEwzNGFDNU5o?=
 =?utf-8?B?NUlBUDIwMURGdWVGRkc5WnhhMEdROUUxeWdSOU1QempKcmhqVWNyR0hVMk1R?=
 =?utf-8?B?eWdQZ2NyOGYwc29adEdjbGhneXZUTk1qa1RRY3E5TXgxWVlLdWFudWs5OXkr?=
 =?utf-8?B?ZUd3cUNSTnRKZzlHbmlWelhzL0dTTGZzbDNYdUhINGdsVllZRkxjWFJrOHFu?=
 =?utf-8?B?ZEVoa2VHbEJTSFBYdDQ0eEJWN291L1V1VzF3Z0hlaGg4clNNMVNBbjlIcWtk?=
 =?utf-8?B?THVpZ2s5WGhPdjFMdzdsaWZRekl1eU93eXhQN1hkRnA2Y0hQbjZrbUt0OXpi?=
 =?utf-8?B?UEpySWUxMXk1bnlJODYvZ0s1MHpzUWNiVE5KbWMvZ2xlS21QV29BREJ6UXFj?=
 =?utf-8?B?U2drYUgwaUtCU29kbFpvOWlIWmEreGJIa2s1OXRzVHFEb29YODFUYmwrR29z?=
 =?utf-8?B?K1hPaG1LLytlNkJhVEE3TzZoS0RnOVkrTnZ4VUt4YlREalVpMlZSdTBzai9u?=
 =?utf-8?B?NFdxaVNwaVh6b1krdHllQXNjVXRSeVdSUzhldmV2aFJrckFweWFidjJtR2JX?=
 =?utf-8?B?UTA5SXpFTElDeGFORXFnNFJFSXovUEZBc1RIejB1a1VFVzFYeTltZXJpZS9B?=
 =?utf-8?B?Y3RoNWpiN3lnbnFTWkhNNXo2VzJ0RlRwczhXNmh6WnFIZW9XaHdQb1J6U2NU?=
 =?utf-8?B?eENPL3hEek9uMk5OMjY0b0x3bWd2VUMvbkdHNFJFS0tNS2NHNVNzTjRra1Jv?=
 =?utf-8?B?NHFjQWRKRkRHY2tlRDdjU1VWQit1eFNMNTBUKy8yS25SdGltVlc0OGREbm50?=
 =?utf-8?B?RXlpbzlHelhMdm1zVU1GOVl5aEhZUUZqT1FKYk1tTmYyQUJ3Z1QxSjlBZkU1?=
 =?utf-8?B?T2dSWVJrRG1Ra0UwVUVGQ2xNYnpKN3pTWUF3UVFDMzF3cjQ3b29QUkhXaW9F?=
 =?utf-8?B?K2tBY21hTEVqWjFOMG8xMmxwS1hUdEp6RTk5aFRWN1cydHB2RkVjTVJvS2w0?=
 =?utf-8?B?U20yRlVFMUFaQVZmR29mOUtHMFNYUFNxNExrRHUzWG9BRGtCSXp1akV3QmVn?=
 =?utf-8?B?ZUpYaHl0YnlJYnZNNkNRa0laUitYU3NSWG84TXJzckxKMGgwaFNvZnlMRG9W?=
 =?utf-8?B?RVo2UFlZTEpnOGxMellIUnRxQit2REtkemlEZEFVOXkzR0FweWcrazVvbHdH?=
 =?utf-8?B?b0VaSnhoSTZOU2s4aEMzb3FjYmpZQkU2K1dhc0VwdERyNSszdGROcVdXTUor?=
 =?utf-8?B?eS9yaDFIYis1U0pvK2RyYnViNUgwUXAzekpac1JEQWZTWHhwMUNURjhXYUFD?=
 =?utf-8?B?R0ErZ3JIS1dLNDlpbURTUGdJWE41Q2JSYTdaQWs0YlY4bUM3d0FKQWlZdTVB?=
 =?utf-8?B?R0ZMYWNqbVpWU0psSG5BREQzZk1sa0xjQU1uZTNqMmJRMzNjSllwdVpFdzNK?=
 =?utf-8?B?b1dJMzV3VElOZGlPTjdodEZCYUphUnVXT2F2UHBoM2dRNjVyNHFZU3VyWXBO?=
 =?utf-8?B?TStsNTM5Smg5UE5LdVpQZi9oQUJlUTBHODV6RktlYkgyek01ckJMdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607d7d5c-c9e1-4d57-10d9-08dee4700a79
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 01:58:19.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pqlo/G2FzVs3zF95fb5vR62NZ30yK76Kl/8i2AG2eOWmdQ//UMILGb9GJeIkjpnsNy+ENz3VVrVblWKANYs5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8504

On Fri, Jul 10, 2026 at 08:42:49AM -0700, Sami Tolvanen wrote:
> Hi Aaron,
> 
> On Tue, Jul 7, 2026 at 7:00 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> >
> > +static const char *initcall_get_modname(initcall_t fn)
> > +{
> > +       struct initcall_modname *p;
> > +       unsigned long addr = (unsigned long)dereference_function_descriptor(fn);
> > +
> > +       if (system_state >= SYSTEM_FREEING_INITMEM)
> > +               return NULL;
> > +
> > +       if (!is_kernel_text(addr) &&
> > +           !is_kernel_inittext(addr))
> > +               return NULL;
> > +
> > +       for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
> > +               if (dereference_function_descriptor(p->initcall_fn) ==
> > +                   dereference_function_descriptor(fn))
> > +                       return p->modname;
> > +       }
> > +       return NULL;
> > +}
> > +
> >  int __init_or_module do_one_initcall(initcall_t fn)
> >  {
> >         int count = preempt_count();
> >         char msgbuf[64];
> > +       const char *modname;
> >         int ret;
> >
> > +       modname = initcall_get_modname(fn);
> 
> If I'm reading this correctly, this ends up scanning the
> initcall_modnames list for every initcall. Have you measured whether
> this has any boot time impact? Can we at least skip this scan if no
> module denylist is provided?

Hi Sami,

Avoiding unnecessary overhead on the critical boot path is absolutely the
right approach.

I completely agree with your suggestion to bypass the scan when it is not
needed. In the forthcoming iteration, I will introduce a fast-path check.
Since the denylist parameter is strictly opt-in, we can simply evaluate
whether module_denylist (or module_blacklist) has been populated before
calling initcall_get_modname().

This was previously reiterated to Arnd here [1].

[1]: https://lore.kernel.org/lkml/ea7kdjwoucecvetzf73ce5dpda3l3etb6i75bks6deekfu6mb6@ooptba3x2oh3/


Kind regards,
-- 
Aaron Tomlin
