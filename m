Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022092.outbound.protection.outlook.com [52.101.101.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806ED352C5B;
	Tue,  1 Sep 2026 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222795; cv=fail; b=OrNeDVsFGj6hABXSyoMH+kg+IHZquixwl/xT7p+tgiZxkxf8fQFUG5IPpQJjoIw8cKFp1vfsfeE1HOfevZXAkqZFY/U8LUwZLjUhFkoqtO8f2XhU0PvVLaVxphkufkL3jP73T1/o/3X9rfCQ2dMw94E5UzxTWNX2Xg6YVfXeg8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222795; c=relaxed/simple;
	bh=wGj+gKauR842CL9eR8HbemoFKf0OePJCYLjoJTZBaAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tExmTUV//CLzXwnCdbkq1NX8kG1SG2m4GwcD1ZW+SY7GBxxT6NHMRiNxCUezOVFPEnrHBGy3V+LODYJ3hnbpf5iSl6ztbqUokcJZ/sPMYf3CHZc/pleqdNApk0RcwRaF+GfAn5H4nuIrLMPJ+thbEIfuftyrk7Ashj3/Na/MR2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpAa5uJE88TxjgDz9OrUChPbJMRmbMneHk0fx3YzXTgE9O3YmHe1RepSgC3lcs1n1dMVu3zWwArciAbO3Mmr0v4IbNAcIW4yYQWapHlh/ahrAQGCa1nBH5a7hI8Gy0FyrJWQuGI6RY1zpDvspm80yQcED373B5U5AD55p9LQ3AJ9voncsYAUZOX5GDmqwZhZsWAPPUqkhVD6lNyg7601RkiY1vfAlJ5r1uyOdHc4gp0hvrJVz077cVcKrWZrF2oXJNKRqYMsgkThlVpqy9MnF0HK7OXV+NOBE9lf5f8TmrTqb+VGjTHPb1LzqAQopwvd8imL7ZOM/cWYWWTD30TvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=WphVnYARswjy2POeEIqnvC1xyKK2bkdqS1pxqk2qVfw=;
 b=HmFp5ThlMiFkovA/Igr4/YKpIs/jp7vUQjfc8srdYtxhpY5kyC0wc0ks8SMh7UQPEXK1DEzc5n/ycay1B5JrlwrfxMhiNiOlgnJWB/L5Xqflx4TQi4EyTWGTfERMJeZI9rKDpCyhTrtpauu9eqxw+RnzlIXc+AOQTK/SsX+HQxzw9Vev5UR0SKti8UWSr2YvXXEuz76Ta6WkeipYzwfaqTGmLaUdpyntL6oPjt0fDE7dNtXdKwUDJaa2gmZhuA13jrWDfsZmWjQ6pTm7GdKBX6LVy9Srf3X3LNtJ0hDTgXQdk8sShAVkT8mz1UmoNPtN1TU7P/kP+phbPcwy+tUA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB6208.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:33:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 00:33:05 +0000
Date: Mon, 31 Aug 2026 20:33:02 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>, gary@garyguo.net
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org, 
	samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org, 
	akpm@linux-foundation.org, mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <kfhhe7uxcygkomf2qnzuqpsdy5nqoful2viiqpfv2fdla4xcea@yh44pyc3yuza>
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <20260807012601.360452-2-atomlin@atomlin.com>
 <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
 <qxmsga66by2pvm3vh2vd72ypo56p36cyjlbzah4yk7xolgun4w@vjjkn2hnbdu7>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qxmsga66by2pvm3vh2vd72ypo56p36cyjlbzah4yk7xolgun4w@vjjkn2hnbdu7>
X-ClientProxiedBy: BN9PR03CA0743.namprd03.prod.outlook.com
 (2603:10b6:408:110::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: f81b9485-6540-4b93-e3a4-08df07c096c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HAxnEtzTKvdAfxqut3R2PC2AP7n7pjgrc1oyGZVDsH+KlNh1WrCcKd9u9vNLfJEjjIzEBtTHrGqHcIaGoccXIBLIqCmSee5WbUfswgoQqBAD/6nldTcyXvpk8Ng6OVvAiFLLZRiEbCgntzAa2dbClP9RyGY1sR+wj0c2/ehR0HqwpXjgdqko2faNSuEBVea3vfMZcXWZan0crvEzUCniKrXAwEAaEeBVvOUL2hB4mfrTys2awaJUNy1Sl/20Mqd4vIg+mF1Yf7mwdmj1+0KUjcwcFu3SFCeERwNE5jOpxKStMXu6rtmzzuqLfHLZsbpdfdPWRsKbsEfLI6liS5AHY3Xkb4KncfD56XZkNl3w0NFKk2UgQBThjndirxYh5bW+pe8yE8Uu6HsZVn7f64LpaPzViVN4W5XST0G4drdNlbUB4Du/8bbZvtKXY8BTuwwGtO7owHIcTwwG3aDFRBMqUUP+l4Jkos5atoikGg+kntKW/v95gGwqEPQ9Xqdsr+AsKIPBn18YczyYxuOujpzfcAGXOJqN5BWJb1tsex+xsvbNf79SdieqBYjtcZlNQtkKDPJEAL/NQ7+EatRLxrahHwJ7oe1LhtGde7gYcYqQglzfnrXYHnKjBQbtsEc62VcI5CiYoKYo4vy0ibFe77pWUpP+Q3NOCXhzEJlwNTCtbPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDFYV0tFQUdOb2xURytCMHpvSU1NNldjMitFSENnaFdBaEgzLzlTS2NkN3Yy?=
 =?utf-8?B?anozT3VzeHBlVG4wYjRoM0xnVVFlRWp5UG9JaVVpUk1WWmJFYXJsYzhoN1F2?=
 =?utf-8?B?ZWxPNEdPeFpUTGJidHNtQjZkendCZGljakxabTJtNTAxRWdhWE5YN08xeEtO?=
 =?utf-8?B?M2lOVTF1ZTNQZTNkUm02SXpSaE9PZndjTm4yYWZEMmM2bzJ3VkNvN0ExV2FF?=
 =?utf-8?B?Z0pzVlU1dmwxQXlIMU9BL2V2MTE0OXZXV25KbXFtTW5xOTBuUTJISmFoNG1h?=
 =?utf-8?B?cHJ6K2d2VEFJZ2VMVHNleUxDYmpJeVgwSzBnelMzMjk1Ti9mTTBheG5TcXht?=
 =?utf-8?B?eWFybXlnK2dRME40eEhNZnRWSzR3bjV6ekwwSDRQUW5KZDM0SkVnZVpwNXJt?=
 =?utf-8?B?amlpVVRQYnNvaVhCdHZmWUoxOFo0OEJtZ1RPV2FrL0pETWVXUldMR2RVS2F6?=
 =?utf-8?B?SkhhUUJVRVB4dk5lRHkxT0gxVVFkQXV2Z1Nrc0x2NWtpWXBSU1BIWXRSSzMr?=
 =?utf-8?B?NEc1RmJjLytkZVJ2Y01GM0lWSFR6MGl1cjU3NDVhT3lpMFNYUFVHdDUxdGN5?=
 =?utf-8?B?d1IzRmlwTWJYYjkra1Axb3UxRyt6Q1VNZGthVThmc0gxVVlzcGdDODlSM0tC?=
 =?utf-8?B?NnhTRkVYUkFSdkYvMC8vdkcwSTdXcGl0ZW02c3MrUnliUGI3K283VG11OTVh?=
 =?utf-8?B?ampTczE0a25WZ0p0UDlCbWQvbVJZbTg0UCs1MVBYZlBzSG1ubEp4NC9URFpN?=
 =?utf-8?B?VkU3cTAybGRXbml6TVZHMTRRNGVNczJLYi8xNDQveUF3TzZqL1BxbzdrTWRn?=
 =?utf-8?B?Q2R3YUlYTVlFcU1pTDIwcTUyUHRWZGpzS3JEa3Qyb25vZTlnaVlEZlhleG83?=
 =?utf-8?B?a0tUSm16VUtleWVlam9taUJ0VzMya29iYUJNVUtWY3NiTXp2bXZTanZwMGpI?=
 =?utf-8?B?NFZtNGVxWHdtckVhVmZ6Kzl4Q0h0N21RLzRlUndjaWVaaEQrVkE4TGxPV2I4?=
 =?utf-8?B?YUVqN3BLOTU0eGNyeDgxeEZBT0s5a2w5c3lqNXhKTUpVK1hJditQaitPRmY5?=
 =?utf-8?B?SGZaK1JzY1l3SDlSTnR6cTlDNUNmM3NuaEtqc2hzdU8zakl0b1BucVJsTU9P?=
 =?utf-8?B?bGlmRWxrNWJWY1Uyd3IyL3YxZVFBaUZuY3FJUkUrcnlRUlhGaGJiV1R3WkhX?=
 =?utf-8?B?ZXVaQUhLb3luOHVINXE1aE1wWFFoM3ZVYVBuemJDVjN2aWJrQis5Nk1ZMENz?=
 =?utf-8?B?c3NxYkl5dHdNMGIzR1VhM0ZVSzhSV3JKZXFMcXJpTU5kZ2UxMmZqdTZLQVNy?=
 =?utf-8?B?aE1UQzY1b21ZTDRrSGJBRzhKUG1WTlhXTzl0SHR5ZHgyNnlralpPaTVzQ3RG?=
 =?utf-8?B?azdER0oyUnFtKzA5dWZ3L2pzaHpIMkpGL1dnallOK0VFR1lyMnlLS202RlFh?=
 =?utf-8?B?eTY5Nmdic3VsOUNra09vakRxQzdXaHNtVFV5QnVFTldQSkZKYlpuaTlDSTJo?=
 =?utf-8?B?aWhhSjd0WmZBeDc3U2JHTzdXYUh5ZFUwMFI2d1d4ckI4bkYxaDltQmd5OU5s?=
 =?utf-8?B?T0NqRzR0UHhTVFdYWGtKQkpkWnQ0Tmk3YTg4cWFtVGx1aE1yaWZLdXhIZVpF?=
 =?utf-8?B?RmxOS1F3SVRoMHlmRDRNRTZUaG93dGJNVm9kVXo3SVI3U2hITlBxcmhrR3FD?=
 =?utf-8?B?Q1BhY2RzbUFJU3pjeVNBV3NoOHJ1aFZRYlpxUzIzVVQ5L3JhWDNkMm9zWkwy?=
 =?utf-8?B?VUVxN0dQazMxWkhZU0gxVDB5cGxuZUcwK1I5bHdCUzBhOHh4WmNPcmZFZmZ0?=
 =?utf-8?B?Zm50dTFnZjBGWk1OQ0xmOEtoemJCY2ZkejFza2g2Y1JIUTVPTEFHNjd1cTVi?=
 =?utf-8?B?QmowOEQ1UEZwdXBUejJERnc2ZG5zckdKQ0syK3NuZGtKWmtGSm9vV2pMM1Qv?=
 =?utf-8?B?c1RKNzhnR2xwZ2JyWHByK2ZlQXY5K3lGMDJTWGw1cWRMclpOeFRhUmVCc1M0?=
 =?utf-8?B?cGE5NEdrVUYrcGxLY1FnUjE0emNEMjhrOW81U0dGeTVhcjAyU1VsUTZ4NDFt?=
 =?utf-8?B?VklJdHdxT3VrTlUybVYydytaRmY0V3RtMVJKTlgxbllXaVJjN1ljTFhQLzI4?=
 =?utf-8?B?aG50aWUxVjNLWlZoMEQ2M1YzbXFBbTRBYTAyQnpyemh0M2dkeXU2RUNBTS9B?=
 =?utf-8?B?MGR0NU5Ob1U1dndPM0hsdHh6R1JMUnNzNzdaRmZHWlV0NjBTWHdnbDNZQnVV?=
 =?utf-8?B?a0trRG9nYjFoZGJwTVUxQy9hSS8yYk1FdFBzSTNhRUUvMGpWaUJYL3kyS3c1?=
 =?utf-8?B?Z3BFa1AxZ3BlZFdDcFJWSXdmbWZTamdpK1FhcUgyWUtabE1CUWZtQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81b9485-6540-4b93-e3a4-08df07c096c1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:33:05.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT95EBXx/BxGNSAEp4iFB1f/jFQ4D9iJ09fgmcejz8U+cDRYJ5m9rKQ6fOkzHHeDd0ZreL+25WWi68kaU9WIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6208

On Mon, Aug 17, 2026 at 04:51:58PM -0400, Aaron Tomlin wrote:
> > > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > > index 06c18e207508..13353b43b38d 100644
> > > --- a/rust/macros/module.rs
> > > +++ b/rust/macros/module.rs
> > > @@ -479,6 +479,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
> > >      let ident_init = format_ident!("__{ident}_init");
> > >      let ident_exit = format_ident!("__{ident}_exit");
> > >      let ident_initcall = format_ident!("__{ident}_initcall");
> > > +    let ident_modname = format_ident!("__{ident}_modname");
> > >      let initcall_section = ".initcall6.init";
> > >  
> > >      let global_asm = format!(
> > > @@ -590,6 +591,21 @@ pub extern "C" fn cleanup_module() {
> > >                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> > >                  ::core::arch::global_asm!(#global_asm);
> > >  
> > > +                #[cfg(not(MODULE))]
> > > +                #[repr(C)]
> > > +                struct InitcallModname {
> > > +                    initcall_fn: extern "C" fn() -> ::kernel::ffi::c_int,
> > > +                    modname: *const ::kernel::ffi::c_char,
> > > +                }
> > > +
> > > +                #[cfg(not(MODULE))]
> > > +                #[used(compiler)]
> > > +                #[link_section = ".initcall.modnames"]
> > > +                static #ident_modname: InitcallModname = InitcallModname {
> > 
> > Can Rust directly use the C definition of initcall_modname via
> > ::kernel::bindings::initcall_modname?
> 
> Well, defining the local '#[repr(C)] struct InitcallModname' follows the
> existing precedents and avoids expanding the bindgen surface with
> <linux/init.h>. I think this is preferred, no? Gary, any thoughts?
> 
> In rust/macros/module.rs the existing built-in initcall pointers are
> defined directly within the macro rather than pulling in initcall_t from
> bindings, keeping module.rs self-contained.

Hi Gary,

A gentle ping on this, to avoid holding up the series, shall we stick with
this approach (i.e., keeping the local struct definition in the macro
rather than expanding bindgen bindings)?

If there are no objections, I'll proceed with this for the next revision.


Kind regards,
-- 
Aaron Tomlin
