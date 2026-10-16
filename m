Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4B3DDDC1;
	Fri, 16 Oct 2026 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134610; cv=fail; b=mbMj2mNY8fya6OXXWksEotoPtEg3F847lkYAIPKBfgAU8lgnu0Cxqi1MGfrwNmKEKwwwSu5Bfvvj8T6hq79hKjLaR01WND4lb7s6dMvBNbxt3sYEajh71YmD8SqHxe2klljJPwSOvi2kIjOjYDyA8XdWlrteiZQRSTWtTQrW3hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134610; c=relaxed/simple;
	bh=hxmsdZNQglyY9/LuT+RqQbCPRymrsm/bUjDdIby2lEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqV1l3C8wFFA40MBmbT0mqPBAag91/DWdDggVSY2zI4tK4Hv2BSvCOk3OyQgCtmS0Pn81gS0eObgsTKPzFGgtFGwIht9Q3bWNurIa+OoaHwBD74ZO+6beESceGZybAoxG0EyFpPTxdyDXPXsYlgYHIRySaheVsdRuGiOrEnCDaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cuY3DyPh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xwv5wchg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuY3DyPh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xwv5wchg"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN766t3477335;
	Fri, 16 Oct 2026 07:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OWxuV+PLT3W2KZBXIspM6CGfpxYY0HucNQPlqeUkMmQ=; b=
	cuY3DyPhAAdmaWPIKBzM1/6PTnk6QRk35WD6oPD/29KpyUtcya1d2KWwX7BFuo56
	q7p8nKahe+T8tyti33jSEMPK/NY8G/CbUvxDWIGiDhPnWQwy9SKBw3CpN8PsOhDN
	2MMLbsJ0EN0yde8ICLY9ytlvaqcl0taGXbDN7/a+5WTOMgbH/zE0zYWF1XdEyxOL
	z0ov5O1iWL4sZaQIQr7TX9jvk2spVpwCTcMi5SwaWhkme8QjusxjtSFyJYimO6gR
	F2ob/wxYnXLscfT0usvAQGgrFGAVV+uF30Vx7uPLqobv9kywOSh5tTVrKjl2hfJh
	jKn+RFDpv0v4rR4zQAb/Cg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dde1meg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76k8A014480;
	Fri, 16 Oct 2026 07:09:31 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btt1w3e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7Xbu6Y/YVoKUU0P0dAVJCsivwokzxgqjMhuYLD4/WiqOs5XwDaVhN0GqxFEp9F/HXUyZ7SutG1kw9BEaM5aflOfgFyQnTUjeVSWAaKTdHD7wPTpVpQsRNee4KOadBpZp/AWHtlFLAkBj0kwQlpTnz5JaLDgYeI9N7a5o9G/iiYpQ0nQ3DDtG8jfuf4J17MWUJNyg5EfQqEcNXiXOSc7s/R9hA600dph5rZ3vnVdFhHIV0NbWefAQMK387lO8GvmS5Ies1niCbkxgJgV8qlrYzBEgapJAoDG/E90lZa2/SAYJ83qsNki1dVgB9KUlfQdc2DE6LUKrxK12xutF/YqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWxuV+PLT3W2KZBXIspM6CGfpxYY0HucNQPlqeUkMmQ=;
 b=VGTTc+OWEDloIRcL9nq1ntikWXp7ZOmZ8PdMJto8X8/N8CwWz4kU/06PKbGKpvzuBEtz1fb9XT3cnOqP3GsrjD21LFj65oLsgLufej63nTiPElhCu9P3TW4JI/e7JVuOktvgW49JzA7fgOWua3/71uk++mtWMwEwc8mpL3NxVpRcwkxA0Wu77WACxVa+7YXUuASa93LLi+4Mi3M1bDKOCTvufXRdgMTKbZt10myhJRSKvENti81ZJNK8jgoQhLXZlGVhQRJwsyJVvqWEzPNjs7dGzGlGaKsMR9WbdB15k2xlr9Iog4VW1nlkQcWjh61iTjPv5u7VvmqKAf4fvnr4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWxuV+PLT3W2KZBXIspM6CGfpxYY0HucNQPlqeUkMmQ=;
 b=xwv5wchghjAhXHnPdCbTIyG0pCaU7him39ZVCVd/m2mUMlPvMH7tyjikTsdpqKDQ41ROY8PyS6w4ENIdMUO/0a53XX0dk8MeZO59RJgJnvOD9mUvIBVPtuRBfBa9yUzsPgrEnnBZp/etPdXF1B9Zi3SQNHLnD7JG7AoJOgTJBIA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:26 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v16 11/16] sched: add need-resched timed wait interface
Date: Fri, 16 Oct 2026 00:08:32 -0700
Message-Id: <20261016070837.440748-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d57bf9d-3aaa-45ef-e11e-08df2b5469c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8Zhd/VF857pDxOmtQrpiddejMC6V2h9VMRPWELdslbf/HbvIqgcH8BEK5YUDPm6FBzBSV1sWFTvr0Om4HxbqVLmy/IrQYVDtW3+BCVxJFKX3TowgI1q7qdHC1XwhoFOTgcdLjUymym7q1fNxf+CCuCeCKT86XRUxk6NrZytVovh//gmyqN/Xybf4KBdcbDRi3QrA1ANmpyHf63pMIecVZQf29LbTURLZtZZwjZE2wNMobug5qxh1UOTTlMHI/swV451cxgQqUOk6+6/GBuNPUXOeTU62ZcQm1paw/cDYAHxe8F17lx1ChN36s79wmMergmfLT2dAr1X4kaD76eYItcaLjGR2popF4QpKjcMuJtfJD1c/N/mv0QGnrcomr/xFl5TYKpf0bVqQ/qaZWWnuLn6dCifmE8/L6qB7WJTzVrWs+Q7/DHpIoeGDkycSHDIm0wWJV9sTjgStY69EEca36dCgoN2Qt5YqYzEV4d8Q6fPLHKP/DpCkPvBArUOixs7Z0I4+z+nnQfCELXgQElkTN19Ew4tcnH2qj0Rj8XO4QSXiVhhL22wR0c0Z+B1f3JdslhSMDFDByKEYSMRyGKu+yJvvpPR/p4J2xnxnyYhv1oYsKwKu+k+wtFeiWRIXCdRoF/HZh+bytkhnh+BywuM+8cqy6T0JJfhhJv0aW19awPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYZiosM/tSOlnD07u5leRfKBz0tC4JQxoeSTbIcLwST47ENp6nlnwjhfQXFc?=
 =?us-ascii?Q?aoKR7KcJywRIPEJmYvCIKNnC0OsEnCsYysHc0YKvuR7eklOekIjxs5WTO55A?=
 =?us-ascii?Q?RpnMmQ4886z/JGBvBZjwWADnQCi2GcqaN4SJQrGS8JRRH4qB8cbRQqiyWapz?=
 =?us-ascii?Q?zdrr6og49IIMweQ3VYnd/BiJJy0C273R6bsLpwCtSjCP8+Mv9Yk/rdDW5lG/?=
 =?us-ascii?Q?79jRyn4JJX3a8va0XyEoPZBlgyaHJ8mInTREl+mx/6lgZFCWzpHO9+I8thrj?=
 =?us-ascii?Q?q4vHsrGu4cQyNHheybFDKnYii/gp8WJe0XNSNYfjQ28GSoo1zWe+DFI3cQ1A?=
 =?us-ascii?Q?wVfhDgy9pokgi/OP3kSAJZFjp75ZRSfd8KKXZOrZN52Q2BzX7iqsPeX+Bjov?=
 =?us-ascii?Q?iCg1G/DbrbUAmAlr8GN3UHy4XLu0iguiAznYqY8lM6DTb8msAL0HSTqCC69l?=
 =?us-ascii?Q?3O5BmyT6+9UAO7boSWKaJG0Q96nN6bVPt4zyimmNczyU/xwwYwIPYJM08kSO?=
 =?us-ascii?Q?wN1X/ZQELf0I2EuKg/g07rKkOvIMHOBUOR8YOR0fTmYMBmmyK2hHSHT7U9lJ?=
 =?us-ascii?Q?7VzmANUsbDjvqXnRhKTg7lP6xUJBCzv30QbKJyyc0ZjusKEFUmE9A9kNK+Wr?=
 =?us-ascii?Q?4TxCBYBhCfS6MxKF09X5Q23yGTFQ8QRJPsqLE/vjSHRv6VB4Zz6NYRfKqdsI?=
 =?us-ascii?Q?HUQf10ElX9dwiVP9l4agVppo/n0EEpz8YRWHgqjBuynbc+rL8QtAB9X8hQMa?=
 =?us-ascii?Q?+ZPrdqNhea1EQDC1ybvy+TDpf8NcENy+Q0O2/21WdCnZidORTnD+W4vk8xz2?=
 =?us-ascii?Q?BDLmBBAw4Ucz6t4RUry8YQW/H/UBcLwquA+5DKgvcy5X7GoY83QMNPn8Z/HY?=
 =?us-ascii?Q?w9qw+WQ/wpCAMHVFTVYGqJ5xpuftdO4GkJHQIkYLf2P4Ya2FmSdR2sfcTo3v?=
 =?us-ascii?Q?O9I9YeOxESUCUaOplE1ZLj2iy/G/UWdAdQ2PK8mlWfZMtcZB7aThtDyl7fbT?=
 =?us-ascii?Q?BrfRGITVHWEc4+O7kvfml2pfLiVcnDiRN1T57Bi8X5b2C8OptN8rOC3Kq4sC?=
 =?us-ascii?Q?oJaEMbBHiU2pybmp5gXvzuvoc9U5GemIA0Y8MkqquacwrqpK4EAi42i1IYZY?=
 =?us-ascii?Q?Hutnd9pZ12pFMltnsOaoTD73BWIlqPOLhVfAqdzmhh7lGQABKd1v847i9EXY?=
 =?us-ascii?Q?HiyMlnnhqTleLCADs3E0mDp2VEgzlGRvGZQDCk9F1nnJtNidPxIyukEDDn1K?=
 =?us-ascii?Q?I89iGlyQkS9ADJoNHZs8hqce9h0v0U/BWsmECxw8YV8KeRwhk4Bhkq0l/86r?=
 =?us-ascii?Q?wjo7TruXI6wPhsqldGJAEIFtybkIgnvJ0b3plwDtP0FWdnrUGClNusw1iUdz?=
 =?us-ascii?Q?0S0T8IhJ3vmrRJ4p3SvF2qT8OI6EZ/1X8cBnXce4xcaEgWXqg0aKzYXqENKP?=
 =?us-ascii?Q?SuNfORpPug+wFPgtcO4KpN6yqUVuTiK05dC5yKMDtGGvbPb6pgoXmxYmSbiN?=
 =?us-ascii?Q?SCQ/Ei6atP/XUs0yRImweIeq/S905hlbt6Fu4R+3PBe3QJ/a5s2wtidbrQGP?=
 =?us-ascii?Q?DT4HpEVHxWkf5v8I8me3UCizMZ5XCsh1X/ss9WZMMQkAgl7PamSKwMRpYwIu?=
 =?us-ascii?Q?v+7nrUmjT0EB6Bo+3nbibDN6JOStru44Yu9c7WtjJ7GVHSwyIJ5EJFMTiK7U?=
 =?us-ascii?Q?dzAsuJEPqd2DKRbaSB/Wd2XJkTO0FamLHs9Kh9DMR2zU3w2TpkWUS+8K0OjT?=
 =?us-ascii?Q?6vIg2URrbLfjwkJFXEaWpT8I7TdYWwM=3D?=
X-Exchange-RoutingPolicyChecked:
	G2NsSuYxgPVCtlTN/GJQXfgoEBac99mlV5KEqMW9lGfq8KnFg24yuZvGsDAfFufs1IMfyh5fLCxQjnUvTRo708eyAQ5q4USQpo/LNMYRs7qX4O/16wIVRMS+NF+GtfJQe8b+ujSQ5VXqjJV687sS9n28GDBTaomvfpdt7vERcCAWIEiwA48HRH4/FGK37IEzKE2/mSXIWmnDSZDUtp1xvyQBCFX2UGOiRI4JV66SW3f8ptq1ywQGkQ3aqeLGJ4YJMR3ed8BMe8Q2wjvl/MozmhWH6cNTlN0BkazZtSeXHK0B7gp+XK8ZFqzgBNU6B/OtRMV5orFfuxd4LQBG8h8INg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IDDEo5em6zYsUJ/afF97trRk6y2HeH2W9doq2j6DvAZuYuNorZU0997e4wkpmas+lC2g+o+++iFc84vQ9rLktTI3f0WmsM/KZKtBuuGf6BcDxZ4/ADFTgCK7Sj5+uNd7iGCQR8tgTU8ZQN6EgR/QeG6ElpFpdjNTLTtY7oGyw6ltwCf+1nwXs1QgQwGD9R6MxqXQUY1jg5arDD6AiO0cb3P+N1VxV3/Fc/TdHg2KIhn/s3LjKVWqEMz50K8Ky2ywwh71RtBiSvOM3XOLjdAm/a0c1IOhN3C3X7lyaNqzHgVPHY/3LuJG0jAH28qrOn1xmARygvSBvgReaoAQeSbiBHLOuj33Rtl2bW9na1/6HcXR8d8K4csF0msqJHTR7eN8S9K2QrwuaOVfBMSmJx7+/RDC3SznlJppL8CwCDTfsiMCO1YQkOTyAjLUNh9fGJFiVGnS9D+luGY+ss+4+6Y1UdhZL8rQEucf2pntCuo2d1ysE2Opjz4DcAS4uqf1xiB2kqGSlANGqxSFrik0AmuPqUDB5VoohgKTJwuOlt5qGVD/DvSirdz3fwCTg6DbRXST4CFpg/1t9tD3kiC3/0lUPTLPShqo2KwUtjKnxxgBq3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d57bf9d-3aaa-45ef-e11e-08df2b5469c9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:26.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTu61fzV0hVrgyrcTHYjM1ba38ZBZNyg0Gc+xNNjueX6g41XR4r6VYqer29leuYNc/gTAZVTuiOmHFJO7kA795hXmXT5SDzN+BnQsUkMCo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Proofpoint-GUID: oqAgw1vUqbe9j-SJhVaCIVezvQWzJC9u
X-Proofpoint-ORIG-GUID: oqAgw1vUqbe9j-SJhVaCIVezvQWzJC9u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX9OnqMFEP8VYF
 6R+LF/qK1RDhR9D4hCfooEFi9nbfCg9kVfgmFpE1eHaUiZMKHDUEoKbC5YbOzB362tRocVUWThJ
 yO+PjKIONG93mqPHGmFpuwt/VToLvKFbnIb3bG2BOFNseysxzzGS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX2sm8akitXUYB
 o6tEllzeXHz4tsLk9B8jLAq9K0QcojrHfvk7qGba5AJbL+7m4gzeMgbQPAfCmo5nqKVqnHRi4OY
 FfelbW+4pBvsB6XhjKa3sy+aVQQPdHeR3kl/rWyNS2HMMFTZYIWiDlPVYGp3zk0PUlGYq8yevDb
 P1Z6fvaAB/mCuNIUNfLn3nFm64ttLksGCnJIpaeCsEemNpSREODm9heipBX+FOvSELxRz6KCmIK
 HaZER4C5cIWFZM2Bx1Ktfz52+dvo8Gi/TPmy5sxwy0HTazDYkCRzz5iWo0EeRTrnyJPUPl6aIV6
 P5NB21vuolz0vqYC8SmIqEjVVjKZ2KjjLJZcG5hUtPQFNQPT7BktTZPkxrsaZuwt1Cwx3/LZ5oh
 e8qxqJRw9Lzl5vyPzB7vEuC7qb9OizQpKsIfkEB2DbQobyECt7tx5+Z19/cMsniKw7TJsP96pI9
 WRqrFbYs4xJmaYLjtkqlCQbuMj9avfd9iz1Z3HCA=
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6ad1cdac b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.43.7

