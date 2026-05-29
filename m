Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022073.outbound.protection.outlook.com [40.107.193.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1E374722;
	Fri, 29 May 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082148; cv=fail; b=enQqH4gi6pTL+Mh8uSaxEXNMkMPtpUntVNn76gpJCWfBsp1JL7K9loohKa6vb150lg8FK0Ld7wULo76sGZf2B3vjiCi73Cqgyl4Qre+ibdA+xw8sVz+ImpDhSXEAi8py1AEatWFKq+XjlCtp2KNV4YRkO8Y9xzmPob5o7LN5ElI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082148; c=relaxed/simple;
	bh=VrKkmfCjGkSO9y4k8iDexFtkzvAU8dtjquArqMvziu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JRYAbuE5itJAqow9exWtRMAovRs0RAoUa+Lts/eglGvqRVAIOMJ1asbQC9t2pO2gEZtZGcHIMtJB0QvAgX/t0eJFSabGzHH9Yof/5CNgwg3zjYvOaatOoWWR/SDC1TwGvjFdtp6sSpjQhmNg1rudCJ0ODUGpgHbonFIbKZLymx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=C2IHm6Ua; arc=fail smtp.client-ip=40.107.193.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="C2IHm6Ua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrtUV8vJ3zc4NkE6fAkbGNT2XA30PUcfAOmuvRWFAvqz0pvzZXYuJB6RnXn9gVc5+XddolyDB/wYCt+/cnmMpU99mWkLvblQpcR9IqPPqSMDca6+1p93Au9Pr8SAK6xLxOkRpXYmf3kIYRezPDTQgCEInJPHT3VSU/XZDwDGe1y9jaLVbP+pDxa9GE1cpG1dKF9F7v/kWe4LuxFqGO51SNH6Yt1xkbm+6yt/98FuLbpRyS9yntKxkoDniKb0XTtF3GYChNnH/azUcmP18bhQORnRzYRUTQT8qFR8AHImcjK10HMRtPVJ9E5v7avaCHcWR1DkVZfn4vASTd4KxjaxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0ddpHKKi9O2KILWKxBE36eNBnrMyiSiwjSGPeP71z4=;
 b=WhEvK0/EwKMmcCYYQlKj1mYo0QXYB7RlY8yoVkMRaWcFsTromyXmVEu0j3upaBAfMcrClb/8m3cyIcQMHj6+ePjNya0UKMWzB+T5WtB477F8ntpQqUCpDUAOhGB9/mYEvPTenB9XeuXBx0zNmbX3MdKfsW63YdFReeCJw7egARvnalPeb3aJ21gDqfdOftVGn0Jv3tZ1DuvnT1T/JprnzpiU8BJRFCXJDiSiVOFSty/L/c9eUxhuK/Mz8i5xKxUUFksbZCaZLsURflNwJXiXE1/N6ndkkcsRDNmTHrGUrWl+4ZKHnsJgQPrOcMFpmSyqtEmdS6Z27uKZOJnXlT84gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0ddpHKKi9O2KILWKxBE36eNBnrMyiSiwjSGPeP71z4=;
 b=C2IHm6UatsHN5MRyQRnELEBFR2fSBocGx/oTvsiQxBN7KxoetQwxz6s9XEBSah6l3jmZYlZ74Q+IYi4NQAqVDF/2tQ3DKgVlbAYWBNJwlUsag/xtpirWeUTV28ohbZzH4DSiFVBz+dKrXjoDZflYevyNCZq9ilDGltcuwWJW2Spol/USX0jiHPf5BUfTDVChbDWMl3XEkqMIpPM1zZCCLuz8wKbqWN00LEAjgjtRseiYGNevVcHSisB2hvroPAOJF84pEtQ4s9kZqEwrzfWLh3ZpMV4oKWLfg8tuOaaQTxpPaQbK9f6O/2ayT8y/EIru9QvMQH5IHwLYwGe9qC7dbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6366.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Fri, 29 May 2026
 19:15:42 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.21.0092.004; Fri, 29 May 2026
 19:15:41 +0000
Message-ID: <75e7db50-cb3b-43c2-9c9e-6bb63815308f@efficios.com>
Date: Fri, 29 May 2026 15:15:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: vdso32: Implement
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
 <20260529-tonyk-robust_arm-v3-5-a6f02684d4fe@igalia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260529-tonyk-robust_arm-v3-5-a6f02684d4fe@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d13d0e-6559-48a3-19a3-08debdb6aceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	YzlIVHjLiRwd6EJHyu5w+q4UaUem0wN5mRyf1c88i15f+GaAwcLSXMygnFneWW+yZAVMIFrWPZDMoRSZrREv8UnL92yvS7/UmvxXTb5L8xUQMi627EgSHmjDKk7DtbgcYcJIME18MtkvbMJPVUM5om1Ue6aV4Mn2kBU4scqA/m5M/zj8s0Aju4vaQaSBgia6FvqV9omR6nFPANvZncNIBT1Eei6NIsaw1B8217/L4xaI2gt5s/4kbWW9R4+iElDzCSRx3duUMvtAoY6JNdFpDwXQxP1I35euMF/BKLj4eK4C75UNtXBmRYTHk1+X/XATn2TRKLb6wbDjyZnmijvORsSlfLsf9BuuaAQq6lsz0kBZh7nBqH3rmjzsqVjJVAgemtsZkZ2lgqnQ6y+0kDDVDlVHBdobJLcO7k1HtK2XoY6/zu/Fa9RUXkev44Pj7dRXoJxn6mAC4sflJGlbcV3KiWd2Q3Ryc2AqRjkTjbF7HWB8MZDO5heC/f+py426PZC52umT1lb3PoID1eUcxVOkYDZjPNTCFJehLA14t61fexkdCB+nmZ4qBz5z1IR3M2HbtsoS9bKVEDknqnWR7laeaCBqG6BJQSS5jrPry4LiSqOoZBGL6Zg1P/AbwOn1BJ8TH+MEWjLilyPmcGztMqfTAggBkUcCzQi0uZ8Z2AnaP2pr4mlABjTljhrJ6Vf72XPJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWk1NnA1RDQvWCs2U05pTzlsc1lFaXk1amEvb2JETDNyRGVUNnh5ejlYK0E0?=
 =?utf-8?B?WmJudUhnb1l5YWs2Q1VXUkxkZzNyRE9VVnZCRFZOWVc5VjJ3cmZXcGZNYnBC?=
 =?utf-8?B?bEo3aDlFNzJkR0FaZHphSXJGekg3UW0zTXZOMmRvSlR2UUJOa1JGWjkxa083?=
 =?utf-8?B?SktjTDFnVHltWVREYzNjVVN4eWNNZmtZTmNQb243NmpNMHJhbG0zWGFFb25o?=
 =?utf-8?B?R1hseTRwSm8xeWRFcFlpa3F3bWtyZlQzeFdwVW1NZjh1bmhOS24xWWNZNmtI?=
 =?utf-8?B?VXlOaDdJaVRReFlDaUFKVHQyOFo4NkNzdGk5Y2x1OXBWdTQwd2xNbGUyaGV1?=
 =?utf-8?B?WUV5S2c1M1kwNmJWOWdUZHBZZzd6aFBNU2Z6SE9SZjdoeDNFSHY3UE9sRkhw?=
 =?utf-8?B?QmFibTFONFFWbThscmRZSnJYdXZQTE12MnREa0o3alZYVlRLZUxVdU9PTE5h?=
 =?utf-8?B?dGNwU2FnQVhVcFFTeER3TTdpa0xoeGhldHNnUDdjWFk0aHprMjRxbmJobnEz?=
 =?utf-8?B?aUEwbG1OY3AyMzZoamZOL3lUYTJYaitYOFpGMGpzKzhSK0lZR2xXRlNyS0FB?=
 =?utf-8?B?S3pzZ3JCZlBWZzk4SGVxUXd4a0ZtL1JmajBFaGhkVFBWNTdWemV0elpZNHM0?=
 =?utf-8?B?dm5kUEhSb1dTUCtYalk1QW9tNGFvUUdGWkIxN204WTdVOFV4SHBkRWlibEJI?=
 =?utf-8?B?a1BCNThLbGhzSzRiNjdtTmFkZWMvdmE4cEFoampSMWFJR2R5SjRZYTJjVWIz?=
 =?utf-8?B?UER2ZExERmk0ZmF0Tk45RGErNjMzYVhhMUl5U2NVRUR4ZTJWSmhvMWxZazc2?=
 =?utf-8?B?ZFJxWG9mOU15cjUyVUpoNGFtdGU1L1RLVlZXOFZKNjFKOThMbzZaNkxGRzAy?=
 =?utf-8?B?Mkt0QmJjWE5uVEtPR0lRNHE2UFhKN0ZNeXJTTnJtd0N4cE5SZmM0cmhLOHhn?=
 =?utf-8?B?dU1Qd3pJcmRva2JxcjV5QzNFSlBrTlNaeDlMV1BPV3A4bkplSDl5Q1IrbXBC?=
 =?utf-8?B?WHpYSXhaMUFmbE1Id2ZmcHhkK0hDRzM2MGlvcksra2hoQzRmSmxxbFBFS2Nl?=
 =?utf-8?B?czJGTFRtL3k1SzZobVVMQVVuc2dOcDZ1dldHWmI4bTNPWHpYczJlVDllbktF?=
 =?utf-8?B?MHdudUxWczFzSkxua2RwQklJT3pwVkg5QlZtdmdORFFsK2JLVUpzMU4xeWs0?=
 =?utf-8?B?VnNnVnZaMS92OHZTYUlGWWZpOURlM2pRSkRyVlgwSFIrY00wajBIWkY5M3kw?=
 =?utf-8?B?VzNFTGZmL08xVGdlMElyTWlsaFhQNVNzeWErdXZZY2xQTmhtclJvR3l3QkNW?=
 =?utf-8?B?Wks1dWpJS0I1N0tCelJVZGJoZTNMcVFuL1lJQmhkNldhZE5oWmlqaTEzNXNH?=
 =?utf-8?B?Y0V1WXpDY3Q3UUxRYkVWbHU4UEFrc21ERS9mQy8wc1lGQTFRSXYvSkRNVFE0?=
 =?utf-8?B?NWxoWkYzQ3hub2Ird2VmdFpHSzdmNVRqdmVodzcxckxGc0w0NWVOb1NxQ1Q2?=
 =?utf-8?B?N0FySDQyUlNSbXV0ZGdIQlpUYktSU2VMSFYzam05YWJDcDdHbElZZGJEUzhT?=
 =?utf-8?B?ODlJeTE2NDFMMG41a0tLUXBoR0pqYU5MelVRREJnNkJoWThKLzFGVVJCR1Bm?=
 =?utf-8?B?S0w0UzNEZVNBbWRiRy9sRVBLRml6WUxYN1Q2SWs2TEVQL0UzOVdJVDZJQnJi?=
 =?utf-8?B?c2ZDS0l4SXJUOVdobTMxQnZxRFJMZ1NEM3dIZzlYTWhyUEc1SkEycENkcVdv?=
 =?utf-8?B?ZGM5TkdVVTY3M3lDS0hxK1BEdTFLQng3VU0vQ1IxZVJmS2g5M1g3MCt2OUpq?=
 =?utf-8?B?YktOQ3RPTE1JaXlTWFR3cElxN05sakZLQi9OQ1UveHlweU53SUJNODFpZjRT?=
 =?utf-8?B?SVN3UTIzV0FXcDFRdExoUWJYWm9EWE9KVWhPQmkxRGpTcU9DSGxVWVdFMFcv?=
 =?utf-8?B?NzR4VGZVdDVaWUhCSjNGSlFKcjdhQUkvOHR6d1hVOTM3cDNWOU5qYTZOY200?=
 =?utf-8?B?akRrSnJBNEdaMEdQam5YRm5kWTRocXhna1BuSVVHNGtuNVJieXBQLzhnbXhj?=
 =?utf-8?B?QkJjMVB1QzRyUy9GNTNGMGpHb1A2WTdtSkhaV0RnUEZwbDZPdEVKbjJyMjBK?=
 =?utf-8?B?UmFnQWU1MjNzYXJ5Njl2WnBLQm1BemhndWdnN2lJRXBKTnBkczg1MGducDFq?=
 =?utf-8?B?SDQvdzJKc0lXYWZHZTY0TDZVWmczUkxnYjFUQVVpWnZ6VGdUSHFHcXJNNEI0?=
 =?utf-8?B?K2hhNXpGK0FkU1JTOFY4aXF4OUNWYjh6cUgydm81SUxvaE50ZkhwOWZKMHJY?=
 =?utf-8?B?Z0NVcThrbStET1orYkFtcjFPZ3ViV3VHMHFKVi8xM0Z5MmtMYWd3bkx0V1Zq?=
 =?utf-8?Q?vaKuxAM/SEDwJfuF/54aZCg28GyolAwHpcJ3i?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d13d0e-6559-48a3-19a3-08debdb6aceb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 19:15:41.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4mu83nynnLOV+8xL7iVK1Zv43zB58v3X45AnUN+c4Tj7cCXJQKJgPBqXxkb5RHRRkuZDmw4jjqTFFPgh/y79kpnR9TuirJ1onlQ6D7K70Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6366

> +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
> +{
> +	register __u32 *pop_reg asm("r2") = pop;
> +	__u32 val, result, zero = 0;
> +
> +	asm volatile (
> +		GLOBLS(32)
> +		"retry:						\n"
> +		"	ldrex %[val], %[lock]			\n"
> +		"	cmp %[tid], %[val]			\n"
> +		"	bne " LABEL(end, 32)"			\n"
> +		"	strex %[result], %[zero], %[lock]	\n"

Here too the address range between strex (success) and start is not
covered. Failure to fixup if the process is killed here.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
