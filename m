Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454D125AA;
	Tue, 14 Jul 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014325; cv=fail; b=NBNIJK1lpSWrm0+tvAxtKyFdGvwspJIpNr7imdt6pKXkHv5Lbm1uzUNN8DWbq1iCzJJMQJXGH42vehfPGNSpNmd1vS0C+ciGdM9y6A1r2GaBXlL8+csIMprrQVXJBpnaYE6YKZ7ssJt65qGHDugsAHpNBrjIPKtl39tZUvUBiQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014325; c=relaxed/simple;
	bh=AQardczMSHQ+UCdawrjRiyPK3eoZuUZKv/we5apgi3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwxTXaUZ/O6D3d4nLZI5R+jQ/DB5/d+DPE0BvIQvdLlOGkRIGNmFMNfdsKqxmWkqLvqNSCMg8IDdWIP96V3ZBas8ibDejWK0HyylCkKsOVg6z9kMo6QWB267bqw4DWJZJHbh2UDbBzKj/reDSnFVR0kRMYcsBGJqhgTffZwJfNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XwhO5/GI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mTPAgign; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XwhO5/GI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mTPAgign"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DKl4VG1391892;
	Tue, 14 Jul 2026 07:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8ORxdN6kSZ+O2nqv89wJE0CYY50frr+9TocGBj1CtJ4=; b=
	XwhO5/GI1Xj4FKBLsOLCqaoX1ly9ScJvKhqERbK5UMGTA7h6SOEXhfhg3RX+Gxpp
	00jkEGyH1rZbYuUIdH4zDHip9ODpkxS+wl4geJAvo+iWwa+0VM7KYZSkmkuQE4QF
	GGCaWVYPvv8jwnQhvQ3Ic7laBuzrfLDCgGfdl7kt2TIzmf0BtrcvnezB7OlQgHal
	ky4G7yfmEE23AjmjwVOKg2XipGpZxI5IpOARVCuq7hxbWxF2WNwC8TnE/4eCNgAz
	rRdZXkZWOBXQ5W7bwt1QY/itLKc4NDpCt8slvcTB7ZvJObMM+rpnT2lwrzZWxFl7
	DeGWHHvtVs+LlBL/hxXVig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbepn3pbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7ScCK028698;
	Tue, 14 Jul 2026 07:31:32 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9r4grc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 07:31:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0fdCjHn94JlPB9UVNr3UwMAsPf1kXBcZHFVxzeEaEkxZkEvYiAw8SUKVL6hwNcbExi6vUd4M41WVAvZf6YiFHx9wgskMDNtSZPu18BKPZNOKh/f+Xif7gF0fm9geE+MxRzVklqvCHGDGYRI7JnKk0Y5CvIXfNkecPXtYQp3z30+SpQsWLy2EQubQUlyECLjEhdPDTM5szbNCptkT2CbfNIUHrRgV/wDFYBYBxK+LPtflznqDZ9tN6lueRHJAFtGcwVO1df81Xwwyz8koERvS53Z9TQ4qhxyu/cQuiEwMqmrXYsyDdFEIRqt1mpEVucxHtIasv4Oq9xvuRhPJtXtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ORxdN6kSZ+O2nqv89wJE0CYY50frr+9TocGBj1CtJ4=;
 b=dJIw+HtBxBhqn6e5+Ft8ibrffaQ7HW3F5YRR4ngIuwqKw+OSMmxcCSdYJ0Ysj4Ew67luhKgWSrDq/yVSiCGybO/Ud8heX5pQjFeRERjkuToTQZoqS2WiBjYMH/Kht/ledMiLHTwhzYlG3O6LEq+BsXxnCC166AhThx42UbLNQMVqgsSvfVyGyiqohKf2jA7JhQ7/Jg859SPcPi+Z2amGKG2izc+qHdHul7UEZfQ1HcDIs6X3eAPIwvX2U1FPxFhJ/45vJJ7qAyvrVe2AICI9hzU5ckGgMnhdGRgizkWCZifgqafZqL96srSrctkXZXC406WI/ODFqg5NYd4hWCBnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ORxdN6kSZ+O2nqv89wJE0CYY50frr+9TocGBj1CtJ4=;
 b=mTPAgignbfENtcftcxSdL8Hn2LtrfkW5ZEYDgxyajPgf02gSdzpOdTPS/pcOWSf6sziqoL3cHbUjFtDnA6tUUVuzGpUSSWgjVJ1kQ9PXrs5QE8u90V8bVH6mTxLxjvjwEmHGQxzCS1E/KRS/GBOE1gceUMcd4rX1HZ9N5C3MnEk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:29 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v14 14/15] barrier: add tests for smp_cond_load_*_timeout()
Date: Tue, 14 Jul 2026 00:30:40 -0700
Message-Id: <20260714073041.40250-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:303:6b::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f762e3d-e8e9-4e8c-dc98-08dee179eb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2pCzAGsoek6SI5UOOYs3CQKv2kyPtlwXKq4BnoZw1jaXYfO0uJFJwDcmiYsx5yZSXyKI4yrNqM+G2iESjfQ4CtBJ0TPTqppZMSaoBw0lTepYAGU4oNLZAB75Wn9Gi4HUpIFgedblq7INTC52ItJ369Y060Er4Sv8fXrmw2ZYcOLGaxK3648mkrvhSbDppdGOl3G+qZic3Lia9mv/h9KbROURfSwrcifOfNTLAWgFS+q2bW0ZLh7N5WdZIr1jG0zoLhvyDrAOU0UuXu8ypETW57qiOoP4jK/46evCnlVK2RBe29gYdUEWCj9YFzXbY74m2VMRAA3BTiUDG4qAPAB1L70BYwgd+aehfpZq1Z6AhJq4Qsdplz16zrVcddU4qrojL0B/lYrkVahm7eAakYZ5Qkr74k6nh4kXbQ9/fD4Uav9+Uj47Ug9kGPHzxJ0GCUK5eAW/JpGxyFGvda6g1VcHDRVYqXtwuoMTB0l3cVPw+0EyooQ2qLjZPY9YfL21RGwXB82TSKizO/LFuVFLzhBa2l3Td1orCuKtt11LdVUyQ1NZ6JgCp34D5bE3pthotgQclrnPBTpASwPjmEiH7GoalCSWJcAQ1oiTKyOCBhRwK4lPjAMfy1OI7ihHi+QA+7V7M12/qMNR3V6m46AjhxMflITmr+6UMfe6T5tLayxoWWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEOezJju/tKVc48bUsb2owVhPunlpgI23CBNuobwAlRZGfd2Jzvfo+UgnrWU?=
 =?us-ascii?Q?4/pCmCSyp+UTFlg7r16oXuHlaU5Hrt7HIV/C9pT20ubBXD/HqQ/CWiNoxaXP?=
 =?us-ascii?Q?C9kasSMz4LSZuqu/rVUjyehWmipYMckiSepa7FPSS2MsaswZUknH0+98Mqfu?=
 =?us-ascii?Q?e16QDMuHfXTjZzuqIOqpHNgvy0sEbQJHfnaU+v/SzZBY2yO79YhJBj+izk3Z?=
 =?us-ascii?Q?U3nqTFKQ7Niht9pP3uFo7nstzUCfivOzf+A7fIqXHCqnjzmCGiWb61TzDbjU?=
 =?us-ascii?Q?n9qRCV2vqt/aEiqsaI3kBuofPJkap3pVW+TwLOhq9lOZvFTJSb3He5j6+1k0?=
 =?us-ascii?Q?yQJ7pxh92aI4VDj2Ah1LbPhM6ju/U7UktdeU5JW8VILOZv9Qq/d47sDA3esu?=
 =?us-ascii?Q?k1NlKBpD4Sl72u5lkJZAwNo2rDdc7cojHxVBMBTJLM/HY0YO9SI+tF6gKKCM?=
 =?us-ascii?Q?qQ37qjSdLZd+703YaTgZ9wXPAcBLtUzyc9BFuwwnKHdHwn/Uenr5JwRhhSAF?=
 =?us-ascii?Q?pxKGqn8pO+dBGEYmzcECTvnuc5BzEqhlLH3NOsZ8PiUc5XldA0rB8mlaoI+A?=
 =?us-ascii?Q?QQDnvxYWSH/O/DXxOafSe7CY45Ap/qSW+O94YAD+ArS9+IEFL/T8Yui7eUF8?=
 =?us-ascii?Q?z/j+kExjv9BNbRY9g9R3x4Qkdyj2XHFFq51OS4vbFxD8+tjKcoQ8M0o9JzP1?=
 =?us-ascii?Q?WOBFsJQUB0a9Rg3whesFq+bzr3xI5y4El2O9NswOND+qze10u+v2VgmaVOnp?=
 =?us-ascii?Q?BFvTmOBSRvGY5tbKLJLNLpuS/aMD8ZvSf2m2AFG++4tiI2ydfZ6JdYFImJnN?=
 =?us-ascii?Q?EvrY9gqU+51ZU6MWOtjeAQmVpqbdpizdBDt6VuZa7H5wUHF5VaosimoJQxi4?=
 =?us-ascii?Q?E3OGweiGfSXf4FREEYZ/m0tOgLaHbGzo3KO2XiqYaXi9Uvslt8oeKXalR6P8?=
 =?us-ascii?Q?37XRjlPNSsDy7CyK4dDspS2yVas3qLXEOmPLrXkIVAPWFkcUf53deyW7apSx?=
 =?us-ascii?Q?6rbuDdajgZpqpkD9LcrOgdLLisezm7iavKvw8WQ9qYkWnEYcGDl7XxgkhNgq?=
 =?us-ascii?Q?7Bx4fxwShKv/cfKjJQUpuwoBqv1SsunzMhBkHApaLPVehr6cqm6mKdpKuAUH?=
 =?us-ascii?Q?CF1gaHwysusf7SsZqMqFp8htuUgM5wnwvVMep0hyNNS92yrhk/7J/ClQ+pEb?=
 =?us-ascii?Q?yHnb6fxlwHFh3w8Taif63LiRYX4kXkxpQqSkbHdMeIC7X/8O21eeHpcFJojd?=
 =?us-ascii?Q?ACNbtSS1svWQOaQLrVffB251NNEseZIl1GxmTTKAVC1kryf2Z+JtHh5kUHQg?=
 =?us-ascii?Q?Ku8HzeNGGTUwe9VrekuP5SuLZd0Ab7dT+rdFJvX0V5eaTBq7iI0sFIxPnenb?=
 =?us-ascii?Q?tjUyWToMwJLdjM4TlqleVQwrW+kReQ6/CpOO9k/ZM44S9F+s4/bswHv6nLmw?=
 =?us-ascii?Q?8H0juBxnUgaKobYlXJ1VUdQy7xMF18LsA5Gezkil15wnTQ8ab5e39NZV6k2l?=
 =?us-ascii?Q?CkEo4SDfROY8GQrua2SZxIvpUiTLUQsAtPA92ihaTsy9pV3hkNdnz5y5iGvO?=
 =?us-ascii?Q?1xBPs9/Se+UKn6MGF/hnVZ2b4F3sRlUMpTKnihikI8cT1kpkdqLBVPs06i+/?=
 =?us-ascii?Q?/Vi7FFPMnDZe7853pMTdRZaOHzUeYGuNTjXB9eNmNf0hs9kHbu9ROmCpT6PL?=
 =?us-ascii?Q?eTduh4TrumgnYRxEP+JhS3h/1bEkdiHb5u3AEYYxmjDX3y5pO7n1JYQoq4Wv?=
 =?us-ascii?Q?1Hrj37sqH6ub2NHLVsqOkv9cxeM8+vE=3D?=
X-Exchange-RoutingPolicyChecked:
	aRQ2+7YrN0lyc959fiiG/Mf8OPOHWiQI2jiBtwOf4MZLR2SBz8W3Ry7h0nhUxktMbDhN3A/6IYNpTky/+3YQW0rToBylhRlk8HZ4Q0/gM4MAxB5whxwa78n5LBMnVIvIniWhCJKfe+znOxqgBxrQVxKs3ZZ2kRyNTrdjklr0hEBHAFMhDbt5qQJqCggtFa3NetPHhsPRwOMCVezMAGqtUjYORuoaLstMzU+Hvy2m8Qv6c74+gKTnbxBUyssM0f3XgdTrdVl5kR4y5nnw6IFR5vqF6Qy3VlZfDWPByHJiSUIeGE25rF8fJq/LjSbD4DIEMZnwMZDLzpeE0FeV+nWgmg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3lQSPF1wPPjUCll5alwPrcpWnaahdexEHaRQ3rbEPjqz25VtxrnBlPbdaMFpgPeralE/fPZ5HsmCyXh2jrN8n7gdmL43sI0TWXBc62YraHoQX7YVT6dvxUhyOsB/D2G4FjPOBGcdHZ7zYKeZIMeTcPAc7ghc2oQykpKaUAKDohVtthxZ58B4Uek6xWEk3sXBEpLvrgFUFdO+mqMg/47Vdpf15B9gp4l6BsLSev6DxyZ0wGpTdX5fjSr9OH9Wc82aw2u8ysbg6ZlTF6KHlYlr+Zoi8g/DCYq74kluwMy493pepnxMqStnHKSsL+LbDx/G9JEYotj0PxKYv2owY0pcCGc+BuIrikKPDZe69IwVo6s5IKmKf7iHpN/9KVbDRGBq0dosUb8FotnHR15+Br8JxIPS01A/2Wr0kMuRE5rF3vKMqKVCoCokDcZtiMJtCKVfdD15qCmNldIxP3XNqDCR0v04iC6L7Yf44FHTAobsBBenEO8p3G/4vVz/YEVEAPaTRtmczusiBbBECEcxfyj0VoQIjN//hugSL772zgQk7IMsVwH90Ji/kZumLiMNU85xuX4imwCpTFsOHFHBd73d1aoRYNdf0Oa6MyZUyaSJ+Gc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f762e3d-e8e9-4e8c-dc98-08dee179eb5f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:29.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXOvwGHogVXcJx8+CJDDBJODohTW2sId5xLngFo3L8ys2jxFtTqmqhmF8ezRBLyYrbPe88iLIZBmdPLzSqG3+21lVhgOciLH0KMdCmLEXhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: M1bZp7YxQpqkYeWQgfAgjQkcmS8Xc4Vw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX1TmJwMRHLb7n
 2SVoOSKJIg+S83FgCBhQHTXHy+ELv3IF6ymcioivR+ahgk1AaCbDeh21LDz9Tql0G66pZZm/yQF
 fra/lOiTxZc8W29wY1ydxN5e1oiaV7oDI+gzCNiHvoNsa61UJAOClGOwBNzG/jw1MV4Natx9EYr
 Zd7MsliuKb0S13bMpBpPHLRGJq5rRBY6q/RyebiPF07WbvjFxui8guALwGYHRUtG2nchmUENAqu
 FGahzE+SC1J13deCLtxRMIH8K1dqrRT874igQIuOpg3baqE22kxpAy237dDTc38zkgBxMEvMnNu
 vmdvZlIJ7g++VcbDBLGnqJTdQtK5x1BjPh7erfqG9AFgNQp4meRtmqRl6rZMMZkCH5hD7PVZHgj
 nFcs0mNia2KXzDBMsPPNzMJLmD/3dJKutKpSLhiMzgBxnPPNej7/C84m684Cz7ej1aU5PSkEKbm
 2t4D232DcI5Ofy0n3F/5WGP646rcLVSr/iUHVbuU=
X-Authority-Analysis: v=2.4 cv=bJom5v+Z c=1 sm=1 tr=0 ts=6a55e5d5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=NepunaQX1CZaHNhu9GkA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12222
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX0gSMUiMrw3Lw
 NNRXaQvo1mHZC74MFu/68IEzqCf+84btr0yqk8zZQEMujIfh6S9RZiDCs4BNtsh4UOnad3XcY4t
 yVLVuArR3WDUD8YhyGXcqkz85EGESHTjIwhjHaYCfiGlOltpd/mB
X-Proofpoint-ORIG-GUID: M1bZp7YxQpqkYeWQgfAgjQkcmS8Xc4Vw

Add success and failure case tests for smp_cond_load_*_timeout().

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Cc: Julian Braha <julianbraha@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
   - s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST/
   - limit visibility of the config option to only if
     CONFIG_KUNIT_ALL_TESTS is not enabled.

 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 128 +++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..07a06cfd820a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2551,6 +2551,16 @@ config FFS_KUNIT_TEST
 	  For more information on KUnit and unit tests in general,
 	  please refer to Documentation/dev-tools/kunit/.
 
+config BARRIER_TIMEOUT_KUNIT_TEST
+	tristate "KUnit tests for smp_cond_load_relaxed_timeout()" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit tests that validate wake-up and timeout handling paths
+	  in smp_cond_load_relaxed_timeout().
+
+	  If unusure, say N.
+
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 4ead57602eac..796f63c89bc2 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_FFS_KUNIT_TEST) += ffs_kunit.o
+obj-$(CONFIG_BARRIER_TIMEOUT_KUNIT_TEST) += barrier-timeout-test.o
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
new file mode 100644
index 000000000000..4226fb6456b3
--- /dev/null
+++ b/lib/tests/barrier-timeout-test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_relaxed_timeout().
+ *
+ * Copyright (c) 2026, Oracle Corp.
+ * Author: Ankur Arora <ankur.a.arora@oracle.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/sched/clock.h>
+#include <linux/delay.h>
+#include <asm/barrier.h>
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+struct clock_state {
+	s64	start_time;
+	s64	end_time;
+};
+
+#define TIMEOUT_MSEC	2
+#define TEST_FLAG_VAL	BIT(2)
+static unsigned int flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(flag, TEST_FLAG_VAL);
+}
+
+static s64 mocked_clock(struct clock_state *clk)
+{
+	s64 clk_mid = clk->start_time + (TIMEOUT_MSEC * NSEC_PER_MSEC)/2;
+
+	clk->end_time = local_clock();
+	if (clk->end_time >= clk_mid)
+		update_flags();
+	return clk->end_time;
+}
+
+typedef s64 (*clkfn_t)(struct clock_state *);
+struct smp_cond_update_params {
+	clkfn_t	clock;
+	bool	acquire;
+	bool	succeeds;
+};
+
+static const struct smp_cond_update_params update_params_list[] = {
+	/* mocked-clock updates flag inline. */
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = false, },
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = true,  },
+
+	/* basic-clock doesn't update flag. */
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = true, },
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = false, },
+};
+
+static void param_to_desc(const struct smp_cond_update_params *p, char *desc)
+{
+	char *clk, *update;
+
+	if (p->clock == &mocked_clock) {
+		clk = "mocked";
+		update = "inline";
+	} else if (p->clock == &basic_clock) {
+		clk = "basic";
+		update = "none";
+	}
+
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, update=%s",
+		p->acquire ? "acquire" : "relaxed", clk, update);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_update_params, update_params_list, param_to_desc);
+
+
+static void test_smp_cond_timeout(struct kunit *test)
+{
+	const struct smp_cond_update_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = local_clock(),
+		.end_time = local_clock(),
+	};
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	unsigned int result;
+
+	flag = 0;
+	if (p->acquire) {
+		result = smp_cond_load_acquire_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	} else {
+		result = smp_cond_load_relaxed_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	}
+
+	runtime = clk.end_time - clk.start_time;
+	KUNIT_EXPECT_EQ(test, (bool)(result & TEST_FLAG_VAL), p->succeeds);
+	if (!p->succeeds)
+		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
+}
+
+static struct kunit_case barrier_timeout_test_cases[] = {
+	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	{}
+};
+
+static struct kunit_suite barrier_timeout_test_suite = {
+	.name = "smp-cond-load-*-timeout",
+	.test_cases = barrier_timeout_test_cases,
+};
+
+kunit_test_suite(barrier_timeout_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.43.7

