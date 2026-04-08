Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860C2248A3;
	Wed,  8 Apr 2026 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651532; cv=fail; b=aWkmhVRi3dGMxlucMlQX9mERAnrobIE+Gl+k8EnYNSRHnLEJhNDgZ2dTEOFmiawGYeWl/v1es45Iu5RdiK4v+ORCpa1ZfzZcEvAjZdSmplr16G0723OsmgPoIIo3i0XCx64UPkoX6fLIoNya2xfzNyyQPgp++jlmBYXXUAEECsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651532; c=relaxed/simple;
	bh=MYshbieWQnP0tYWq2yV2v8uPqi0VCMZk3YuYFERR/pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJnspLz0tp4tQpZgJ3dLjJkSUfRGZ/P59w1KfuHXDHkBMo7UUsHRam2ZS93+0PC9sh+nxspnKNC0mtQAc2tbFJkixrL53+ONoFQ3054q8Ngc+EObVq7lgFpbI9WBn5/53PLsXe9dEKnlsjJXLlGBvh/0bFkIr1hjHQ/MR4mnkNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LqkY2XXy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b5U4WArN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqkY2XXy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b5U4WArN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386kiQa880930;
	Wed, 8 Apr 2026 12:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NxiYtykFdSzVQMiGjeYMTLioAPuSw5F2JzJBDcdDhRE=; b=
	LqkY2XXyZ4QHSakdsQYZhhEjOy+10eYolPdjo0Vd9T1vSeLZcmV6u4dsbGqISRCK
	cwzFyXKJ5LNcjCv6qY+7nrVPHL1gsZktUotYqjbJjFQI9KTyty44Zk3Rv/t8ZnSo
	QP5Z0zGyuXww5jnr71v9Svp0NijfGs1cdKiNPFbVc09r9Kph/I5o/NmtFW9EsORi
	ZZT5CbYe4Buiee8i25b1pM1paGfWliVkByGCOQETYroxOHZ3nP3k/O8L/ndWNeQI
	oK8js68rMDh3K7nhskzsVNQRpZRprAA1i4o5PhZWGzl5VrnH+UrFgwGN4bXMWFo8
	fKEDgHcuER96LGmglwr3+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqb3dht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638B0N2G040702;
	Wed, 8 Apr 2026 12:26:43 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmn9ea0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YelwETcQoKXIx1Nr1BBzwNfillVeP412Y+n2ZgyBmoM5lLS2tQDjSCfswt0iUQEvDbPxzbRllKCOtRdeZxskHLZbrOySN19S/Kzfdsb+6Aip2KgDcrO7l0t88qMxF0ZO+0D3lEDAt9YHwh6aA1JTlJeqTnG1pWpb60bC1cYZKKPeElACwhq/Uh6x49UmeagdiRieogLLYMk9pt1klLvrIyYnxEYdPunhXLBeokcQtZsSBLd/qU/w863zatYJPP0uLq7hNFXMozSvVOgsprS8WKbnQAGbsvkHcC5oUn82zO9HhofLILFt4VFW6ljs7Jw0NA+GcP4Uv/b1PxToF5u96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxiYtykFdSzVQMiGjeYMTLioAPuSw5F2JzJBDcdDhRE=;
 b=qhzuKkkb8Oy7F080mxx9Rdn1+a56CVlGFDFpfjU9B5Qt4jVL0VmrR9WJ0S7EeyTVAIOfRUkiQIhDIlPr1ZxQgC4GAz+tlztIJkf2sz7rdp2PI0fmYWLEux9xom3Lz7QaduWbHMIEmechIGehA7C8sLqX24UHQ96ivkf04k5aCPtBuNubBWzDntqpizYFUZQQ/Aj3aNmdY80Pto7K6n6Z3k+hN+7IFyIh6HtCT7j18RB+eOnwjx6MkC2LhQNR+wXQicihkx9NjBGByKcjvVStA1kRxn7wbJv3eSL8pd3xu+bCtpOJorEHev3soQy8g9wo8faxl1m8st8fudAcUDaAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxiYtykFdSzVQMiGjeYMTLioAPuSw5F2JzJBDcdDhRE=;
 b=b5U4WArNsHNIq1bZQ2wOupMSBmI0VA0qZc4wgR6bLs7ozg0bsB2lsauPZtz8NqAvgh2ezVTLZf8zxXyxmrwdZtISOBBgcdxMW68k0xM51PU4pCFCenLWyUkdoVeLqxzg42ZZusI27+Ut/myD59L8v9qwCCTB+22y4a3nU6WBkJA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:39 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v11 09/14] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Wed,  8 Apr 2026 17:55:33 +0530
Message-Id: <20260408122538.3610871-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 38573c68-b45e-4090-88c2-08de956a153f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wC1oX6FNW1PUGA5jsFBl/y1I3pzfBMG/yNQsYXSEVCQgois7T5NrcTn1lu7tC5lMiZUaIhw2Fkt5LQ/iRw9hACBLaCAm9pxtrD+V5kn0noOy4R6cwGuMjSAJgoQ/xrumOGoZAWRjLhwnEtTjgK9Q4rTuUU58+knkljpZb0IZX4BL6YrqdIJB7MfeIB1vori6S/m0CWD3EK5IbE4B3s9jafjFrgy6lbCDDVlpihF0CGqB3Z8kxpajWdQfCaagkofS/3EBLDkWjUxUrZAWzgDohe7lczomn8HuTuJlvn2JreIlnbcmeHHLLMd1D/Pqdac97qAQgu93J9bsyRFlE1NHse5uq9UYL4TFe4bXYlce50vbTH2deemuSqqLHj5Y1Vk347mipXo53U6QBELW2YG2FN5F5mE6dQfHWbM7bihVY7ihxOJ8w5rGPL4bvyoWPwjIl1jniVAInEHn+H+/bGKTLf3/XbpxSsa00HnWhjx1c+v5xcjIVFNPlqnIuhjHCIZzaV0YVx4Zm00Tbbsp0JmZ1d0E7TtSlhW0RflCQAmL9EJhxldFyRMNIHPZi7Wj9YDINWK2MAprB/p/Y+UzuvAOSQPZwuDMRZ2uiAPYTW3zkYXfeTkO5JcCRFZq6qr08zihTQ9lpaBfrGeXHbFmPC/DAh4lMrdAsu9z1DSQbulnrBgM0DYF8GIq49ImJMqLPr2Icwvg/c2Coq+j+skdJ7rjaaw1Jds+7mt9CFFYOQ0ID2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGTFYWT1WPJGIuLH46bR9XL5g8oXGSNjKtylTc6fIa4Clv1QEm86X4cCVxLF?=
 =?us-ascii?Q?6qRd4XgsiOcxlzavL5ZZw3+gXDm8u+BAqqyXrnA6fmiTHloHAevQpu+A3x7P?=
 =?us-ascii?Q?ww0ricr8ObdxotWbBTWq1cuFANr9JJWH+Fkhek35L79QZg3frtz5EnGMC4Ec?=
 =?us-ascii?Q?h/iohCMIbay9XOshyLKvJBsmDjFqzCbAQw7oQdZjcD46FXVZ6G1Vbzsx0B2Z?=
 =?us-ascii?Q?H+49dA/LJgFEdU6OsQ4ftuKhOgQLzlHI2PhCqkJH7FwxO3nd3IrthoRALOdt?=
 =?us-ascii?Q?tUQwjs+WEkcF6TxMc5x/ygUYwgD5szTva1MyejXexIHmSn4QDSsOSsfdHJuQ?=
 =?us-ascii?Q?zI8cNcw0yZDXlY0VUWsufUyH1Rir8BjMtRhmbPGO6B1SpyfsQC5Jyf8NKHjJ?=
 =?us-ascii?Q?iHK+2wk+WJL0e3XwesMDyL043awJfV5KCFn68HS6XzoUMc9qCPkajLcstF/R?=
 =?us-ascii?Q?n1hXOUqSAu0yatvC/T47VA9koLXZEIIwxNyDqxiGal3V4oZCfiRCoIAvgCWC?=
 =?us-ascii?Q?QNH0U6ta1P9l2yCDEXscU5X0ZzK1zm9dN1RMHIthxj+KnTaEjid39cji/sF6?=
 =?us-ascii?Q?BveAJizB9Dh/peJFRuuGmJXBBWwVVocOkK0tjqyrBpE4nCv41V+N8qq9njYW?=
 =?us-ascii?Q?JAlqkC4FOqCxdKZ8yAEK/tY7aql92MhSYm9OD90nKuzs8rsZoPGdHGItkGPo?=
 =?us-ascii?Q?i+CHLrZzSWathQAWS80SXYEEkeDRBd+wicFVeJU9sVGTiU/NzAYfvgwpEceU?=
 =?us-ascii?Q?GC1NRUNdg9r7FzEOgw6i64RmDmJMA6u4z0OIhnSp38csp1iRTMeHjLj3OZlx?=
 =?us-ascii?Q?odGlFJZ0ruSaM+deToSD/x0boxfvnNepE1WnOEzHWuh+Z2DhNozcXuut7YjN?=
 =?us-ascii?Q?Xg+l0VlCANVosWgkwR9PGH7gAAvN/SKXIyi0EdxRq9c9mbDM8IIWJWDYCjOz?=
 =?us-ascii?Q?bRZTHDeDjlX6aRlXKmdPBO2hWi8x0VduSFbHANPw5cOWLYS+yBgJj9e0tCA2?=
 =?us-ascii?Q?5VvePHPXydAD5tt4eb2tv3M/D4m34KAmhN4Mzfv1u0A63vz60dfhWyfW0UL6?=
 =?us-ascii?Q?uitspCuZ3MEfzWQntzoBJmUz6TV/ox4gYMeFupL7XoaELg7aBcyZIC+G/69V?=
 =?us-ascii?Q?jAZFioxnkNH7sQfEnaPm+gHKes/gfuYC81gF0K7QDSUzJB5O0GHL3g1NueiT?=
 =?us-ascii?Q?xXxyWfgHnAgDgK1MJOLMkgsNn+ttEzdvZWv50UTOGmCFhw0nuAoNgpIj3jzl?=
 =?us-ascii?Q?7RAWLfU/Mp6AEW6G27SS/IROIsf4yl7us+q3fgYpXGNg9Kj3n6Qi4d/c4zIP?=
 =?us-ascii?Q?icBDAlWbolQ7FaiBAF1+Wl9vkFT4w6hfY4X7pksR18HTLpAEq6ihe9+YMFcN?=
 =?us-ascii?Q?Y2Pym7APua7Ja48Wq0UcJfZcSOiYbeHbpWnOXacVE8e/b4VsRLLVDPj6RC71?=
 =?us-ascii?Q?tr3AIfWidcWos7wVH1qs8oW66+r2pEFpVvsfIcI+NKjWwACYyucPQju/B2B7?=
 =?us-ascii?Q?U0FKktc2qvAqO3yD3cnc7o4fyEOJN2gMM3aSTLiE2pdm2w0RbkAIo4ezg2q8?=
 =?us-ascii?Q?egXk1n1KVyD8R7CjQ/8K7Yf6mCG+pV9o9/jIarTmk7OKvtEjDkhXby82kPZt?=
 =?us-ascii?Q?WnRfROFHlcOpXhZDlaeLEdiwUqZO8/wFUeOFr8n/OeEgkBD6JYvx2HswMHeH?=
 =?us-ascii?Q?eCr6OOTRab0RHvbddre3SfvlrqpZlE1SoM3fikFiUETiAmTZegbALC/Aa1Wb?=
 =?us-ascii?Q?1AjCuo7hTeEonXXXT/JWwlXHDnbbTzZKYtI+tAevmsnCNRDUkET1ZuYrvVw2?=
X-MS-Exchange-AntiSpam-MessageData-1: s+2uOC6LT49yoRzwDucGEwQJfw5lE7Ol6a8=
X-Exchange-RoutingPolicyChecked:
	GF/+aeDDSrD8vjKvgbTLbMzcA4G5SL45kXKRaXJ4FLLP51Yh6WvGgg2qx4dRCnQGB/ueLIfacW5wtMJT5aIdx15rxMljeCUJMtJRP6SquKQ++uOFNeIIMBWpNA1lfPdWqSmE5SaHfgkKItx6g8Z3BvqZlYf49BDWo3wZMlNTN6KHQr+b7tGk5jedTN2OQqEXw9wjD+tHAT/9BgfB5AvNv3OfhhXhPjGog7rf5Gi7mmWr+tixedslKGp3ihs8Nj2GC1z2+SUbu64NSEKK4NXSkDwReBUOHqQrc1vwnfh7+6S/C0eYbRsu3A2FvbG1top4+anTs+fNuxTNJmsI1R+UgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0VEJwl3SLU5cdwOBLJLsvWTSd0KQDlEmRCFwZa9mv+7LKPn3EldSDDXZXy+mH90DxEngdMUwgj/UXs8UzhuHVujB7SKOGFudstklGQxmPxKkICKDSSSMGsDvw2Xl637IQDyFgFQ3b9huQal5oZz2mCsH2Cci/42cZ2rM+ZXzlcznKixXg8on1HNiMBOC4Aoew9zu2CM9a+gjsQmUTltICU9aEzH7BDZccaoRgI7a+tM1rM1UUK4W6ZCeU91qEe3m6iNPFb303IqysJmd+W1LsArVZyrUs4paStkAPu9xizXZt3DET/4BhXhNyvJTIN+tL8pXTJYC9NMITFr9cyjXf2gRZlsFLNePu/D8QQingSO64HiqqUw+bvlCvgsjCU/YfUaRBmLPG5jBMTwTD9E8dFT+uaXBzjzcPvDnDdNY8S509HZ9KXjsvkHG8bCdj+F/KAtPPAanrv4jxgnzKpcTCP05lMNqwZ27EKdRjgo1QNdi3YS2cZ3QMR6e0+2EleWqOOnKo3n4KlMk6uleK9EA/rLIJBkIqUxW/x2qW+8sLXra0fq4m80j7fqIFhNqmAHmBmmvjluaSnbn86laoIzSyl+N+8zVbkNhVV1FxxMX6J8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38573c68-b45e-4090-88c2-08de956a153f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:39.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR7e2xwjk3wu6BiAJGmbaTggUUfn1PdEW7Jr3sh42BloBIIru/hmWiCOCPT5LxY0pAlDGcySbiRbQ1JQCy2MXPHF+tX3EUtk21/ai2/WCuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXzFwKpsqX4IuH
 OrKjkhGj9KnXYnlULz38V0tYH9qPVuKqamExQ79KD9+eBaMaLBj6EaE8TE43gJNMaOldw1AO6uU
 VuqIL6fHkKK5VD3NP1RF7b5EMbPqhEEgTVJ3DmDrm1McErxaCzZSXpoXbMGKw9xZQyoxf+qVd5x
 NkTpjy5ILi2PXDUb7puHXCn+F7zzYE8Y3DYgwKzAIviKPbPj/XY1u8ZCOCs2j5atjptwPPWgNkM
 mSID+dOf1rBpoD/rBEw4dsY2Ad6KomChyQs9vYAia3UirDC7wd7axmEz6lkZRDjBVBA1yP4S9tu
 bk5KUacH5wEkNLw+8mYujEiQZ9aOj1q4bVHtPhxi+HuUG5EQTG3fBfLz9Rr3O539bbvkQDeG/dI
 B+ePD6F0VPcg29FgVmrjuV5zy6ydxSWyK2n9tCBXC6zpXjr4zm+aOtRucc4G8XmbPjuuWNTJ6J4
 ilEAQouMUxyHSCHYhSA==
X-Proofpoint-ORIG-GUID: 6nZjwHkjHrfl3S639wULO-gc0Nms3Yp7
X-Proofpoint-GUID: 6nZjwHkjHrfl3S639wULO-gc0Nms3Yp7
X-Authority-Analysis: v=2.4 cv=cK7QdFeN c=1 sm=1 tr=0 ts=69d64984 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=LqkqbBbWekfmbT-3qckA:9

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
when updating the explicit return status.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..0ec17ebb67c1 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -231,15 +239,22 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  * as the macro does internal amortization for us.
  */
 #ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
-	({                                                            \
-		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
-		(ret);                                                \
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err = 0;						\
+		if (!(ts).spin++)						\
+			__timeval_err = clock_deadlock((lock), (mask), &(ts));	\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
 	})
 #else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+	({									\
+		s64 __timeval_err;						\
+		__timeval_err = clock_deadlock((lock), (mask), &(ts));		\
+		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
+		__timeval_err;							\
+	})
 #endif
 
 /*
@@ -281,7 +296,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -406,7 +421,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
 	}
 
 	if (ret) {
@@ -568,7 +583,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.31.1

