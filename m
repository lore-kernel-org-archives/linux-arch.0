Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795110536;
	b=CxBu6Ww5zLpgcwM1JuxkyvFTyfI2Htb2eo9S5M6h1XQ3a2rlgqNocwqEAPAf/RpFbZjs
	 V4dfH8Fpny9FrliWERIYTlvXyB40ldJuzIfpj9HE/LOEQ+7HbRtpB+ZGp1Ofy8WXeVKkS
	 Re2UdIY6Dj5D/OsHSSt8lIQuL8S7qzI9+IAP3ajJQbeTYbSJBU6llJgFpKUvY2cKVq8LA
	 r8QFUWBw/wWym0AMKyE0dxqbYIhnUzmuMkhnPdxPj1FWVTZC9IB5P7/GRWhwpnk/Lf32H
	 G+jEXSqPEwNaAQp3AHjRSiBijbIzgxYIjhwDNS6ovF1PMB7dOUFtyWDfcbIqYgJyUrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110536;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/vLNHmtF9gHz4291MhYGXrrnLDBd8exLtA+zAo12stg=;
	b=3+Pt0QdJSNHkJtKEZ4SGczIlPTwfwLyeOV7PmiJqOLyi+OFD8G3rrBdBHjuIAjz9ZAN7
	 3FaIkTRDkgcByzTXVCNgWkHX2YgLw7IyzNVcSz4lyW96yyTgp8TCJqOuOmPOQpqkBT1Lu
	 E12UbaMWmZ0I4bYylM7dVbFg3Eq3Rdp4CwOrx1liHt8huORK61AcMwvE6XNP4bMLO99Je
	 Schfz0ClucmCDXXapTT8gZ3zVruyd9NevOlKHliQRFbYePm1FBzvVGGS8s1YDMggyqBnL
	 kdkhDsELQe+RS+a+yc6xY+dChtAzr1RYaul1gLaduKzbIH4Pop2bi3DcE0pJ54VjJcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EOpKKsBT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.45
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A34606A320;
	Thu, 19 Nov 2026 17:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A34606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EOpKKsBT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDV60xpbpWh6Uzgbm6ggsh93NPieuPw7SR5SsQRHeAWX5UZ6t9H9qnT5Go06icbdt3NrGMTbvgYmmxS4XYYzqUndZ2bvlG5D/V5Q+kEjjeoVlj+NPUwIhQl6oZY5kSTbfDrL+gm0FCquGDeWEa6Y96VG//1Qgr+jdK6Blh1PkGufDDHXKJ5M56A2OZddrNxs+6mrz7lpfgWfwPANVYOltnd3OFLHDij9OJX0Zgm4nwmdt+Lfqcse8lKEH09ELVcBp81WHPCU62jZsr91rlFsHirVQfxAkrWueNSmUui6gquOTkNtu6NbMA1pMyho3tYgxfyyIUYzRJMSOKJD1w/3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vLNHmtF9gHz4291MhYGXrrnLDBd8exLtA+zAo12stg=;
 b=CfIt0unq+BzKinX08mYRzN9N4ibZ/lr4RjrYcns6Lu9jaVfyKeUWtNRzJfSfx08cfg4uc/rAr1GD5F40dvaQoS/dMn3L4HjUKN4NFe8A1/n4fphD8oSGjPg472W/b/J8IEjuzK5nJtypl8p3t0Bp1arjWagXtqzDLixzcqnh70J8ny8qwYbLhDprpuCEkv87Y+Ss95nj9b6IB4aV6agS8+sEgzZYakEuS+goSapO5LWKct/FJjbFAc26WAC71S7wOWjx3yE07En1dF9U8D77KSjIHY2qJH17B2w5R23fmMCFgVVCkRCICm3jQTZF5qmaaqzISGqvFD/NDGCNPIb1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vLNHmtF9gHz4291MhYGXrrnLDBd8exLtA+zAo12stg=;
 b=EOpKKsBTOC5DZYkiMZZCOdfRPA3Ep7g+61ghDRZyTs3uyvcwrZJuzdxywCqibz6g69Is1d5Nrndu2Rv1UnooThBzSxoBVn2+9CMIF58P3ummLcnOwgoz+CjUkk0E8k8I0SWvDx9wjOvqRgpLB8NpkEme7j1lNBd8xuaVY+L1ztyvfESC4yaLs1j6b5mhsKl66IOKfwb/cFR6BZzFWvj1Nl2NVh3k1WgUA5f3u6EiQvz1tKwuqcShkKvXjKwpBYwMOKMLVaiLd0Zb0PHL3UA2reNEO9laa+P8ZlCRHAb6rOBnYryF/zbHiCFp2AK816aAucflzpdrCowfPtnG4p4/rg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:48:51 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 17:48:51 +0000
Date: Thu, 19 Nov 2026 12:48:48 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Tzu-Ching Yang <shingekinocore@gmail.com>,
	Brian Cain <bcain@kernel.org>, linux-hexagon@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: bitops: use the compiler builtins for ffs(),
 fls() and ffz()
Message-ID: <av82gB34yByk1WL5@yury>
References: <20261117054939.2126980-1-shingekinocore@gmail.com>
 <av3-Nf01tdGw62lh@yury>
 <20261119053249.2098578-1-shingekinocore@gmail.com>
 <7b19010e-54e7-418d-9fdd-bcab69d8a885@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b19010e-54e7-418d-9fdd-bcab69d8a885@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: c84e3a97-e55a-4e50-e1dc-08df46655f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|10067099003|261028144727099003|11063799006|56012099006|261026140227099003|4143699003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o3H+BR+tTNMMeBUtOmOO98ZpqNrnCPCcj2S6uYs/mZEbgSui77MV03lWXcSq6llpzs/rF4O3uyoYWNag5RT103s1+NyJLbaAYE0rvNjyDcSrhhaXJs97PTCjcIXnvP8B6tJ+f/ydoG9HL/DpmKdFf+NGwywwsJXd250m+7RBOXsG+29xc+pdZxr+e4al7YNwvD+XjMSodTzm3iaygR5+MKrUEbS+eM/J87D1+1EG5VZSCIjVqOiLMAfMzTktNwqHD09X5XNi2odFEjDZjg0sOEROyNkhoK7wQQELfoCywKvI1OR0LPy8L7L2WQDvbm4/HjiwWaZZXd4LQXu/GGVh/LxA2uBYeISq4WYJ9mDxjqSBesM5vg+uHFJxQd0UoPNJbetGbqt0fvMuMRKu4sxfNbE9dXbBtxiGJQZDbRNnxRZgtr7QG1WHKiTKC0dabNKIonBad1hIqVckrVIwpu3h5oZkIjC/HuN/kLlfWXSx2jh5N7LvNsNbnrUJUbyOgwcSwB3slYIFIn3XC988SLtzBEoWApSaIYdsFDlAs1aBlMSBHjOeUwDzWDehmkOmwWNS4l0ruEPqQ0hAw9TKAf2+HyWuNm73JjHY4AT36A5EPD1pEMXjDgHlbMCPzXaZ08gH3yE1U+m/5ev1s73D4izAEooPv7aKprO9lIge59Czh4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(10067099003)(261028144727099003)(11063799006)(56012099006)(261026140227099003)(4143699003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zsGjqxn0UbbPVVAsCLPh8WdWQX1G5afdAA1IMQDuLqiSjzvzgeeo5f0zxNgh?=
 =?us-ascii?Q?2yG6Mi/wQvIv09hdnBZCPCxZ0sBYHx8lSEh0ROflVYsT2GN8/hazoHeMzxmv?=
 =?us-ascii?Q?KrRKC2nyFSkuHq81wGYZr3BwRQY6RQQxq/9xc9LAxs8i75QC+HQlz5b8e2+E?=
 =?us-ascii?Q?LtZOJrUlM56cOectizX47SWtAh3z7/NKvJ2jDnYtHdXbaggPPv1VmtXWcEH2?=
 =?us-ascii?Q?/P2FxIfWLBq/tyq58HDuaNnBDE+rXEJ4XwYSzAYhe/vVB+MfBjH6H1/z0A77?=
 =?us-ascii?Q?NdfKTCtrEqOGcGqAUaUH//Y4NPc4EEFmwJoftlvMoV5mrAe0tmCvfvW6pZtv?=
 =?us-ascii?Q?+MZy0jjW1pCc4nOQPaWJWvjozsGxRQlDbZw+EE9lTrw4lPmt3JwK/s5MNQ5J?=
 =?us-ascii?Q?j/QCzudfNZ6R/IHYZrDWUK5o31q3AgRVWs6Dh58eXfH+0wu5u1ZtYs1phK6L?=
 =?us-ascii?Q?3TMaxWSGkMqXLflkc0RKOBW7hYfY2HxG19fRCVKtBlMyLEulAvjSSD9AhvoS?=
 =?us-ascii?Q?sZGXdPcGwWq2NhVGpMvH74EXf2uHLyteckzHwjdmHUh2e+osiC8iwuM8/aSh?=
 =?us-ascii?Q?u7li1Xsw5Hn/xvY710/VkV2RjLohr9LYRZOYxN7sLPm5YHPnqpvybqG4xpH3?=
 =?us-ascii?Q?Y1NYwxnA/NYZGk3eZkUygyxjon4obyY2VlktGx9V57yJl0JHCK6Vd7rZfF8n?=
 =?us-ascii?Q?q699c23yq31jRxdEafMU7LEIDt4U4MSoTPkV6PddbhU+OujOZYUcGn4Is8DO?=
 =?us-ascii?Q?7YvelqcK7j7vdad2rzB0rhyL0aJL7D5VPVqg0+1n0Dh9jQSqewqCWjGM6WCg?=
 =?us-ascii?Q?UHv9KBGGWrrpGrJpfBiQWeBEa2uu3VRXOZy9zFl0EcM9WDZNJWoKhrWhAwt3?=
 =?us-ascii?Q?DYrj0wLbmTjBkst1NzPztZaQL4wqUFYIAr4/ZMEgzwuLdtiXVSSaa7rLKos1?=
 =?us-ascii?Q?ctiDA7ktpAMVUtxb9uSVIEftyV+F6zBg/jR8hFR7pD2fc22afTJ7ly89sn5J?=
 =?us-ascii?Q?pusV9iczwCp9rlZa2NoB63/S/xH+BAtPdeuA7MKaTgD+kx7SahhwekzMrKoT?=
 =?us-ascii?Q?0qtAIScVhgs75nzwVQVcIY7fWUu4s1hnFLl71Qgv3rQThPTMzrs+CNrOpzW+?=
 =?us-ascii?Q?evkeuB61+Ruh6iF4ujM5HCSlZtYJvCsj2i4k+AIlDLOW5iBYNvrDsCRDpZUP?=
 =?us-ascii?Q?ytoYvrL+VHNGzmbO7fiCZ7jDGuJoLlcpIF6oxAAnl8fmN7ji0EFZo59XwQDV?=
 =?us-ascii?Q?iIvAQ2+dvQ6Hoky5zKMp92aG84ECvHa6YaYxFxMBrHk1CNRS6zArVr0Wi4O0?=
 =?us-ascii?Q?H3hrnctEUpzchyUfZCHmIxNOwm9Zz9ZST8YrBH6nLEsSjQsERLAdg5NZk494?=
 =?us-ascii?Q?d0r2mLXqzN5A/UkfpfXaomObsF+EWB0I2KaIcTSbqkisdIfd09X3UGSoDtkp?=
 =?us-ascii?Q?1qkDjaB9fcpg+AbquhAfXbiJ0fwAk6AcIoucHU8uNLQ4/I7VD2s+0dqx9yGK?=
 =?us-ascii?Q?/p0xUaQ3zYz1QWz4G0ix06eFejBvjIQx94Pv043QqXHgxYC705TGWGq7OcIE?=
 =?us-ascii?Q?jfE2BC61vr6XX1hXBe8EcO6qVXbJRCoKKAIEMQMY1WJVi59H5rKhOwmlX/Ff?=
 =?us-ascii?Q?huUmqU7XwTrqY2qW4zA+6BHsFSC81MjPMGqeQSg8KMPWra7ouRmnjFFENuTb?=
 =?us-ascii?Q?JekpF/ZNKpReAPSyuiNYOVrBijoe1hwxnzbDtwUrLzafeP5QDowab3dUjr51?=
 =?us-ascii?Q?pXmMLnW7kbRbkBIgpzwbl+h5jSxu2gWCHEsnCrKZzmB+mUKvwgzq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84e3a97-e55a-4e50-e1dc-08df46655f31
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:48:51.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paUl8sA3FrJgXtNDAvhduKS5XZU4sYRZyDULG44nAjokWvvLvqGQDX2rDzqPYI9QzMLgN5utkxCOqf5IbDT+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581

On Wed, Nov 18, 2026 at 11:37:07PM -0600, Brian Cain wrote:
> 
> On 11/18/2026 11:32 PM, Tzu-Ching Yang wrote:
> > On Wed, Nov 18, 2026 at 02:36:21PM -0500, Yury Norov wrote:
> > > Reviewed-by: Yury Norov <ynorov@nvidia.com>
> > > 
> > > Would you like me to move it with the other bitops material, or leave
> > > it to Brian?
> > Thanks for the review.
> > 
> > Either way is fine with me. If Brian has no objection, please take it
> > with the other bitops patches.
> > 
> > Brian, would that be OK with you?
> 
> Sure - sounds good to me.

OK, added in bitmap-for-next.

Thanks,
Yury
