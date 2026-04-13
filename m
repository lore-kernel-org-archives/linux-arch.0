Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2630BB97;
	Mon, 13 Apr 2026 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058418; cv=fail; b=HXrq9wKIHODDPzsOy8j6bqHBsGV8lPjw61r0nDwXhKhbd+6ZjTshbPZPs3j2fwPIAs2wRAkOlAlhb460ZXRNxM9+m1bAGin3tbBdTM0U4wFQ5atWJaPxqSWEOoYvIoaXb77WameHsbhPEdHBfY2ig3EMi3gNZ/nc1v51qfXaC1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058418; c=relaxed/simple;
	bh=EHaRL1cA2CAkjbAtGV77AVcqcxelsXsK45coAJBB3AI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ufuURVLQgX+1EPVZmY9qlCe6ZWuOxYrqP/6uhMrIKsWM8FIXJ87ew2CVlskZ3BUACWyycierOJVZDXB/r0ZNUyW3E7tWvfr3NEJN68nxL34IoD0ZyAVn7Z5J6TEFv7ogwVArLca6LrY6h2Gkbq1dgVySr8xRSnSUWRtcKH7cCXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJPebNnm; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJPebNnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SetEX8gGRZ3CCK5VsfDO5NTac4szFC9lMaRwVV8jGj0ZgJ042BcHR20sKM6nFF8kT7iHfnAFJdV4yBp4rwVvqmIfRMm+SArvOruw9Ynm1Hdk5S/f1WUbkdQd7x64gU4Tju6jNVzYQihqo5AyeMRb18nP6ZUiQpGg1/076IAUHBa4/M3GAU4Ghzng/KhYkK0/B4ndJaJ8a9dhOT4zJLalVqBgqWw6CMLnJ0l+00dY2JUVaxXc/mhQLT7PKjYU3mjH9i9BcDRTFuWAYznUt1FvTTwYYz4cZAk5Kz45dooMD1ZRBLThZDlIHGcz5ZG4BY5CmThxxeCQEk3bn9VjFYtgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHaRL1cA2CAkjbAtGV77AVcqcxelsXsK45coAJBB3AI=;
 b=L4bHvj6V+sCNz8eTFFv0SCDosuN3hEb6MTxbQY7On2Rfqu71SCz6Tu0+zcW6n49hBgcakP2KCb26yA91ww6+WMBE4iX3inB9NU+dUmHZfCUMPkRtDhKlBQLpalx2b5urzQ0nukHl/yrQhiCU8y0Y53Q1ngQr5ng7mgQzsGq5jctiuozLpTH9gQ8nfleP3Hfrg+d3n6dOSr0D+UUyVK1vLcKafk5bIeamceNMGkJ0x4DuaL1hm6AHbDBhM2pYZFISylb5E3xsIzLArK56IERnLTS5NH1bfM56mjKqkJ/Sb3LVZjAAr0x3IF23Obdq/iss8juIa0bLhhrYjpJTZjAmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHaRL1cA2CAkjbAtGV77AVcqcxelsXsK45coAJBB3AI=;
 b=kJPebNnmYTpD2zlGS4V2gJnwc+td/bKy01umy2l3jCBLYyJJfg2KzYT88805U6qgpKwvbHOKJtS/ndM5bq4/FC+Gqlt9RAGg+qqihXgbbFsD6E4M0+Uy7Hkq5YP6h+iNR3a0tIOQzQ6jelz4VP8uQenYaPlnHAu2jO9QXmiwAn9sK0HOA1peZ5WqAYT7A6QEBWyofaiLgRk5v45n7jiEOM7bnaTt8i0Zu8bCxdMkNGUw83xOsOu7kiT9+dL7wVftzRqChzGKnhBk1qkdi9tyIVlcDMb6fni65QG/rwHdbs02EEK6RvQR5MAOwXkB6Np7JzIv897yQNgYPo60OX1VwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 13 Apr
 2026 05:33:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 05:33:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 14:33:23 +0900
Message-Id: <DHRS5QL3JLEH.T9Z5PSZ4K8BJ@nvidia.com>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrea Parri"
 <parri.andrea@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Nicholas Piggin" <npiggin@gmail.com>, "David
 Howells" <dhowells@redhat.com>, "Jade Alglave" <j.alglave@ucl.ac.uk>, "Luc
 Maranget" <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Akira Yokosawa" <akiyks@gmail.com>, "Daniel Lustig" <dlustig@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>
Subject: Re: [PATCH 1/3] rust: sync: add helpers for mb, dma_mb and friends
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-3-gary@kernel.org>
In-Reply-To: <20260402152443.1059634-3-gary@kernel.org>
X-ClientProxiedBy: TY4P301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4897cee8-f382-4eaf-1471-08de991e2fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PKt9b6ofqglvdKm6JHhc6ttj93LR9jdJcknJhssMpdofFkVeGqTX/wiVnqH+gYrwPu2nC9JvKyVijM3EMAGnLHd6hwwsjoql7kevT+/PXFgzeqzc18oD3pW7/AUc+/JuRKhvnAoUkpS4DMcLIX8x5TKaM6LfP0B7mGH6Vgt184QCPLtpwJCVvS8qLCNj0Zl1Yk3B5iwNsOlPkNQwsDxhEMSeMNEr3wMOZKvDlBSFuUBTsJSo0jOTuGbP2zUWjl+LYv7R59PkLf47Qcgr3T6Vc5Md2S+udBiH1PIFiRXMJ7X7gSpx5f7YBi/Ngf2JIM04swX9H6l2PifpJLZylZj2cta9zwaxzZTn7d52Lhz3m94Ar+3wCdA/tvNtJgPFYBgD/VNYH82k8XEacd03av3JVc/9U32bRk/ItTxs8j0R1jKXfTfFZlArPgWyCdLSg3DXgUk6kZc/37/AwhL/Xx54FRSaHIXlyXqxdWADGbeqv+NeQxYuYGMjytiNvqON2lgdhjWTUSTcOwPHBnzCozryCO4DjAHc7jjjHnxBIquyAlXeUp5hs7gB1twDW1yOBF1LEfj1qwGnt1q7DknjJTUiMwW4A5Buwlkj9kavYA3cBU01NwAm5VV4k5i2gev/D49VJ/Gqm9c8vchOiWxelKgueLf6e1yZKY2yjHn60RSUn6G96dgJ9+20PunG4Mk1KHh5L5xhx5zNpQs+wWrwy0U1q78nssK01sOKHLCLIntTM2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZwckM4Wm5NcVloNVh1VHc1RWZWaFFlL0pXOVZEVCtqWXRvTHRaVWJETzc5?=
 =?utf-8?B?dTZUSG1zTGRqMlpYWDZUcVdDUVNsSE5pTTMveVYzTXpUMDlPRllNclZvSzBX?=
 =?utf-8?B?cTJ3K2VDNXEvbm9GS21ndlFCOEt5d2pKSGtwUnVDYjVaRWFJeVRwaStZdXNj?=
 =?utf-8?B?UVNoeXlGY0VEWTgrNDl0ZjdtR2d1bFRENm9kNitqR0ZhdmxNWkk0YStrVVl6?=
 =?utf-8?B?eFJsS1ZWZzZ1V2lZZXNnSGVOdExheXhmRjJReFN2YTdqODdjK0x2Q3NOWGdO?=
 =?utf-8?B?bmlhSExZZXkrUmRNMVBMQ3V1YllzOTZYSlRjSDdOdDlMTzlvOXd0YlQ5L1pU?=
 =?utf-8?B?TEFuTk01MzRadllOYUF3WlhFL01tUEZvclpaZ3hHVEMrR0l3SldjMHNON2xC?=
 =?utf-8?B?VlRTdWNhb3VmMXRlbTR3YmZJaHliTzRpMXY1anJGdjdKcXh6c1BXOG5LZUh0?=
 =?utf-8?B?TFYyOVlvN3ZUVi95S0hVNlBBQ0htdzVLVnZlUVJYUzc3SktFZnV3UkxjSWRu?=
 =?utf-8?B?SnlDTzdONGo0dS9wNnRwSWFEYVA5ZjZuYXY1Yld3ejNtb2RFeUNORElqdTJZ?=
 =?utf-8?B?RW0zR1c4bGFGQk1PazB3Tk1TTWx2LzRhRDdKbUlkRWJnVEhlY09rSVdGVUZK?=
 =?utf-8?B?RUs3RC8venRSL1VWOHZNWlgwV1orTENpY0FDZE5nYW5UdmxxUVRiSjdiWDg4?=
 =?utf-8?B?ckM3eEdsQURNZXQrZzRCUER6M2diUEdsZkFOYnpUb1B3N0JmS3FPL1BuMWFr?=
 =?utf-8?B?aVlmbWM0WWE4RDZydy9yWFY3TzVLVzdBN3QrZFNnQjRTUXVpSlpERnllUys4?=
 =?utf-8?B?MWhiSjRQTmM5M2hsTGEzWTgzS3czTVNPV1RlT3kzMzU3cC9CZ3RTNGdOckF4?=
 =?utf-8?B?Q1ZIUFdlbEwzbnlFc1BzclRjaEQ1QkxJc2NiVHQ4cmxWMENqYmhsZ3JDSHJ6?=
 =?utf-8?B?cWNHM0JNSHRnUExVbE5hTFBIQWt6SGxFaXRxTWpzTmdKbWJmYndsZ1llVW5m?=
 =?utf-8?B?WFlxdUtPYlJxSVgrWnBpRG92QTBPQWVyTFFRZW1GOUdZRlg4U0JnUTBpYkty?=
 =?utf-8?B?VUthYVlqZUF3OUJheEt0OVZIVGFZcDZjbnJJY3VBelhzN1RIQnk2QWRicFN1?=
 =?utf-8?B?M3g0Vmw3aFNYWUEwemFVelhIdkNFbzZxbStvalQxa251RXQ0VWlnUENWNkJn?=
 =?utf-8?B?TVNRMHdqNW8rdnFsdUZUZzhUN3ZGZ3ArYkp4L1VMZXVkTE41cHUyU0ZhREVF?=
 =?utf-8?B?ekpiVGd5RS9qdHhRWlYxV2pmSG1kTWZ5dXlPZXFaREdINUhqMG1ySVc0QXRs?=
 =?utf-8?B?akhZN3NuZHg5TVhyTUxWOTM4d1JyY09CVjZwcmZuc2NZLyt6NmZBTW1oNEpY?=
 =?utf-8?B?Nzd3TEZCc2MvOUFkUUtZUGdUUU0zei9OUkVtdTgyMllnQ0NWbXNtbFdDYTl4?=
 =?utf-8?B?Tmd4cEVNc2Rsek5TQUxxUy9GR2FzMEg4OXBYV3ZxWlhJR0ttTkNTejNjZ09z?=
 =?utf-8?B?OUYvZllaYmo3cTZlKy9DbHRaL1NFUFJyRUl2YUpwK2J3OUs0V0VpWUZ5L2pr?=
 =?utf-8?B?QmNhTjBLZXRDL0JxTSt0MmxIYTQ1Ri9XWWNFZjMwa2JZaHo2MWFKTGhiMklj?=
 =?utf-8?B?S2p1NkVMRnhNNDZSL0hBeWZEZTBETzNnOE9mWjJCVXNTN1oxbzMxT0p2S3Ra?=
 =?utf-8?B?S1ZMU0hoU1p3elNWdzRrdjdtbXBVdHBSVUNUeVpVSnBLdm1hU1BDQXIzcjJN?=
 =?utf-8?B?bVZXUEZxZWw2WHA5Um1WUzBXSk44eVNpcUc1ZDk2ZDlrYUlaazRaZ1M2bmVV?=
 =?utf-8?B?ZU9PQm1jS2g0Q2YxS2N5OWlQR04yYldNMWViRm9XY2FMTXlyd3g5TlY5TFNq?=
 =?utf-8?B?SE9TS3BxY2tOekQzVWFLVkhTTElNb1JpVzQ4Z1dtTUVVamkwOFJ1S2RwMHIy?=
 =?utf-8?B?M29ZbnhHei9LZnY1c1UxSTBhbkZEdFBJMVk2SFB1dUlrMmJhdkYzSTY5ejk0?=
 =?utf-8?B?UU8vTTVzTzl2dkJpa0ptdU9LK1hVSitBZU5nR0llTDllOENCZ1hmUUJjakpF?=
 =?utf-8?B?WWRHbUJhTFNGdDNUMnBnTXJoOFVuL1lzUHBjaGFyNDZObi8xenhxakJLWlNl?=
 =?utf-8?B?b1BRT1diQzRWdGt0SjBQL0s1b0RVODN0TWpDWVNKVDh3WGZ3VnZjWDdtdHNW?=
 =?utf-8?B?UFc3WHlFNXN6RHdNY2dMczF6TVRuK1BOakovZzVqWUs0bXNpZ3lPVEpuOXB4?=
 =?utf-8?B?SnhrK2JhZ2dyRDd2QjRockpNRjE0c1UyYkQydmE1ZTZyZDhJWnNWb2hnOXpD?=
 =?utf-8?B?bVRqbnE0Rmd5Y0VDRjNMZmhLSitpOXJlRFFmc0ZXQ1lEa2JjVXdyK2ZXNjJG?=
 =?utf-8?Q?8Z2dENqimWMp8s1drCrlN36uVPJxiyPtai5Q/T5Eu2VYc?=
X-MS-Exchange-AntiSpam-MessageData-1: l6+arFR1uQNvqw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4897cee8-f382-4eaf-1471-08de991e2fd0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 05:33:26.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlhGnsxcBx0Rskvce1aO2oCGTNNXI61lFRAtqKEC+TdZsx6TfmgbiBTig0nl2b7ZpK8LjxPoCacEd/0m1ccinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1

On Fri Apr 3, 2026 at 12:24 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> They supplement the existing smp_mb, smp_rmb and smp_wmb.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
