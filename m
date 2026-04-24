Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BA3FA5D4;
	Fri, 24 Apr 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057967; cv=fail; b=HZA9YcdCJqYnKJhzMdVpShOKiop3z5uuiTTVVDAZNDDEkPe4s1sNkYzXx5EmJHxM0H7JlvFJHAaVPPC66WxlCl4lVo/3ahkuVZYj1dfDfsqxOFrNtZ6g0IeqYnreDI1f/aWgH6HYKWYZ0T54/W7ouBXHdEbGEKQjdwRlZC7sqYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057967; c=relaxed/simple;
	bh=dfvT9qMO9HLsSIyfsAHGzBznY2dUiW47YQRXzjvATqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBq+jtXriSbpYJV7oorYPElT81t2wvVmxbAcHpU7RksOve+pNE+0dbXAQEyg8H+V9JHr2JSmtxNH3GZQSK8zZYH3qgtC17uj/UMFZMpwQTm4KMjAOw2DiQWI5SPNksFw2PNxp8o0U6M6sBLovUqkhScq1AliZfwWfr9dGlu5Lpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4/l4ccp; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4/l4ccp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rdt2+X5daCYF36zgNTgCpnGfLLdCWO2MzWwm8H2LFCfkWyXzyDen9aLG1AM4Hnztw8EMp296N+RrqhjmElF3FsmDDEjJdqUZgEIG/JXPwXKJXO2k3TvBnGgYOUPjdApGrFMJxhym/++6+vpMBUsOqsy2LkD9FmMNSbj2oZxI/zFhvy8TVe2g79RcUceY8lebSMbuQhUnASn0Qywje66bBCX8/GoZr/Rs/F/xH762nxkh+WZeWzgvO1MxIO2gvoA5q0+1poutinJoIU98YQ6ZExJDWuC9i8QC+8zLh1J36xE5CWHyiJX3qF6m1+VXtW/xPJoPOLJxKjjM35UOS+FECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfvT9qMO9HLsSIyfsAHGzBznY2dUiW47YQRXzjvATqI=;
 b=yN1j8QUfUttn8J9LZYN/dg9adMzaqKnixjOxsOcoixzPca+vq+xtuRtvM4Mvv33u9qEXgLZde8tP+B9eUxOa907sfvIzojGr0Yo/ffwm1hDdUEB7iTUGu3SMh17ehppfuJljfazKzYFd9nEH1m84CDipQsOr/bG9jLvhfih61EpIeuL6cQxC1QpIiX9xjD3RGp0/zz/DO0xx/K3jwcR9t5n+w8auQmTUQS0SzSgk4yITBCvwremNHUxE5rO/p4scV8XZ6NeMVtKIXzOgj2BUXG+TotziP5gVRLpoJeGWlIk8B8UTTlPUuKFb6lnILYICi0U5TJFL5NQYxcaKvSaTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfvT9qMO9HLsSIyfsAHGzBznY2dUiW47YQRXzjvATqI=;
 b=f4/l4ccp5I0tFK8WJ0rFHiajHWGteUobdPhrsjMYygzmkhO13KEQItEZI+BncvFlOOoxRmcpu1hDZ27rAibWBMSqlr5DDyjC6T1iroLWtnZ1yV9jpvaeHjVPUF6SZOydTFVA9W7rC8/K4+oGob50kV7dborR36jZIupadh+GjA8ItGe0fYg2c8AVBelQiKuuN/9vDIw8LLM7s0dGxo/MWZAlZlNCf5ybgh1Ib0OYHidahvgohsrp8cMiRXE3lS2LQQ9bwN53I8zUlEGSOurMn99ZwK2mH1AAG2ySqQRWs6rnTjKIT0iAFgtTbCgsZWCQ2lNtO5luHzRlwqMLJ6+pkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Fri, 24 Apr 2026 19:12:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 19:12:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yosry Ahmed <yosry@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Lance Yang <lance.yang@linux.dev>, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
 jannh@google.com, jgross@suse.com, seanjc@google.com, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Date: Fri, 24 Apr 2026 15:12:34 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
In-Reply-To: <20260424190141.GA3783056@noisy.programming.kicks-ass.net>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <20260424190141.GA3783056@noisy.programming.kicks-ass.net>
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:208:52d::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: ff26da72-15cf-4117-3d7d-08dea2357344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R50WZZiKmjCxTGYCFGM5Hrxjk41Dvj4iSkHEbBcrXVQFhxvvHDbgX/us4fdK7xUyiXff01qdROxSgvV7TsUl5u/KDgavLOkVywFlavlqWOpoPnt616q4vfQ3gVlfP6tHOiK6mdbO5L9fKJ3Fc2KBzCijg/hbKZMqfpSimcVqieFxsf/drljfxLXQB+1jfMiRsN0V01Y6gFb/3+clxmUFZWftSL6HZPqJrWkw5+Cml7cyrGaPZe/TvEGS38fMdC7LzoA98o0X+wAB/YNtJlTw2wMvrboONt327+j0EPd971Qupn5mR0+UUqfDLkz5NFFnX4eH42pR9vVr2wTah8kUa/yUsJPpDumF0bAQ22ooAri6qd+h2rWYATZ8pqgIPSGC+JGKHKaOXzEYFCTcr7LJVL9ITjq2U05zh1KXlaczCjuSOtVpnoCnHcaSpPi/dTegPS5s3n9ktQCzrbs9wk01CPoTKnd4C8XyOcgQ5lUP+j7tjm3/8KoIrkmFq7GBzFeNzEyGsuRWX17rveZSE6j7B1wZHXxaiuq6K2pcKtUNnC2LUrru4zsWG+M5DTYnVU2AQjVeVkREV//xBUlWIGpqfjtV7u0ommtTp3Rbl2LqjdhxN440hzKBNWdJ4nlpmMbw0rZH6JF3sIAXHZ0IHltCbdkKsSzVYl7HAMtAVplhYHc99eVMywwXdRUQ8+0BaiOuyO2SYWm6+8axwhM/slqRvje4xVatgklUOhvXrtVCV1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1xgWr/WKiviu714CBg+egng3lVCnpkmDAc4bIJ7sgzVvNMRK9G+C/Ap8hzd?=
 =?us-ascii?Q?i+10LlZ+X/kFldZFWlJ7Lg332fm9hZFFqg8kW+VcYcDzZXHO5e1PcJf//Iyd?=
 =?us-ascii?Q?VBfZ63lwYMGAtLFatz45rqCfoV4G7J7/IR1cDCeaBWfMlHB3wlBYcAcZNNgJ?=
 =?us-ascii?Q?zIgGDsHQR3LrYPqeGBVefmgtw+KfLC6A+dpdgQ62EIJW5MC7JM7AjdbkOPY9?=
 =?us-ascii?Q?V4L94ea+OEGaM2Ae4LsNZLTyjbxW7rX101yWipn/UxjoZE9cZmnwNnkvLUgW?=
 =?us-ascii?Q?+QxxzPzxqDYKQy6ZOoOntdXV3YeCIf1SfgIV+TviTEFf8OhNrrqD3SwebjYN?=
 =?us-ascii?Q?kBdCLP/BRZVbRgXcqZrGXPS6LGzS5FfyiUpC3R8xw6zM0Nm7wR/KdVt+NaAg?=
 =?us-ascii?Q?2ctmR5e5Qx81VUII2fTu059HV7TjHk9+MbkzzWqlAEsg/buDyVB4EMegwfLh?=
 =?us-ascii?Q?iFs5hqZZayySpc0vlUbp1VCnS5oQbb8BuUMZZI1/E6MVjjmRcNeP1otz3+QF?=
 =?us-ascii?Q?88XpSv3/f87+QQoa/1CW6Kp2cSv2+zBXcsnzrunx3YU0gp08AzQgljFniutr?=
 =?us-ascii?Q?EsGFtb6TCmX0K4ow0Q1gUtk9GZbRj+T7vHt67n0gZuvCmLKmUByxj5zrtP9P?=
 =?us-ascii?Q?/InRiESbI8FlPqnA1cNTzbMRSWdFAwheGAluJD2e68KbyyQzUOTARmw9c2FO?=
 =?us-ascii?Q?guBALq3xbGIQ5slL+hKmt4rWPvlHxDc64StYYtcC011QmL6a4FB+zgighVH4?=
 =?us-ascii?Q?qMVKHlqzbAiDJPwwfOl6S83itewLLBXrEM+dcvJGjOWEu8+aWZgpHrwWWcoT?=
 =?us-ascii?Q?KkPVhPoQh0O6t9Y/aRX01FsjSjw0YwznEyVmluswQql12ywpJXJbIZDO+Mrw?=
 =?us-ascii?Q?m5NzWXoHWaIUDt0tmInJH0dFimHNcmoLkzEFARHIczbkwAfBIC1NVnLNRU49?=
 =?us-ascii?Q?bh206699ne4I6H6yFVdaCC+jwsdv7vsLxr++eGGhRmsRveLGG0pNBptMr8q0?=
 =?us-ascii?Q?PrFXFk67C0H7vlCbhEi2X9xqtJu3cTvZmDNToI/amKHiWT446tqGM/EpUAZv?=
 =?us-ascii?Q?k6/Ph3xBvieCRHh7/XgLAX1+E54JqKM5ZZgIyjHvdYIVhvBWaP/n84tpH/ef?=
 =?us-ascii?Q?B+wRC2ZcEJx68/aI6mWp6TT4PUGDAcpv4gGReieI2DML7eNLZkUb1R403hwK?=
 =?us-ascii?Q?6OhCOe4QyfJPTjs0d6MDVrWt11kS1xzJx4ZzbKz1CoMEfhEbFPKoh7pB/1mq?=
 =?us-ascii?Q?vWwsHfMHuy4ed45z5SF3owBHE7ICAkFAwRXGK5vR3wE5EEx+FFwdeR720Akl?=
 =?us-ascii?Q?7ZNBXRuutuw/PBSDoOCLjWONWkdPhkxguTpfmbDPwltKeSOP1C9se8sXaOVQ?=
 =?us-ascii?Q?FeYUOvNe/9lhMlHJd3a1uNhLauJbazILNk31N6Yzf47BoJveZoQ8fhdDuYw2?=
 =?us-ascii?Q?QrqZeQTZW/DIANctPUk5b3ABQUzMKjXLl8962tuhqxldpAJTC1zDDVRxQ4QR?=
 =?us-ascii?Q?0DXitG7gdLF7HedFloJ0vjV7iH6vB/PJvLGuZpkwt7FvJgP6HLBwjwjAwTpp?=
 =?us-ascii?Q?5i4MmKfu/idgHrqpBvkOkl98sZ7A0VCYvj3fmo5LAaR4BUvCrg73JEkgfcXj?=
 =?us-ascii?Q?ct/DnBaTVq7wRMn0LyPaOuZNEcfcF/6Fxq9kGvUzhJwOD6V19gsuPca5uRkl?=
 =?us-ascii?Q?Yd22oSexuMQat1H6E7LOFuvMmroS52vDlQ67CL99Tus1OUJUTjRhMeoEQzZ4?=
 =?us-ascii?Q?390CyEnJjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff26da72-15cf-4117-3d7d-08dea2357344
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:12:38.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbFAY7QmsOCRkH9hsSXVp3P5P6z/e/M1WKQK6ooSoGEc5/vlSNGvepyqdCziSNEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

On 24 Apr 2026, at 15:01, Peter Zijlstra wrote:

> On Fri, Apr 24, 2026 at 11:50:03AM -0700, Yosry Ahmed wrote:
>
>> But I imagine it's useful for reviewers to see Sashiko's feedback as
>> well (without having to go look on the website).
>
> That's why I have a script; if I press 'S' in mutt on an 0/n email, said
> script goes and does webrequest to sashiko and inserts the review
> comments into my local maildir as properly threaded replies to the
> series at hand.
>
> No looking at website needed.

Do you mind sharing that script? It looks like a great work flow. Thanks.

Best Regards,
Yan, Zi
