Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7D35E931;
	Fri,  8 May 2026 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221954; cv=fail; b=FLIsdM6g4HO/ZsV/iEZZqalfqt8kSzYWhy3oK+do1gat84BxRs9WB5bwnhFRaOWnf8yi6FDOLowbLvENl0SHR6t314JqJqAuXOTnUekfBVSnLpEELROhUQrV+6nLFuzjvPqqCTi83uK7LbDi0zlXL4B9kPqJcLhqv8AItO/CvuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221954; c=relaxed/simple;
	bh=XXNz6ckr701bPEEOhgG721BCpbUV1F2/AKF3/Ril/4M=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=uuA4Q2l98/5go+4A8kYAqbd0M5xQjlhahg3rVLHuOQMF8h88LQ+usQ7IunvO+v0zdZTWKwFh3iAj88ziBIbh9nLoMU+yt0MQfYxdLk50Xvz9pj78P+FpDUQwCJfK8njrjvq7XHr6kNqfvAi4JhwU6zJfFZvRMqKjN+Jp2/Mr9UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KZs1L1S2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mKheMelL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZs1L1S2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mKheMelL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648352Pn527646;
	Fri, 8 May 2026 06:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4rkM81oAXk9yQ9xtF0
	5HOZDJ98RV55GhkXZLG5GBe8o=; b=KZs1L1S2pg6Kyx3e7o5FYmMcqW3fB9wUHI
	ypHdUnSyUSink92rqx3HchU9WYhLkfoo7BWhaIURKsHPD+c8SWQnD/ylJv7X3TbK
	q8dcsSG25bWz2omlzJ7fY9lPJpQs94foOt/jRzvZTaPPX65I1nzQqXj55tcI2XXk
	d0R+TYAWx9lLYg0tyaGX3GJNuWf2UNdz1mhMzpAFRrigDuCElRkakylRG4ZAbebt
	mJ6F0+/Pw3Ule6KnwCoMoGm7OJYzvOjogJDFGsMNYUPAxaQAuyPxVuX7mFa1Ne3i
	2Gan9b1WHJt2xDLLQzdnyW0kt5yGs2aanWkxfJi4eg1hVs/6Hgrw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e4j7u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 06:31:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6486VhDb030616;
	Fri, 8 May 2026 06:31:44 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dx581bukg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 06:31:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB1xp5nHMmfuRgLHKWoSsJBj6Nap0jRAZmWxgPk0ToB6Pv5wXuv7zEwl53LpibCZZA5GdwJJNfB9oX3h5LvJRBvoKHrkXfvmWQbvixIARP/FYy3Cmn5kGSW2g2fp9Yail8ouFJHV/+ggKAwuNSzi0QmpvdmNCbsEf2kU0ZrhLCEgwVJ/L9STBuGrUk0TGmRY6Bu9b6NKamYCKY/cNimDb5MDh4iyMvE8a2MpctJ7a4tiR4G8GQjRy6NrLkrhL3lLw92QRKAi4nGgeAQmmf1OdfR5ploJ13YKr7RVOebVecdMiu0dX+iEEK79dfjk3dQQazoHZRZfQ/UnxG0P8hUXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rkM81oAXk9yQ9xtF05HOZDJ98RV55GhkXZLG5GBe8o=;
 b=IsiXFXj6sxnlfSR6edi1g1qSZR3IQiH8BjW8bYLmNqsqTXz8ymT9LwgBQ7SZUwY7Ecf8AZsf9wK2iJoqKzp89OQnuN74EtpSjS70hM0V4Y4rI2ba4En8qkyS/+TTrUENoZJGgSxYPpOcBOej0ZaC2rYn+tsqdYl1BK4PhUtyf86IpBKGDui4k2+oalC0EF6ZChR6BiYb/hZHVW5n5SaQFn5v5UL+twzDk9mn+wDDAxwtuXT75JxxwluNIjn6YW4DQcwo5y+Nw81AVLc/w850TVjhKf1KT1Cc9xR7DXBFMkdRHRH8eKMYRQ3GFKDSSbNKUv2Y4TerfiM9JGEAU92/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rkM81oAXk9yQ9xtF05HOZDJ98RV55GhkXZLG5GBe8o=;
 b=mKheMelLHUI+47///WDSbOZ4iYSiRTG5YR23p5fJsw/6HAjGpYzGKWgWvtnaFyyzJRmnw5/ALqubY2tLdiuhH/bKQGuF1oQBshyWWsmeyxRZ2DwNcSl8NvzzjDK/W+DCGnTttuYHOzaKk4QtqjJwk2tQdOtq2qMkqiTWHNm5AOk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 06:31:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 06:31:21 +0000
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260408122538.3610871-2-ankur.a.arora@oracle.com>
 <874iklm1uy.fsf@oracle.com> <20260506095836.216d9cc5@pumpkin>
 <87o6isl0nl.fsf@oracle.com> <20260507105721.66ba1e45@pumpkin>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 01/14] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <20260507105721.66ba1e45@pumpkin>
Date: Thu, 07 May 2026 23:31:20 -0700
Message-ID: <87lddujttz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b07884c-4136-49d9-e508-08deaccb6b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	v7iLYha5pKo8sPD8Ld/ROOUPRykKWylR/KOSVwOfnuzBP2ZsOsuVXzqX4qqkoM7UrhH7YEskzDCQWpd5c5lFhDYqAgHYNhGnEUyLWHATpP8q/FK0LRRVaPPgpEk27Hbu2PpemBaxh0dv/lSgKs1g/UCdjzUgX72OvZP3ityR5L9vEbq7igdVQ2lvod9OdFZn97KHHAl6MYJfUXG68gvHCVJ00DXUzjYZBsWxJ+Q9ShdPIgxHQjj3bxOCX/UNbxTA8f4IABUmlCTBpvxC6xC5xVbD26ulEPX9wj23IDiNkFauolaMoE+cQD9QmnWAh2Fz29tGrrKiYoRYyTVU6eTctP4ajZrLPfPeIQpLTFbKeKdiqMgrQ6xZYoOk0aH4MQmvTlfmxNfjIzyd0pAlpSTENELlgLlBEPB1nllQBe7Clc66Pq8WftBN0hLWjzn32gmM/fLiJsaSdvZqCeGherxXSennX5vrHLIG0HhkdlIzJDY0oyKeFyTLuXs396qJjh0+0AA2m8ddOHgFAaW0kMSiNeevhNHdg0tc10a7EaiuOaGYihCi/wJ1Ne9C6oBmJdzbMUO5/4BLGXtlB/lAhzT6uvCFjnTtmXNKzGNBmkkuCgPP8v4Sos1bzWIPkBdnArzRubTXSFQgjf5uuCEpmATfv9Ue/lm0pXSBu1uZ54xE0e6HnSCmfMoVAxmEDhOFRYIw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhY1NqWWB5nqXReZo7F+eefKUKYDYfMjNMnP5JiiHzrWVaHNEoNw7/CT0i1H?=
 =?us-ascii?Q?QxyFOW9XV0mf4b3+KmaXiYaltq+wcY8tJPAx2MeQT2gmPIQ0HngLtSiwZDUD?=
 =?us-ascii?Q?mK59ch605sjIWFEK2iVgGSjH1giB2DO0MEHwQ6wFAFAtWefzemVyHYJW5NJw?=
 =?us-ascii?Q?BIB24FeDJbEPkwQWKm/J4O89sZl2ExmfbnnYEZX6doXSnETEAn4ouMvBsb0G?=
 =?us-ascii?Q?z/Dy+it3xXU+1JqUB+erCoOH9M2nvY+z3+BocRrN4KXJIHlioDAjvQ6FFlo+?=
 =?us-ascii?Q?4+CELXavvZHGeRJ6gJwlUYe5Ru902BBmct+Zyhxj8o8bJTQZGOMl3ZYcPjlF?=
 =?us-ascii?Q?7zKOq9VQdtlOfBrLRF10ghFwj4rUx0MCQN4OsRPCmz0DdkMs6puFYIXIlqSd?=
 =?us-ascii?Q?1mL2GZIw9E54HYHhDjomOyC6Rg7p+DadMLWBoXY36VKLjy6A0/XcNKmgyP40?=
 =?us-ascii?Q?WIDKr3CNZKYoC4t7Ac5KWXos4bs3DzYuAL+rqqHoMGeBH/Ul38SRkcYJBTpw?=
 =?us-ascii?Q?894bebKEittpxYni4sU94Y71TBBOCT0Ze7hfZe5kYjRpDSvnT0dbW/AZn2fV?=
 =?us-ascii?Q?p3g0WgGJED9JT8In8cRaDz8EffWY3BMW4Diwrz8o81inHuy2j7M+cA5tsxOg?=
 =?us-ascii?Q?BAlyRP9FkDGqzIMT7zeXBRTVBTgmjpO84yzuLna5BkPR9zVzEOCEm6vkilOu?=
 =?us-ascii?Q?MGKUp7TdljwsUd6qyUJb96A6RFNKMi6sfLMBisMJMY9QLdolHDJ1SAiY5AOr?=
 =?us-ascii?Q?7b+MMooYhyoatdWTVVdQgCDNH6dtj8phHNQvJ/zxJxs65/dK/Xa9S/yyaOSR?=
 =?us-ascii?Q?0ZQv8r92UpcnMAOnnH6dd+5Vbpr9YDzZ46xZzMtjSVLhVas4UQJp5qDG1WHB?=
 =?us-ascii?Q?g9AfynoD0K32++gvlaQf9d1LqgXpMNMe7M582yTSap40n/QvHOohl7ZZtzWa?=
 =?us-ascii?Q?dl1S6UJqqxFz7nzl9njM7PXJ/pNfomvphJ1yeLd7e4458UlujvXnQugiRDgN?=
 =?us-ascii?Q?dRPOHDXq+VPLCeqZDlILdjI1I3+34KuTGgnsSWESLEHCqkU/aaq7H0zlNw11?=
 =?us-ascii?Q?kkTgkEZewTEbXMbEg9zPAMCyCszhUgHIbRug/b5wm/J2hfOIbYyWptjFOB4F?=
 =?us-ascii?Q?PWosTcZpJ5232en639It6r2/4m7hI7BHwuwRPEkQJuNt+Id4cteFmQT/1IkY?=
 =?us-ascii?Q?oPU1/8NqvA4VVf7zc4YfofNh0fifmDHAhPjtL9aF8OCnmcetMXXbTzcPVVNz?=
 =?us-ascii?Q?0QViZfKFI00oVfv/NgxupZSfwE1nrSWbbb4TQKcXXhIPHpgOBLbQNdmKGgHw?=
 =?us-ascii?Q?0na4ijpfDF/hserxnhgEIBWPdzlH9XGMZDXwfEKXHDaq107mGXsq7OrUu5H+?=
 =?us-ascii?Q?noP7487sYSSkU99dWUotGCcOhjcJXWcZXsczwVOdcFVc4260jdXwMvDGNcTO?=
 =?us-ascii?Q?LQv/v4VRNJpMxKHD0e0C/gKKz51HCwAzrRsOE/Wk3KjJqx3rt0L+igbhtBeo?=
 =?us-ascii?Q?RPtaxjwIsGeZS2fbPzVt93P3lz0kub9+eA6dUoQYpoWxeRBJ0XgHNJPw/A5N?=
 =?us-ascii?Q?sCOXRi0wwVPDUnDbX6L/Xfqpsg+zI1vOos6eEMkabUFmEoRC5U2nT1aWN8H2?=
 =?us-ascii?Q?bxU+dqS2kkeJiwjj6ZZcDZERHzzj52c96Nx6xTlQrwS6N/O+1dcsF123OJH4?=
 =?us-ascii?Q?ws+pi67XZZIXRBWBZHK8tDY4vY2tiWD5217rxGfmzz/YyE1IewrTLFyAEwAR?=
 =?us-ascii?Q?O7zmZeKpYMac/hqnSBVqVn7Xy7c0a6E=3D?=
X-Exchange-RoutingPolicyChecked:
	lnV/ZXpvtsm7pah1uHS4gcJof1MTyu/OlWNcCtVMUyetrUR5gwIdkfQ3kMkZA28t3NMpmf8t9jM4v627BILCb3THfdA6ycngQAhz8VcDLZvXt0irewvuzo1wpZByUm5NPMvY/eS0hyNAdoX9uvRtBNvu9obtKDXisuatltX8r9y3NTaFQqDSmCir3FhRiivVdILckZ/WaRBhrgqv6ixkeKJSvBwQdJclGFn5b7FhNVtybAuKjVVj0Wy5wQCM6pxQGe+tgCT1ZcAQdj9WsdtMhAi2kP0DzcsDFLGeolR4tNnmZ9ago3Z62TXeWKwzUWhBJnPQbwYOjK20YdCe12hOog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zsqn0NaQVgr2CTnbx6TaLEJdz18SnczJRkw4uVEjDFdLCY0F/umfFsl0ZUPLD9zZkdsX19WmqdNQm2A4JyRlcFTLmyeW4UIZZtNXfD1/zBSZ3ECFi7IqQm3f4Nd6BbR690PT40N+NfQBlylP9rKhnPR6XD/i/uH9kE+t73FuTnvwqqOJMLtldfjg/SQsmkudkXhYYXmAiRHI4ntK1ZCmDkIO4QXo6b+Pg43qLEFedtH3WUBRfCViKfM8g3x+UGO8BVpi0D0V2+rycZStYx0PueneGuEGFYYRJGViFce6i8lTQrE2qo4bKJtTY0NiJh6s9oT/xDRLTg0od5NY36L2RlpMoue2B8GFz9xaB7wj/uh60xVQ6ExFsuPGBNdBpCQyt7W+hd0ecI1+JDQVm9l47aW/8TcJKtaf5+DTLUfCWsatduMTXcJdIgL3yYglbaqaIF2zLZRn/AiZHJnOdAKmfuxbbPMH+AHSCHV1nFDo08s+3czvxnraUT5n8GPAA6g8wfsLdY/MpCAvGLnRTdSXGSqzJkIeIXirGODw6NcAb9HToP2hA1yvpCHOZOsrB68Wx8kN0HNOZwiGOVk3J1tfn3Zz+s8hMQKQXQAf4YhzSIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b07884c-4136-49d9-e508-08deaccb6b7e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:31:21.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lgjt30bRwHO+hSPbkw8f3IC/6pxausYQdx/Yld6uCkqhzSHTS+OA1IxWZQ+tcxfoEbZYH+HTUG833iN5uKk+oWTqJ5YxwRuP0A10uKXgOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605080062
X-Proofpoint-ORIG-GUID: LakgHjC5xf2Ump-UhrN4yeqEitQEbVPO
X-Authority-Analysis: v=2.4 cv=O+YJeh9W c=1 sm=1 tr=0 ts=69fd8351 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=R7HQDbO3xpJVcD_IMk4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 cc=ntf awl=host:13839
X-Proofpoint-GUID: LakgHjC5xf2Ump-UhrN4yeqEitQEbVPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA2MiBTYWx0ZWRfX7ykH1PxDYsAL
 MlZVO8umCT8Y45BTDuzkW4ZMRYfWUTf2+rnE+6Pl587TxwNWsaknJg55FA+jML122FuzuKRBdoP
 3gsTamC0ZVhHc7r7vkSzj3TiWYtPTo8BK2y7OkLMowJVmfTEJLiiUvkAYmej/yNIx7KY9M8sh0o
 u8xoKnTcklZswJXuK9VOHDZBK02TZHTwzVCz8JskOvVpu42oTyLLIW8gcEFrNsM8iTYnpGKMlAE
 HwWOucrGPt/QvfH/peVjcJChm1QA7p5ahP/TWSa0RwDjbCb6YxlQijMGY22u8mI/Zh2RORpy6tl
 +gyyhJJxBDbiJIwqC9rji5HMQCo0L2pZomLJJjTINuAT57RR4vvFB3rIb/DiwaVxbHypCwfHnST
 59T+wvNm5QhwablLDqxLg2NDhKF1Djqmy8bUjafoRac2/JfsQEDWybW4XAwPT5nHCvtWUoudv0E
 8lq7iKPL7bzjLYIF9rrgiVH6y4rzblnUkFQnNJ8Q=


David Laight <david.laight.linux@gmail.com> writes:

> On Wed, 06 May 2026 13:54:06 -0700
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> David Laight <david.laight.linux@gmail.com> writes:
>>
>> > On Wed, 06 May 2026 00:30:29 -0700
>> > Ankur Arora <ankur.a.arora@oracle.com> wrote:
>> >
>> >> Ankur Arora <ankur.a.arora@oracle.com> writes:
>> >>
>> >> > Add smp_cond_load_relaxed_timeout(), which extends
>> >> > smp_cond_load_relaxed() to allow waiting for a duration.
>> >> >
>> >> > We loop around waiting for the condition variable to change while
>> >> > peridically doing a time-check. The loop uses cpu_poll_relax() to slow
>> >> > down the busy-wait, which, unless overridden by the architecture
>> >> > code, amounts to a cpu_relax().
>> >> >
>> >> > Note that there are two ways for the time-check to fail: the timeout
>> >> > case or, @time_expr_ns returning an invalid value (negative or zero).
>> >> > The second failure mode allows for clocks attached to the clock-domain
>> >> > of @cond_expr --  which might cease to operate meaningfully once some
>> >> > state internal to @cond_expr has changed -- to fail.
>> >> >
>> >> > Evaluation of @time_expr_ns: in the fastpath we want to keep the
>> >> > performance close to smp_cond_load_relaxed(). So defer evaluation
>> >> > of the potentially costly @time_expr_ns to the slowpath.
>> >> >
>> >> > This also means that there will always be some hardware dependent
>> >> > duration that has passed in cpu_poll_relax() iterations at the time
>> >> > of first evaluation. Additionally cpu_poll_relax() is not guaranteed
>> >> > to return at timeout boundary. In sum, expect timeout overshoot when
>> >> > we exit due to expiration of the timeout.
>> >> >
>> >> > The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
>> >> > is chosen to be 200 by default. With a cpu_poll_relax() iteration
>> >> > taking ~20-30 cycles (measured on a variety of x86 platforms), we
>> >> > expect a time-check every ~4000-6000 cycles.
>> >> >
>> >> > The outer limit of the overshoot is double that when working with the
>> >> > parameters above. This might be higher or lower depending on the
>> >> > implementation of cpu_poll_relax() across architectures.
>> >> >
>> >> > Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
>> >> > cpu_poll_relax() that is cheaper than polling. This might be relevant
>> >> > for cases with a long timeout.
>> >> >
>> >> > Cc: Arnd Bergmann <arnd@arndb.de>
>> >> > Cc: Will Deacon <will@kernel.org>
>> >> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> > Cc: Peter Zijlstra <peterz@infradead.org>
>> >> > Cc: linux-arch@vger.kernel.org
>> >> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> >> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> > ---
>> >> > Notes:
>> >> >    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>> >> >      be using architectural primitives that don't support MMIO.
>> >> >      (David Laight, Catalin Marinas)
>> >> >
>> >> >  include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
>> >> >  1 file changed, 69 insertions(+)
>> >> >
>> >> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> >> > index d4f581c1e21d..e5a6a1c04649 100644
>> >> > --- a/include/asm-generic/barrier.h
>> >> > +++ b/include/asm-generic/barrier.h
>> >> > @@ -273,6 +273,75 @@ do {									\
>> >> >  })
>> >> >  #endif
>> >> >
>> >> > +/*
>> >> > + * Number of times we iterate in the loop before doing the time check.
>> >> > + * Note that the iteration count assumes that the loop condition is
>> >> > + * relatively cheap.
>> >> > + */
>> >> > +#ifndef SMP_TIMEOUT_POLL_COUNT
>> >> > +#define SMP_TIMEOUT_POLL_COUNT		200
>> >> > +#endif
>> >> > +
>> >> > +/*
>> >> > + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
>> >> > + * that is expected to be cheaper (lower power) than pure polling.
>> >> > + */
>> >> > +#ifndef cpu_poll_relax
>> >> > +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
>> >> > +#endif
>> >> > +
>> >> > +/**
>> >> > + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>> >> > + * guarantees until a timeout expires.
>> >> > + * @ptr: pointer to the variable to wait on.
>> >> > + * @cond_expr: boolean expression to wait for.
>> >> > + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
>> >> > + *  on failure, returns a negative value.
>> >> > + * @timeout_ns: timeout value in ns
>> >> > + * Both of the above are assumed to be compatible with s64; the signed
>> >> > + * value is used to handle the failure case in @time_expr_ns.
>> >> > + *
>> >> > + * Equivalent to using READ_ONCE() on the condition variable.
>> >> > + *
>> >> > + * Callers that expect to wait for prolonged durations might want
>> >> > + * to take into account the availability of ARCH_HAS_CPU_RELAX.
>> >> > + *
>> >> > + * Note that @ptr is expected to point to a memory address. Using this
>> >> > + * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
>> >> > + * tuned for memory) and might also break in interesting architecture
>> >> > + * dependent ways.
>> >> > + */
>> >> > +#ifndef smp_cond_load_relaxed_timeout
>> >> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> >> > +				      time_expr_ns, timeout_ns)		\
>> >> > +({									\
>> >> > +	typeof(ptr) __PTR = (ptr);					\
>
> 		auto __PTR = ptr;
>
>> >> > +	__unqual_scalar_typeof(*ptr) VAL;				\
>
> It can't matter if integer promotions before assigning to VAL.
> So something like:
> 		auto VAL = 1 ? 0 : *__PTR + 0;
> will generate a suitable writable variable.
> (The '+ 0' is needed because some versions of gcc incorrectly propagate
> 'const'.)

Thanks. This is useful to know. However, we use the unqualified typeof
dictum all over barrier.h. I didn't really see the need to depart from
that.

>> >> > +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
>> >> > +	s64 __timeout = (s64)timeout_ns;				\
>
> The (s64) cast can only hide errors.
>
>> >> > +	s64 __time_now, __time_end = 0;					\
>> >> > +									\
>> >> > +	for (;;) {							\
>> >> > +		VAL = READ_ONCE(*__PTR);				\
>> >> > +		if (cond_expr)						\
>> >> > +			break;						\
>> >> > +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
>
> That doesn't look right, __timeout is relative; if the underlying code
> uses the timeout then the code delays for 200 * timeout_ns before even
> looking at the actual time.
>
> If you want to spin then you may not even want the cpu_relax() at all.
> (Or with a very short timeout as in the version below.)

Yeah, BPF uses this in the fastpath where we want to avoid looking at
the clock in the fastpath.
Overshooting the deadline was a minor problem in comparison.

But I agree the version below with the shorter timeout works better.
Unfortunately it doesn't help on arm64 if we are using WFE.

>> >> > +		if (++__n < __spin)					\
>> >> > +			continue;					\
>> >> > +		__time_now = (s64)(time_expr_ns);			\
>
> Another cast that can only hide bugs.
>
>> >> > +		if (unlikely(__time_end == 0))				\
>> >> > +			__time_end = __time_now + __timeout;		\
>> >> > +		__timeout = __time_end - __time_now;			\
>> >> > +		if (__time_now <= 0 || __timeout <= 0) {		\
>> >> > +			VAL = READ_ONCE(*__PTR);			\
>> >> > +			break;						\
>> >> > +		}							\
>> >> > +		__n = 0;						\
>
> Resetting the spin count doesn't look right at all.
> In principle the code will delay for 200 * __timeout.
> Possibly the earlier check should be:
> 			if (__n < __spin) {
> 				__n++;
> 				continue;
> 			}
> (Or just don't worry that the code will spin again after 4M loops.
> The problem you have is that if cpu_poll_relay() ignores the timeout you
> probably want to spin 'for a bit' in code that only accesses local data
> (in particular avoiding evaluating cond_expr or time_expr_ns).

Yeah we do avoid evaluating the time_expr_ns. And I agree we don't want
to hammer the cond_expr but the cpu_relax() should help with that.
(In my measurements I see an IPC of ~0.05 in a cpu_relax() loop of this
kind.)

>> >> > +	}								\
>> >> > +	(typeof(*ptr))VAL;						\
>
> That cast is pointless; the return value will be subject to 'integer promotion'
> and converted to a rvalue - which removes any const/volatile qualifiers.
>
>> >> > +})
>> >> > +#endif
>> >> > +
>> >>
>> >> A cluster of issues that got flagged by sashiko was around timeout_ns
>> >> being specified as s64 and a bunch of potential edge cases around
>> >> that.
>> >>
>> >> These were mostly caused by an implicit assumption in the code that
>> >> the timeout specified by the caller is generally reasonable. So, way
>> >> below S64_MAX, not 0 etc.
>> >
>> > There are plenty of ways kernel code can break things.
>> > Provided this code doesn't itself overwrite anywhere (rather than
>> > just loop forever or return immediately etc) I'd be tempted to
>> > just document the valid range rather than slow everything down
>> > with the extra tests.
>>
>> I don't disagree. In this case, however, it's somewhat borderline.
>>
>> On the pro side, we get rid of some of the implicit type conversions
>> and assumptions around those.
>>
>> On the negative, it adds an extra modulo operation in the slow path.
>> And, the for loop is structured a little differently from the usual
>> version.
>>
>> On balance, I think this is a good change if only because it makes
>> the types a little more explicit.
>>
>> Ankur
>>
>> > 	David
>> >
>> >>
>> >> I think this is worth cleaning up a bit. The change is mostly around
>> >> introducing a u32 __itertime and explicitly computing the waiting time.
>> >> And adding a check to ensure that we start with a valid value.
>> >>
>> >> This does make the implementation a little more involved. So just wanted
>> >> to see if people have any opinions on this?
>> >>
>> >> +#ifndef smp_cond_load_relaxed_timeout
>> >> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,          \
>> >> +                                     time_expr_ns, timeout_ns) \
>> >> +({                                                             \
>> >> +       typeof(ptr) __PTR = (ptr);                              \
>> >> +       __unqual_scalar_typeof(*(ptr)) VAL;                     \
>> >> +       u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;       \
>> >> +       s64 __timeout = (s64)(timeout_ns);                      \
>> >> +       s64 __time_now, __time_end = 0;                         \
>> >> +       u32 __maybe_unused __itertime;                          \
>> >> +                                                               \
>> >> +       for (__itertime = NSEC_PER_USEC;                        \
>
> Ok, so that limits the initial 'spin' to 200 usecs.
> That gets added to any caller-specified timeout.
>
>> >> +               VAL = READ_ONCE(*__PTR), __timeout > 0; ) {     \
>
> Broken indentation.
> I'd change it back to a for (;;) loop.
>
> If __timeout <= 0 then the code goes through the 'timer expired'
> path (below) on the first iteration.
> So the extra check is just bloat.

Yes, but by the time of the first check we've done this
computation with it:
>> >> +               if (unlikely(__time_end == 0))                  \
>> >> +                       __time_end = __time_now + __timeout;    \
>> >> +               __timeout = __time_end - __time_now;            \



>> >> +               if (cond_expr)                                  \
>> >> +                       break;                                  \
>> >> +               cpu_poll_relax(__PTR, VAL, __itertime);         \
>> >> +               if (++__count < __spin)                         \
>> >> +                       continue;                               \
>> >> +               __time_now = (s64)(time_expr_ns);               \
>> >> +               if (unlikely(__time_end == 0))                  \
>> >> +                       __time_end = __time_now + __timeout;    \
>> >> +               __timeout = __time_end - __time_now;            \
>> >> +               if (__time_now <= 0 || __timeout <= 0) {        \
>> >> +                       VAL = READ_ONCE(*__PTR);                \
>> >> +                       break;                                  \
>> >> +               }                                               \
>
> How about:
> 			if (unlikely(__time_end == 0)) {
> 				if (__time_now <= 0)
> 					goto timed_out;
> 				__time_end = __time_now + __timeout;
> 			} else {
> 				if (__time_now >= __time_end) {
> timed_out:
> 					VAL = READ_ONCE(*__PTR);
> 					break;
> 				}
> 				__timeout = __time_end - __time_now;
> 			}

I had a version like that for one of the iterations. One of the problems
with it was that needed a named goto (because the whole thing is wrapped
in a macro). I don't tihnk the extra check is expensive enough in the
slowpath that it's worth rewriting this code.

>> >> +               __itertime = __timeout % NSEC_PER_MSEC +        \
>> >> +                               NSEC_PER_USEC;                  \
>
> That seems to just be putting a bound on the timeout.
> So the '% NSEC_PER_MSEC' could be '& ((1u << 20) - 1)'
> replacing an expensive signed divide with a cheap mask.

I think this is a good idea. Let me do something like that instead.

> But overall this is a lot of code to inline.

Sure. But it's a small number of callsites (and it's a relatively niche
interface) so I don't think inlining it is a huge problem.

> It has to be possible to get it down to something like:
> 	struct info info = { .tmo_ns = timeout_ns };
> 	for (;;) {
> 		VAL = READ_ONCE(PTR);
> 		if (cond_expr)
> 			break;
> 		if (_smp_cond_load_relaxed_timeout(&info, PTR, VAL))
> 			break;
> 	}
> 	VAL;
> (yes, I know it isn't that simple because the arm 'relax' code
> has a re-read in it so needs to know the size.)

Yeah and as you say above we want to minimize hammering on the cond_expr
and the time_expr_ns (but only on platforms without an event based wait).

So, we'll end up with similar issues inside this
__smp_cond_load_relaxed_timeout().


Ankur

> -- David
>
>
>> >> +               __count = 0;                                    \
>> >> +       }                                                       \
>> >> +       (typeof(*(ptr)))VAL;                                    \
>> >> +})
>> >> +#endif
>> >>
>> >> Thanks
>> >>
>> >> --
>> >> ankur
>> >>
>>
>>
>> --
>> ankur
>>


--
ankur
