Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055125B0BD;
	Tue, 14 Jul 2026 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014581; cv=fail; b=NQhtHn+4Dg2m5vnba5KEATYA2BwtlzkBOoN3faTzVY+TfaU+Fuwn508hhBnGisDtWEn/nE/G1rdNuZRH6n7261g6Wt9nxNGkHMGAuF/g1DkIskC65FFpKL89M6REy8jn46TCcsJ4oZpLgdNPphSBCs/TrF1jje9JibIfNZeoexk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014581; c=relaxed/simple;
	bh=yQ1UcSEIYOjH7tFW8ZPPYYbtW5BHAhtUm5x9ryFFvPE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ETzbbhdK6wcH+11RtuNMbra2x4B33FB6un3tHVYYsx1tHe8keG+PR4ANIyqXUK+iG8MiytNzVtZPbj7JA6erSGJhWr1cNTscEEbQvyxjVwPjtB//IgyySAGQHj3jyuHjlfEOhHobZJ4JoS6xCdT8Q+6DUlm4vYcU+smdrCD3SPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nIvSzNe9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z2hMAHz8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIvSzNe9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z2hMAHz8"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E0Efvr2662519;
	Tue, 14 Jul 2026 07:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=98Cg3nXNlC2ybTSR
	SOjouswiX2rFPkhywLyUb/1vVSU=; b=nIvSzNe9YrPWfHO1NBNmxM/OuoVqBrpT
	9DSBmlOC72jbrFVyED47IykRzpg2sef164nD4AaVOfIqzYk96V680gvFXyDxQdOG
	3X2LC1qSjo8LLErqddnR5SkUggSFGIAjjUmRYMtMWvlUgrlB4pR27PDA7Np/Kyix
	4TZ3TX7dchgYv/eABLicUEoRWLmnzv8GymIEDAuZOIW1bjsvtfgR396sjAEt3t1i
	o1/QDixwwdtR4S3KYwbtInC65ceeLKUaqAVIqLI/q+r0raxwcwbW1Ire5MA4WzoK
	jKmC8zd1+oLi2BQyVoAHKt/Q4yfxAWgoxVcPk9rdv+O+Q73npyOfmA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed83nbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:30:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7ScE3028669;
	Tue, 14 Jul 2026 07:30:48 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9r4g0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:30:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVHFSpJG13yaY6U1OVVaC5fOiWIZG/qmA5jX4ykcpAZKXZgYh+P6kbX2aKjnVPfLRjmMKnup+oYZU1RuF1Mvh5SqnEmoKg1m3NAbHqhhTz8R6nEw3+4LQBkCnQfkwEbrD+mkLY/pnpNZXtDSps0X20XwiPKytO+T7mGDHEf1fyUlmNTxzJ9FctzVaFDKHl5NIA4649Ob9yFUJWavNETrbEi3CWcCf3hM9RDy2GYrgd4nPZmaoya7G/6tEnI/VKTSV5HOzKU85EYsuoQxYxmlJ8kX38KuZJswuwhyPviWa2brD0m6d3E/kPVw5EP0Dbd+vFz+Q6X904LsMfSDFdZFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98Cg3nXNlC2ybTSRSOjouswiX2rFPkhywLyUb/1vVSU=;
 b=tYlZCZZ5ul8keQyJ7YPkHFR4sVHXGTL7NAhrOT2owYkvAFeN6P8j7fcNcpVoQotdC0d5IIzgt4i2M8GHVvWX/oUvJxb0ZtZ72YmELAT2uaPjDvlVGU11BJ9qwX4zrVE6KRBDlBaCzFFibx9NTOCG9VcI6/l8Gq3SRc8tNM7Uwc9t+u09BRhk1e3czXvuwWuvwCrKmHLxywj+eJKOa1rdKyM8k42E0wALlwXacMJ4bv/i9RRj6Nttja8gHA5H0pwXLdw7/AEVzVwVpXxlqq6wH6jgS5Ti6eZGb5DZQHzzXqN6rdDOQ0pbVCEEoRiJ23UewA9RGRpfic+yU4fneYEMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98Cg3nXNlC2ybTSRSOjouswiX2rFPkhywLyUb/1vVSU=;
 b=z2hMAHz8NloUo2HjTrayHUawh/FM4tYkDNwEJKbmJuRYf6uXjPOwAwSReyC/dHPhYfvm/JEHH6+xiaL53rz+49Vt8l0Gf9GaHqKBurDXaqrlIhbaGn7FmPy+sOpfDA19vwPPFOFh6JP8zchk4lbthI2EgJyo0LdP0K4SdnoMPx4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:30:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:30:43 +0000
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
Subject: [PATCH v14 00/15] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Tue, 14 Jul 2026 00:30:26 -0700
Message-Id: <20260714073041.40250-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: ef248941-bb8c-4fe4-5f99-08dee179d044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|13003099007|6133799003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	XMH1CckJadCZI/YclowwlhR8gscZcvRjkKM8D/7uprOal1wGK0WBb2tvThiro60Nap25yqsi6wqU1Et+rC9tfIN0EW5krkg+jas6K0o+yMDK+zBtsPTgR+ETwj75E+f+GemsVcPBSplzJyTBK6l+KKfHUtnsTvZz8xBGsAwpLMNmOtzYOaiEtn6hDuU/YtrMMj625X3cccJNwy413Sh4gsJAVHSoFD/5Qt/byOXyuUtHnAddfpCgP8arX+1fpI0aI5bBWFsx3qGkLD+C/wjh5iaukz2XjRFhD4SJgtFu0MWZa/SmR5cmrT2fho5d4NXtHd4hV2YMjLH1NR4Jd7uiu39fWibS1gmQOpjdh1CKfqK0rTDy24p/gbJVntQH1FXENhS4VJHxBH2zhZr231xW8GA2WaCWnOoT0qDgAAqnoZ4X9vlkHHKZ1crbEsu1DZCt65eLuD7gtZTm1UGcYBGqeoL6RxeJu2SXnhAFCzEzaKnMF+z3zYBtKBQUIsGEUIYFPzw7IRBDgwq9Vf34WNXcMkTSS0kvyjfrFY00H6l7DCEwgWwFdLW1Cppkv5orc746TULjfuLQeFT3kPlmAiilRyNs2Gpunw7UNGVqe+DkOieibNlB1GKZpoauZYBS4xMz/t/wVs5pDLcbLbQILGHOHKyVq2z2PuoXeIL//y1PZz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(13003099007)(6133799003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZmlnlOB19ZaA03ILRbfbBi6JLUmDCLIByr7PMTVH/7ILYkbK3fxR7xp+/fe+?=
 =?us-ascii?Q?Q2WXKjwWHJ6Idt6ns1LbpktPgvMI0pcgeD1H82DDjmrGbGul8iUFQ3uVk2lf?=
 =?us-ascii?Q?6gG/tdSPDv3AplMu3UzNO1vdf16JhceTK8zLNQrc21AsGUyD0kD7psZLUZ/s?=
 =?us-ascii?Q?3aEmckGz/B0FU7fsRIoe6jsGHk+ODZtUO3Z8ChkAq2u1UUxLiM6oW5UJJ3fY?=
 =?us-ascii?Q?SiIf9dYnGf4hzH3NAaAQIC/RSPB/QC+1oJqPTDiSBcLBSxPyiB/2TRW4/gxD?=
 =?us-ascii?Q?cqNwuccVl90Naqo08XEOJahZ5MLD/tdnQ/pxwsdO3FTG73Lgju8dx+DQufY9?=
 =?us-ascii?Q?ycIvM1HjmdnvUEzKbmx7sSkKUtp2lW3QRPl2TnVFv7joCW49L/o/7xC0PnBo?=
 =?us-ascii?Q?+hQ8ygpd5CJ0rVzgK9lRGkm3Em8AWcpzA2JhaMvgqa7Kon+892UzNlDyPwnT?=
 =?us-ascii?Q?ixsoNp/bMTTgSxJJXvobN4jXIVy2jlLWMD5StkciRFLQeMnWUVa9blHukxAQ?=
 =?us-ascii?Q?W0A/pcgJ0yewvjtpbCzDhZ2HiFGVytax9VX5Uz4Vz5sSIbLJ2+NDY2+gxKqw?=
 =?us-ascii?Q?HXPWFVBnECOEjMnTP9PQA+7DFiobUrHn32CQjN2JlIpOEQeh/Dclx86bJFDh?=
 =?us-ascii?Q?6uwsvmQ0uIDcCE9u95aH3xksciOuBtVkbq6msoE7HfJJhc/Rhtt8yqrvHmPn?=
 =?us-ascii?Q?T9oXqg8CFY/ppJZDxk+rqrcuW8WeE5/r2Kn5QyZcKg24BIVvVan2x1Q8zdUK?=
 =?us-ascii?Q?wtXE40Z5RoZ/+XrRO/Ayvr9tO4R9SixTZ0M8fP1ScTSKfTZFxiuwELnfhcnf?=
 =?us-ascii?Q?8cwd6fY2ujGmGMgDaib53R1Ymyw9M6ZftWXyC7BZS6Jfut17yO+ojTrcPE/t?=
 =?us-ascii?Q?8CVSs9v3A65fFakQVvbwYRXRcU4TvKsjiAE+KSMWzMFzuATfjawArmLXvG/C?=
 =?us-ascii?Q?6Pf3pNrhZ8oTrm/7YQ/IvaXUoIDEbGcwXe7uQfo/ZnCoGq4IW5PtnigQ/GHa?=
 =?us-ascii?Q?C87rwXv/OR69b36x6kr+tzL4/yY4NHoBA9OGsMGWnsFYAhXiWsgWKzm4Vth3?=
 =?us-ascii?Q?aoaiAAr8Ecsix8GBYj6xqpRu7vvPcCLDeX6q3i68/na3/CHLKySxa0ujhflG?=
 =?us-ascii?Q?yl8w5suHDJiILaOegU5hmcd0NsRduod21QVQk4EwBzzbrqL8ppyKnEVA0Kv6?=
 =?us-ascii?Q?b2KlicX4FHua3dqVzfeacNi4nEBo5St1YYIvPlRas3hHkIV+xIe0Q6rBE6G3?=
 =?us-ascii?Q?mCypQ9nu/yyS/4DODuxfZbzJXi4fEa1M6uWmrRHngG0rv9151GT/XsF2DWIL?=
 =?us-ascii?Q?Yyc2FvbHDrQQmJCVvJDJXB7Rsrjt7p79xu86mEWhmR0C6MlRzu//klUgWik/?=
 =?us-ascii?Q?+LUDnhAxRS3goGfgtRzkTaXLyR2MnSYhEAz4/XdgtdpwlnRG9QA3STC/mrsW?=
 =?us-ascii?Q?uHKFbx2nWaDypmiXi3Pt93e9HIUiqwoem5MnpTuAwKNjIF0PEsOHnj8ovE3p?=
 =?us-ascii?Q?T3m1bYH3XIFgyBFFEeSd7ZOi4jrusLsH94NdEHEwXbewTNP3ITE2i7zVUe3W?=
 =?us-ascii?Q?fV3ZIljeh4pK8vxoOZKwiYUeZJ/NGgDlTBStJ51kgGM7Q06KNAp++CradCaY?=
 =?us-ascii?Q?HJhE8m6WRdR5EahvuOp7lMczAiVzOPbykDWw7IIPKnjXU5HnUYMnZ8LssRDZ?=
 =?us-ascii?Q?D+dg53zfGnqe8jzVvLLqYCY1nzJghXQrV/iWneFmR5yNkIE5EvvbtFn4pl5h?=
 =?us-ascii?Q?Sa7hCKZ6shNwUqp/dngByYEpZqIfAQ4=3D?=
X-Exchange-RoutingPolicyChecked:
	fEVhdeIE7ITl3NvuSbeQ5yJW6OWIzDqQbzmFRvPhrUReg7cC7Ft+y61lJJGDPzI7TkX10UampoxJUjvC4xJeKXK6pNrY+9D4OtyEfivP1mVwfdM40TfUe0vwRe2GKsXs8hbBysbqVAIt3mzCGVRO+C+ryqj6CVQxnasAYUJIWIxvnwzXZtmuqDizMnfWNC3GCm0hVQFqEwWGbOV541ixfwxFkZZD/wdPs/tf/C5efStVjNgi7/tyE7CaDowaZrotFBu16kplbE4YGAkOt4+Xbo/4mDfM/bfxhwaNJ117eMXgHA1mIVZZPkSMCZCFR2IO0vjLOiG/aTw5bMiQVFjJnA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uChN99Fv4T+jsOz6HYeUaDXKah6+SBjWX18e+s0OWmiXZkVqvASpXN0WtHAeM4p20hcPBDH8em/bNnFC6E55WD1dsdwnEfruxXbfC6ok/XB0lOij7Q0rztuwwgk3w5UKlIQbGZfvnxAMx2EkMGqZbOEgT8152nAG40wF7Rdv5wN3BTvfqTkhn5GMkZmPZCXZpFrgk1QBsmNcXHuTU06/Pep6Q9ykQh5fSJnnxC4SG9I79eHVfaFyk91PweYbTTo6jn/SlV5LcaxHLWQn2J/oHkUTHfXk+lc2cnG8IDhKL6+JX1amMhYgSFUju2hAzBZ0PTfKCr4+GsIoQcXNkvW1LtxOtFZL4J/yMCMbJnv+Htln3zBAJiDXN65cwpK4Bj46q+fFDYtOIO/a3d6exVLUy0BeV5Wb3p7rGgz4LjOlKGBrhhFAzdT5D2/hcb9rSZLZmzabgr0kXazIBcuDftoMhmV3hMON1F9LzxU2R5XLhCptb9Y3vwFN4NaBdxW55deuDeKA8e+ggnwJtZXRTHVXj1Q5EyYQ6yj/814tnu+4L1iZBNkGYe2TcPoqEivO8zJgZD870de1G1440zGYNLGKG4PXf8Kig8yyCIk3YcwtRKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef248941-bb8c-4fe4-5f99-08dee179d044
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:30:43.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVFnOu0IYM4CnkvxoGlH7i+pS86rwmYTG5/F5hTakWph5G8iu8ycAigs3jnhmEje0HbquzaKudoYXrFf0OparxwZSWyxqD1mKPOizkSwVTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: 3Or5_TdJ8FKwcXPbu_VWsK26AtygjrYy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX4DqSaRljShN0
 pSGg9jj6PgzAnXydBWh4jmml3o2QAT/KDvkE55R94usx5b/+AHg85gGzj+p+kkufKpBZ1Zx1rG1
 KdQG9S87N82dX+nAw2E0/UyFc6Wd1BCcR/Pnsn/sC/guTtzKe5y7
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a55e5a9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=zETD0ykFHjB7dweU9fEA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222
X-Proofpoint-ORIG-GUID: 3Or5_TdJ8FKwcXPbu_VWsK26AtygjrYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX0VMOe/o3hFdN
 B2OGfdhq4xV1dT3+GDgWg7HKGsa/6x74jlKGah8drn09fSB7cL6unDCy3CmPF/UNxdqms0RNbpH
 3mmuRc22SntwtDM3Bo9oV6r7z2A8VaddMZTONk6GMIGOJX2cwa4JL37GTuu6D/+rAMxx0asPc5c
 ICDJI4BVygNXqbL6SmmGOOfG75juYej6L0VYNreoottoPpKGq0tXd7Z+5r9GWF2/R0+K6S1Vv9g
 LPIKwl0RU5EFFsAyff1qn5FKJMv/9/nARD3w9IILw9+EaGLf/sKUlyo5KSMeGbBpbcVcT5b5eD1
 yCxTXDKTV//59yYLHvMv9XEoW5UZPgzF68VtDFukoXiOeW67ZhGI49iVx9XqN6om6x2GS8poyOU
 Av5F3b+vSprNI0dl1+77nEgqt308uP8EAI02XJr7PGmv8UfI00b2cAauEzkMuZP8oKRL1+u19DZ
 KZQqAaQOH+DFCBcdp8JmH2fR7cCbwVUHMw3t5ZyI=

Hi,

Changes in this version:

    - rename kconfig entry for the barrier kunit test to follow
      the kunit style guide
      (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)

    - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
      is not enabled.

    Both comments from Julian Braha.

(There were also comments from the sashiko and bpf-bot which I've
commented on in prior versions of this series and which don't
make sense to address.)


The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
on condition variables with architectural primitives used to avoid
hammering the relevant cachelines.

(This primitive can vary greatly across architectures: on x86 it's a
cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
which waits for a cacheline to change state in a time limited fashion.)

Regardless of architectural details, typical smp_cond_load*() usage
does not allow for termination until the condition change occurs.

Beyond the core kernel, there are cases where it is useful to additionally
terminate on a timeout. Two cases:

  - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
    duration expires.

  - rqspinlock: nested qspinlock acquisition that terminates on timeout
    or deadlock.

Accordingly add two interfaces (with their generic and arm64 specific
implementations):

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

Also add tif_need_resched_relaxed_wait() which wraps the polling
pattern and its scheduler specific details in poll_idle().
In addition add atomic_cond_read_*_timeout(),
atomic64_cond_read_*_timeout(), and atomic_long wrappers.

Structurally, both the smp_cond_load_*_timeout() interfaces are similar
to smp_cond_load*(), with the addition of a rate-limited time-check.

Usage
==

These interfaces drop straight-forwardly into the rqspinlock logic
since qspinlock already uses smp_cond_load*(), and the time-check
extension can now be used for timeout and deadlock handling.

Using tif_need_resched_relaxed_wait() in poll_idle() removes any
architectural details allowing arm64 to straight-forwardly support
that path.
(However, for efficiency reasons cpuidle/poll_state.c continues to
depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
with an optimized architectural primitive.)


Performance
==

Apart from simplifications due to this change, supporting polling in
cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
patches):


  # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
  perf bench sched pipe -l 1000000 -c 4

  # No haltpoll (and, no TIF_POLLING_NRFLAG):

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

       12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


  # Haltpoll:

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )

        7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

  We get improved latency because we don't switch in and out of a
  deeper sleep state or from the hypervisor. This also causes us to
  execute ~20% fewer instructions.


Haris Okanovic also saw improvement in real workloads due to the
cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
mysql, and postgresql under certain loads. Other applications likely
benefit too." [12]


Changelog:

  v13 [15] (as listed above):
    - rename kconfig entry for the barrier kunit test to follow
      the kunit style guide
      (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)

    - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
      is not enabled.

    Both comments from Julian Braha.

  v12 [14]:
    - smp_cond_load_acquire_timeout() now only has acquire semantics in
      the success (non-timeout) case.

    - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
      defining TIF_POLLING_NRFLAG, in some cases we end up with a
      degenerate version of poll_idle().

    - kunit: removed the test case for timeout=-1 (not supported)
      Also add test cases for timeout=0, timeout=1.

    (All of these address review comments from sashiko/bpf-bot.)

  v11 [13]:
    - addressed some review comments from sashiko (see commit notes)
      - The one notable change is to the implementation of
        smp_cond_load_acquire_timeout() where there was a missed
        control dependency in the timeout case.
      All the others are minor.
    - fixed a low probability race in the kunit test added in v11.
    - added a bunch of kunit tests validating the implementation's
      use of the clock.

  v10 [10]:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)
   - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
     Morton.)

  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
 [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
 [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
 [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
 [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
 [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
 [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (15):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()
  arm64/delay: enable testing smp_cond_load_relaxed_timeout()
  barrier: add tests for smp_cond_load_*_timeout()
  barrier: add clock tests for smp_cond_load_relaxed_timeout()

 Documentation/atomic_t.txt           |  14 +-
 arch/arm64/include/asm/barrier.h     |  23 ++++
 arch/arm64/include/asm/cmpxchg.h     |  62 +++++++--
 arch/arm64/include/asm/delay-const.h |  28 ++++
 arch/arm64/include/asm/rqspinlock.h  |  85 ------------
 arch/arm64/lib/delay.c               |  17 +--
 drivers/clocksource/arm_arch_timer.c |   2 +
 drivers/cpuidle/poll_state.c         |  21 +--
 drivers/soc/qcom/rpmh-rsc.c          |   8 +-
 include/asm-generic/barrier.h        | 119 +++++++++++++++++
 include/linux/atomic.h               |  10 ++
 include/linux/atomic/atomic-long.h   |  18 ++-
 include/linux/sched/idle.h           |  29 +++++
 kernel/bpf/rqspinlock.c              |  77 +++++++----
 lib/Kconfig.debug                    |  10 ++
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier-timeout-test.c     | 186 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 ++-
 18 files changed, 548 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h
 create mode 100644 lib/tests/barrier-timeout-test.c

-- 
2.43.7

