Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63318DB35;
	Fri, 24 Apr 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054627; cv=fail; b=u/eVRMc2Ao7dlU9jmFWjKEBUIMvgGAshHYZ3f97dNZer3ebScd3C/zdrm6ClLh7JQnmAbUkyQtM7o0tt7CrjarY17qaTGQT10htMs0ftFfPkj0FHM+B9/9aafAEwK1bnE70M+bSR1KatW/AKM0KjcJQIUC0qSJw6hck3a3BMMVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054627; c=relaxed/simple;
	bh=Paw196VP3ZYW594UxqymhgEtre47kn/v2H88OhqadA8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=PTlQ6U77f+cMarGLT+fBey+oWADaUlUnaDaKZ3ItSb0HireplWWcQVzdzJ6Rc1qZou1jYGB5L+KLYZ2cHi6riTVSs14u/0q7ANaahTdOsUcYq+WMFsBEMQfDyA6QAgL/0/mQckeibxu4utOCCGcexSa68TZr+oAo2wg58JG77ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozxHckou; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FwAeb5lt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozxHckou";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FwAeb5lt"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O6x0Ng3560474;
	Fri, 24 Apr 2026 18:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oJ5tqAIU6eAz/UD4HG
	OOyobd/7UFXtNfn5YwQmJTYJI=; b=ozxHckouqOE3vPDso5hYm0zhmoAJX3YYuv
	CtsA4ypks25uY5OOR+SiWWqe8ioXNlbQKLDjk9fAznRmdZgtyeQ/E6j6E8Mh5ZCs
	pa18hS2zkqg5rbosHFKcmP74T+ii3lTgunhQkqXPqDFvEteKyRBRT7IqeqmjY3xN
	FmZeZ4F5X61SSYxllLnevL/VzNze49pigo+tIoG/gKH5m94PArWLUk+/sjNmgA1u
	Sb5ivVSWAXZw7uslbwuGiNBf3+meSEAbF0QNzmhomUMmsWlx3inUjgvHnxnA8pQu
	FgZ8uWwSLAJt5ZG7h90GHeriruX15AnCy6wC3WEz/RVRhyilj9uQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenmx4nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 18:11:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63OIBKg7002038;
	Fri, 24 Apr 2026 18:11:27 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjhkqff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 18:11:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Ni4iA+ibvmucaHZW7sLIXt9dchbaOwekou0fRvwr9+DQUXrtLBlYOaGCTh4wKA6RDIU5LXRW0kOdOJiCxHYGpUjmOGi45/caWDBm7YmHJ/sTjlyprrKn54qgzW1A83v/PTDr/bz6h7mO6DZuPxl/ZkNP2Gbx7Z1+IE5JFxGEToKwBv8WCUTO24qFBVP2tqvogeGbGwG3vkAeqxjubQ4TpfHSM0DDgXM8NVQMjgS0xL9WULtvLmQFDTDfatJysk4B35TlAtgOIOGYEqiyQ0JYN7KPHvGH2EWh2gR2Vc9aV5rvekoMx98KCe87kFtD4tL6Bd9R04T0jnKsaKErIFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ5tqAIU6eAz/UD4HGOOyobd/7UFXtNfn5YwQmJTYJI=;
 b=oATjT0CiTxS/NnqE2n3THKDirOfqzOYYMUa+JXs1shernB0mvskBd5BmBII6QbVtdb5l80OuOPXwlOPAkGI9r3Y1KyHrinem4tlOdeKLxHHmG/eAkLhHJ5RgRVSxOjF/DF7muXd4u1D6K6eIwPfES4bOlSLIq3pP4mlgx0QdyiOOukcf2ikRjAuanlP60tAs4kzDYk3NMOa14eIr620xqx//FxCsfZt+vJyNLG+h3iZyKfSLg+rjEBGhnyTKOLM/wpnmWPoIxKsKxqVjPYOO2yywZL/wqzq5HX6GQuihKX5aJciRSc02Cd02dhsPeCIyU7oZ6VvXWViTplXT0btU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ5tqAIU6eAz/UD4HGOOyobd/7UFXtNfn5YwQmJTYJI=;
 b=FwAeb5ltQGFTtIIRXLvdPSNVY8oBEWZx4VIv4HTtx4VSyaYT8vRRFQU1iHrm4Q9nNAvViH0WvlIvY8WF5H1HKO+9EmOdnQp2w0UGrkQi4pRbs5reusglP6vUcdM75o5mJ3mo615m8W/NEDaZOtxq+u9fgwbv9GyUv7hvzaQXg2A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 18:10:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 18:10:47 +0000
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260424072845.5eba94c2d732204f143b8629@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 00/14] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260424072845.5eba94c2d732204f143b8629@linux-foundation.org>
Date: Fri, 24 Apr 2026 11:10:45 -0700
Message-ID: <877bpwns9m.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcc9cf0-00fb-46e5-6ad7-08dea22ccf6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	KkJ+uMxgsZxa8koqOphTQOOcCh/r4AN6ayXx7Y+/wjGuxmbtLwDCXEkLAdtNEnqBkaoc8yjWRZP+HixqU/BhWKdXQpQ/tZcFg05frT/o3ubYzPC7jstSeaiRfuD98i4Ro2j9nDRB1MlR6GtBghZhlmoQgYzaPwl+EPgxzTl908d7ijntb/lsJctVGGOflNqSC8Q4f6QnN6ayJ/+To3KwOaIaPKEz9ynenAxK+CRiLSAsL/7VQ271AgBZvi+7nKj3eNolk8UhJ8TkQBcmP+Wu6tB8PLRuEJeBKhJDFS8SZDI3i6fIX7qsIJOBRriIgqHKR4UmgIWSwWVXWoApC/o1Nx7zZB/QvEnlA/VQvJ8+2FxRgsqhGxqMAt2vAIJjarwG83RnGBxZh7ZH5vLL469unrNWIQJ7L0+SAAVe7iF6AUL6ZUk2XnIR8Qahl+0VaAGzO22K1V9VHn7MCmCGlinuSicUqYRp16CEVQy0VzlHyzNTYuh0KbaJLkpGIEDsb5WUqxWlzGemXn3K7UgfAvXjixczgBJKAESOtZwLEE5mvENJogssP9uemCkIJoN32FVBvAkiJjLIzrauwK2fH0DHJBXelggYtpgWCCIwYjGSmWkNUyNdPLPJD9+ToWFvs3Y0CdrdMMFM+RzkRV4ZLyhrdDUjlNAM7v8kDekYeNnbRstjKALDReThyGORSK1Kc3Iy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(11006099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBBOpG70ppIaIyBC4YED8WfX2avb0+DGmKFSWzJXWXvqBS2OU54xBCJqo7n2?=
 =?us-ascii?Q?MgAUlDz/mY+9jb4f/dPwlZvZ1d8EmbWeSYwEtf661i1Wbcx0woJX9qniJn/q?=
 =?us-ascii?Q?3cVI9mJaXZiqbqoc/Mb+5VCjZ01Vgp//0mwfnfZhvZTcToZaNCw/xfYL88lw?=
 =?us-ascii?Q?0VMvtEQ4x1wjUH3CDQViCCqHJP5s+7zUzl9exMP32UuZ4BfmpQL+EpJf9yIb?=
 =?us-ascii?Q?8jWSPiwuz25xJZy6QRjwb3CpgFZDQb+knpTpNoW91X7/ZEQqjtUsvpzbKfFk?=
 =?us-ascii?Q?+xp70ikCBgmbsbp2rf1wGj2/0hYaK+xWDAKDjWz5UPbkJsGBhFK59/6//Tnc?=
 =?us-ascii?Q?WEbp46CXtsuB/pKZUJu8IT6QgD3MmDwh+FWP/7TlJe50JGho7LAoZHXGBFfP?=
 =?us-ascii?Q?fgFatlk0xuxq+xSa7B+C8Fhp4tVhhfQvvT7U3zHkKbQvpOXHWyR5nO/OktJN?=
 =?us-ascii?Q?sR12nEgQ1Z2LtvdfWoLyedCPZMvXwZRvCYrtfGiWHSQVfX8MF2NmW9G8ElH3?=
 =?us-ascii?Q?81JfkDDHJsN1XjAQCbsoR9+AWOvEqj8/S1ZvS5kctHmzAarCGRJFQGbbG3KH?=
 =?us-ascii?Q?eYSOyhPZA9If5vqgEXFLcZ2Oprpiumi2p78KRwdxi0EJ+QVaxB1E9W+a1R/x?=
 =?us-ascii?Q?tMzp7e/NOmCQRoovVunAVL5QpU3u8l26Z5vhRwVs9LHWdfTx69FOP2KIu0Mt?=
 =?us-ascii?Q?vfU6Wfwsbtv4/Lejmkui2uxYagBxR5umtB4LEJOpjpL9CmdYgxBgJfbQA+eX?=
 =?us-ascii?Q?XTydeR/uL4GeKfyE6Se7qEB+nBwhHqmLYGI/jRv7t4EVC6Q545CF5ZRkEkqj?=
 =?us-ascii?Q?wwSqlgtm00mtRtM0SO8pZJaA7v28RMyOSnaEo7bO6aXzIe+Nr+R1zVY8jsOr?=
 =?us-ascii?Q?pIpohK30s7vu0LIQdoFEno7Ong7Smetq8AvNuvM0zfLk1PKgOBQx6glp/hJX?=
 =?us-ascii?Q?oG/f4IAP3paOmLOncpHruRVLY981LyaNjdEYKJFzNQZlKrEZhgY/NHWHEVZT?=
 =?us-ascii?Q?D4T73YeeHD3qkkCxmjKCQ1h2FSwLqfm+CGIw5H3j3gcM0Xy6r8BYi9tkbYjE?=
 =?us-ascii?Q?DvCxZsZxGeg4iWB1mU7xWuPsUgJTRiyXOgP38Y+yg2YxE79Q90DiQkXapSPN?=
 =?us-ascii?Q?e9vEFJWnzPn06Xw2EX2uNQs6xZra50lOfgFIqN4pViNnqMGMdur9zPRWEeyf?=
 =?us-ascii?Q?pOQCOz/srXRIlrqWND1MyxHliQa80SPo24dGlj9Jz2cwebD31g7N03BgPM6i?=
 =?us-ascii?Q?2lJC52LM9hsVFqJMdRh0GCPByfK+c7V22haZb7R1FmzBv80MTJU1gIERr4mk?=
 =?us-ascii?Q?8L5KVMzmThMmSVYTI1H3wgLQuONDPsRihc1XLY7fPA8lhtfdajBESI2ijKUK?=
 =?us-ascii?Q?EvMJD4Yiu2Z46Y71D4IJnKe+1cJtf7/Izc9MEyc3GW0fD+SnA7dxRmIUyjUQ?=
 =?us-ascii?Q?S2PcSDlncr1PRcTmIWpSr6ileQosGeAKkvav0PkO/Alo5Shh5lQIybZmwRCC?=
 =?us-ascii?Q?YPyKWQdzBloM1qGE6JQWal+JYOX1z6+oaugXa8DubvxdH6XAKV/XsUPED5yp?=
 =?us-ascii?Q?xrGR1SdOupo21oJn1ZK12qeS7ON2eeW8yH+BhfutB8xsmC8q1oMMVShah9YL?=
 =?us-ascii?Q?hAAGcNk2lvKFeVa9Z7YM0QAYHify6Om+jQdgmUpkZh11ltKLt2NdG/krqOuT?=
 =?us-ascii?Q?FmWKdLVGueAsxKd2ktwvSs5yprfoQGqLeMNJf2PZ9Q+pro1urd5e8WSsmcjZ?=
 =?us-ascii?Q?Q6wbKuwgupirW/hNXG0w6leS6VlkREI=3D?=
X-Exchange-RoutingPolicyChecked:
	EI4QTcopfvNgwuyftv2ArEUPXIt6qTJQBSZY920GmjDXRapyioshrAD9r6cpwolEau3DxKgxxJVxDuYAPVKmXOb5Ov/MVhH7YlKgSDrcqDMVzgR4By1TQW7Wg0fgfPsVhHLDiQHWd3SgHKk8iaRsIWP5Sf/FVm2DQ/+9h+weQLCsrN6y3Hyw/i24FgENEgNfQvwnw+iaLrsgkZOMEHkpTtZvHhe5uS++KotHAL+fzjsBxL0BlKUghR8cTGK2951XF7jQH6ZdIc4bruSSNVBDZ5C37S5pJPdcvYwIs25h1aV+UA+tZ/L1Jtms3xKayBkm4Tq1v80Ny/FScBGw4oy7Cw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xCQ6E81LNmmR4Lsp5iWj99EAJMAaWW6Z5/QF2IZe+xWa+NiENYNI3MD/dwtmItQ4Whma3Er4DFGh+udLTrcc9qGwydXnZwAagIaOPalnm76vKmsiNjiDxCs9jQOTMn1vLhOl3vf7bM4ld6X2jgn1VhMmIymhiP+Y5GrhhoYs99eRuplGjjUUcnivLvgDPLDMyeNIYJpRkNlondXb1Ot/eFMIeyvG5lQ9Zpza7q6wiV8JU82Oy2kE7z5juy1UxrxZGr85YW0oLnoaWxT6ycZMc2QR2upGNaMEdu1zL3ed/56q0+VaBniJ7FaZU4y9eqFAZ7U584Pr8UP+IGanR0j5K0ad3ftEIuV8BZf4XjEiHNqlHgDJhTUVC7HNFnUq2zXk1i+jcMES6NXUUd5L1TgrOZbWVcTJZhFoubqKL1r6olgiRzeAKNfZqTE0yqFTM29KXO/IXF2MyJDwyL7pPN3JqdLK8r/tRM92m+CIQhKQQS+INEWBCMbsjcpRzO4iNJpbg3csFUFJytp8z5WzWQo2sFHQ9rCpAbX6SqJTJA7duifHMmWCjBWJfnO2xKjfaKIPXWtvc84AnmR/BaPderTYTQniqsQZM8BCZpXYpDAQmio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcc9cf0-00fb-46e5-6ad7-08dea22ccf6d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 18:10:47.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYY1tvrr4y9J3cTN7oUYIMLXKz42Pix/Z6oHVluBE08is7C5prXsvSv9/its3nAE1OrqQRiic+4ncBjdBYtYwxgDqld3CMMAhsKyGQYEINk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604240177
X-Proofpoint-GUID: uypvF6rMPQjQwGS5MvTIMZBFZ8zQprjB
X-Authority-Analysis: v=2.4 cv=Z6/c2nRA c=1 sm=1 tr=0 ts=69ebb24f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=c92rfblmAAAA:8 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8
 a=cMS0faxKSLiuJPRkHcQA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: uypvF6rMPQjQwGS5MvTIMZBFZ8zQprjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NyBTYWx0ZWRfX7IJJm8cRuaiU
 NIwb6XdSVRBHPY/zWjDPW9fWrcS7p+9GTBrhYLJjX4C1Fg4LqIOubcJauk3YRZo4b3UjM7aEoNL
 oX8oVc206yaAehVqA0p44J3yISSyXVOwkz36f2l/sNLLYQlWtcOUFJFbshkLCTzQUGDgRSYNnmp
 DSzTTp1/5+anJXQRhW1w61jy1VlTlNRmPeWJf+3egmYWnYd9YJkrdRIwm371gxSChJvG37VOdcI
 Yrfaz6RRqOmNPmo9TzkVsAaut/yX2geXZ71BSlOqRi/fva8uadYDovAWE9UlTVMUkPB2I/c+Oal
 I7a6SHOtIQy8FdBaZFdE5ZicYU/rACpUVrftWpd/ngZhLh5V2hodZl1J7OTyqGL1j+yelo7a08p
 kdpjQ9Glq5uZVz1xp6p+tFMeXFessaGgEHgIu1eaGHzltYkDyoJcrPDP8Ky+uYbmm0ZrO3dWo8n
 GLeO612m62cDVLU8z8Q==


Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed,  8 Apr 2026 17:55:24 +0530 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
>> on condition variables with architectural primitives used to avoid
>> hammering the relevant cachelines.
>>
>> ...
>>
>> Accordingly add two interfaces (with their generic and arm64 specific
>> implementations):
>>
>>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>>
>> Also add tif_need_resched_relaxed_wait() which wraps the polling
>> pattern and its scheduler specific details in poll_idle().
>> In addition add atomic_cond_read_*_timeout(),
>> atomic64_cond_read_*_timeout(), and atomic_long wrappers.
>
> AI review has been busy:
> 	https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora@oracle.com

Quite busy. Thanks for flagging them.

From a quick look most seemed largely benign but let me go through them
in more detail.

--
ankur
