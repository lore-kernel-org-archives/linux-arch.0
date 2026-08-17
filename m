Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F535361DDA;
	Mon, 17 Aug 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996916; cv=fail; b=sk3JTJywXwD680arUTz6tgiziMD5BnQkQwBwC7dr1wn9k+9WShKkVpA/CSW6RCT5QYMrpbDBN6iGTWm4JbQQHzRc2V8zJHQF43QPVJpFX+9pLVYVR1UvkMGa++LU8MIueTuBa1PFjosUqqzma6Sd+SsdnS8HXjk3qr8BLabduSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996916; c=relaxed/simple;
	bh=F6ytRHBak3Nv3vvAQ+Iwo2Z8y4gVh36gb2/jTJbAjuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lGDocR/REu51tN5NZJU4D4wcDz8VKWD2sxVu0sdxoxqQ27EgdfCqfl4xfP3RRQvr8ajDpkMT1/U15nSj5eLD/4v+cW5KgHAA9hOmD4h5a4rKnXxJF4EnSnSsuZxh255tKBepYlr9Yx9RSB+d8IOXIPlkQFMDMd/1u7gqEbt7uUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE+TnYBlV0A+U8vKjoHe8yiCPIqQe+KkOgact6HxCQo9R8YYrINLQQh6TJ6m1rXMzOF7zOo7LY1Ocw4LVPp8z2RbZex+893s2DG4C8JCkaITZVZtV8PTRJMFlo4Vr13GXe5fJ96BDDT6Tc2ZTcNHLEOgGy75+LOIntuO/ZhySSeeICgkSLYHbJ1o69yDR4FnQQh+8eLYrbCQq207zFBhNBnywzpXzH4g3vorkbRCwHf9ayMRwUgIaXOcyUzdnavuYPOS6GW3vNefFjMoRSTzP0z9xtmgCD2/LWRrGTJAapqNXlo4a/ITsEjRvObo78tdzmZ58db9hBUK7F/Ap0rjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Uun0NEv6w6dN3Bzo3G1YbZPjhHAXEBKJCo5JO23U84Q=;
 b=KaKuIwSs7sB95wORsWxTR1KpXrYqkig1j0pw24MiCcLeZbSCkII4DMxdFIvRqTtTtlZt2NWGR4vmvTIVQfLbT9UIMxKe6vttNUCtFHWHfj8wMGd1buGBx+yhIVV3K8aKOiQCJoiw992cSvy/Upxrz9EueIyQ0T1/o+aqlOc8I7hrPr1mgGj2uCYA00cqLaw7eDLSjHVMkSi5Kcr+tpVTvEjjxfrlPJMfGxLitFDvPYGkFGQU9GCxNbfQTaMws4ZSguz04A9Kb7aZl9rcSeLQ+xmuAAz4yZtdJss/tjAYOYvkJuJn2J2N5H1bu6XZJAI6Wy2ecsuEwWxebnKxVjiPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6421.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:01:50 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 20:01:50 +0000
Date: Mon, 17 Aug 2026 16:01:46 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Gary Guo <gary@garyguo.net>, arnd@arndb.de, mcgrof@kernel.org, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org, 
	akpm@linux-foundation.org, mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <2oh4gzy5y3slhtidyinx444m2xguffl2azbcoirbyw4j5cauho@4wugqgi5fjr2>
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <DKNWEO3BOUOL.9COZBXZIGS6A@garyguo.net>
 <9044355d-bff2-44fa-a8e2-ee3500aa1af0@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9044355d-bff2-44fa-a8e2-ee3500aa1af0@suse.com>
X-ClientProxiedBy: BN9PR03CA0898.namprd03.prod.outlook.com
 (2603:10b6:408:13c::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cc5980-1aaa-4af7-a395-08defc9a5fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vOw+tJo4GPGhlNycdbbm1EInPzu/TWZTyB9XnVKJDP5pyJYVUT2e7rppJ8HWA8PrgplGk800rf0rbAlb9B8u8cwZqDtlLdZA+NQLUghcJBjpp/I62JZ81Hqso91Lxv8tSEb2BzxmVgDNZ0h/Sp3XlqM9rEZuhp5LXlc2pcY34nP11fF8xRtgamNB4PBvJBcppdRiH9alaRvX+BWYm47tYy/zX3Ix+Zlii5oAqnNkxul/8RffHUU555QRL/GiNZJ2hfCeG9AZbknxkA5pOLZb0DnCPA2hUJQcZKgij1/Dq2kRFw9ukc9LW+2U/bT17g1MVQk3T9D3Y1vuVwxhBre3SGBzRIt5IxatS2Kmuj3+EMRzXF/jSJEgEGO0T65CN01StOS8Ei6ZmvlWWD3F6wB5ezE6HN33M5w+L/Ul37fZyyyklL0o/PSg3NSEBZtquTZUQvHVfZvCORuf+YJcaWWAMojw/+aGD5d4zwE8kzA9KeFlMOvn8UfgA/7mM94NqAZaVxvNIxYCN92R9Pewibmz/Yzl9W21JV224WksXWTjWooqsfPIBRgeESraWHwPDXIoPrc4nFT4VAw+csVQKxSaETNWg0jDtk9khwZkoSYGfufB8j7mKtU6ctaHtD8w8FIt3He7vfUQjK34BJOuriLk7gAQH40vBVCQY5ISlAgf3rw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmNrYndEN0xlQ29KRjUxVUMzNUlLTlhLZ1pZaVZOdHBMT3lJUU1qY29YYk82?=
 =?utf-8?B?ZE9GYnlQbDFuMEdpR3daZmVHVnJ4aERCZFNDZC9KVTNCRlBmR0llR09CWElR?=
 =?utf-8?B?UGdlVkZCb09YZ0hrejUzZURWaGlkaXNmbGszcERweFd1UG1wWGo5NWFtcGFE?=
 =?utf-8?B?QThqdlhKdXh2WkEzVzcwbHJWQ0lHUUdJTlozUmt5NzFXVDE2c09Da0FYdkZp?=
 =?utf-8?B?WUJ5SEdYblJmTC9mdExURXVRMGlJSldBUVNUbHRscERKamV0ek9ZNVVSL2RP?=
 =?utf-8?B?TGJ2dW44K3l4QnZkWWcyazNxQkFqcEMzNkFYT0RUUmV1YnBqVFdpM1ZZblBl?=
 =?utf-8?B?UlEvQ3ZYYWxhRG1tMjNEa2pBRHpMazFVRmNUZk00UGRGdHJ3U3JLbTNwMHBK?=
 =?utf-8?B?NEZLeVVLY01IS1dIOUoxeVRDQkZHRUs4dTQrU21VSkU1RzlxdWVlTjY2TkRD?=
 =?utf-8?B?WXlha0pYREpnS2RyV3JjL3lwZVZRRGdOa3VibnlpZjlycXNrZWVyWVBTUUk0?=
 =?utf-8?B?em53MHJwYlhnUDNCYmI4QnhMZ1dhZUE4dFlobkhUR2tUSkl5UW5SeFFGMCt4?=
 =?utf-8?B?MzIxWkkvWWxxTXlMRThnOWRXN2ZZYnVOZStUdmdZL1FkZE9jZWdXOE9jYlJm?=
 =?utf-8?B?QlVOZkxLTHFzVG5mNnowTmhsMWVaZ3ZicUJld1hidU8yUEZsS3orbjVuUE8x?=
 =?utf-8?B?WTZKb01ENXMrckRtYkJ1SnNMa013UFVKSitMSHNHblNxNENzelJBaUdJMjFB?=
 =?utf-8?B?R2F3NVlpR01LcW9NcFBGMFlzRkg0anQ2Z3poZnc1U0V1eUdEN0lXK3FybWFY?=
 =?utf-8?B?VE5XZDVxdEdCOUtZcE5ONnhEemkyd2J6amppVzBHT2ZTcnpDYTQ4THpqZ3Zo?=
 =?utf-8?B?KzA3VUhIbERhMVRYbm05YzRmTmJKQ2MyK1lKVVh5SkZEY0R3QXRCZEE3eVQz?=
 =?utf-8?B?N1FmRS9SNjVmRENUZTFhTmQzcVRoZndPQ0F5VXM5Ykh5NE0wQm45SUlXU1R1?=
 =?utf-8?B?T3NVTFpYV2g4WGM1Z045MVcvSXVjMzhiMWFiQWtsOFNWclc1bTV3TXFwSHll?=
 =?utf-8?B?T3Q5TjdrVGhNcllDd1JOTEZjK3F2U3V1Rks5a0NnYUR2RFpaY2dlTHRaMldq?=
 =?utf-8?B?TnBNNFYwa3d0bW9mdEo2TCtCYXhvZEEzMVh5V1pZaDlUVklpeEVxQ25tY0FM?=
 =?utf-8?B?cm5ONjAxRXpwRnhVdjk0YzVKY3dQZzhMNmZuMDBYSFdYUUtFYnVXcll0ajVZ?=
 =?utf-8?B?Z05QRHEreHhKSS9vSHBia28wM3UycGgrSWhVUXRoblphK2NqWHpqdFN2SUFS?=
 =?utf-8?B?RjkvdXVIL2l3VWg4V1ZUUmlwQ3lIdS85NUkrUk1Cb3l1b2lKR0N1SkNsNnBn?=
 =?utf-8?B?TU43SGUyNmNDWXB5QWNSbmdrY1Z6bE5VRHNVMEJHTGFqYjdFWFJKSjBkMFEx?=
 =?utf-8?B?aXVUempNNHVkcEtKdGl6MFFpUFJWdE53RE5uUS90Z0cxeXlvUVZKaXN1aU9Z?=
 =?utf-8?B?Z2I3Um5WekplQWpGR3k5TUtZd2IrRG1ibU5jYUgraS9zTHdXMnJoYUVBL1E2?=
 =?utf-8?B?SmtzeXQrT3NNTVlQZ0xCd0lsaEMxemJ0RGJuMXJIU0VzdzMrY0ZjYjNYZEt5?=
 =?utf-8?B?ZmJ2eVZuZFBGZEJSQ1VhaExUQXpKMlBkTy83MkI5WFlxdVpISjBZamhkbHMr?=
 =?utf-8?B?Z2M0bXlaczA0R3NUS2o5L1BTRU9XMWNPdGZmT1o3cGdXanBEa2xOeCt4d2hp?=
 =?utf-8?B?U2lUV2QzdTduVHkrZWlaNXR0dkdOTkVwa2VpY3VBZG40cGgyd0pGVW1QQy8v?=
 =?utf-8?B?NTMvbk9hcTVMVDBJNittbHNCYmkrYnQ5STdIOHNkbjlYYk93eExUYVVNTTJn?=
 =?utf-8?B?VnF0ZWtkaEYzY0VKR3NBU3VsaHhZOGdLTHZ2V1gwWlZsNjFQT04vdDBwQ0lS?=
 =?utf-8?B?eFZ6UGtUenpTUE5sbk10a2NsWXMrTTFzdE5ZSmQ1ZkZDTTlMbEZjbFovY3d4?=
 =?utf-8?B?VHl1SktQMmMzTGswTXZHbGZPakoveEdUL29NTjQrWGd4bzV1ZXFlRDRPcXp0?=
 =?utf-8?B?bHZKdG5PSDcvZGgzYWFXSXJzM29HZ2N5SlhGdnM1d1VxZHFkbHB0Q1NHbFBj?=
 =?utf-8?B?ZU9pNi9OSTI0UEI1R2VuYTJIb3RyZWF3VzYrTEJjVE83RlhncEtSV1VLMmpk?=
 =?utf-8?B?SHpaWGVNZXhSRHhkWXlsTmRWV3Q0L1NjUkt3SWtBQlhUUVZhV2R5MTA1MjVT?=
 =?utf-8?B?Q2hycnljUEJsT3FaeXNqVFR1OFB1c0Z5S2U5Vlk5YnFHc21FYWdtbkdPc3pV?=
 =?utf-8?B?RXJMNXBaTjkreE9DT2tlaWtTU05vWXNFekd4SWdQYXJ6K3piRzNZQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cc5980-1aaa-4af7-a395-08defc9a5fe5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:01:50.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEBRHBcNDc1K1Du8M1DpCnajbNxIEfl5ldBIX3ED8F7BHRHoZmozA1A8HHmDRHoYz/3V11cWtCWS+N1Z+gjnpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6421

On Fri, Aug 14, 2026 at 01:16:01PM +0200, Petr Pavlu wrote:
> On 8/13/26 4:50 PM, Gary Guo wrote:
> > On Fri Aug 7, 2026 at 2:25 AM BST, Aaron Tomlin wrote:
> >> Currently, the "module_blacklist=" command-line parameter only applies to
> >> loadable modules. If a module is built-in, the parameter is silently
> >> ignored. This patch series extends the blacklisting functionality to
> >> built-in modules by intercepting their initialisation routines during early
> >> boot.
> >>
> >> Following review feedback, the implementation has been split into two
> >> separate changes to decouple the introduction of the new feature from the
> >> terminology renaming:
> >>
> >>     1.  The first patch extends the "module_blacklist=" parameter to
> >>         built-in modules using the original blacklist terminology. It
> >>         introduces the ".initcall.modnames" section to map initcall
> >>         function pointers to their associated KBUILD_MODNAME strings
> >>         (restricted only to module_init() invocations to save memory and
> >>         avoid matching core kernel subsystems). It also restricts the check
> >>         to a boot-time __init wrapper to eliminate Use-After-Free (UAF) and
> >>         Spectre v1 vulnerability risks when loading dynamic modules at
> >>         runtime, and adds a fast-path check to eliminate lookup overhead
> >>         when the parameter is not in use
> >>
> >>     2.  The second patch renames the variables and helper functions to
> >>         adopt the preferred "module_denylist=" and module_is_denylisted()
> >>         terminology in the codebase. To preserve the existing user-space
> >>         ABI, "module_blacklist=" is kept as a legacy alias pointing to the
> >>         same module_denylist variable
> >>
> >> Aaron Tomlin (2):
> >>   module: Extend module_blacklist parameter to built-in modules
> >>   module: Rename module_blacklist to module_denylist
> > 
> > I feel with
> > https://lore.kernel.org/driver-core/20260421-acpi_mod_name-v2-0-e73f9310dad3@sony.com/
> > and this we're really making loadable module and builtin modules less different.
> > 
> > I wonder if we should just somewhat unify these completly, so built-in modules
> > just behave identically to loadable modules, just without runtime relocations
> > and ability to unload.
> 
> I can imagine this being possible and potentially useful. For instance,
> a minimal `struct module` could be used for each built-in and loadable
> module. For the latter, it could be then extended to something like
> `struct loadable_module` containing all the fields currently needed for
> loadable modules.
> 
> It could also help improve some C APIs. Functions currently cannot
> determine whether a NULL value passed as a module parameter indicates an
> invalid pointer or a built-in module [1].
> 
> > 
> > Of course, that's quite a big change... And mostly likely people won't care
> > because almost everything is built as loadable modules in distros anyway.
> 
> I agree this looks non-trivial. It would require proper investigation to
> see how it might actually turn out.

Hi Gary, Petr,

Thanks for the interesting discussion and ideas.

I agree that unifying built-in and loadable modules under a common, minimal
representation is an attractive long-term architectural concept. It would
certainly bring cleaner semantics to APIs.

However, as noted, such a unification is a non-trivial, kernel-wide
overhaul affecting core infrastructure etc.

In contrast, this series is focused on solving a specific, practical
debugging and boot configuration issue with minimal intrusion, using
metadata that is reclaimed entirely after boot.

Given the substantial difference in scope, I believe it would be best to
keep this series focused on the immediate blacklist/denylist functionality
and defer the broader module representation investigation for future work.


Kind regards,
-- 
Aaron Tomlin
