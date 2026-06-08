Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3739EF2B;
	Mon,  8 Jun 2026 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905929; cv=fail; b=a6BY4mDWaDNO5m8TezyzlB5IO27iCypOWR8oUZg7h4JxJcEckooK90Ymm4Zgr+Ni4Ien2BMjWIXYH3QYP5qd7Q0CXfqP9n5dKv7qLBBRx06MXTXTGJ0xVzM0yxMRii0ZDTBzhVzpBJyqgwfze5yLzZ9bLFmipizSQ9UO2Hv6sag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905929; c=relaxed/simple;
	bh=O+wNl06gsVkIlkv/n7iX+JO0NqSOmZLLixDGwaow40E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q45866h8mq6au7lXYLfH/NA7c3G16+B+lJ6v+ZPnmug8k+LDgOPfACxx753gMPVkkmeyb6/PlY+7JtAHh/WREfBvc0ZhhjkcTgqqWvvpZlZUpqAn2JXHtA5C9NWRE4ND18lv4FnbAJYaryOb2BZb45EQD5gVOqn2BHH3sdHzOHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LJsgOLGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tRprvFfN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJsgOLGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tRprvFfN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NhEFP3923557;
	Mon, 8 Jun 2026 08:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TbOIip8+SAoTVVtZN5aNRZqLtnrEvE/UsdvP9I12MeM=; b=
	LJsgOLGQK3pbUg21VpAntRPVyw1+q0Jw7U6JlCAovp6Z4hRUiaDWb3Ifw1qfQawi
	iGOhaVBqVCd5Bd2XrVcj8Zg72Fnel/XcDVGjMak9Si7WWemMJBE/7Z7r1x5StO0d
	JSu9W5/96L90gWpFJzUXLa95T6aUs0xiA6gMIWre/h8nll1YcRhJTor/nzZS4nkx
	gTakvE3bYXLeIqLi9gYizv0lcYQykDegaONxpvSto9qQXsX3019FSkFzCxibQeHu
	xLgciFhBH4vr93ju61sy1yDH89Ap05jT1HuIRA6HlWqk58pjn6ipDPVEQiTEzKbE
	NltOn4UYDDr+zR4plI6UYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5st0f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wT0G020263;
	Mon, 8 Jun 2026 08:05:00 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0ngqvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDEBL9MT1CZ0alRcDAULHf3PpDA+jzJ9aAQHK5wsHaIF7b/QMoqOWdJ49qGv8ZAr6lm/9iHgREeBFFauuYjqHVbfnj7fnbvquFJBwFryj2o6ISzjaThHzV09Hw0mXcswrayuVsmu2T34NzCIEGWwgVISXILbg55wZHenWiTnU5lOMqo8yP6XdZtVrxrqAQbtW6hda1uInhgLsG3P2eG/lNQvKWEvRvMlKxrzb9nTHLeSjk4gmASWFAvQw+qhJXGuZ3IWrqtDlfkaVWD1QIETUe01oI9jMS0UwppROL438TjSi2TjVnrrVVvN+oZaz/uhyBGxeZOn9Tqigiionw9fgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbOIip8+SAoTVVtZN5aNRZqLtnrEvE/UsdvP9I12MeM=;
 b=S2k+At6JHk72YtrQFaTw0PeF/Z9OlQRy0+njJrUW7/JdiHib8ikqEI79sbipVVWZSi2NhZviGNvCDn3YcfninZr5Cg550o20gnJwzJrPzc7mphA37tVC9KKwcW/Uh1notBGIEdVHSDfsEqzmvVdMxo4bk8zER+BLhaCdRqqt6F6gQZ6Qf7L9F90lgnmMnSAmjlKNxBvp8JbuprN+PwJEQ5mgkFZsCCM5y7blCI+9jTq4mxIhxmbdPLp5XLZrfjjl8oW0t+ypn+pnAEOxrwx8ZeyYncjE/hkk9Y6LfAOh86ctKSWwXqMh7KmdXI5Fsi5wDbZ2QVAWYIUY5MsMFtVWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbOIip8+SAoTVVtZN5aNRZqLtnrEvE/UsdvP9I12MeM=;
 b=tRprvFfNAguzW2FzQgzkdZPFFLXGOZkHY4v94DEkXQxuRKAGma/QdqOz7XSL/4TV4jUu4ijALcfJZ4rRxxVn+imog51XsyFrQexjGe+qWku0R1TqAMOyG94UfX55Eg7rnzDnr8qWqQNpis1eAfi0Fuck981lLJmTRNyl9a/7GGQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:04:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:04:57 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v12 06/15] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Mon,  8 Jun 2026 01:04:31 -0700
Message-Id: <20260608080440.127491-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bbeb3c-8f28-4436-ef56-08dec534a183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	NbV4WzZWQhW4mvcKtUiPC6oH3BfXYM2ihJAWGsNO18MfjiYYclLyOaDUX+yNb53+OKxi3+2zt852ZOTlDczTf4VTpB6LwFqkxmdl7bCBzKwRuXkXCBaKEJBUvCzswIwtbGu4cBIkvfj9eNu/OAfqWfRGdBNe9qC9FwtWoEm9tt27BGTbZvXeBwn40tsbhg9vcNmh1rxqxay3RwlLdQOE9ULSXAaoM0QUZ798TDH7U2FGfJdq89p/PjGSmxlQ/5spX0GhxyOQMfUydd3/5jEE51AfYmsJQjMCzMiKyUJj9BQzPO4lfL9iHupuACyW+u++OEuXKQmwg191PpS1JHgGqbunbrVOtz10UFOwY6RWnx5uBDARX+oDtANKKrcbE8mIS/H7G/6kUWKrhBqmbXYL3RmPvTBFyxfHj3jgcf1Xl9mA6C/U+U+bW/IaPDAlfubM5ITiY6lQUNqpMGJEY7dQ+DPnoM/GcdA8gmgd/N+PTmfs4WfN1wmCQ4Kv7kcaFmalxk4pEIdhStiN4GP3xxAIBcg9J6bBeTbvVg09qdyOn777+FQ0vBmOG2GsPGJBilc2R7BJUNkZgLd7Np3l14CctF7/JmYIgjdVZmIGblunYWxQ2TS9dvsoxfZezo0JDpi2DNKbMkq2FJnVfgrNVAHbgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VDxY1i8A/Dyqhc66uvEui1DSZznneVaM5CQBST+Wd7yM0b8Dfecfy3pOWjYn?=
 =?us-ascii?Q?f8Zb8vwRi1JGk5Eg3C3X39Yw1wvglB0rp5/98G+zy3gzthtBbkWiMThblTsD?=
 =?us-ascii?Q?ZPcKodJ5+55gEv0geI0WogagBCiZELmePKNvsA+AokZ9EOjiJsBdRnZWU97E?=
 =?us-ascii?Q?ztHTeFa7f4srSTrdKB+rheY7Zzx9W7QLnlO6bVq6gJ7RLCRFQawUcCgIO8D+?=
 =?us-ascii?Q?lfxqtePjRAlDco5+2ZAHHVwQrMk2ExMK4rXP3/xp9f/JsvV8pI65lpswATNz?=
 =?us-ascii?Q?j1QwskgEtyDKixpG1dQixlOPLLK7AmzuqwAZJz8DH6AMTajgz9kEPh0hEEOu?=
 =?us-ascii?Q?oqoLKneDa10kJnFKx3fJkruj9+XaGXSGwDvDPxbeJZ5LZ40wEdTirXQwIV5s?=
 =?us-ascii?Q?MwTxTLr4OHWPxN917Jx0v8WyA/XS0Zc+usYebL37EhOtjqbT8xZqRaeZlSQV?=
 =?us-ascii?Q?8mbKVVMYijhspBhA1Ovj9O1vGZfTDgDxFRKQCaCQazLhzlDK+sWks1JURdYg?=
 =?us-ascii?Q?FbGLx/on6Alp9m8oXpLAEGjLJ0paPX4ohaAKoDWLeHmKyVJJC0sTHiR054gr?=
 =?us-ascii?Q?WXrdPSpNQGWZ0uGcfUFF1Gf8cozznlfoss8PGwmJhXuJZQyOABvUwlUddmA2?=
 =?us-ascii?Q?s8k9sMfV5yyHXAzqanvDMN7r1eaCFwG62L2HlEt40KKPfu9ZBsHGH5ZBWUOH?=
 =?us-ascii?Q?IXmCAhwaoXy1HC0dqS7GSKy5NN1OoV9567YoM48WORnW4uv8hAy7TSvuNQw8?=
 =?us-ascii?Q?OraTBJUUyvL8vqgmD9nLrPGC3KeDPW595m3A34JQxfejeP3npz/2kbcWzwAa?=
 =?us-ascii?Q?L+SOnkx9XM8lzxRut9lzivc/E/pfzdyUMoPIN3LPFSpSe/hMmmYdbmWtLTnz?=
 =?us-ascii?Q?CRDrNdsT0Viw8sGKEqw1jFxge9wbVdex/vEJyIGJNZ4aZ+CLh+8/6eD7NNGm?=
 =?us-ascii?Q?JCJRZTPljOxOLuiB+9uFMh1TIdlRemJg2A27rApOq2VA26GGxionGx9hqDDV?=
 =?us-ascii?Q?Jk2QoqZIyA65sQmpMSTUaQTGOsEZkgQZzDQoeKC/eRmHhb0p5VeuCxpEFpWa?=
 =?us-ascii?Q?xYxUYxoRtNja1zQ9ztX+aYQouFyzPXmaAyEVpugPE4P06IYlSBQzCKhkCdkO?=
 =?us-ascii?Q?UBTNMYxWDCFf6MdQ3NGqLrs5f3g6QRMRMKoZN6rVacViCwTdLUJ2Uj3sKVCY?=
 =?us-ascii?Q?6Y0VvbYNSZvyqAcWcPqR1kRFkwSvoBEc36jN+g+sc7BPtuAG4KNU1FcXdyID?=
 =?us-ascii?Q?QhqHG6aynA/zPtrXwRm7kHGQsb467pJPGhbB3kFZJiqwZQD+NEt2+qQ0r023?=
 =?us-ascii?Q?C5CH7bIuhlVfQCm79FqpELzJHHV3u5Y8ygtoYAKSvisHhnbJLwnksa78Zu3i?=
 =?us-ascii?Q?1LUkk6nr6tQV8FJS1oYcWSvGZ2lE6ZiG6DC7iQXnmvDI90GZnplBfqoAQghh?=
 =?us-ascii?Q?bBSFh91XSrbTwjUpwlMUdsrNWtTty5NQ6wcV/v6bX0rF3R/CzIp8Nb4nqzA8?=
 =?us-ascii?Q?rUDHOe+/b0ePoHlIfp4a97b+Ho5i4rI2N+DYNXst2yYR1zSolL1qXVK/JIO2?=
 =?us-ascii?Q?SiYJBoK22BqRBGOxV8KeFJCp+ag0RB+Ki7jUssEwypMGcabITXZFG/qhtUIV?=
 =?us-ascii?Q?zRfwd74vPXVAqBgfp+RYBLfiypeYjY9dTixL0Em0IniFQurr/zWQBDB4hLHU?=
 =?us-ascii?Q?XXfMGDTrBgiqzl+vvAmBA6DOLHBPvjJfhsuB4EBgpUIVJ5tBHpWDRYjo56IH?=
 =?us-ascii?Q?C/WfngmF7A=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	V1Bqj4YB/IQjtf2KXlWixaUsX2ZJ+1E9f0tWxsR1Zi2SmQF48SewIo+RgFVtKlPaaH36l7a9yOcn/cIw9Yg39z69KCZr3Scdoo9+hknX0R+7EtKr42Sw8ekXYQ0aI+71FEXFsGGniw0gdrOGYC5POBXgbeaXqfWJHRvLrDOGgHpBBq9XSWS0jGnVoFl8bzqimiYIuVN2v0MSU/PpSkWncO3cMrXbcXXaT/F3FnEuL/s2g/VhCo7cuXoaIpLJXjeYu8l26LsR6dazLg8uBZXZsyXoS+Mvc292PRkveIQf3PhPP6lIwt+v4FaonV8lvk6ZXIDtYzlFdst2ZejT96mSRg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MiRas3YiIT6+DYSWqR7xrRPmEupsrRr47xHcH9m6dIFPHzuKEBq8i6aRQJSfXoPa2jq3Gs5mYzUepRhod01Nebg+dkx7BW9RKm9Ivq16U/ALuYmqZdWGeOcjhbJ6qJ6TebUNL0iVH/2P1mqrmOcX26/DLcP3fu8dyTqzVcC2Ou/CxWnkyAUxBLC1uN3LPuFxl7y6rJMB7BdlvNEVLY1DKU3iHpghS45NA4ymDApS+JZwp0sOtnDI0IehRlG3EFAZEH0tTYacwjg0rM87htJHNJYP9F+jYcd9D5oAZJ6bdUdk2ojLrwjE/zeWCJgMmZDgyCh7DrXeDkSW/L5ox6wWQBdBbSf5ftKzZbfV2tg4g022p2Et3HfLgYhxB0/Zn65jWUffFm1uKethmBEl+Vq7dAspMblS8E3vZggtFC+QqYlj7rLHd6ty0ZJHguNYTVnxH8h6yyZXSnFz3Xg7nefPVQhqfB3+yC1k8ca8GWBxtbRYRwI4CU4Nfjvs2X9TLPSiapUvPG27OqyCz2ZxwJFVyZ7OZxFu0ur2wbFsYTVXLqrGbTi+Xw27l4n7A6diJATFvVUVNMkP5RvceTg/J5djadebKdeEOWzj2Bt2pEC5XSc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bbeb3c-8f28-4436-ef56-08dec534a183
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:57.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEgP3iZnbsTAUG4v8/LNlLq1QeEWqKMoCDJ/bnKR3KcW5o8GlMiAZIKiJd8BTQilWYAZERRCi7LpiO5nNm76uvexUb3ZnZRiYshbA6+yZE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX7yLvVtAHG8Iv
 89AbYV3S2VXqUNBYb0zItbC5r5Rt2gACSxh9GciJqszQh/HhrVBJZfKILDqwOBHdPchmfT9xiwP
 B2NLpTswjeW3ZZ7Z8pFuPKLTVbeR4wABip4A4eYrs/BtGI2mwj4OYobpa7S+ZQuNK5Fnhjh5hJj
 YB8l20QdKyG0vskfWS1DEgC3oMjPmtf6qrCcyxmIOtrB0kdAmiqlYHQdoehC/2B+Axgg3uxQS3K
 0NwywmSUvzJeq2QakmyRPOyo32m9oMnaeyoDH3yr5IYdeiV8LBxVaOlOyzBc8mjcWRIZX760nRd
 twULbDvXWxudPnQIyelcUnhSh/Gi79pN+1Mh5trdtn1nkTLwkrkfPG/oypW4f2DI82VSSc3GxWG
 myQVekUq98jeTEb80Vj+Hhh5C7f+ZzCC0P7V+oc1kNSIaD7mMXOnQwRSDUzpHo1vEMAMkxgvtJl
 8o3MZ6D5AB9ZTQuibrAn8fQ01aMWIOyHSulU1nTk=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2677ad b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=c92rfblmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=2JwLO8b5TkYCcQbzNysA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: qZtUqDzjnxtzxH9TwSmZ_CWbhRkKPzGA
X-Proofpoint-GUID: qZtUqDzjnxtzxH9TwSmZ_CWbhRkKPzGA

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with additional LOAD->LOAD ordering
via smp_acquire__after_ctrl_dep().

To ensure that the necessary control dependency on the dereference
of @ptr exists (which does not in the timeout path), introduce
an empty evaluation of the cond_expr branch.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:

Sashiko notes [1] that there's a missed control dependency in the
timeout path. Fix that by forcing evaluation of the cond_expr branch.

Catalin, Haris: I've kept your R-by on this. Please let me know if
you aren't okay with this change.

[1] https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora%40oracle.com
---
 include/asm-generic/barrier.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index c56df9513a08..0ab26e98842c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -342,6 +342,34 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	if (cond_expr)							\
+		barrier();						\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1

