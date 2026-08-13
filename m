Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020137.outbound.protection.outlook.com [52.101.196.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C235839E;
	Thu, 13 Aug 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633024; cv=fail; b=TwzYXpAjQ+9jkklhZKb/HtiTvQlsAT1bg7wnCmfnPW5JmJkcwC+LPc8GW37fn5M7R1E2nQbCMMkSlWFRJ4pSvYZyatcl0A/LMgMVntPGFvNeLin/kiJC2+CHqRzdnNbiwtkVmpJ9G061iSo7Cz29Xin+GJRsPWdPeY6qXtl0Pw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633024; c=relaxed/simple;
	bh=mlOEpwtYO8DSpPpe0o3YOEARW0p1BL9WFxNsvvrB75g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mQAkfiiDsoEVWNMK390v2QRhvoA9ZJuBhTxQmAc55BgkOrsXaIIX9Ttg7unPi7Rae4RsM6wakKt5UizZFfeQ+mIk2C9DVKPBVwULanNW8xJdgh7R5nxWLa6E+9OCptgzTzmVukSGQjujNtrHvDEMRza6F1cwZVX/+spejTnIDlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Z1dFNx5l; arc=fail smtp.client-ip=52.101.196.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Z1dFNx5l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys94M1Cw3SkiAgvHHNdvpdvrSKySwitN9Lw6i4FpFaPvqHvIuEVmD+rhX8OS2DkB7nz88UL9eqzQFJq+rof+yXWThiESHoxf9F6+zx5UhmzJrD9gY+ZFODtJhWTmKfogOpM5/VBdvpY1iaOlLSl3cKdGtt1NK/CkwyTSz8EhNLwE5Ab6t1dgaRYYBWriD85qbHAMmToUcYlqYrKDz+WJvepl9gdxSO2VhxQHRqXWQ+DLderQ7AE3BaIoUs/pNf+awwAPSWyIbAVFH07004eHIsLitmmx7fpJy5oAAJWpZT0gSHPKDLMWIYq5sNkqkRSDJVmDU69Fl0Ven8wWL5Umyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tenGr7qD3NuSLqJ4F3LGYlI99da6E3LMDDathjcC7Y=;
 b=rk4v3FS+BkMraudY1PNz8pLn2gY5Zc2uqpb+yBTYaXRybLu36LC6Q3RGAp6OqY7syWIn52w13GfIUaSum+5UtMnTTIUfObhAaC1+vU+W/xs2lmw5QDMw50l+UfrKi/AhjioY/MVaByEDohKVY1DXIi1eaeEk7eOGZW7L9Bf2c4iyuMEP2ivdLwJq4irUHbiVQTeIH6ARmjc4Au5Mdi7IaICNMHRjBfXbWiPPBabgrn9gG2NuiVHbAJYcBiBIqqm+6e9lq5RnKg8fkHh43hvuc2Z1WVKttwwxEB46jK3wMOZVKTFe0jSdvLCDk54WEW/tkBBRN46CUHf4XdgfaAiLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tenGr7qD3NuSLqJ4F3LGYlI99da6E3LMDDathjcC7Y=;
 b=Z1dFNx5l7DLAj1FXGbP345OJKlEOnG/MyhZ3xOQiunmalor/uIowGr49w95HTg+B5otRhzbkuR2GIoC4tDQ/HWkLkVrr4cmlVLdfjmWUAKqjaApNxHpRIpKatqXP2bNs0fUQJFAVvME61uf8CVSy9aLJZVrYf8C+XHxdr0o8hH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7972.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 14:56:54 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:56:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 15:56:53 +0100
Message-Id: <DKNWJNKYK5HY.1BZYPRXP3BZSS@garyguo.net>
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
To: "Petr Pavlu" <petr.pavlu@suse.com>, "Aaron Tomlin" <atomlin@atomlin.com>
X-Mailer: aerc 0.21.0
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <20260807012601.360452-2-atomlin@atomlin.com>
 <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
In-Reply-To: <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
X-ClientProxiedBy: LO4P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2868de98-b5c2-420f-2fd5-08def94b1d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|56012099006|18002099003|22082099003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0HKLn0tCLaCxNU+Y86IkLLCrjp1oupQgasUCdfMtwlya/zC0smR67kBnF0eaBpDYmnFJpGAQreRb3eptyhBzA0EYc296WK5JTY1G2e9CwZvcJ1IX1zmmoJnqp65no3onDIQDL88W+fXYSz1xHNMD5KMRMWnC5na+qlZKIoipqj6EmApFzTgrBTJ0YDZI9xxS3AEjbPEZ87yUe+teVTH5oZ/tDTxvYkVmIjzmRiP3GyaSVJe9+mwVBBpXwk+7uSz64lRe34QQtZN+1pz5SveDXtScXmWM6EV0o030pzHByjXZOQIYEXxanM/3zMg99CvRKdKjPulErUoG95rHiYa8Kph4+OoaSDZ6TOSKjOmEI7hYQ/wAjU0PLxUDWZ09BVN2V13EDjSHb+Zaizv3ruAIKan0vB0FczYCgW0v7a1+Ow+SE549otamKe5HMaRmgZjZbUKSBygfmFeiGvEtGqNC3+SuFwiO98taFndiEPORuU32RPlm/mDGg/3GctJo/vxKYLOZHgJnZIZHf+dcT6qb7PssPfrDGSnMYWkVerk/yU0CNHNAbL8oWISDy58RQ8Lj/nQKmQrtRgpv8UHoiDRYzhMmJjUTxqOESEhI7JgFeP9XRX3rB5aN1UlAIpqriiMraFPm8iIT3Y+bpMcA9vJedv6tw+vYP/U8bjE2kwUq0HI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(56012099006)(18002099003)(22082099003)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTAzZTNWSWcwaXhYZ0N2Z011Ykg5VWVJZ2paQkpSY2YwTVMwL2hkakEwd2s2?=
 =?utf-8?B?eEpWR25vT2tIeW1uVnFNbTVoNzF2U0RYaWxVNlNiZ0k2WHVDdG1zM0h1R1VC?=
 =?utf-8?B?azd2TFU5emRKZ1k1bkUzUHBkQ2pHQmlBYW1WOHdNV3BaenQvNzBmSkozL3cr?=
 =?utf-8?B?TkN2ZzI0V09aVGVSaFJFYVhPYU9NeHoxZ0Y1MnRZWHVMdURWWU1zTlQ3bEV1?=
 =?utf-8?B?MUlQT0txdmN2dURaYUN4OHNTbHF4WWJ3SDhvdXJQSE1FY0F0QTJhQmE5Nkc3?=
 =?utf-8?B?eEJNMzNWOFd3Mjl1WmpOWVcra3dzaUlUQUZlUWl5SC9wNVR2VXMzelBkQXZt?=
 =?utf-8?B?TXZqWEgyQnpzM2ZoZCtWS25oaHViUko3a0dINk9LMTIyQ2F0dEZtNERqNnUv?=
 =?utf-8?B?czV3MmhLbEVSTmRSZjIzTE5YNmhyQ3ZFR3ZnR1ZRcG1sdGNqMHg0VFdXWG9q?=
 =?utf-8?B?VExMUW1Td3ZhOUpseWJENkZMS2lUZFRqTUJKNjhvMS9mNGlMNFVjTWhwazF5?=
 =?utf-8?B?MCs2SHRVLzFiN1ZUSWx3OEdxeDNoNDBuNy9jMDVNK2pwejNLUXJBdUx3dlRC?=
 =?utf-8?B?RGVWSUF5d1VFbVVFN1FqVytwY0JyV1NUakE2RUhQbkRTTGo1ODdnYVFRUEhP?=
 =?utf-8?B?T3VYWjRCeDlHTEh4T3pUV2xIdUJPcHpiSTVmdjVXb2tnbGxIblk0S3BZWjRh?=
 =?utf-8?B?R2VyczZ0ZC9tRmw5QzdvT2xhU1p3ZTAySGdKYWxleE1kMEhGVDBHVjNXVFJQ?=
 =?utf-8?B?V3h1RGIvVUtDRHlGQ3VicHVqV0VJODZtQ3kvdjhwRGlrN0xhVWN0bEVzeGpz?=
 =?utf-8?B?eUd1NG5lK0JlaWZPdU1WODhYbmloREpwbG5kUDNFRHRwL2pxK2xuK1VEWjNN?=
 =?utf-8?B?bGZvUDYzMnJQeE0yODZPc2xtQmQ2SHczdDlNRHV5UXMxNnBVTWhjWEZSVjhl?=
 =?utf-8?B?ckJBYVk1YVVOemhnTGxWb3lkc0hMRTl1SlhOOU5ERDVZV1RyR0tWc2tZWGwy?=
 =?utf-8?B?T3R5TDJ5VUxTTlczODBqMnI2TnFxbnVwRlVvNGJFbzFGNUdyK1BnTHhVSmFt?=
 =?utf-8?B?L1hld1FPTnROc2J3amQyN1U0V1NTaitpVGorY2JiRVFPR2dJbkhuYUVnemg3?=
 =?utf-8?B?SGpJK2ZJOFBmUkdSY0RnN0FNTWxRODZudWRNcVY3ZFgwd0phY3lOWm5CSlpZ?=
 =?utf-8?B?dzRpVno4MzZZMzFtMzdWMkRpaC9XVTNHMmZ2cGd1d0J3d01mTWJ6WHZkV3hC?=
 =?utf-8?B?a2tSbzdWeHJBUmJTQUQ4QUxyRDJ4T3FDWnN4TW5LcEZDZDhrTUJhcGd3bUdO?=
 =?utf-8?B?VHBYczJQUTM2dUQ5QXNZNXZaaGJ1Y3lPVDdOLzV6OFBCbXJjL1RmRkpOVklt?=
 =?utf-8?B?M0Y1NjJjUDA1NFZScHlyYXBlbCtzRlJmQjNOOU9RWUNwVVM0NmtZU0NDSGk4?=
 =?utf-8?B?SUpreWUxVDdkMXhYOTRJd2V2K1ZFWk5TOWlsT3lmYWJERC9BSFo3TDNWVjRQ?=
 =?utf-8?B?ZkxySG01cFFYTEZHVS9VZ1E0Zy8raHRVQ282VjVicFBuSFV6MWlNK1NZRzhm?=
 =?utf-8?B?eFBPMlBzV1FPa3RlLzJxdWludnRQVFJTMld6UGF2b2JKNm9QdmdxOXl5aGZs?=
 =?utf-8?B?cGM4SG1uY3g2VlZoVlQwT3I4blZwWUVFc2M1K09ZYzNrQ3hwRUlQN05tVGFk?=
 =?utf-8?B?ODNBS2VFUG1JdHV2VkhySVJvRXcyZDNQa3FlaGZTUHpuOThZbDBxMlF5VjlX?=
 =?utf-8?B?ZURqYk0yUEsydWg4WDdsVUVPM0h4ZnlTVkJIWVhWUFRudWJqVmRId0ljMjIy?=
 =?utf-8?B?WCtVWVU1bEJ3Zjl4T3RGOWl3QWxhMzN5RklKT29ZKytZK3ZKZkZSbkdSeXhU?=
 =?utf-8?B?NENubkdrOGphRFdWZlZLNHMwU3ZEUmo4dUZmUnJLRmxVcmZ5UnJEcmowOE1G?=
 =?utf-8?B?R2NzYjMxT0JtVERVaHhTNmxFS2cvU2lXTlUwWW9Gak1zd3NUTTFzMU5keE5a?=
 =?utf-8?B?eW1ib1BrVWNqSmJmcEhNb1ZYcFhoQS9BRTQvZUcweUJ4aU0xakVuZHhKNDd4?=
 =?utf-8?B?d0lCd1BuRDVMWDEza3IySEhRZjRKMGFSRmNrVXFJRHFjL2NPL3RMclY2N0I4?=
 =?utf-8?B?cHFUZkY3SStkVUVLQVZwNmRrUHFCODJHYWU3Z2puZ2FROW9Wa0ZIbHdhbjFU?=
 =?utf-8?B?Z1RxU0NwOHJkVlpsZXVxZ3VwWXlONnF6ektFOHE1TC95OEY0aG54eVltWGVD?=
 =?utf-8?B?Vkh1ZWdFTG9SUEJLU0JpWCt3MVZXdDZER1pDTlFraVNwVmZaM1BTV29oallr?=
 =?utf-8?B?K0pRYjBSdERoWk9CcDNoMVFKYVoxVzl0Q3Z5OWpqNUIzWmQrbEt2QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2868de98-b5c2-420f-2fd5-08def94b1d47
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:56:54.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HR+GRK2idR6Acr00Lb/z3rUvBRdWd9DsQ4Tp4I6jlNmWSseY0bzKtcZ75T/rXZgovImvskivRCXQTKoleFypuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7972

On Thu Aug 13, 2026 at 3:15 PM BST, Petr Pavlu wrote:
> On 8/7/26 3:26 AM, Aaron Tomlin wrote:
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vml=
inux.lds.h
>> index 5659f4b5a125..799d912dcbc0 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -734,7 +734,9 @@
>>  	EARLYCON_TABLE()						\
>>  	LSM_TABLE()							\
>>  	EARLY_LSM_TABLE()						\
>> -	KUNIT_INIT_TABLE()
>> +	KUNIT_INIT_TABLE()						\
>> +	STRUCT_ALIGN();							\
>> +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
>> =20
>>  #define INIT_TEXT							\
>>  	*(.init.text .init.text.*)					\
>
> I realized that instead of using STRUCT_ALIGN(), a cleaner and less
> wasteful approach is to prevent any potential over-alignment of
> individual .initcall.modnames sections by having
> ____define_initcall_modname() define each `struct initcall_modname` with
> `__aligned(__alignof__(struct initcall_modname))`.
>
>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> index 06c18e207508..13353b43b38d 100644
>> --- a/rust/macros/module.rs
>> +++ b/rust/macros/module.rs
>> @@ -479,6 +479,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<Tok=
enStream> {
>>      let ident_init =3D format_ident!("__{ident}_init");
>>      let ident_exit =3D format_ident!("__{ident}_exit");
>>      let ident_initcall =3D format_ident!("__{ident}_initcall");
>> +    let ident_modname =3D format_ident!("__{ident}_modname");
>>      let initcall_section =3D ".initcall6.init";
>> =20
>>      let global_asm =3D format!(
>> @@ -590,6 +591,21 @@ pub extern "C" fn cleanup_module() {
>>                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>>                  ::core::arch::global_asm!(#global_asm);
>> =20
>> +                #[cfg(not(MODULE))]
>> +                #[repr(C)]
>> +                struct InitcallModname {
>> +                    initcall_fn: extern "C" fn() -> ::kernel::ffi::c_in=
t,
>> +                    modname: *const ::kernel::ffi::c_char,
>> +                }
>> +
>> +                #[cfg(not(MODULE))]
>> +                #[used(compiler)]
>> +                #[link_section =3D ".initcall.modnames"]
>> +                static #ident_modname: InitcallModname =3D InitcallModn=
ame {
>
> Can Rust directly use the C definition of initcall_modname via
> ::kernel::bindings::initcall_modname?
>
>> +                    initcall_fn: #ident_init,
>> +                    modname: #name_cstr.as_ptr().cast(),
>
> Can the modname string be placed in .init.rodata to match the behavior
> on the C side?

Putting strings in .init.rodata is more likely to grow the size of kernel
because it cannot be deduplicated with other strings; the names are very li=
kely
to be in .rodata already due to it being added to sysfs when registering wi=
th a
bus.

Best,
Gary

>
>> +                };
>> +
>>                  #[cfg(not(MODULE))]
>>                  #[no_mangle]
>>                  pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int=
 {


