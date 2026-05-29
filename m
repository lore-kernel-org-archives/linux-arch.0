Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020087.outbound.protection.outlook.com [52.101.191.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A13909A2;
	Fri, 29 May 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076856; cv=fail; b=pkFPoU4KIHTZd+UmuQx6qgwte3PF58s3om3bVT7x2rZc4lfPUOqziP47XT2EbwpLtSoLWjsB2B69hTQCG144/bmUCIs8ZQOrdwvgvmQ7vFky2zi+gY9ynCkjzG2N4gx1mUU82wmVOirWfd9Pc7Nz1ynSkvVn/nk8Ft8pzoAobV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076856; c=relaxed/simple;
	bh=+d1hWInGxWI9/nZlwyu5dQeHrUSSaKKFnVqmHpBTO34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=slcNQm9DPgG20xIlSQbObEEshfVNNWUaVAzYusKS8VO1n1/Evg1RcLK3lZy7WUDHeUBfI45OeU2u708nzGEj5Tx4MXJyPJ8sO7QtzipfLsxr3q0KRRwbNXC6fVITRijo+1RK6yzVn0via7iGCttY4ZMoWD3J+3IYzAncIaw4kWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aa6EeteE; arc=fail smtp.client-ip=52.101.191.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aa6EeteE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuiZmJOH75OOOAy0ccY7Q70H3YfST+mos9xo8bwP+hqluuS6BE9oP4h61UeBIJ604PqDNLkBLNfwFGTn7wvz21M7T5ny837qW1nE/XJjPG4G8Y1Fj5nU4rnUeIi5FPPlKYrlzbBsfmOKvJHw4puqECqSn4SZxq2esw+OWlfi8X/EXuFXIX3I1pK4SbA6b1/NPGwRHQIb0X3CluL4jXF/+XwmkYhd7nbfmKLDt58267IQeoeAK66PaG1JrBsKWVCpb1RoAoYEB0sB1ByfKZraYgFD2EJt4hLjWxnT5+DscgPXI1scRmwNRzstcR3e8E6Ua42pp7KBQc/ZpkMqbqiSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB0FIykHwSvyzqTlvm27XBUJnI1wlUFZM8BAEy4O/Ek=;
 b=u23PR7vxg9P/pZwtH+0IQ4RPpb8imMC72q8ZkUFt1UT6lQB/veqyvyQJbIjRRbww7whn+GRFfoDWaK0zkK+UPmCM1Yx/5sshJsk8fK0tdPzkuXpqN+bl9r127rPTJ53ZRSZpWKRAVnUE3/BZ6iarOpCNs/84gxPIjLV1y1TK5/BCTAj21IhSfN79gLfV5klrZ4OL0WgG7/VcsMsyfkLWHzEBpZv21pyd/X3sqAfhZNAaLmOj2m79Rs9OlfzQQtKT1QVgFP825IX7SmPwc3ozev3KO40zVGo2gdEzsDja2Vf0UM6jxZutjY6nKti3Q4amZGHVehwmmkB2jHk9XLyvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB0FIykHwSvyzqTlvm27XBUJnI1wlUFZM8BAEy4O/Ek=;
 b=aa6EeteEyhRJj1bRQU2b/QgQibvt3aPoCO+UY4jK4i1y6al2fFHRKm42j+iaawVvT0KO1OQI5OECzFLWRLEKncroU4ELJrVMJdRem4l/psy+QMbosV/uiZMJerTdKZoQzZpsHqZgi/LuViTr6Swj0gvs+39uT0GqbE41AKBCn+lWqG/U0NR4i9i37sCuYHq9EX+fKx3jug4AP1sDNrICCuTDPLxN30u69h6fTly+0Zr4BgD0s3uXI5WPOxqiE+VhHRcgAlh/NZo5AlSwAyRIHKefUUoVYWpv5lcB5WvTveONcjA2y2ZTRKxZjaSUkgScOQD7C7udaKhmFYqHD7BgLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5835.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Fri, 29 May 2026
 17:47:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.21.0092.004; Fri, 29 May 2026
 17:47:29 +0000
Message-ID: <844b56fe-b5d4-42b2-ae8e-ce07980d0f50@efficios.com>
Date: Fri, 29 May 2026 13:47:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uros Bizjak <ubizjak@gmail.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-dev@igalia.com
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
 <20260529-tonyk-robust_arm-v3-2-a6f02684d4fe@igalia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260529-tonyk-robust_arm-v3-2-a6f02684d4fe@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: ec87b175-a7c4-4dbb-aad6-08debdaa5a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v0oFQubAHBEN+c8UfB1X0VqeADe18DP4vqoI5O6vGVmiDMnnhx0TvP52h1CveGiklZ/LmTbxgDOasyyxyCMTfdF9di4iePe5CqI+T/WIcWxrEDJkvVb7NTroqKC0gjTf1AY0iDnb4Y1zBRH6JkTKpUDdDWOFXQofKcb4uojBCYuODxI4WxcUovy9G3PWIHjpfdrP7uDOSpFAa+DpNkUSAro8UOw1hqBU5r3MdUdvqLmUK5Ipqd8XgSxiBDKX8/24vAtwJqM0aIBRUUptR0ajXvJ/fH3/Zni+NZw7wVfRjFhJfN3WhGUKrCejZ926/sd4JLsk/WxzE1fVtao/nMu7aPv8pDf7e8O30fTEWOtiW8uWOhB6n4JmUhcwqi29DZyxODS949qOj85+Pwk8mRI1DUss/2nCEOknarA5AHGTsyA/qXVmd/+g3ffYeTxu3l4ssAm5Z3/VDMIqgxpWDpusTAYJ8U3JcflfIgDcOsiHYVYqatMGrg96ydtnrnFyZc0CiFkV6jzAvGhMWu5yXVyZshGfWggGiusq+rPZH8JsC6cQLR++x6P/FIbu+yzXgJRFT5H0nWCIudmtrrbabBDiZ96ElYly5Rp3B5pD1VBCxGOFC+sBz/2GSWAusGK1lELcGADxSGWAJsHgIdKFGF3m4yPQb/PWPzN1gUow3aA8Oc/Fz+E9FAo41Eg3NR1QqWc0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGxkSnVzZ0UyUVlNQjV0R1VIMG02MDBTOHR3YXdlM0tSVEkxWlZiS010ODNN?=
 =?utf-8?B?Z1k1NHd6b1lYTXVCa0ZkQ29DUkI2RUV4bmw4YnZhZEJ5K2puMENsNitqZFR2?=
 =?utf-8?B?OUI5Vm9icUJiNGJWWlNpV2pIdGcweGYxTlVPeEk3VGZpbnh4Q2thR1BJQ05s?=
 =?utf-8?B?bWc1Q0dhYUxCVVhVc1B5RVR6dEFsbGFQdENFYkd3VXRtNnZoMGZDd2o1Qm9Z?=
 =?utf-8?B?UU1aYk03TG1qYm1QcDBRYVBnNVBlZFlIMnczcW9oVVNSYjB6MzJONzNTOTl1?=
 =?utf-8?B?WUJJTmxzMXFXRWxlRnhkQm5vWU5zcjBITjQ2ZVRibVJwSFpEZ09EWStLbGhI?=
 =?utf-8?B?MDhGdjlTZC93dGhtQ0lUbmIzS0FMNHVSRUdONzc5RzBkRGRRQ29DOG5GZGtE?=
 =?utf-8?B?TStXMWdQdnQzT2ZZYUVycUxZK21Sby94TVFOWithYlBxRGY5YXB0MG90UHlS?=
 =?utf-8?B?SFUraTNBcS9PTUlLSGE3SUVDbEhnYnNnYUx4TUJXR0plZ0V4VlIzeWZ2K1BU?=
 =?utf-8?B?NnlUcitnYWtNTGtaZEc1bGdxSDhPVlZmaVBBRUlCY0pSNTdjMjdudklvWTBE?=
 =?utf-8?B?U2IwUGMwNUt6RFdHbmRNRmExSHByVWhCZTQ0alV0dGYxYVdhb25CR0UyQ1h3?=
 =?utf-8?B?N2pEWmoySlBBWnRlUC8wbWpycE1jVm9yUnZMZ0F2VGtJcDdhZUZ3dlFoMi9U?=
 =?utf-8?B?Tlp4cTVDbXFFN09kYUhjQnh4d2R2cnRuZ1hBcUtmSFI3aGF6anVLV05wQXpX?=
 =?utf-8?B?d0tlM1RLNGJwZ3J3UEU0MXRtOFh1TzcxVzRRVXVhRVVvekxKazhldDl6Um5Q?=
 =?utf-8?B?WTJRYm1wR1VpN243T0d5QVBIZWI3bnJPaERwbGdpUEFkTTJBSEk4bUVtRE80?=
 =?utf-8?B?SGh6TXNVNWExVmxTS3IrSnFOOS92TlkxL0s3b0hmUzhjK20zb3B3MjI0Uitz?=
 =?utf-8?B?QjgrM05EQUVqT3Exa1p5MllyWkl6V01LbTNIR0lOY1k1QTNoTzlPNE85MUYv?=
 =?utf-8?B?am1KbjY5NHNLcmxxQnpNdGlDcmhTVnE0TEdnanl6aGZ5cWY5aFYwSmc5ME9m?=
 =?utf-8?B?aWhpbkdpTTlnZG5qeGVvQVA5U1liK3F3ZzN4eFFlYWxzM3VVYzI5RGZUdU9I?=
 =?utf-8?B?eFAwNXM2bmlsVTR6aHJnVmhVUFZPWnB5TDJxLzkrSCswZTY5d3M0NXdHL1pC?=
 =?utf-8?B?dkxvVXlyRFRmdE4zQVZKS3hIS1BGTUhibmhGWlgvb0RqUThmS2RWYzhMSW9N?=
 =?utf-8?B?dTNXS3RxK1ZtZG9nSHdhSnhpMDkxQkNGcUtCUHEyZGI5dWdFSGJuZm1ERVJi?=
 =?utf-8?B?VTN1SEhCQlVyOHVYVXczZEdhTGcwVnlobkhXcUY0ZXo2OVdva2JEUEF1VWhK?=
 =?utf-8?B?K08yQm9nam1QWnUxZ2gvVmV2Y0FPR0NWeUlPUzVIMHFsZXQ2dEg3eXo5dTJ0?=
 =?utf-8?B?Y2s3NUpua2VYTmFRdVVVU0xFdDdGTUo4K3BzN3p5NmNremRodDQyL1IxRlZ2?=
 =?utf-8?B?K2pzZjAyUm1CRjhGWkY3V3pPb01pUEJWbzJrclFwcmt6bFpXNUVMSEdiaUtX?=
 =?utf-8?B?aUE2Zlp5eHZyV2NlVFMwT29oZnZpeWtaZmxTNXdQeTg1SVFpZ3JnUXQwaGZt?=
 =?utf-8?B?bEJUelFZeTNSWlFhaHFjaHliRFZidGVGK1BxbGtnS2twU2VGTFRSY0Q5VGtR?=
 =?utf-8?B?SlhUdCtzTlR2aWNMMDJ1M0NzdlExSWxjSXF3R2NZWDNUS05nTDZrSGVGSlB0?=
 =?utf-8?B?QjR4WU5PMjRjYzNBb3RGc01iSmxaRjV6TFk0SU1NRlJnajFxYzRkazZiOFNW?=
 =?utf-8?B?Ni84SjNWbHR4dUpHOW1PeVNHYVViSk1Db0VXKzFaNzlJUWhxdGlvZmxvd2pP?=
 =?utf-8?B?eTU3YjRxQ214VzRmK081M2V3ekc0dlF4USsxOFU2M2xxKzBqZzdWWUNlT0JB?=
 =?utf-8?B?dis3N2FEU05FN3RoT3ZLV0YwTjR5MWRERHJTeEhGVDY0ZjNuTVExckUzS3kz?=
 =?utf-8?B?bS9OSEh2MHVrTnAzYzB1YUhaOGM4c3RObHhHN2xVb0hNRDIvV2VoMkZtWW84?=
 =?utf-8?B?bzNsRkJRbHphWUFRQmtjL203V3lRQ09GWWJSNnNuQ3pTMkJ1SnVyR25ZbkRC?=
 =?utf-8?B?TUFZYlRLd0sxcng4MW1TazNSTGNsdEc4ZW1KK3hwNkljcCtQaUdTRHNrbk9N?=
 =?utf-8?B?RUdCMlU0T0wrYlB0S0lzUTBNQStlODBpMWNSLzZGY1A5eldUMGFOblFPTGpU?=
 =?utf-8?B?cE9xZTkxTHFkK1BFdnRKNHZMQzlFVWVGMnlVNDF6SFpLL3lXU0tnUXdicTRj?=
 =?utf-8?B?WUhQRVcvYUU1MVdMbDFBSStzTXMxNzlVVEFiUVhBN0lRWDhrNXYwdkI2NVRj?=
 =?utf-8?Q?RK8nvF7Tz9vELRIl+JTDdZK2wAA4r8SxK7LB6?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec87b175-a7c4-4dbb-aad6-08debdaa5a91
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 17:47:29.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD39FSmmvrBrFD7KlEXtZXwwNRVb2WlGo+WuD3F4C0Mfu1j3hICCOBTmHsf2dDupyW02c7FtzlU9pdE8h86FLGSBd5WaVpHE0EVBGfXxcow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5835

On 2026-05-29 12:33, André Almeida wrote:
> Based on the x86 implementation, implement the vDSO function for unlocking
> a robust futex correctly.
> 
> Commit xxxxxxxxxxxx ("x86/vdso: Implement __vdso_futex_robust_try_unlock()") has
> the full explanation about why this mechanism is needed.
> 
> The unlock assembly sequence for arm64 is:
> 
> 	__vdso_futex_robust_list64_try_unlock:
> 	retry:
> 		ldxr	w8, [x0] // Load the value from *futex
> 		cmp	w1, w8   // Compare with TID
> 		b.ne	__vdso_futex_list64_try_unlock_cs_end
> 		stlxr	w9, wzr, [x0] // Try to zero *futex

So it looks like stlxr can be successful, and the process is killed
right here. This is not within the start/end critical section, so the
fixup is missed ? Or am I missing something ?

> 		cbnz	w9, retry
> 	__vdso_futex_list64_try_unlock_cs_start:
> 		str	xzr, [x2] // After zeroing *futex, zero *op_pending
> 	__vdso_futex_list64_try_unlock_cs_end>:
> 
> The decision regarding if the pointer should be cleared or not lies on checking
> the condition flag zero:
> 
> 	return (regs->user_regs.pstate & PSR_Z_BIT) ?
> 		(void __user *) regs->user_regs.regs[2] : NULL;
> 
> If it's not zero, that means that the comparassion worked and the kernel should

comparison

> clear op_pending (if userspace didn't managed to) stored at x2.
Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
