Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020129.outbound.protection.outlook.com [52.101.195.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3503911DD;
	Tue,  1 Sep 2026 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225696; cv=fail; b=E3T23+cXU7mwTV5MrtV+5VyR5bL3L7iUgdkLrk7kYfa0vfnJREOBX7fMQ4eLp6fV8SyVEscmx2wy3Y2Hs76Zkho73T2E/TQeHpcL8WEzd/0mCANMRwHKpqhscRFhfNOBUTuznCM8uXA00s3QqdgRB/xHxmOiZ7AZ3LNr+YA5380=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225696; c=relaxed/simple;
	bh=nfGPNnBZitBw8Z2QQ0rwh1gs4yG8i0aEka+bX4f5qF4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=b7qurbbE2mjFMdeaHhdVHK939jYwEgs6kEjcBsoXKZDXpdBJj2z0dywv6DhGnG+7sogq+Dc3MJsfYqK2hl+yAQGpXgOucQd5JmUcqPlABtDT2RNXgljwTvFB4QDwxj7AOCOKPr8aWDvHOHOtgvKc5yIHPSS+VCQtVlsJua8/KEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HPLlyQBq; arc=fail smtp.client-ip=52.101.195.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HPLlyQBq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgkuGz1bfx1UDblY0653kQKSpTLvRLo69zBbIy8qcQ9jJ0Y1NBcHC4od5tPco/mymFECuSN81TA9i/2D0hbhu1ecOOIpYWggiJ8lUOiElZxhLdG4WwVfvPsEX1IEdQFRN+Aj47tC+vCYoWzgq6tdLd82pKuPJgkRJdJrhUNhFKHRwfOpy57fMViBQAtcvIxcUH5rnm/qzsJjzaHM/LGUQPnB+7OFOGkP0T8ZLe6kBcXjh4ol7/D/AROX4DelOsXo9+MNiWsAfo1pDS+JbJL3J4YkN8Y9mIhHEb2W26L2KPk6OkL+u+IUr3VsSqidBm2xP8Ty0KuEVWIThXFYurrtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxmGXVQ6SJMZpTRvCh49lDT9i9ELYAZN3BXuNZJzhBE=;
 b=WdX5SukAf8lx3PBt5+g6OgnKheYq74FSJjxUIcG+xBlsOJRgADdJpuXI3e7MSdT1axxEH4sTMbGGai7rJALZyT355Pg1P5ypWSmNePA6eywGWLVUprbxq/uiVu9rD0h0npYDxq0XuM91yVhu+QiQYAuZQstAkYZHtbskHZaVIfbBEdr7oQn8Zf0iUPvI8hUSaioqf3vd8ghjiJe/Tj84Dakpsok4WJfk+PIGIWBeMqTHQfPb9fgY9iiG7fuPMMlaUhRq/wMwdGBznTnTaGjOpmqOxTBtt+JGlJRiWFNGgTXKdiEbtwtREz7llFXoBc8djww0UpFQ4EXpFMPKzNPLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxmGXVQ6SJMZpTRvCh49lDT9i9ELYAZN3BXuNZJzhBE=;
 b=HPLlyQBqvqk8I5KMa1D99KTvFAY939fZiTNAUyUG5kJDbypm3klf3X7Z/b/2D13ZYTSgqisvy8Sp/PTw5n45xhHxmTAmX9EFIw/RulaiiE1Vt9bojt85LrqN3BEUvSidb6yqfdUKcgz/WZa2oUKr/2poqvgUY4fd+MwHjniEW3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOZP265MB8550.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 01:21:30 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 01:21:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 02:21:29 +0100
Message-Id: <DL3L3OUMSNKK.38L06NMJHH94U@garyguo.net>
Cc: <arnd@arndb.de>, <mcgrof@kernel.org>, <da.gomez@kernel.org>,
 <samitolvanen@google.com>, <peterz@infradead.org>, <ojeda@kernel.org>,
 <akpm@linux-foundation.org>, <mhiramat@kernel.org>, <boqun@kernel.org>,
 <neelx@suse.com>, <da.anzani@gmail.com>, <sean@ashe.io>,
 <chjohnst@mail.com>, <steve@abita.co>, <mproche@mail.com>,
 <nick.lane@mail.com>, <linux-arch@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] module: Extend module_blacklist parameter to
 built-in modules
From: "Gary Guo" <gary@garyguo.net>
To: "Aaron Tomlin" <atomlin@atomlin.com>, "Petr Pavlu"
 <petr.pavlu@suse.com>, <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <20260807012601.360452-2-atomlin@atomlin.com>
 <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
 <qxmsga66by2pvm3vh2vd72ypo56p36cyjlbzah4yk7xolgun4w@vjjkn2hnbdu7>
 <kfhhe7uxcygkomf2qnzuqpsdy5nqoful2viiqpfv2fdla4xcea@yh44pyc3yuza>
In-Reply-To: <kfhhe7uxcygkomf2qnzuqpsdy5nqoful2viiqpfv2fdla4xcea@yh44pyc3yuza>
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOZP265MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ece230-2b80-40bc-ef1e-08df07c75a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7smoLAgvKC2OFGzZNvXRGh7cpPoWjPhETSeMy5YyNgkmoH1T8VgrHo/02MM2WswIz3sOXrQ78mjgsD3Nq6ulEqyt0UJCNCiMC+npZjtYy86n51Prunf+qDiCndMEKtgHb9LkmACJ7EbU/vY3msgnNzIwhKzTYwUHyfbvroeHdLppJ3RQWVs8DF69/ZZh2OTssH7cAA0m3LKasRmdE1/3O+PmFPA8BIX90D1h9rdvS8hxEI5KGhCBqlwaKsIMx1GVG/REfFwvUE0RjY6ZqNyQC6ydtVSv36Wy2KW1D3vfWvtzYECzQzA6TWAdPBvDLat5h16T0w+S8nJoYZeWr9+uBFXn/wUaF8OeOfsVQBbJfzR0vcQc6FBDmnlRL9aFjgupT6UqmXeG0cxanxlAFZ4E5qkX15Ia41AZcuAHn4agpMUh1IjSJSQv8FRoNXEAHNNrDphc9Fr+vpbYKxVz65cZXv16DDauRl4DsSjtHvOgIRHihCm+vqu7Id0ietyFbLamSelvMryBcPqDPg+NpykbN5P7qNo+NRPo9sL9xzQV3j2bfrhUNqU1qf1JhjntKiShRegl7R3wHkfkQ1ho4rahZH8lPYt0z4/HNBcQtLpvllf1mhOXbBuzLWOf/igyKYdGALy2P+AcTpR1VaQ+d7owaJnADttxmQrtnbOhBlRmLpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtnVDh1bWRNa3p0Mko5bGJUbFhEM1I3NE1LSlFPckhWNnJwbmsvS0xoYld5?=
 =?utf-8?B?YTZremlpdXNUZHlKMDJWOC9XSWY3RWc4bDhucjNmNklBWUJmNVQ1NUFmZTdZ?=
 =?utf-8?B?SGNPQVk0RzZTVE1NZmVIWG5DT1Y1NnFKWi9FOGE3QXlRcW9CTXIrQkFkOCtM?=
 =?utf-8?B?K3A5QzMwQlFvM2JJK3pTT3BOOEZqSFFSNHFIRjA5ZXFjZzFqSWhMRlBrUGxC?=
 =?utf-8?B?OGhMNVJTcFVXRUtTQ3A4Z2E3WEpVelhBT0ZOekpWb1RwemhoNEdTekl0anhW?=
 =?utf-8?B?VTFXbzhKcHZFTWpvY2VLS1N1cVgrbHFXQlZvcVBLWVZGWDhrLzVFQ3lwVWRL?=
 =?utf-8?B?UVZkbHc0WkJjakp5bjYwYlJkN0c5dTVES2FiczV6L0pQbHg1WUtSamVrc2l3?=
 =?utf-8?B?Z2MrT3U0ZllQNlhtR04vL0hBdTJVaDhYMW9nMTlWU1pYcnJ0UFlCVFE0NUxF?=
 =?utf-8?B?NitKYWMzZTVKbFkzQUE5bE80cjVJRkVTMmpPUGFNb1pDOFQvMTJzRHVLWjFw?=
 =?utf-8?B?Y0s0NThjcy9pcUJKQVFnbGhIOWJqaVFnZUZJSkgwTjFkMTd5RHpJM2cyZi93?=
 =?utf-8?B?UFNlOWpuWk42S0tTRGdod28vWnRlcFNiN2NMclRvZkFNcVdFekpsbHdKUlRG?=
 =?utf-8?B?VFhETmVILzNpWUg4b3J1ZE9TZFJNbGZpOUI5eEFVVDR1VXBpakJqREF6SVFy?=
 =?utf-8?B?T3VDbWltNEh1UnZueHk5c1lUdjRXckQrcUcxYTczbXhuWmhxS1gxUUxwZnd3?=
 =?utf-8?B?TFZrY2NhakorWUE3OS9xeE4zMHVlRUQvejRJaHN5QTAzdURPeGYyQTNFY3lV?=
 =?utf-8?B?Um5qS3A5TGRmL296NkdmRCtuSm44REgyY2M2Ty9zN3lhUk9yaHFRRmNyRzk4?=
 =?utf-8?B?bCtBL0NqbTc4TDNLSEs3R0FMVmhIdVJQTVhNTGVFUEVWUExYNnQ0Y3VyRWVt?=
 =?utf-8?B?UGo1a2FMNUoyTlF1cm9KaW9ydDUyeC9lVHlLNUwyd1dFOENsZjdUR2ZyQ3Z1?=
 =?utf-8?B?UjVQeE9KcXR4TWVkWmtYSytwOFk3cm53ZHBka05FWUdUY3JpcnVBYjVUaG1C?=
 =?utf-8?B?SVVZVU5NZ0p3RVVsWEgxYkZNeUN3bWs3N2ZTeW5GL29DdnpMWWdudFpkNzZt?=
 =?utf-8?B?YU9PUzgwcWVSejdVRWJCWVl6eDEyWTdxUEdEY3ppbi85bWNQK1YyUGtnUzMv?=
 =?utf-8?B?dGZuVVRIckNHV0Z0dzkyNHpiZnNZRE5GSmg2YUJ1N2diMENpUjFYZkNWaG92?=
 =?utf-8?B?Uzh1TGpuU2lTL1pHbzhmK2RlQlBadmRBVFcwazdIMnVnRm1PbG5xaHBQRGk3?=
 =?utf-8?B?bG8wTjlRSDlHUGlKVGYzMkRsWWhqY293SjU1QU9nNSt1Q25Pb2VlVHlNSExS?=
 =?utf-8?B?TGFtMy83U3JzVXJhZkg4SmpGZzY1bkpaT3FHZ1RNV3p0VjRxb05aZGhQcWJP?=
 =?utf-8?B?Njg2eFF6QVBId0hWSVBLUDFLODU0bDRZbjVvTWV4elFscW8wRXJLZ2c3bzNN?=
 =?utf-8?B?WWs5WjJqNEJjVW92Z2g1TjNDUVdwRHdxdGV5Z0l3SGpxQ0FnckRYbGtkZy9h?=
 =?utf-8?B?RUxreXZvSjdhTzZzVUxnQzVKWExqc1FOVGdLTDJoM014N0Z3WWE5WE5xNW9T?=
 =?utf-8?B?QkE1RE9IN1hQN0wzdjFkMUlQZXFFbGNwZFhteWJjNCtkZE1aQmg4SmFVMnc1?=
 =?utf-8?B?TFdxUENJQklQYVBnamNrdWMxSjF1dUUvaDZlZ0ovakZSMGpXR3lxWDMrYTJE?=
 =?utf-8?B?SThIcStaanVIK3E3d250RVdDMkovV2U1OEtZTmxsc2I2S0VqbUhhckRxSVFq?=
 =?utf-8?B?VjhYUmFLTTJNTzdsMUw1eEx4YWR1YWpmRERvcHI1QTc5T0NqVmVNNElFbzht?=
 =?utf-8?B?QllXRjRDaWU0UTBYNG9YVm5ZOFNwNjdaVFk3OWhsZXFkb1JTRW1udDFBQ2x0?=
 =?utf-8?B?M01LNWdjL1QvRTZlVzM1N3lsSUNnR0NSYWUxMkxpSjJOZnkveVVBajdVQjBJ?=
 =?utf-8?B?TTdVN01waXIrakhHdWFkUjg5b1hMTDVNZWZEb29VUllrT2J2dnhRZWUzVnRu?=
 =?utf-8?B?M3BIcmswbHRBL1RoVHh3ektnYi9PY1pOaWIzTy9nd1d5dEFBdndvV1FnQ0JI?=
 =?utf-8?B?ODhxZUdNTmlMSzBKS1NEeEJ6a2srTTUzR3B0R1JHaG1veFl3SDdqT21TVGtR?=
 =?utf-8?B?MkRScm5hS1dpNFdXRkNsSUt1SE43d1NaVnpKYnB2SWlqcmJCSFVibXZEVG56?=
 =?utf-8?B?UWI4RExFZS81OXkya21DU2lhUjhCa2ZPNmttRGRHVkcvenBqMHFKSnoyYVBR?=
 =?utf-8?B?VFRZaGZGUnU1ank3Z0ppUHpGVW02bFNCa1JTbEIrTFA2c3ZBTWg1Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ece230-2b80-40bc-ef1e-08df07c75a1f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 01:21:30.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqQB1iXPeqTNXBqrLrY6AGeWm/y1gLjLiZIrGPcN8z1u3uZQDvHVsqo+iS9llaf9x0qSsMIxgZDb4+L9izIh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP265MB8550

On Tue Sep 1, 2026 at 1:33 AM BST, Aaron Tomlin wrote:
> On Mon, Aug 17, 2026 at 04:51:58PM -0400, Aaron Tomlin wrote:
>> > > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> > > index 06c18e207508..13353b43b38d 100644
>> > > --- a/rust/macros/module.rs
>> > > +++ b/rust/macros/module.rs
>> > > @@ -479,6 +479,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result=
<TokenStream> {
>> > >      let ident_init =3D format_ident!("__{ident}_init");
>> > >      let ident_exit =3D format_ident!("__{ident}_exit");
>> > >      let ident_initcall =3D format_ident!("__{ident}_initcall");
>> > > +    let ident_modname =3D format_ident!("__{ident}_modname");
>> > >      let initcall_section =3D ".initcall6.init";
>> > > =20
>> > >      let global_asm =3D format!(
>> > > @@ -590,6 +591,21 @@ pub extern "C" fn cleanup_module() {
>> > >                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>> > >                  ::core::arch::global_asm!(#global_asm);
>> > > =20
>> > > +                #[cfg(not(MODULE))]
>> > > +                #[repr(C)]
>> > > +                struct InitcallModname {
>> > > +                    initcall_fn: extern "C" fn() -> ::kernel::ffi::=
c_int,
>> > > +                    modname: *const ::kernel::ffi::c_char,
>> > > +                }
>> > > +
>> > > +                #[cfg(not(MODULE))]
>> > > +                #[used(compiler)]
>> > > +                #[link_section =3D ".initcall.modnames"]
>> > > +                static #ident_modname: InitcallModname =3D Initcall=
Modname {
>> >=20
>> > Can Rust directly use the C definition of initcall_modname via
>> > ::kernel::bindings::initcall_modname?
>>=20
>> Well, defining the local '#[repr(C)] struct InitcallModname' follows the
>> existing precedents and avoids expanding the bindgen surface with
>> <linux/init.h>. I think this is preferred, no? Gary, any thoughts?
>>=20
>> In rust/macros/module.rs the existing built-in initcall pointers are
>> defined directly within the macro rather than pulling in initcall_t from
>> bindings, keeping module.rs self-contained.

>
> Hi Gary,
>
> A gentle ping on this, to avoid holding up the series, shall we stick wit=
h
> this approach (i.e., keeping the local struct definition in the macro
> rather than expanding bindgen bindings)?
>
> If there are no objections, I'll proceed with this for the next revision.

Adding linux/init.h to the list of headers exported by bindgen is fine. Giv=
en
that this is a struct, I think Petr's suggestion to use generated bindings =
makes
sense.

Best,
Gary
