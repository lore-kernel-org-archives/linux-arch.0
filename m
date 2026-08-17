Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021112.outbound.protection.outlook.com [52.101.100.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8F367F31;
	Mon, 17 Aug 2026 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999927; cv=fail; b=b/K0td4F7fQNkWhQJBpiH/NBat8MpRo4YGSATf4vZN0/HIb7ZoH1AoGRJ7Z+KY6WPfOmlNviJWLBRf6bvmhVWgyZbAqfYOs++kTQyVTHPExLlI3bnDL/lV5xMGi4I07coYFYEbCEUVS7D3MPSXTnlUE29PUJSLLlxV7iwipvXwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999927; c=relaxed/simple;
	bh=JlBbCXL00k49g/uvgJvXga2Kikz8AlhJLEVnHksahh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ozVfaEDVZ8b3ZesgvIvQja/KfEC2eZoz0ZLyrLzN+SjVzieBZq/gvcIcaJ6pukt9TeC75PKSKbHd0SI9TG2eqkylDiBqPZhPRdDHIkUW62A+pX29fCZJODgLvAg4rr1qqIt35/JC7VCCIFKdccazNA4LxT+LTd8DmqclS1uAHiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np3/qak9AvYVNuk1ql00128pesyE/fwy4gUptAhSt3RJg9vbBvtIq3AaTcFoG5rGCNnVdph6MeIzOvURPpM3+bO8xBP+g2+yXk8L6djQUAcOCJFwEvqs/nPXQlzCEjSOJT+tnW0MX89PvFlndb32zOTR7D5YUchvCW7W110RP23lNnJLUMkluN65JOdbW85iW7kHxkmB6EhRgJFxXrKKnxFU7XYpYgVGdngDvoOZbv1J2WZmyPKMp4Xvs4zNJaE+A+YcQo1HGCvoPhi7iZ7HB5KzFDf5CaXmbm/Qae7gurAwcwksjWLshZ/EtwqvnB5XnjyAN9FPp9K3RSEsD0n/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=OSR8E5YK9M8GRmWrJiRWzJnVhUWXNdrNtURqdrXiyS4=;
 b=khV+FoHc5nj1GA5YiNfn3o4dSoBkoAfWOEoUqQxmh3vhXaBr025fQo1k2XIKZds34bjRZnWBLkePYtXMopwTCnKTWkWKYcI6nCuZx4NmKU9CcDo2LlCSixwfiGhpfNFcakoylBlp+YoxZjYp/tRbPC9GhQvmgKFe2ZU45toa+P9XJU2VWKYk6z2AotngSAb8JDtQTXSKuKasCfr67z5jfU+/qwo3dxTkQq9a00LM/OhM/Sm6Utb/r4lU15KFOiKvOPFUP6rJlxS/CddMY0OArahtQchlHKuHRoNYhz/1G+wRoJRxfIcCsaxQn9XB8dVAhowAZazwBh7Tm25T/UD3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:52:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 20:52:02 +0000
Date: Mon, 17 Aug 2026 16:51:58 -0400
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
Message-ID: <qxmsga66by2pvm3vh2vd72ypo56p36cyjlbzah4yk7xolgun4w@vjjkn2hnbdu7>
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <20260807012601.360452-2-atomlin@atomlin.com>
 <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
X-ClientProxiedBy: BN0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:408:e7::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e5c340-cdb5-4a7a-cee7-08defca16359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nY2BmLb/NqA8KFKZzrZNDG+JezdeaJPXTvQdYyqrlSjP15uMgPNMX/LmfqqwAa3G26ubjQGQB2dtpBQOBgR+fFu/hc0mRsXryVOfHsfnuu7O/SX8SieuuEUFCNpbF+URTuVJF9mb8Vn/bt/2Hq6Vk8K8BPWbpiua75cRto9M5YHapCe84VmUZsFBLDg8zmPKTspG6rdrYuJFTz5tswDIy81SzQTKv8iZRLn4S2xyY2AR40KFvyjI2EgRxZ+kDXN0zkmUON2an4kqbLi8464i/SQ7RofrRwW8JTniWrjsplqI83S5RGxzkemq5Fql33kU4ZcKcNOYLqWvrMYGZf6RBara0+g9zdO/urzfgbu7fi2Ta5rok3GqVfQDIqLmIIcv7qrqySg8P3Mk6mTgwbqfsqKzWw0cXNCWgaw2i5JKj0z90SuGNKMZbIX9b6b1nX4l7cMcU8lHMKgMuhNCdm1EVpqzWX7LpiBqnOtjmFSXf/6E0RZ4wtNsKfuT4fFnhKpZJKSH07Pxf4PyMFWQUAV0TOdmaNR++kRFzro+DJNoqDfC0onTj2slvxv2p8lcF4M4rCMhUuoOaylpWjK/RO0W2XGeLNPdWPubeH9MkqDXaxQnK2X9lzST+D47dInjOW8VcmnDuidvFWcNoZsiUO/RbC4lyHdt1HkI/lqRhl1Izb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29WVldaS1FhN08zNUNpQlRadUFRMjNSVE1pT1g4Z1NnaG9xUUpRN3dhcXJl?=
 =?utf-8?B?c3gydHhHRjNkK01KM3hSa2NxVDRsdnBWK2d2WGJGOE1oQnZ3WlpmOHFrekpV?=
 =?utf-8?B?Y2l0b2luVjFFQUl4VFArckc3NEpWaWlZSVFnVGVDRmFMRG1CdW9zZkdBRzM4?=
 =?utf-8?B?bFQ3cThuMXk3MWtiaG1kZnBCajMyS2dOZ0FFOE9SeDkyQkpDTXhRQWFxbGsw?=
 =?utf-8?B?ekhrVXZyUW5QNEJVN2JhSkZsS3VJcy9ZVkFjMlR0M2tjbWJKMHlncGJmM20w?=
 =?utf-8?B?YXF4Z1l3K3l5Q0NydXNpSHFrcUx4K2VENW9PTDNDTmZ5MVR0MzRxOGd3Uy9W?=
 =?utf-8?B?ZEhxK1FQZUVHZUo2SExtTGM1ckVsMXpKNkt6VDlaT0RCYmRQcEhCWmhjeFRz?=
 =?utf-8?B?U01yRmhONjRtMW44eWZFQzQ4cVJ4ODJIVVZCMTJ1Z1BMOTB4ZGNDMmwxbWo2?=
 =?utf-8?B?UkNFMHpQNTU2cEkvdlpKTjhISzNmL3FxeE9CK2ZINHVVcThtTVp0U2JFVTVi?=
 =?utf-8?B?bDFtNzkzd3VITGdFOUxIc3MrOTFjMGZncnovWEVFOVp5T2RaSytYUHVBTW5M?=
 =?utf-8?B?WWYyZWs2SkFyaUU1TXR3SDYzTGE3ZWRhT0hmenJUT01rMWQrY3k3RTRGVm1U?=
 =?utf-8?B?dTRPZnJVa0d4M2p5eFRjSWlUZm5jSUhXVWwxSDdncFpKNWVMMS8rL1lVS0Rt?=
 =?utf-8?B?cGJtK012V0VsUE1aVGp4Ukx2KzVtYXBBMW5MejU0akttUXEzd0VqVHdkOVlw?=
 =?utf-8?B?UmlGTVhleEUvSlNoVGIwckxtcFZlaSt4Y1R0ZGdrWW5PRDFYUVhMTTI0aHlJ?=
 =?utf-8?B?emJMbFhhcTlueHNpaVdxZXRscnRRbCtrcElCdGZqc0kraksxWEtJbU40OWE3?=
 =?utf-8?B?ZVdqQlFDNmZSQ2tienFYTlJ0eXdGeHVWRkdEQ1JidjB2Q1VmZnBUMmNHRit2?=
 =?utf-8?B?TENuSUIrOHNYdVArbVBJbVVkMWZtbzZJOWtudWZWdEVKM2dFckNDbW95TjU3?=
 =?utf-8?B?eXRTNm92bGQzYnhjUnh0N01ZZGsvMENZQ2dHdnVVVHQzVmFXZE1HOUpFS1RD?=
 =?utf-8?B?ZllCSjdGNktkRFRaaUxEZU5ZQnBpc3NjZG43MXdVankwTDNTTi80Ulo3eXJS?=
 =?utf-8?B?THUrZ2txaW9JQ3N2UkpHME9DRXFoaURyUHRpYzIyRmZKWjU3Ukl3VzdrcVZB?=
 =?utf-8?B?RWlKdy80bGJWa1crYU5ncDQxUHZXZ3gxTHFnbExKUjdzcjRBYVJLNXBDRy84?=
 =?utf-8?B?aU5scm90YldROVZzd1pEY0Q1VjFyMjRrVDF3VStWM1RQd1VmTWovdkhnTUs1?=
 =?utf-8?B?TXNhSVFtNkM3NDR3OXllVkMvMmpXQUIzdWo5bXZCYWlZT3hqNStNUFRuSjJN?=
 =?utf-8?B?R3l6VFNreTNmTWxUdmpQK0x6S1dmVmhqZjlLK3FWZjVva2FOMGhMb29TMGdx?=
 =?utf-8?B?T3pFcFBKQVBWUGR5em15d0cxK25wZFFBVnVmb0ZDWGxZMXZWejZkLzJEOTNv?=
 =?utf-8?B?UG03cjl5dE1tN1B1cllhT0EzSzN5NytlY1RadG1rV0Q0R3poSVNObFVSSE5k?=
 =?utf-8?B?Tzk1eWRaMUZTTWtMSmxaaS9TUERzWXpoZ2UxcVdtWnhtRC9TcjF2SmtXZEcx?=
 =?utf-8?B?L3VOWFRva2ovOHJSenZ6Vkt0eVc1VVhWREFBZVZ2c01xRURTYlQrSllpbm4v?=
 =?utf-8?B?c0FPSUNuYi9JbVltNjdsb0t2SGpQTHVQbFJmYzVrbHZWUkQwVmZLQjZrTmV1?=
 =?utf-8?B?TFNPdkZIMWtNWGU5d1BCMzJkalEzcFArWERhQm5qYndSOTRwRGJXQTBVdDIx?=
 =?utf-8?B?cDMwYnV2NnZFQmV1NFFpckZMeklpUlBIZHZwSHdrNlhwUU5qb0V1WlNnOHJ6?=
 =?utf-8?B?bXY1dEhZN3pjSjh2dlZwaTYvWG5EU1pjM3ErRmFIbkhyTDY3d0VEVjdKU3Bp?=
 =?utf-8?B?WEN5bzZvNUtQRmJkS2JibFAvMjZaUEZOUTFDOTF4SmNGTEt2ejNGSjRQUlZw?=
 =?utf-8?B?QTBiTk1NTldkcmRyOEhkOWhtcWpjbFhEdDFSdE0xRS9OSnBZMEVZamtqdVBS?=
 =?utf-8?B?ZDJaSVo5U3ZHMGhFeW8zMHdEWjMvZW1naGhrdVBWYm0rQmZiWkl0NjZYOEc4?=
 =?utf-8?B?eEJhQ3ZvRnhwazVhclpJREVlU1dsN2Y0RU15Rk91dys3RTlJUGg3TjRWUzJv?=
 =?utf-8?B?TzBJRzZ6cUEwZmhxRnJHNms1UzNOM0txNEVWNHRxc29NaU9iVWdHb05GWUM4?=
 =?utf-8?B?RkxHdzViZzZtQy9lWjEwdC9jelVibSt1TE53cHcvTHU0YXlIbklEZUJXbXFu?=
 =?utf-8?B?MUR2OEcxeUVPTEovRnN2RnlzeDRyaHNzY1NPaitlaXpEUWdVbEkzdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e5c340-cdb5-4a7a-cee7-08defca16359
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:52:02.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqMnOc7q6fsSoZyA2QY8yxrFWIx9UJLEG1GYK3COX3DG+aPcQBrAK4zCnd9UMfb3AD8NwlQsRH9S/l0XeJg8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3226

On Thu, Aug 13, 2026 at 04:15:05PM +0200, Petr Pavlu wrote:
> On 8/7/26 3:26 AM, Aaron Tomlin wrote:
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 5659f4b5a125..799d912dcbc0 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -734,7 +734,9 @@
> >  	EARLYCON_TABLE()						\
> >  	LSM_TABLE()							\
> >  	EARLY_LSM_TABLE()						\
> > -	KUNIT_INIT_TABLE()
> > +	KUNIT_INIT_TABLE()						\
> > +	STRUCT_ALIGN();							\
> > +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
> >  
> >  #define INIT_TEXT							\
> >  	*(.init.text .init.text.*)					\
> 
> I realized that instead of using STRUCT_ALIGN(), a cleaner and less
> wasteful approach is to prevent any potential over-alignment of
> individual .initcall.modnames sections by having
> ____define_initcall_modname() define each `struct initcall_modname` with
> `__aligned(__alignof__(struct initcall_modname))`.

Hi Petr,

Nice, I see. So, adding __aligned(__alignof__(struct initcall_modname))
forces the compiler to use the structure's natural alignment (8 bytes on
64-bit), ensuring entries are packed contiguously with zero inter-element
padding.

> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index 06c18e207508..13353b43b38d 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> > @@ -479,6 +479,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
> >      let ident_init = format_ident!("__{ident}_init");
> >      let ident_exit = format_ident!("__{ident}_exit");
> >      let ident_initcall = format_ident!("__{ident}_initcall");
> > +    let ident_modname = format_ident!("__{ident}_modname");
> >      let initcall_section = ".initcall6.init";
> >  
> >      let global_asm = format!(
> > @@ -590,6 +591,21 @@ pub extern "C" fn cleanup_module() {
> >                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> >                  ::core::arch::global_asm!(#global_asm);
> >  
> > +                #[cfg(not(MODULE))]
> > +                #[repr(C)]
> > +                struct InitcallModname {
> > +                    initcall_fn: extern "C" fn() -> ::kernel::ffi::c_int,
> > +                    modname: *const ::kernel::ffi::c_char,
> > +                }
> > +
> > +                #[cfg(not(MODULE))]
> > +                #[used(compiler)]
> > +                #[link_section = ".initcall.modnames"]
> > +                static #ident_modname: InitcallModname = InitcallModname {
> 
> Can Rust directly use the C definition of initcall_modname via
> ::kernel::bindings::initcall_modname?

Well, defining the local '#[repr(C)] struct InitcallModname' follows the
existing precedents and avoids expanding the bindgen surface with
<linux/init.h>. I think this is preferred, no? Gary, any thoughts?

In rust/macros/module.rs the existing built-in initcall pointers are
defined directly within the macro rather than pulling in initcall_t from
bindings, keeping module.rs self-contained.

> > +                    initcall_fn: #ident_init,
> > +                    modname: #name_cstr.as_ptr().cast(),
> 
> Can the modname string be placed in .init.rodata to match the behavior
> on the C side?

This is a very good suggestion and definitely worth adopting! Thank you.


Kind regards,
-- 
Aaron Tomlin
