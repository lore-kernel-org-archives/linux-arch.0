Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52FB347BC5;
	Tue, 17 Mar 2026 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730459; cv=fail; b=LqRta9G0ukq9W0NACFJ0Y3NmFCU2utqY29xWDqHJNo1lwKJmSgPVhU27ejxmsOgSh6x+iHW4U8kKs34hy0AqHyq/Sf1onoXCv4G7BKYxovQqTq+CBiPdAD4Q0HocmaTIzt2/9wLv+SYOMIxylp2v7Q33cpl8RjyUmz2/mwxFWqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730459; c=relaxed/simple;
	bh=TXsFvcT5CV55ANYVI6me+8duLnHWDov2DXDGhplK69Y=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=qwsgIt8I9YL9+ZiU6axoj6uv7hHPvcqmIiLyYkY8EEET78Axce/3u4LVaGZVfWuDFeM5yMr7hjtKgxzPSI6xgIqG73Ivb1uxB9HNnykHefrO0zsr4c2XZOrQP9nJI46imgOeZSNReepaND3IvO031FYo5+pQLqw855VbPDnFTKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+LEImlw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kWC0TIYp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+LEImlw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kWC0TIYp"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GNJ04l1248210;
	Tue, 17 Mar 2026 06:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Hdmb5clSprAIi24/fy
	cQxGawkrwzW+zjftdYlZPSPJY=; b=b+LEImlwiOYxmKf9//aiDEDSpARv738AhT
	SmT0iNFxnaKIQ2MrliDqMeob138f4GxN5si5Zip4hFQ+A9sxOQyPhqtshyHNXZXO
	gKGmdfCCiWjhO3l5N6MxOtAAga32VAy8jfftHq9J/zMOPrnl/q+K0jgdRDDK5bFY
	1/LlLKdjIqEIAG3kErs58QA3HVk7sWxvOCumToFuvPdSwyh+Dfh69k66tM//XPIj
	LFYt4Nx5Xxqjfo0nk4O+wUyFfn0kAodzGKDeelJ6swY4xIPqB3oIhES26b9zlNFP
	7dLFlDGvj2RYCdnOpMDPNbKRX2C+ajvIyqgw9KMwvs9D4pB09XxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9ruh8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 06:53:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62H6nRP9031891;
	Tue, 17 Mar 2026 06:53:34 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx49mv4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 06:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT010LCvQ/U26i+0Ut/sXrtzOXlbUZOw9EtRNAgnk8MD8JPaDo8VNW0PvKtuGJ/DJO7hHgnS0N7ucF1bPrLnePkZtPduwDAS8ZpxY75a9onO5Zgj/euzBJNP9Iv4M0DaYF2wFlaYv/1H1yQPsIhgGHrn2Vylq4Z8lJz3JC2cM0m1MG++PeeL5e8PHVaQaLtz4/SgXaIB1fR/Grrpgdf5Vf33TSyjPeC5GKsGef0QSxNSlQNlsu2usTpszwfic45cQaBu+0H+HfvDTHRELpkssJjI/LszUyfc78hI3Gi5t15I9LPUyOrww8vnZyDBd3DljhRTz6BosRLJr9uUsFIs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdmb5clSprAIi24/fycQxGawkrwzW+zjftdYlZPSPJY=;
 b=ni2+5J/UbvbD2d5rGj+rQT+d6vXR90kq0zT/VTgauIgggXUNBiAXjTs7QFH2UQiHYWn2Re9lNLNL5zbL0uO0DeG+R6/Wh5ROm+HL5YLR6Je9IAwY6NweiRmbjSbjVa9kLvXgSavUZJiRcsN/nFEUCSZjYNnsPSbr5RfYsfGzShNuwKdrFnhE269LMFjIdVEdL7Fry1Jd4hl2dVglQYLz+MnDaRQMUJ4kVVj3WmOOad1B2zhmP6Rz8NUEVBe6wR/zAoo3uBo7Jm32jKe1XURjZ10q/3XQkyMExab0pJ+rm/J7zB3wfRWMXbkfhaNrSHiCPhgJscKx9vHqFveLri0r0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdmb5clSprAIi24/fycQxGawkrwzW+zjftdYlZPSPJY=;
 b=kWC0TIYpXVnK9AJerQaDFNN4Uc86RaBPs6Y/VI0kVQN0Nr/vGlTMVEb9uWtWG9G+sTwwZWXRFvewmE85yCExsYqInoAqhX5WLOzIaQ90o51yiNuUkG7OEssqQl2OKI2P/nFh5fh5/T5Gm91pfKD7llU3VsgKMtSA54fiNoIV9kU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Tue, 17 Mar 2026 06:53:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 06:53:23 +0000
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
 <874imftol4.fsf@oracle.com> <20260316233712.7cbfac27@pumpkin>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260316233712.7cbfac27@pumpkin>
Date: Mon, 16 Mar 2026 23:53:22 -0700
Message-ID: <87ms07rlp9.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc93c52-edb9-4cbf-0880-08de83f1e1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	P3Gx2k4TCIygNB/b/6kQe23/K/BQUKvzcoSBUXGCUDZLyeFIeLsjjS4gvwIUVOttP13kFRu705n/VxK5snfLyL7mjbS03sLx3o9HAOetCtLD9LGcLJSpxbwGuSq0BcVYowJjMgm+MVpNGVO/AO4VLTVAVME1mNWajkULWTaEnh3VY8Ftww0QgXyb2n1M3bxUYOh2Wksd73M7CNEuGT9aCymP2Q9y7iDq5/Eqy3FyxowbN/65LYV/IWtZqqAIomCg8/RUYUS/tZqE2WAspCkkZ7rMAj39l8nuZXNlkhWevSO64R9bkvUB7kFpx2wk+0foAcSoJHenrhlzaxZvKaxu3F/QnPhET+/K5seszggvbvnouzjyzms4XlXkFFjBAWdDL5b3hGU1F0G7s9q17fghIwT1eM6mpZpQ7UIrjR0JgWStxw5UiRKPECxAMxNhJ1O0W/Z1QRPgqfFGjC72o+bMjIvw1sh1WnqWkgF+Sp3SmbRFvUjkQ3+kZ/hyjUKEQcaqQGTlkBO+xffBv54D+fql3ueVIMlvIqj2tshC5oi8sQbqoSYQuvhDJQDpfwHy/dDGBIyDCjLRcedWBsaMJJFc6iQcYPb+DodnqUva6+9FOqEKwD6nGWYiT5gyy5EEVWb4ah2MKzVo7EKGdkuDSPoF34LmzloXiH4gJtnM9+YHRAJTPS8TPT4pZ+aMvNd3gUbS3SJIWXMLroZlL6V+oS+DSrmWOQv0G2A7gBhGwjZ1s5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pw9fSO52C30ARUbaPoLsqgB5KC3qn4mR2S5ZwsmQyO4PRsg1Kr90gvwFoe2Q?=
 =?us-ascii?Q?Vne2TYYE64hT3eGYLAXK4iW6yfEgI1N22dQqgjiEhi5k6IXiUdg0QdyC2EFY?=
 =?us-ascii?Q?wNap1X9Dot3eJddFDS2zYiAhPzg6fK3CcDOXg1WRbk7hNCQVdZsSGXOQywKo?=
 =?us-ascii?Q?irfB0xPlIBdpwTCSbN8FGv7SeD+NfEjqMZwtvSoG4/bZwf6gg7iWo9hlJMop?=
 =?us-ascii?Q?/sjzdSSiLShJcjeJH3ZMB6iM1HuW4USBkTixWqxSVsyATrM8AD+w65bLLg3p?=
 =?us-ascii?Q?QWOskW3KK/W6rtB1DXps8GjE+F0akdSbMCZaHIzj/+7D+G8ECMgaSOHfayZm?=
 =?us-ascii?Q?rBdtlZGQ5oaQvO1Uust3T9l7c219RISTNwy+jXmD8zATGiAhrPI/HZ2TaiMz?=
 =?us-ascii?Q?we+mi3icI4eEw+kwx9G1j4XBLfj5baSuvYshr8TBqbmn+PNDZ5Up++nFVfL4?=
 =?us-ascii?Q?z3NckdvB3jb50j0vAxEP6/QORvGl0h5ab91eHbkrWLZJk0QQMA6I8WOOINm2?=
 =?us-ascii?Q?LAB7X16zhns2QMdI9A913LvmjRx0RDGOAjanC2yMeflpaQPofj4U4eqSTc98?=
 =?us-ascii?Q?OD7DbOuZcGryhhDyHzdO2zuuOcXcjsmPhNtz5N5tJrylJlJuJPgfyvOrgDmB?=
 =?us-ascii?Q?G+JxY14fbe3ZwbcTqoTla3sBWFHZ7b7YnnXTAemAHk6J3ri0gi4p6LsLtiAw?=
 =?us-ascii?Q?WBVnNT5nSY+AYQEwKlFEy0TscuDuPjrtK0OSLsdWZTTRaaVlswlQwkg9GQ+n?=
 =?us-ascii?Q?deZNbB34ZqkSAd9/7h2M3TtFkckPBshBKTGNZR7zhN4aCowhpN40m9Jt5Nx3?=
 =?us-ascii?Q?hqxf5TUlP2QE5usSomXYc49dJwc1tg4AAMtBrwBOr59X7ydCTNQr0lskNN52?=
 =?us-ascii?Q?p+JUieYgYpWl5xOExb7NwN8cASwyeQU1HHfZdcupD9svDbns/plshIUHuk36?=
 =?us-ascii?Q?DXKZZ87I60snPHBwJS2uhLOloXPNnUke/oduq4LoRR5DPCYjvRutnsvD9J1C?=
 =?us-ascii?Q?kvSmdUPlz5oVcaN53/h21NjiR1Ze/6zPCMLfLqF6CkbrDRPfwiq+z8dmU4cZ?=
 =?us-ascii?Q?jn/jZkKDgiU6Mb1PWzadeUtYhmMgcQRz/yiZ3Bemz7YHezB6QjknpC29BPPj?=
 =?us-ascii?Q?UjFgcBpZ3zyN30UqsuqGxqPnLp75pPHsSCaYWsNFfnyxrH/uOIOiIVIHI8k2?=
 =?us-ascii?Q?UTTSZGvGQvo0qfl5dKCO9mRLuLEldIafdIcxVOn5vzteZWrT5uWf8k7gFu5j?=
 =?us-ascii?Q?6M0UOaaKbW/A/JWKFy5K3KGmpGCJvNrt2F3IOe5oaRvtbIN3GVH3EMHpMgD2?=
 =?us-ascii?Q?pLgC8p3DGOA2DBA5UosdgvEHC+tM1KxYw4tSSRP0y9ZCI1UuCEqyCOWEPUFA?=
 =?us-ascii?Q?145dSjpt1Of+3jAJLIb3VWYaO7mLKKdl7Myf0L0aHbCQO6LJ8qe86+vXl4O2?=
 =?us-ascii?Q?EuHxQY9O84GocM79+WhkCuc/Gg3JQ1jvKodB0AR4eb98TeZvph3gxDU1MOGr?=
 =?us-ascii?Q?l5cdmE66uv9Vr0fRGoi/wlBxdeOuJUKW3I2w7R2qFpseM7AbYnWbOQn9Mqd+?=
 =?us-ascii?Q?ooW6rhmx1cQ04000DN5bF7xzTQu7iK1JQl1cUa5TDkK1pMVhmvHy+nouVBAm?=
 =?us-ascii?Q?ZoKAisgAcTnbOiwlCsYIGVvH4VjZ8zN2fx4c9wUdv5JWwGcOMKB4L6rx3S8j?=
 =?us-ascii?Q?E5TmU+4aFP+W1ShjohEySsOUZ3/D7MIcRnAI1ulOPyepaeENZ4Zpx+mJxcWy?=
 =?us-ascii?Q?VgZCYF0+SsZzzv14Vqvim/tOinLbz44=3D?=
X-Exchange-RoutingPolicyChecked:
	tr5baDQ8oZyyXKb3lDHc21GNf7GuMIp7qs5/pb7FldeCwdjBS0P/O2Hr1Kk7ZdPVi+MV1OP2aPRXeWX7z6JgYvFTiv7OmF1wmJS/7HNuerHXGRgQP0C2zIxgSAh47qKTNAHErVXXRbWf0935nlB6qFGXNUhdCy8EiRsjRE+OAUAZCnJ26Z2cPuOuRm7KG0pqHhViP5BsYk7JcmrF7U/YqSUYqturOfJByzIuCZZw5G2pZCG1i7R+qb7BDBNpbiMMOZwaKMo/P29EfsPqoHxisGEGx0l45o71ScJS2hLmQlMq8UKOYUfelP0dwFJiGozKrnwW4dnYa9Ef5vrhnhQVOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8HixPY3z+/1xVR1Eq3W4B3D/+MctgzvRCy3XeVfH7LWJhTADcFTt2R/6ISIxflZuc/AXebRGTVHocIxMr5kQLpKTPYFCDHsrIkDzprgWuLTrfhs7n7F0qfVdfEggL7hWFRa4EDwUVmY0SUr/3GD7pwkq0w95ZVxljoJSp4wLcRldg+Po5XZJCon3orAWI+vmKL7kBcyCfFeGKduO0aZHiZhXvduFkJF3aNnL5x+elnYfxKvxoka9BDvidaCGVw1HdKPtzjrGLUIl+znl9sXxWKqMaOBgpfxrF7OO6J9QFLXqe3YxhddL+Pi+bNFgM/VfMDVBhYUhfmd5c3PMwtFfbmagmGf91P3a/WDmCZBMqs5dJ8aCy8ZHky4a6vCj3+8KQ4Iav0FjT1B5TQfpX5f+pJMIvrUURPFnsp2LxRMAP9X9y2aRfbb5Z43E/o/Cy7yQJA2adLqlGKOTOlpZgv0SH8UKLYrX+QUdtD28FPUeNYitx5HBCN57Hx+6iwMh32953tyt9erddfDcUGXS3yaG3owPCpHmrJk7fv+qd1lbzPbe6vpsujQJTsIsKEM/wxfxDGGPv8l0YsBs5bTXUY9yApdJXsXOZyMJmizm/VVCT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc93c52-edb9-4cbf-0880-08de83f1e1f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:53:23.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tm64Ke5us9vn4EEFOxow4RbAHxDpILPxX6lD1DPnCgvtzWuCU58U2ihJFl1G1Ho5OgWd44ujEWLh82m3d2M0HdxPjpiYDioUlKOAda6cakI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603170059
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b8fa6f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=qbnnC1PJtrjm2xo4jsIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA1OSBTYWx0ZWRfXyt4RY+Z1oXgh
 ZuJwK5xlSjWT/R9y3sdTZfeVMPVhjA1PG9IObCnbxi9WH8UUoGF2OPdvvlVVXicteCSZeK5fZwj
 YebaobYsgGl/V72LbE6XgEJ1BdLEpsV2nYBaf61Yj8jqde7KaOifdGXyN1yNJfkUcTfybAZC2La
 GeIrcoDdD7OwTKzpyBkek5pa2pnn9ai3VGlp+88yP9A1RSzgYGu6pLE/ppvPsooaaXX0p+i+wLL
 lpqtW54E5F9fAvWF+Q0oBuVPspXjQtmRoqGaZrlpemHzBJSPPUXQDQ13A9jmOGebxtG80C8ZRuN
 dJv3RgvL9p0hdeHZfsazv72VMKSqwl0DGoLjcXA9H4hfngJoSek5ApjAoQjGDsUa6Pl0NIGPubP
 Ba7SDb4hykldy2f6Lte+ZnQNe2nj00dYMCwuoZTn/ogpK7K6sAJLzE3NnU1isB7e03rN1F4yd19
 YTvg9ie2ruGBJogC7Jg==
X-Proofpoint-GUID: p1gNkWsm2BCB0dj_BBzufOjw1_QUIpgC
X-Proofpoint-ORIG-GUID: p1gNkWsm2BCB0dj_BBzufOjw1_QUIpgC


David Laight <david.laight.linux@gmail.com> writes:

> On Mon, 16 Mar 2026 15:08:07 -0700
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> ...
>> However, as David Laight pointed out in this thread
>> (https://lore.kernel.org/lkml/20260214113122.70627a8b@pumpkin/)
>> that this would be fine so long as the polling is on memory, but would
>> need some work to handle MMIO.
>
> I'm not sure the current code works with MMIO on arm64.
>
> I was looking at the osq_lock() code, it uses smp_cond_load() with 'expr'
> being 'VAL || need_resched()' expecting to get woken by the IPI associated
> with the preemption being requested.

Yeah, osq_lock() has:

  if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
                            vcpu_is_preempted(node_cpu(node->prev))))

This works on x86 even with a non-stub vcpu_is_preempted() because we
poll on the node->locked while evaluating the conditional.

Won't work on arm64 since there we are just waiting on node->locked.

(And so we depend on the IPI there.)

> But the arm64 code relies on 'wfe' being woken when the memory write
> 'breaks' the 'ldx' for the monitored location.

Agreed.

> That will only work for cached addresses.

Yeah I was forgetting that. LDXR won't really work with non cacheable
memory. So a generic MMIO version might not be possible at all.

> For osq_lock(), while an IPI will wake it up, there is also a small timing
> window where the IPI can happen before the ldx and so not actually wake up it.
> This is true whenever 'expr' is non-trivial.

Yeah because we are checking the state of more than one address in the
conditional but the waiting monitor only does one memory location at a
time. If only CPUs had vectored waiting mechanisms...

I think the smp_cond_load_*() in poll_idle() and in rqspinlock monitor
a single address (and in the conditional) so those two should be okay.

> On arm64 I think you could use explicit sev and wfe - but that will wake all
> 'sleeping' cpu; and you may not want the 'thundering herd'.

Wouldn't we still have the same narrow window where the CPU disregards the IPI?

--
ankur
