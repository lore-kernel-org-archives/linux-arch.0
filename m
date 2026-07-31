Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022133.outbound.protection.outlook.com [52.101.101.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFD435EF0;
	Fri, 31 Jul 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510302; cv=fail; b=QriYBwV8GX6MVBo4YmdLgXY9hIU+0uzpM8EfSiPGlx2OrdF2DDyVjJuUkKWv9W/OHMATXQS61HG2GpjjKmuuTEa/Tmvu/Sbf0E0VH9fAtFTCRn8JWuPCZiHMuellurDTdAjYBkzzpDJIIGaYtpoL8VzoPvh9LSQIQY4Yis1bGmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510302; c=relaxed/simple;
	bh=a10YCCyBGsbf/rzqb/EzBcjBj6AbB6uYD4UBUuUAa7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5Aes6RrRd71CYRmeXvZ5oK3R0EKUyOgkjPkgMN8fezgao/Z/Kho4BITIK+jWGJolk6KsPGb1QdSfNSRJ0NUtfwujhbR2JWhWoARGvjTIevH6Nr1uYD+pNBkyo0G1AFSU0mGP3UCj0LY3XuRKm+D4BgP2Ub1A/5IiWIjbNGlbCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRD6ZvNKBnnsD6viZl1cIKNE64gLs41iNCOpYhBFmvinHSXTbcX8Dr+CPY9R4L8U7mkATjZw9WZ3iQmrkZq1SfGfuLctuBFsBVYbSd7oTMyhO78uDNg+chWYVgSQDWGcSTu2Cv8UOws2qk/RuevDEYcHENt4YIP3UW+EuiVKpOv+H40rkH3J87X46d2yu33ZcZ2iERH9nt3Ypy5y28jCffvgnxRe6NGqZSli0+0Z1j+9k9GivSndJ1leLMCDhQid0GoH/rJ2fWXXIc3yfmpTSFnZo9ZKLvwx9t8ujkSuPKKcHLmmKW2vkS/RqiyXGQuiXUqwI0SguTWYa5QenRSP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=8M9NFlPHu3Bu/wruJiL0lHoH7d5Zm3ZbxPJVIMLi370=;
 b=bn3nxgpJQx+U2G6lobbIoqMMtZ1qv21ksxIpJITFYs2dmYk1LRicg/w3I/8993DWdBGJMGxcZGkvijaVp9vdLGC3tXMX7T6tPVIlruL79VK9CjIPQIarUlydms9Eeg8FNIFeVaj0/HzCKPu7ufmooWsdV9WTfBdD6KvVUf7ZBvrpULkIwOxJKtARtCyJFRAzrv3xT41C7QOZ17r8hPc45OpkJk2YpAIiEWNmJ8tZOInYUNDjbFapo4xBZTKr+i/oArW8+0sv59gJlN9+jQPsf2WkkfE7sStYDdtNLkjQ3Z6icqHyussGNzbCg/I/YMdrD2rAXA2lOxtedLMqU1g/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3407.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 15:04:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:04:56 +0000
Date: Fri, 31 Jul 2026 11:04:51 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] module: Rename module_blacklist to module_denylist
Message-ID: <cdrr2r7j7auy4yxmapa4dn3e6xycs42hjjyff7lqgxs5ailcuz@kgpqnq4guu4s>
References: <20260724024744.616286-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724024744.616286-1-atomlin@atomlin.com>
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3407:EE_
X-MS-Office365-Filtering-Correlation-Id: 4213e8ee-68bb-406a-33e7-08deef1514f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	83lwCbyRjD4tmsJ2mN/hzi85z3vLfQsq2Bh8tdKnIVgcsinI1j5/P1orqq99QvRZzjzHswOQR1Une/R5Uxz7XvsVpkJparjm/bTKZiOMuE1o4xj9i4ecM5wj24ZOK9LSjy/JPC+bKnJyKXU/UfhikSouqn/RGuFgXJg37WHcQ8ZI/cGUxcU9+mE5DkPBjv2yN1zZsPFCr0o8jXr+GO6ycdLxsMB8Lu7rI1qf0gPd6rImdqT0Wm2t8nqJMqZM3532zii+8ZF9Pp/yriuJIvRiRj7cxDYZAOs3ulf6tATmWhzYKaqREeDOh4bHwdzkdPmlv6u0J4en7wxSh+Sp6YFwIT0YpsqP71viboiLKKmkSql1jI2DtgflsJRYcelFG3J8Ib97VEZtNOs/+BY5fVkosvdDlqSuu1nRNpolyAWH+wKxQ72v7KKfh79blBxHW5itRyI0lmAduc66TNnkrXbdWsCmr7aTpRObWoFUffoH6Uz7N7iPo4ktSXElUJzPY1tJqejkwoBqTa2azfkmLNfm7nHXS/+9Qa04eP06kjp39NFKyouQdMHZkiq0ibfPprYDH698FXR7aOf8PdLiFFsEDZttQDOoFt3JJOCPB9gXymRyv5XqwGVMjNUf6m0jdoCeF1nPm5R8+BTR0xJP4qv4HF2Pd51y02BgUA7owxN7iI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE15bDN5bEVYYXhEZHNuQkcxSUlXNDIrL0plNGNsMFh2YzIwK0t4TFh4WHIz?=
 =?utf-8?B?b2IyVnFYcWt4d0Y4enVWYlVqKzZOdnlCWk1VNDVQb0xlTG5UT2NrNTZ6Zm1q?=
 =?utf-8?B?SHRVcEhySEM3YWsySHAwNy9PQ3JOTlljT0R1cy9VTkdkVXNMalJkTjdpWUtq?=
 =?utf-8?B?dE05OWtycWg0RXpZZ2pYQnFlR3pVS1YwU3Z3SitlT28rSEs3ZGdhQTR4aThG?=
 =?utf-8?B?QURJSnVDNWEwK0Y1bVFLVGw4a1FRbWZ1NEhRL0ozSnpvTXA4d0VLaUZWdlV4?=
 =?utf-8?B?blNLR1FtMEhnMmM4UDQ0NkZwTTJYWlpYbUFna1p3KzNvRkd6KzRkbFdmMkdW?=
 =?utf-8?B?Y1dpdCszM25jZjdtNS8xS2ZQeWgvUXhwZjZFWWpjRnYxU3h1Z3Mzay9tOHZP?=
 =?utf-8?B?ek9PTTBPQzdxRDl4aWwwMklwaUd2dFRZa1NqOVd0QnFXY29UcWo0WForOHFR?=
 =?utf-8?B?WEk1Zk9pcVlZMDhpcUxvRytLTnRKNVQrOUFuc1B3V1VjZDVVVHpWQm4vWFdJ?=
 =?utf-8?B?dVQ5azhNZG5vZk9xR3VCcmlrcVllOTJuYy9ZUHpvRkpXbmNjWUlHaXl0Umxz?=
 =?utf-8?B?T0FWbkcrQjZ2UWdXSUFkcGhpM21XOUZVeElCWWp3d3cweVc3NVRSNTVUVUR6?=
 =?utf-8?B?eWFjYUp6V0NrQmtpWnBOaHlVUFZrdGg5N3ZRTXhFdXE3WEk5WVpaOGZKdGo1?=
 =?utf-8?B?NzdwR29FeC9FNXJqWHo0d3EybE9PdDhqL3Y0cCsyZHI0MXA5THYzYVBMdjFF?=
 =?utf-8?B?ZVVwMWMzcXNSUm0xS3pwR202KzBETXZYb0FKcDUxYis0TGZ1MVB4VnozUnU1?=
 =?utf-8?B?ako0U0p3YnZ2MkpnVXRvdC9WVHFPNzZyVXR5UEo3N3BsOW5FQmJZZEk5RVZV?=
 =?utf-8?B?blBZTjdsNGVNT0F5MlNxYjVxc0Ridi94a0JUZVlHMS9SRFFWUVJDekhIa3hC?=
 =?utf-8?B?U2NHTkFoMjYxMU9wR044R2RNQWQ1cUVBeXV6MkMrRUkxMGJzT0RmSDZlYUdx?=
 =?utf-8?B?RVFtaW52Tm1xdkJvbnZUR2F6clgyeHRSVVBweVhvU0Z0bVBPQ2daM3BtUzRy?=
 =?utf-8?B?T3M1ZUM4SXlWVnQ1S3ZtbnRvNjludjRQcGdOY0o0M0VrZ0xjUk9XSjl3ZFZw?=
 =?utf-8?B?eUVTOWtNNmlEVnBGbTFackEzTFZZSUFtNXhvd1pQS0JWdmJwTFJMN3JkQmhD?=
 =?utf-8?B?aFFnS1l0VEIxZXFITi9idWZCcndxZFArMmc1aStqUnRUcmc0dGYyd0FOYTlI?=
 =?utf-8?B?Y05VV0Z6Q040ajdLNDRsekVka2VGd0lueS9LRXVlZVZXc2I0Y2dmZDRwTU1h?=
 =?utf-8?B?U3ZJOXczV3RIaFpDY3BJKzkwQnpkOGlKZ1piM2haZDkvVXIwYWI4aEYvNkdJ?=
 =?utf-8?B?Q2M5UGc2UjVzZXJodlBZekxUTnFzN2hnMEJWOGZUZG80SEJpUTJkK3JSR0oy?=
 =?utf-8?B?UE9DOFkwYVRTb1VFUmZjT1pPWVJkem1tdGtiaWYzbDA4WXE4RGJSUWZwdlMz?=
 =?utf-8?B?MUI1eU5LRFA3bkpuQUJuekFJamxFc0hDMWFOcHdmU1Q5RDVrSGVUc3MrT2V5?=
 =?utf-8?B?MmhHcE80THZEUlJlL0wzVjR2UkhnTm8raXdheFEySW8xMkNOWDRnVmlRUFAy?=
 =?utf-8?B?cEYvVEFGRUE0R3JENHh5N2tJMCtlUFpRZVpMODJhSWpZeG1xSHVXWlNkQUlp?=
 =?utf-8?B?OW5DeEZheDlWNDIwOHZvWmdibUpKQ2Nudy9SblVndG9SWTdLTXpGWHlEei9l?=
 =?utf-8?B?cGhydnlIelNkSDl5cURYSHVBQVBUTHZwdmtkYi9Lc0xYWW1QVyt6K1dYc0NU?=
 =?utf-8?B?NmZYVDBieWpGNUxqWUo2K09WOWdCSldsaXZpb2tBU2JuRmpJVXBpWmFrSVlC?=
 =?utf-8?B?amZJbWVYR0lWWElRcmxzbTZPbkNReUlBQU9MczVBdW1JSTg1Z2JIbFBtOFRS?=
 =?utf-8?B?SHR5M1ZyUGJJdkJldlFDSmk4Yi9CZTN0R20zVDlmdFkvQVhCWlNqd01uY3dP?=
 =?utf-8?B?SXJMdy9rU25DQUxSekNOaWxkbUFBaWJEMXhHVzJLZ2tZbGp0bXVUaDdFRXMr?=
 =?utf-8?B?TW94MGZQSlo2bGNmWVdiVU1Cb0pmS055WWdOQjFFdHRFdkhNOUczY0o4M0VY?=
 =?utf-8?B?UFNWaGdjTVRSNWZHb1dnM1FIaWtmQU5ZZnluTlJ3UXRxOXBOMHI1VjZQSmMx?=
 =?utf-8?B?cXY3NGprVDhJRWo4SHBDNGlFVjNSZjJNSnBuVHV5QkN6cTFXTnlKUU5NSXBy?=
 =?utf-8?B?MWtsZjFqZjZ0dk10SG1NMHNuUkZ3N3QzeUdwM29wRU0ybkw2RjMwZ1BLbEdv?=
 =?utf-8?B?K3l2WjIxM0ZVcHJ2L2tSSXFXeUh5TlI1WDZVcU12UEVaeUp5eHB6UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4213e8ee-68bb-406a-33e7-08deef1514f6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:04:56.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X79n0DXwvxyJDoK4HDd4ZEbR9nGFfThib64Xb35l3dFIVIO+dxjlvg/TMv0aiws5op3BqLD/rW/mi/guYTNemA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3407

On Thu, Jul 23, 2026 at 10:47:42PM -0400, Aaron Tomlin wrote:
> Currently, the "module_blacklist=" command-line parameter only applies to
> loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch series extends the blacklisting functionality to
> built-in modules by intercepting their initialisation routines during early
> boot.
> 
> Following review feedback, the implementation has been split into two
> separate changes to decouple the introduction of the new feature from the
> terminology renaming:
> 
>     1.  The first patch extends the "module_blacklist=" parameter to
>         built-in modules using the original blacklist terminology. It
>         introduces the ".initcall.modnames" section to map initcall
>         function pointers to their associated KBUILD_MODNAME strings
>         (restricted only to module_init() invocations to save memory and
>         avoid matching core kernel subsystems). It also restricts the check
>         to a boot-time __init wrapper to eliminate Use-After-Free (UAF) and
>         Spectre v1 vulnerability risks when loading dynamic modules at
>         runtime, and adds a fast-path check to eliminate lookup overhead
>         when the parameter is not in use
> 
>     2.  The second patch renames the variables and helper functions to
>         adopt the preferred "module_denylist=" and module_is_denylisted()
>         terminology in the codebase. To preserve the existing user-space
>         ABI, "module_blacklist=" is kept as a legacy alias pointing to the
>         same module_denylist variable

Hi Petr,

Please note that the subject of this cover letter should read: "module:
Extend module_blacklist parameter to built-in modules". This iteration
should address all of your concerns raised [1]. Thank you.

[1]: https://lore.kernel.org/lkml/2cada244-171d-45cb-a6f0-46e6a09375c7@suse.com/

Kind regards,
-- 
Aaron Tomlin
