Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792590456;
	b=Sa+YdJ8Yz7X+SSFtFm+Y/8lOIB11vd9eyP4kiT38CrIckSfprqT3e9tqMbZ3gv3P36cH
	 68IjaDw8kAsVWpGEnQSBzimv+Z7pJMf7gMGqvXRhzNfjW+8LtG/j7ZRtsr1fYgTj5RHWv
	 evyG/tsTUKdbc/+i3ksH1FOLEam1v6mgVBQvITAgqhekYsy7KaGfs3iObfSkN8D9AyTlU
	 2vONQTwy6O7qmVBeS1DPIwp4p7EsfZIYi2MDgiGoh0teKrDOrh/ZTz2hQyAnqEiRCEa1o
	 goYc80XU8/xf24Gzn+hlj3pfv2+plfhfTz3+3gEXd/4rAPrtUKznDqtqdFGm9JebI2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590456;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YbqoSSx3b76bEgGfa7XZSXnoCpxhF2wiDG/SvxtbXyA=;
	b=Ek29A9xlz1IHsJa31DIHWlWOOxOU4r9keVphVEEShjZTqaKdaBUDzke5GnyeMlqEP04n
	 5nfpXGTDTRQvjedcyWVdNYTy1cpGqA83p+K1rsAb3iZ81NZsotuX0ixCIklDsAwelyZo/
	 CGZB/eqGxuNCPcVYRrUVnYo7QVOe6CVHtvpH1l7Bijgnn6m7Nz8xGqQxOrqEZXulllk8e
	 YDb0DkxLeCMwIY+d7A509wiV40dPl+HzM24gCXviEjggFc/4/8SGkL089SXlLdER/m/r9
	 34kLhPHW2NJHmoFn6Cps7NzBE2rO/Yf4JCeOqxiWBqWEXzSWf3oe1XQO3LMvhijaaFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tqLLXGd3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.13
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07160A2639;
	Wed, 21 Oct 2026 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B07160A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tqLLXGd3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo6ZAWOpT1+DHL1w+iqEdA4Frp//7uCthUoNb1hEdoDGR8foQe+vRFsRHfEvX/0TwtUWSOQj4PxqKN8lUOXo6bDrzuhvhevAwbf9KYfqqfVVQ7UBc/VzlKvK7PWCi2TmgAp0plVTHdsD+8dhQtvwhJdmI4nSyBbkR8jUFuarHfvat4etvLNL2UEwoIWLzrgZ87C2VHSdGe6pgQ2RhXERuZunUHUcQ23UQ4e77p/wna4u2aAXrzun+pP3AUC2G3tC7IF4HgIUWgrRgDV9FToBVyuM3zifQOTG2j+/v9L7heTuEU2RJgUsCbVXqq5okCwa0D+dzllG/cyE71NsQe84QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbqoSSx3b76bEgGfa7XZSXnoCpxhF2wiDG/SvxtbXyA=;
 b=mzW0bRK2Mu5kC369+Bmic/LminfI7iJW0FAOdp11fM2XBKlixq5oV4AF0mJHhnQOyKQC1/OHMTa4Ia0Nd+5Aq6RU5LFz2iC1DQv5YbaSuA1B2Rv7eO08Vir0I83AvIWjsF29p5hW8LjyfF7U0rpzCPctEPGtovrL5EQ6lmGaWNi8TfNAzTazMhPzuMjn7aoaNeUc1EDHSmJbg52gU2adrfRU5gs4SyYceCHbOQ4cXbukhAcN5FUjexno5yPFLmcFhRcvwXdx1+b98OdoKfI8cTQStTti+0LwDQeBMffnCWrNtJTtdxOzbGxW0rM662Rwg6KlSNbImL/SiAoYGX61Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbqoSSx3b76bEgGfa7XZSXnoCpxhF2wiDG/SvxtbXyA=;
 b=tqLLXGd3z8352hpkjjkFF0zdU7ZTrpgqMN86vD4JHZ0tfOvaaTuq9ON1XsiQ0YUOtp3IjBKexFvCcZbXarHQoFopOBTPgVZ0CA1nU7BCarfsnvLPTl5Egf9i4qZkrxcTsZDKi6JHZDLoYSPi8onshDzs7P7C+d2r72rMehhYhKU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:47:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 13:47:33 +0000
Message-ID: <ae7ae97d-cac9-451d-a0d4-bd52d0f063d4@amd.com>
Date: Wed, 21 Oct 2026 15:47:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf/dma-fence: Order setting of the signaled-bit
 properly
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-4-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021095512.1345191-4-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 07598ab4-1cb3-4471-dd0a-08df2f79db55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|261009223027099003|56012099006|4143699003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CSSOJnrHmTB2fpruXz22XsMfW3nt+CZnQLExjGJhOOK2A+V8X9OMsI9ryJYDAFUCD6VTr4JJYiCvXRvQnZv5CloZlQbQDewfUCHYN5EPBdG7t7KadB5fDjulu8Lu3IVjqBhU+RN50VoKSbitlHgJb0ON+dABvkl/eKisk4AooSChncwDCZ3uXzgFe1Tuze4fwjQ/Bu18Api894Srl/bB665pF1IAV4L++WwApUHifVRUkyqE7HkYnRXzhMy7ZM0CT0Gb++z+INWngR58/andchgAYGNDeS8bA0JMi9I6lOGdQokAaVQBAp+z7OnlHB/6vzWHDiOEffbr9oeG9eiTEp6Y/BIgv0Al3G2mxA+oFnieDjYLefUH3kzZolkMRxQ8JtpugQQb6+5SofP81Se4/k0WT7Y9Jd6irfZSoYYgBKEpZ77Gy5eeSRRO5tuw825KPo/r1QKwbrw5f54ZDNl048D8i9Dxm7GnLJ8dCTGG68iOiLcb7KielupNdipmpFCYuUe4GNoqHPVHEyhVzaSLSCXksGAyZjdj1W9u7Ig1vF6mlCn/Mehw7LSM5K7szWP6bgyjMYwnwQGRAqIUHRZhDGcn/mtEsgD2hmXWxKFeNcjB8wrRbQzkJWqdhPARc8xVuC2nWtnPecXlgoZADIIPDa8T6n9TxV9iGj0Dr/gbNe8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(261009223027099003)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cS9yRXNFZlVFeENJU3lVZCtKZ09GUGc3UFVOcGhwT2tSVm9NUjlQYkl4dE9v?=
 =?utf-8?B?MjFjMnNtUWw4eWl4eDE4dGxXRDZKUGpqWnJpSm9Od0NhMnRlWWU2OW1EcXVR?=
 =?utf-8?B?aVVYZTl0M3Z0UGRDT1pJc2U1RHFpWk5OUWNSYnNoVnVGSFNnWEJ3VXVYWERC?=
 =?utf-8?B?ZEZWUkNSRDUxSEpNZkxwdzBtQUtqT05FbFdQUFNWVzAvbXR6cVR6S1ZSekdx?=
 =?utf-8?B?OUZCRmRZb3dWcTlvUlB5SDViVG5Sc09hZHI3N2h4cEhZemphbkRuaTJqV3ly?=
 =?utf-8?B?ZUhoZEFzSzdOb3A4dDNzU25DVDk3SjlGeldTR2FVRHBaaE5WSGMyUlJMZ1pu?=
 =?utf-8?B?S3diV3BqdDdIQmdEaklCb2NxcEozdjRldnYwV0VuZ2I0RVpLM0czU05hNUVp?=
 =?utf-8?B?RGxKeTZwRllZZmZnYzhZa0lzVFJ4RlpDQ1NiMk1JelIvdm9pQUNOMnFMZWJo?=
 =?utf-8?B?VkZ0WlNTRmpKK0Rzekg5cHJrb2NYZWQxak1lR2tucCtoWUJ5Vm9wM2FMVUti?=
 =?utf-8?B?bENJZThtVStBM3FDSnJUYktSbEJvaTRDVi8xcVhoS3BKNnVNeThFYkgyUXI5?=
 =?utf-8?B?WGo0d0NDVWo2aFllVkVBNnVzaE03VXFFWS9DOVQwZU9US1NoeUFGclJMNGQ5?=
 =?utf-8?B?TDhsY2tvMEd4WFErZ0VrdEhwaHNSQkJyNXdkczhuQy9xZDl1V3NmYXdGbVVq?=
 =?utf-8?B?NTEvdTdyS0prRnVUcE5DV3Y0cU5xYjdmZWVEbWkwUkxJY2l3TzVhUWhScjNE?=
 =?utf-8?B?VE5ZMmZtY2xRSzNhM2pYWkcrTkhrQnNjQldzN3FQNWRpQjB5dnNITlovSE5j?=
 =?utf-8?B?SXlQa3Q1WUJXOGpUOUJDYytzenU3UC9tQlU2YkdEc2QrWWl5TWhyUFpsbkY0?=
 =?utf-8?B?cWFycE1CNkVmT1pyd0ptYVhwTkdLK1J2dStyM1dFV3Z2c1MrOGpQTnUyZndT?=
 =?utf-8?B?M0FFdmpPc3lMbllLWnVEclp5REZvRCtxdUlyREpXQ1VteHBYbkZwQUc1T2tZ?=
 =?utf-8?B?VXh6cFNkbmROakdQVGZIQ1FIM29ONTRkWGJNRDgrVE5ucFViTUtpMjVNNTdn?=
 =?utf-8?B?aVhnYmpFRWl6dXB0ZTI1aGMvWmVpZHdiWk9mN3RIRklwVHVPTG1yUWVWRCtK?=
 =?utf-8?B?dENRNU1jc2tDRHVSWm8ydHB6eDNwRVAzLy9NWmhPNWJ2V1JIUGptZDhPOUNp?=
 =?utf-8?B?V0gwdWl6Uk5xcWpnS2dDdzFzeFZ5WGs3TkNmWkZENC9MU0xPeG9NOUhHL2NL?=
 =?utf-8?B?dUtiOEJKblppd1ZOYUVndWVxMWhsUmxQRnhINW9rZGZtcWI3R1RQRVB1Nms1?=
 =?utf-8?B?K2JKMzRkbFZjUll2dUZKeTY4VmtIQ0FUSEFsZEZCVFpHU25YVExmWlJOdXFB?=
 =?utf-8?B?cDJHSGdjTlM2ajNGMHZIcFgwZGltRnBFZDRkQjF2ZU9YNFBqWU8zdjMyUklJ?=
 =?utf-8?B?WHNmS094bG9jZHFoVmNmaUtJS21SR0RFOThWdFBCdG9uYngwTkFJcFc0cE1D?=
 =?utf-8?B?V1M1Q3c0NUNvQzFYK05jVkh5eVpBV0k2bUR5ZmZvWm4wOWxUaGhQdEFvOG1u?=
 =?utf-8?B?a3JFVkcwdGE1M0N3MjhIMlQxaHhSUGpnYVRzMWs2TlFpeGNhNmozcmZlR1c4?=
 =?utf-8?B?dVdNZEpSN3gxYXNUK213UFBXeXBBdnBLMzZmdGhjMmxHL1BaaTdNWVlFN1dG?=
 =?utf-8?B?VXh0bHJwcURmdFR3OHk4U3Zkc0o5NEl5MXQvV1NFUW1IMzNobjBHeU9tUXNa?=
 =?utf-8?B?T3NCY2FVOHBuY2UzQnh6RlIxUXhXbnhqbHlJb3d1ejhIeFZXV2hiNkZQTmZ0?=
 =?utf-8?B?Mng4YUpPTnlDR2lPVU4xUnhXUDJnZFVWVUR4Q29lMVlwQ2tuV1RIQ0FZM0hP?=
 =?utf-8?B?T3pEejhpUVFqNnZyYnpsNUtMSVZsQzIzZHJQMkc3eHVzNEJqd3FqVWFOWklE?=
 =?utf-8?B?cDl5WnRwYStnd0ZwTlRObTl5QU1yUVVZM3JyWGdLRkI4NEtMWDh0N0RDSUli?=
 =?utf-8?B?cjgyQ1lEc0NxS2hjTWZTVGdCcWRlTFEyWllaRWg4b1Bab2xid3RoSWI3ekFn?=
 =?utf-8?B?cDBJeVpwRlRwNjlJakgrdG9QYzd0bW1FMGlpYXFsNnBLT1h6YVBOSS8xdXYv?=
 =?utf-8?B?UjIvRElzMHIrZ2hIK3VoQUtQeDVyenVzdjRQZkw2VjY2cDZDeUlXYXBNd3hr?=
 =?utf-8?B?SHdaaldGRzJjdjcrMFYxdHFOMXVUNHVCaDMyZ1hiRkpwMzRNaXhzQkhzWnAr?=
 =?utf-8?B?aTlqZE01VDVuOVk3VFFPMWVJdWlUaVlnTktZdUN2U1psS3lkZWZHRzJ1RXcx?=
 =?utf-8?Q?KovdJKr5h8+6MjRivu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07598ab4-1cb3-4471-dd0a-08df2f79db55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:47:33.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw+DxQIM+Vsb60DOUW9xCPvsPqMRQL+deI/vS7ShuW/NcLVl2FLuX0Xiz2ywCVYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On 10/21/26 11:55, Philipp Stanner wrote:
> dma_fence_is_signaled() can return true *while* the fence is still
> signaling. This is fragile and has been involved in at least two bugs:
> 
> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")
> 
> The signaled-bit is set under lock-protection but read without it.
> Adding the lock has been rejected on the grounds of the lock-acquisition
> shooting down cache lines of parties that merely want to check whether
> the fence is already signaled.
> 
> Make sure the bit can only become visible as 1 once the callbacks have
> ran. To achieve this, read the bit with test_bit_acquire() and set it
> with set_bit_release().

That has been suggested and rejected before.

Background is that the signaling bit must be visible before the callbacks are run or things like dma_fence_default_wait() (as an example) just break.

Regards,
Christian.

> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/dma-buf/dma-fence.c | 11 +++++++++--
>  include/linux/dma-fence.h   |  6 +++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..07d499fa35ac 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,8 +359,7 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  
>  	dma_fence_assert_held(fence);
>  
> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -				      &fence->flags)))
> +	if (unlikely(dma_fence_test_signaled_flag(fence)))
>  		return;
>  
>  	trace_dma_fence_signaled(fence);
> @@ -384,6 +383,14 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  		INIT_LIST_HEAD(&cur->node);
>  		cur->func(fence, cur);
>  	}
> +
> +	/*
> +	 * This orders the signaled-state with the test_bit_acquire() in
> +	 * dma_fence_test_signaled_flag(). This ensures that functions like
> +	 * dma_fence_is_signaled() can only ever return true once signaling is
> +	 * completed (i.e., after the callbacks above ran).
> +	 */
> +	set_bit_release(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
>  
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..61522027af41 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -496,7 +496,11 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
>  static inline bool
>  dma_fence_test_signaled_flag(struct dma_fence *fence)
>  {
> -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +	/*
> +	 * The counterpart of this ordered operation can be found in
> +	 * dma_fence_signal_timestamp_locked().
> +	 */
> +	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  
>  /**

