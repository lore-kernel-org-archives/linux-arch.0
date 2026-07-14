Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA13EEAD2;
	Tue, 14 Jul 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014295; cv=fail; b=eNcdj0TpLHQ6wR19EWjMwS/PC2WtSmtsnKOLX/myTxGW4OL1RXdRYmcDYr8lVLfd4aWYQZujxNydQySHnBdWGtHTMfNaFQpmO1DIhHXNP9JlNTBvcHyPZ8cGjcpXmTGQ8nWGwwnMBVJYvY+r+z9jrrWEtfQKT6/Pad5fXEbr5dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014295; c=relaxed/simple;
	bh=yw6zIiZnrZULSOqxioCTns/sFf/1ZCpWDOh9BSaA/CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y+Q+xqA9lHWomTGPegjUdY9j7kRBF+YUNXBeID/qL/NBhdbqrUf2wba3V2gevzNLYFI+5je1cGatiGXB0bjHhwpyFRgGFyMUmOG4YXZkJgnMwA15RcJ8frqcj1vbEXbp6Y7MAGhViUeNEeRaDGLkswU1QCuTL94i4kMIL9fsDE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bzr+NKeM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iXoE2ZX1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bzr+NKeM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iXoE2ZX1"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DL4eUY1376588;
	Tue, 14 Jul 2026 07:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=; b=
	Bzr+NKeMd6Z/IFyK+NDu/i5JphAKCOJcwta1DO4n0Kn5HjGpPAi6AMOryIzxaV3F
	xrQlozuuXhQWhaRd0Ezm8F+E4t0sjQsSJtIa0xFDm0yNeNeDXIvLstM70Ein7JXW
	nqEAnVgBQ8E/CytTo4ohX+JMgON1UOb3CDBmVRzy2YifE73MJ/5jRUQYqy51/po4
	wW1tZs/IZ1iOO7mFxzDrCt8+He6P4XAd5rkGouXYiDySDWJG18huG0lcmYzjJ0uv
	nUAWCEnmyWoTkK6NVom7Cq4aQFxp95Uf3+XFA5GeGi48Yeklvt/LwyU7Pb/UuL8v
	KTRXzc6I342quP+Nsb7ZgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2bnhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7SbRH007789;
	Tue, 14 Jul 2026 07:31:06 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qur8v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvFdDOw3F1YyYmaD+xcivbHEKZVRCaacbJE0Qp435wsRMn964Hcwbkq8g+TbNfrT4tzJJ/YQCVpw8yaA66xxjA3xiY3RKboDEmd8rm1sXcsbLHdGovDY2+7oXsrkD0GmoYrpkEzSPnWctzvMWMSdHeY0hhWLqvlZ+MAETvXVt7cjjZGklVcPdTNwB+bpvkbfV9Yma/QCYmEsioJ0aDnIiu5QYCPMMVimDxbg75MkB2G+MuHnQ84A55j2e+yZ6fSV5CHsdiptl+8dHwhaIOsvW5gMpDikqlvyoCwcXjY4VQSU1tfPBQ4Vonmu8adyLGuUG4+yYELVYDzNK79LvtACXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=;
 b=PBdmJH7moOcPX/eA2rhXAz4UMbuvS5hKJgJ0lZbp/eQm2NoW1wIolHFgd4ijQ/yKvBdqO1tqJYMpqYqe8ws/WkiBU4SVQaoMdnGxWlWN3diNBXEj+h1QdMKSfUb8pqmCD9TT2n7gQBgAwrgVYA65BOsYfDu7gGTrs3e3b9clNnIUBRTJ3XCsFs8TnOnmajdxcbLkPpohDXManOrJJqZYKmAdh3VvM6+rsJINuP7Gr444A8ZS/Zz5t6Z5n59ysFqertpbPzt4svAEQr+GhSDQUUloMe2LwJbLBAFJ89N5x92vH5/ZixIKzHIKGGga+gBbEwuaSC2igRjrgEkJBqivsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+mT8x38yrV66x073641HB2W6EifwrcZYnsp3oa/7t8=;
 b=iXoE2ZX1u3vUO4oOcaHdjvTKn0aEFFLaW4TnbMuzCzKJKgzIQBYKcJteQnybyEzvWNWszt6u1Oa6DwVx5Tnd/kRP1C0PVwr4cnfczDRF5qS7S382sMo+0opvOia2y0YzhF1+j583rGBoE6zrnnZhFg+pZo5QJ3fwE/8FcAm9L04=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:00 +0000
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
Subject: [PATCH v14 05/15] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Tue, 14 Jul 2026 00:30:31 -0700
Message-Id: <20260714073041.40250-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0395.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aed35ce-0bcc-4db0-1061-08dee179da76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	T865dE9z8aDImfEveUbJJ9FXUzWqttV3+qcq3Uc99WsXb7XamQ/WwJbyES+hZThnPtgtfiaN6qKep6DvufrKjAIdFNqsTZhA1h2CW2+T0W/XVU/tcFAIAlNbxjPiWUlOePjpmmv1LOfzIavppknV8GnFR/58t46TmH73aemOio0SlnpVc5ddD9qHL7bojcCjiT+qqhAHUXTVzQ8aUR2MDWL9AFslg51VvoU7xXMq9A3z5dDVzVVOE1xhakG1lwFX8ahmFqB7vhjbrtRq2iqMbTaK8DyGzlmFLAHaiYPzUVkYdc3A2QTN32GMIUkKf8o0RlzBctFr4utS+O9YNI2yptdRNOJz7hoEQXBUnNeqKaA41nFUzX569+c8TQ+VF60Md9zNan65u63xfmIGRA7RYRBIsJ+6sgEVXf5DiNWwkbw1G3wFS0r7sMrb3+XcvXgiAxEHVV+Nja4d9EIdna3/uV4805Dbt/+NpJXlbdUxzQM1JFRi4PsU7SGnvATFmIhHFiEkV33JYm589RTdi1/QPY5NbpZlhy3E882pxE7bH4zufTApgQmHrVqZ1dHefAKVF/pB/xIo+MrmbFwRPnYdNCqZJiNcgpKeotUPgzLuatGg4OQH18lx15TVhdStfyL0effx3bHAtq3r0S5fIBt6YprRdsQQ04D/pp9dfc8QZBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVMtEaGrfr55BEQEv5QyNghjZYr1+vpfQV2C8ywsHaeg1VfliivazA3fP+5b?=
 =?us-ascii?Q?KnFjAcZvmU93hjzl4lLGCDKyBJWcwsx8Eh+h3kzb8b6fxfZ01ONaVUrUEJVN?=
 =?us-ascii?Q?F3Cuw+SbvQN3wzK1DxsTFXB4bBMIWReqAjtpqTY97bYhwRmWm1h0MHnmWcuV?=
 =?us-ascii?Q?XQ5q1gIhCGPGOwKNv54NfXe9+JZTwdLlW9/pevlEHHcRkf+lVK7n6be1mhL+?=
 =?us-ascii?Q?Pq+aF+xi7uBcvJ5QvJajutJ69rbP+g07dk8cG140wRCiZZLi/S5s9WUIcD0u?=
 =?us-ascii?Q?iyDBtYvRpw+6t9GUeGavtIWDAl7pihurG5g/kTCBNan/IC8aEZhQpAYSBdY+?=
 =?us-ascii?Q?TFSNRzPkGHNGm4qkz75QtnzsDvRSdEolwm02WdxFV6t0AP9UdL25TMwh3UQv?=
 =?us-ascii?Q?YLcRRHm52BC0ybAHXLXLfIz9DvUWA9tZjsGyBp0pC7Ox3AYU1aNX0y2zoYXs?=
 =?us-ascii?Q?YT5yWhpaRAW9n33b3ybXzzX5JscbDACag+bIJJe6ZZJevHkRuHAEDJz6GkF4?=
 =?us-ascii?Q?leVp3z6HIuC2Jfq6v6blsCu6r88Ne5ZBKJEoroKpWZd6hOjz1/wR5COBk+H7?=
 =?us-ascii?Q?vmJRY3gHcXPv4DuXyM9xxtYbwQ5ga7JY3WDWfczrva0ky7kE63wdPQ3qPGjx?=
 =?us-ascii?Q?xzqbnjq71/NosFpSLQvf7I91+V3COozLHR3fQU3p+dacnWBxch73n95PSHf9?=
 =?us-ascii?Q?6dSUcWlWSlOF1uQ5Aohuu6lz0PyfELXV5g05hQ3aZeIpPKiNl1EqkakcK2mj?=
 =?us-ascii?Q?bCzvC8zXUSHPEtjB+gcU1/c4IBj4AbHXKbf9fWEtjZPKjvcw9rvXGNOn/R8P?=
 =?us-ascii?Q?ftkblXruFCXPyU7YRQ1V+6je64FKD2qJSI8ExqVSjHZn3HQrDSfGOycJ9nDQ?=
 =?us-ascii?Q?yUUEs4xbeg2KCMt/FS+5a39Cq42+xZqB6BHU4BVDLoNlayYqE16asdSEh3uY?=
 =?us-ascii?Q?ZjZ04FB6t1VzKmTGI0Qc/bVOgQ7748++v8y6aOJa4mQQ7G/i/lxm6EUjr9AR?=
 =?us-ascii?Q?++TMAw73DsgYqlagH8ycJdI+bK3ObwasS9JcFeS4D3vPEfYM7ULUh5WIHCiG?=
 =?us-ascii?Q?a0jR5dX9ALt95KreDBAYqPyTEHMjQweVHPGs2/hgE+fMAiGxowA1g6BMubUT?=
 =?us-ascii?Q?xrcM5ka8fnrEwikem8y2i8PBlxRWEb6YFy+DxuIUTf7gg3SJZpOq5KjDOneg?=
 =?us-ascii?Q?X87efa7y6d+bATMg4QVVXFnWtKdM39GlD9uXX73aVspWo84pgJUsOo9I0q9B?=
 =?us-ascii?Q?LwR4lxclPAayYgwbnLZVGusEb3PQXyMpYbl/+9llfPlIY4cgZr+v1fq92aly?=
 =?us-ascii?Q?HFhJUcGD9YjriQ+MV1fNO43gNUJIsvKP/h3exGtiz+5Ynq6UgPJE23Ph06wF?=
 =?us-ascii?Q?klNaOnCkW5Rx2PL2XbWrTJ+hF1lV2bKSEYahfjENe4VfsT+D974tEiVfQK6E?=
 =?us-ascii?Q?fyoHr2JhEPwSV2SrUKqPN8Axe5sS8Peull1mTjEIeHKr63kEmjUaI2H0c1d4?=
 =?us-ascii?Q?lWEMOivL3SJSGkqgydMmDWHSDpw05P6rBc4ZPIlct7FFKmvfsGCcmIYtYHfa?=
 =?us-ascii?Q?+wwzqf+Lrz18bTt88IKKDJ/E71gfsAfmBfWo4TckIjRo1mEZXPCg1xxw6iIZ?=
 =?us-ascii?Q?nXrM0fz3cq6o9h/oJTyMigwz6RXgFJTAe/67eK9e0kwZ5FqhfXya/7G8fjDz?=
 =?us-ascii?Q?SeQz/AUZDiG0/gcIzYtQXSNDXYnIv/y3QcKPk5HKjN/ENJ/dqFk4NNEHf3r/?=
 =?us-ascii?Q?qew20A1bFC9852YFMFQUgMF27RtC3qk=3D?=
X-Exchange-RoutingPolicyChecked:
	BmiCxl8BZZPgyiq+6OEdiRXsK1E4G+rAbdxajFtybewL7klMlfZZYUMFfdSdDhwEwMBMr0W2DNFW/DqhfR+hHnWSK7vQST5oXV9Zk+9g/R4x82tU5CW2xDZXJda62cldc8qyRSGV5xOSTKS/sNIu8ux9fyqfcEZPXjJYAFWLvbsTbXci/KKO62ruWHqaMJf39s2Z8Z9q1g4nfeV8EffIWSvl0njSMVqyGxnust9bnow1QDsftBaXem6Fn6tiDYBOU6PktHjoGH2aMJ83FG/+V5/AC7uUpyiKEfqMUVpHD8foO8Eec1H/WGmyKrsqyj/Vzx2pEvasC3NwFnoRtDTpag==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0myVrpoJTZ3hSmQhr/sbv5Q+EwG7LptVhOnCiJhtfRppgPudgzJxCQf13oZX5n2ilPa4qtMDM0ytSZgqLzm2MIHnsGufQm96aFg517Ri7v8kvoG+jmQxPvg0YWA4jB4/Ae8GElCzfWI90PTsshe9wY3hf9KX7GUnCNXHOStIqMMbmp/7MaTAeu4ZIbdK5oKBhjpTyn6AMog0xdyFeVs7rl5N3xNavSufKJ4IKz8G0/R1lHByugwEh21/7bQ3lsegWoEpoTn15d3u7wYA4wdI4dc5lD9WampYNGnh/14bwcU4ThrbH6UvrOcrqab8Jn8ATPbjNcWERv12c7/rGJrsn8n777LhubxwkHCpgHWlXeU8b3IoMagM5n3zHRXiAzTOok0pycEJAUlYmkeI/nmTzYzZ6WgLV62A2Nfc+Vj641h0H9YknnzyOH/N6CG6T0kjJcn4r/HHjCbJQqJcjpIE3UNaQyM9f//QW+aNRhAyfjtXJ1bLNZ3Q5xDRL6wiC9FJaAQLEA4XHTxcP2lyJZ6JXNv4QShDPy/3Eqk5r2rGo7NGVW246KHFW18dyg/fqASqbTb8fxs8EEknYKXDfOIZtjoA4Qvx7YUxgCAc8xaWr1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aed35ce-0bcc-4db0-1061-08dee179da76
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:00.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wMqKz/eaJ0G9R/g6/448iHMc4JmGlQhoeHeFReAV/gvjyxIu+V4rikrXc2Nrc0zB0P9gRtxstrSOV/kiRMSa9dgGD6LSI8u/ZGhC9freEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX4YWxMoK/vtfZ
 Tz7MfqEZraR4yDkJyEQqtvcV+qjcx1GqjcAikIP+zwHhEB1VBmMvxq8vPWMz8neXawlLh4/xMP9
 SxRwPpEYApMi147bWNrx1KXxzGGKBH+n4PHzikkz/SwEWnnbpJjZQEQetN/d1CrRcpJ7lrIx080
 vS8Ui+fb64qePTCmu1nc/X//6n3aZE0meiWer0kz/tW6fqu2VJJT4+qslu6yi3HgrHJTM6IPLIZ
 /BW3Ch56OwSIFh192G8p2K8vgUbmslYqHuP1mQu3Nz/otW/w2ewzOfAsIDStJYTEZc+22m0d2a1
 Xd+woGNiIc6ST5YgpRpPGmjzW23RVgOpIMicZPNsjHQ1Kj7wweXisXqFswmDiF1n3jytbPjqjJp
 O1uTpsF/I2hmGQVn1+EdDanKvWktkqu8v2C2E6D+mfq2eDp0yUl7ynJj4SjXlYIX4KbYspsyYCB
 3sThkVoVMjbhbRSdp/BQl3EEybzHAgM85RZ1OtF0=
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a55e5bb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=PuvxfXWCAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-GUID: z8UP5hlzxT3ftBIRq3ANGxhFMrlQJi0j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX4rTAvg9XGUqE
 HWyYh3fqly6L5jWbUrn/xzrH0y2LjZ7cdu2i7T+tjnRxJbsLnyQP6wdhY6TyIcHiEdCcriZ4QNQ
 aGXmRDUZelP18w9NDk3r6qUC1PV8TIOK3l6I2zzCxvfxX3KXwAgR
X-Proofpoint-ORIG-GUID: z8UP5hlzxT3ftBIRq3ANGxhFMrlQJi0j

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.43.7

