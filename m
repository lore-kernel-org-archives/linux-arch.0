Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E4282F0C;
	Thu,  2 Jul 2026 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956064; cv=fail; b=g3G2mWj1cDdjJBADG1DYtj+C13ggEYB7lplRdgnl2GNzEH/3eqlJQYMPU8D10brNq6shDjCmBJWIaPNdnsmKW2kjfkAo9bYy8sQYYETsMb/26bIWvR3QzFOLv/6n3cvD9RExzhINPB9WICQ0+Ijv8EhAOXPhtowP7t1ztr2HbAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956064; c=relaxed/simple;
	bh=TXKJuw+pkA9Rr6N4C2Z3YRNTjrG7FLJPtn6clTDySHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Abvh36OU0zfx4rXtwgVRX1nBz/Ls8b5IZe9BELkgRgWytM8ij/RVdXQef6INmayGQ9bgT+4n36ebi2TUJtB/DsYc76sHdoIl+Umec4yTXnvupbHqypnhjAU0iAs5CpErtjmHmifeG1/ua4Jv35CEH6ehNf4Plk6T8EOP4RmUN5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=glTNcW9J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s9MSUPJy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="glTNcW9J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s9MSUPJy"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EKYJL2931941;
	Thu, 2 Jul 2026 01:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=9+jbpQG84pXOV45x
	jI6SqaoEwEq0gvWDd0O890xROG4=; b=glTNcW9JrlCHnTbhGjQ4g+UaHcQY33Cr
	r8axr7MrT0oKOvVNBU2Vcqo6n3UXbLXQYGlMLVwgx6sGVbjh3KO4V/AAv3ApiVp4
	rNpYmfE7q1WhOSQYT2QZuTmN32NlOy7I6pUXmb/mSokvJE9xMYS/eowfGLO5QrTR
	AnXVm/Yllr9PxykNdi/4/rHvwmb/FNyeIQk6RO0wJZ8rlChhx7D4VleLpalZQXha
	x6e53WsL6AVptwki8LDCAy1DMV1uutGUuAmXqeUjnwJn1+S9VXDjlEZP7DFV6wlN
	Ouj4u2F1Vv9ZFLDyA0CQrzwyCYaY0McRB9I4oE24B7BrA0S6Z1Am4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26kyf6sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X606012533;
	Thu, 2 Jul 2026 01:33:42 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24yg6v70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:33:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWK17LC/MddagLzwjqrPqHx/C6EMI/XTQAX5IjSulO1qgQeEdsqeagjN/1daKmitYfwMUtEyYRj16JgdlUOVob8TX3FPjYNUANIYPRn+lMkAUr6d/Cmhq7N+Wu9XlIbxWmp7QsoxYiJuq9B6AhNnedCYzegj0O1RuU02F39hYe1AZ4LEf2VxNNb9noqVYWC0+nBiocS+btC92a+Tw6huEW1N8EbMDjTvFE4hCtlzc+HDnect/D7Sd3QR/2kUfOHfic8/mxSlH7HWxJ3OdDQbpb9m1vTbMCZ82bx4BVqBs/1yJjdCNOuZUHjhAGByafhMVlMH4YWImTuW5ndu+IzTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+jbpQG84pXOV45xjI6SqaoEwEq0gvWDd0O890xROG4=;
 b=WFG+4YYVFMvqgrohhPLCSzTg5lllBufg297uP+z8bqsDTlbMyMIz3iKaaM4QbX/OLNrFxx5GijCZGGMFoEIiba/aqMSGDhUZinHQl4tRIRJ9BbqcCA7TrGXXIxW1IybbMCAaCkZhHhQVrN0L5A34dYjfoulCmSZJ7YeVVnHtoKE3UPZqqlyuKbFxo9qE3ADwKmemT2wi4wvsRK2vNa3DvNXr5d+9CWbs0VJL8EjIrjB9eAxGp/zXrDIHW9raLAxi9zWz4YnmO40CfDbpwCbnRCYzrIybBTxs3iw2OLNhvqGYoamIiSBeoMKnzWzSan/FpZnCZilQoCfR9HTZb2Rf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+jbpQG84pXOV45xjI6SqaoEwEq0gvWDd0O890xROG4=;
 b=s9MSUPJy5Q3aSQcOuylAXhawJbhfrTtEboRQpOI3q0TCbb5xp16t65Cf/exSgftpXfru8wsP0S9OeCBOiC7zEs+6ZSvoGVq4ijv9TvC+toSQRmdhXoSQruuqj3yhv+JhyhCDkfKiXKbNIMlne49AmuS7LZEiRegNcPpFClgX5ME=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:33:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:33:37 +0000
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
Subject: [PATCH v13 00/15] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Wed,  1 Jul 2026 18:33:19 -0700
Message-Id: <20260702013334.140905-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: f99c9ff1-9ea2-4d9b-5888-08ded7d9f042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|13003099007|3023799007|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UDoSv5WiHW+FHCayXDwXey227y2/L+nSXSiI8ry5jojWKbm0ZmDiaE1Gx8miIQahQyh4rQmH6xKTbMCZh6hhaBI0YvcjjPVogYkbG7ye2JuHTJnHBkdRp/ZawtW2NT5En8JmAl6gFE9gaNkZJYN5SMzzX8UXkLCDTfW49VZRnCbKqTfAs2nGD3js0f+v/iBHKGqSsU9Sa5MvsVBm9EILiHdv9euzzrrtST+yMPF/RJpfx8NYLE2woSmyoAM0ZmdKwol/qUBanO4YuXZhepgaFD0INR7meRk0JKQKOeCxye8DjDmExc7ujx0WU/qLbEkt5SJrQZfnHrPiY+/qBXTlVOsdgjB6xn7dSfkXRrAVFutZ79jMB94ReB6+fXrnOkMkEJcUOFPcm759ZEnnyzwgKzGcRy/Js6yWzyh9z2cqWiahy3Am6stp6SAf89SEmeWW/iiuXtFq8/sOykpYwHfgAmz8Fqlk4O6+B4PNJ5/gOXQbsQyXcQtfMBgMqcYLDVZy7c9txxXeK8QeiarKuAeTPxAXYoh8VDCwX47UWYtE9PiAm8yTcI5Dk3qWTwwlAyTOch2FcBBtibOgiQqPkd/0XXau5029kM0mXsUWhG2BEHvQvs4QZDUXxZvLLyzid9kXLM2P9fbqXGcpaAdOryZWVToRdajXeI3JqnUFMT5VVWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(13003099007)(3023799007)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WMBmZDEw1w/b2Inv9ht5pfMvNvTUX22aFGeYNR2VK4ZV0Fa53mUgU7G5G09L?=
 =?us-ascii?Q?UrGegHWB81W8iTnIt0d7BUkwmfFFypM88EpBkF10QYjF8f+fsrlOD0VHYhlL?=
 =?us-ascii?Q?3c2J5qY0L14N+1YINrrnR2a4jeahTXnLtSc0KFKh+2WhZl/5SZ+64eb9O+ag?=
 =?us-ascii?Q?VeZBta5ibPvqSBLC7FoY2lX/M/kz3OzdSr+wxg236FUPZA2nBx+gkgzFM1Fg?=
 =?us-ascii?Q?U82oruFTWDff9Q6dhWs81renhj2KYotrlC2uj9uXOeVUpntwR4eubOASgaGV?=
 =?us-ascii?Q?7q6dP02ZtjKKhDYX53YEP4NMNW8NizaT4TeL1hCYd+6CZXSmkZq3yZZTVV7e?=
 =?us-ascii?Q?xqw241Hgd34OTpH5z4egTU7VWSa1Hin9pcT3wbRqJvhNBqTRkJgapy9XrL3j?=
 =?us-ascii?Q?MbU7i1e5rmziO80cMYbzKG+5bX2qj1egMZ+iQF6gOLBAqHYCiXpsEWmCIUa6?=
 =?us-ascii?Q?PgW4wG3E+zRZfnzeXPChrHBulI1bUeV9V8DVLiZh0Gyg7O+cPYSHKLD8P2k/?=
 =?us-ascii?Q?5hrv+8dTt4N0u4hvFWN5K84S+chUfDOp2dQ7sTHYUFrOQOuELUumPlm5pewJ?=
 =?us-ascii?Q?2+DAw5brcsF4geYwoMpD/b5WP1k28K0ktQbMwiR+Bg/BI4/16Olq8natMia+?=
 =?us-ascii?Q?juOMc+UDci/fqQfzJgp6sWnk9dGbRxPZCfJurLr/eggzwm3OEYmaX8uvQzCn?=
 =?us-ascii?Q?aKYLfmjDuvP1FW5oqfca4I51pmJWMd+CIijTY+0p8XcgBLgkoUC0UktpOk2f?=
 =?us-ascii?Q?qkZ0o8aKNblqrqIlJTDa++YK7aUujThYsglrLmDEHqPIx8sTaYRRcizYJCDN?=
 =?us-ascii?Q?zf1G5WL6L3ovZzDigp/BG6LMxV8cBQaxfCqVt5BZP3U6OugWSiZH5m+9Dg2R?=
 =?us-ascii?Q?gv2NyQfG1gc/7yTFg6rk5WiMtamCGqAC9KW7QGyYFCrYI0JrEgd+paTz6Q4U?=
 =?us-ascii?Q?VtpmOXWrl7TglUaBOjXIc0nv6MvzShG28h4xysaAs8qtMiyBPSMtZ7bDU2kC?=
 =?us-ascii?Q?mF/+IHaDfy95MSkjOA47bL1sGY8HpUZwdXUAb4XAivDAIjEVcP2EGhgGBJ7O?=
 =?us-ascii?Q?3lS6X/jMijEvuGVskG7bryTMlmgzWUuvkj8pmA1xqMuVpXRPc9hbXFuYgHoV?=
 =?us-ascii?Q?XC157kYaNx8tfeMIwic9APkXwWG4IjH8xsVU7xphWutoXjfjjNzVGoVwF87Z?=
 =?us-ascii?Q?YKTF5xczbw+LXe6kyzE5h/uoNgGWLy9uAHj5RN2VgJozg8nk/VEjYH1MLLaY?=
 =?us-ascii?Q?22pQiW32RJafaZ0M84MZf+iaRbFpZnCwFWFKe02G+3iWqalwBMKzIClnXewZ?=
 =?us-ascii?Q?xMsOtd/9WvK8A+8mHtPPxjSXYVIgA1bv0/5Y3mw+Xm8eXyoPnO0l7dUhvLeL?=
 =?us-ascii?Q?XpENXRu58jOT0gaxRxtoP32Y32GoxbzdqjSVgCgFQtPCz9d9SGYc4DeZaaaZ?=
 =?us-ascii?Q?v6Yr1iXB1RlTyl4cwE7056Rno19mWTG2y6jh+h4822KF4ncazAfoHJR5h/bP?=
 =?us-ascii?Q?S3en2pG220NgOF5GK9elVFx2CHSIZyDCN2h1Rz72+BAq5cWJENUT3B3JTTYu?=
 =?us-ascii?Q?oQuhQEa7kbedWJnj9YvZcvj1AZT+JWRXfa93hyVuLe0D9QvJGh07614x/H8n?=
 =?us-ascii?Q?q+uososDEDpeH/DiWLllyrCgM63AxUWcvYAc0aa/Oup3O18VkGFVFRArsI5I?=
 =?us-ascii?Q?OtSagV7cmuV68kH5SN5MNunMV37NKx/+VV1JF1Jb1UMaJb6QJheQD8nWfkLw?=
 =?us-ascii?Q?mJmrFMSG6QOLWQgawSVcJUkSsOceHwk=3D?=
X-Exchange-RoutingPolicyChecked:
	V1lD1PvVQVmjcmRopzggJezOO/kxNw6LzwjIoBvWRKTzoaWdJE8f80wW7cHBNXzYUl+ZEy6/AXf910pykNnPddZiuqTWAGDv8t5vADOmxGPGiAKsY3mcBGWiwtf6TydLRiRc7c0h3g0gLzGxAIHaoYINmFhEqXBJpFdeO/nL0buzrVVYK1yUCq0fvZLVoNTffBTP/9eJd8zoWfiK9ZPOFlTU5MVherHH5DG/WsiLFr+qE8+N7dzvN8dRLiohyZ2QQh8sowulHCZJxizwwA4LV+9W5ABuo0hHHNhaqare4RMz/JKtkCZPP6BotIRp/Cj6fAxW/rhEGFbe1yFVOpWjBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ErKR33GzZmUT5kklbPvPxrefHu/f+oeDW8UrJFN3QQXU3pTuV+IUHGFk/wnpM43HWpMekkSaM8zZ1TEQxb+E258txC+j/QXdwD+kcKr0oI+bukAzUSXC/wdndu+PxW8zCvBnugCbb53Q5gsKk8S8uapaE2zE5mdaR6F1TsDO3Ead5rT6Sik3gXPVvQFN3n++NuiSBXVJtIudbALy7pSY1jRov5eGt23NU6qPOLU2YGmkOqm9c2lGj9vSKQrHdL/yxaOgDa0G7eAWS7aQSYHMDatGFyhhWKil0reGewLUdcMdP/HIrsVYIuccqxchZ9RYpVSjr+Cwygn6TqHhjrj3QYd5IN7AZZoNw8LfJDLx4F5XGzjaIRFX59lpTCXBirxrIAuQeQHPGaNt2IZ3CfolAs9ZUxexQHn7JcfIQP/gQ7nOojfqaED63XJ3bHzvc4zeCg2bFlw6gLaWZLrz97131Lxn8GUNOjF2eHIV7tjPdRejThRTM5bZ3fmmIs9w+vRvMWpq519vUyywECprGNzBU9PfgmS2j2VQmeaOKSqDQBLtZLUxBRtWtQqV/MbZv6DV3kggjlR+QXheIzJpPxfksQCGOXA2uyj5H/dWBaQGdjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99c9ff1-9ea2-4d9b-5888-08ded7d9f042
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:33:37.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae3UuRMwaK7V+QEmIaNR9SmE5TgtoSFSVE+WZLtJ2A9vgrXyN/utIStmpaZEhmPpl6UODBzsP+xGafIQgWlkUHR/KB98HXJ7Gs9ehd5HoIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX05OPQBPYCTea
 weSIfI29rDA5G7VKvfRN9KNFGXLEif2DbWK3WecowXCxCzwQivU/O4DHnWgqFNustlJB5mdrFDB
 JpQ077qcCHa6QGuVj1Q0Mia57dnbaH4wtrFv71dOKHt1dGIp7uK+
X-Proofpoint-ORIG-GUID: L8HojBn014hkXVmOQoDHiFK-OyVwcBGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX5f101Vzvgw0B
 A1/R9jtub+N2FkP/4Wi62+6aGmWnwnH0FBDpcQozQMO3Vuz7qGVsZVp5WL2jaJFzpR9kgjiBEL4
 AZrO04czn6PpC2opuD+sKqlcfYLJsagmvHU/VURuDyxLE8c9v4hBr5PZl2SEBflix5Q23mjLCCC
 PDpH33ekkrrsnaPVmvz5gmAcxuLuDQngdGgkmawmaIgZ01OHeOJd0wS/bDVYjnpjgo7VYAOBfoJ
 4vGtyN3v8YusH7ztdZ5xc7HFHUGqqvGaJ4j7yah0byO5F80aiguOCgHur7AWNy4aK87+eQytY3f
 0fbUzzMG8uz5AFnEJvOUzaABF1V+jw4UCtSfrDdastPCxvoIXtbB6klFOD6qDxvs+1ItWpNzlss
 gbgXd6/xt5uOc9YPN0UWElkf0qj1MJv1qClzfRXkitnUCLlLP+YChMLEHdK87QgJa9IxzmsCjMe
 sh/WxpMnEGN2UtAH1pg==
X-Proofpoint-GUID: L8HojBn014hkXVmOQoDHiFK-OyVwcBGN
X-Authority-Analysis: v=2.4 cv=ROaD2Yi+ c=1 sm=1 tr=0 ts=6a45bff7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=zETD0ykFHjB7dweU9fEA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22

Hi,

Main changes in this version:

  - smp_cond_load_acquire_timeout() now only has acquire semantics in
    the success (non-timeout) case.

  - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
    defining TIF_POLLING_NRFLAG, in some cases we end up with a
    degenerate version of poll_idle().

  - kunit: removed the test case for timeout=-1 (not supported)
    Also add test cases for timeout=0, timeout=1.

  (All of these address review comments from sashiko/bpf-bot.)

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
  v12 [14] (as listed above):
    - smp_cond_load_acquire_timeout() now only has acquire semantics in
      the success (non-timeout) case.

    - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
      defining TIF_POLLING_NRFLAG, in some cases we end up with a
      degenerate version of poll_idle().

    - kunit: removed the test case for timeout=-1 (not supported)
      Also add test cases for timeout=0, timeout=1.

    (All of these address review comments from sashiko/bpf-bot.)
    
  v11 [13] (as listed above):
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
 include/asm-generic/barrier.h        | 123 ++++++++++++++++++
 include/linux/atomic.h               |  10 ++
 include/linux/atomic/atomic-long.h   |  18 ++-
 include/linux/sched/idle.h           |  29 +++++
 kernel/bpf/rqspinlock.c              |  77 +++++++----
 lib/Kconfig.debug                    |  10 ++
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier-timeout-test.c     | 186 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 ++-
 18 files changed, 552 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h
 create mode 100644 lib/tests/barrier-timeout-test.c

-- 
2.43.7

