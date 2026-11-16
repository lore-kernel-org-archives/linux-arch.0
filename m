Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817541;
	b=0h1xaoJwDk3wFo0/sL3aBjCn9copb5h8B15r+cF6Yyqh7ss+TVTMP6KpgHePp4V33K6C
	 pZ9BhP8YLYxsKPxvTe0S/YpLZnYcm7hsfLXKgPjBwJ0P2hvq62GHM0i7mO5EJms+XlCqd
	 iXn/xX7MCA8DlLoL1RWQmghZ1vLGWKjqdjTFtCneCxa5pEhKBH4suSdghcqL8BypKJr7Y
	 vtpRsRr/OHBirDvxOF6UWxRmzEEZROg29V9q8jxpVSpktI6/EAVd8yfVaPvU0fj7aKg6Y
	 3ei2uw3mBKZ1Gr9V1oa1Z+dFKjCmafCbSLCGGHYXv3vjqv/YcrADYvozichDrYENFTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817541;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc;
	bh=prkav2Ycin3aCy5sl9/3WZIUZ+EPzqxPP8z3jbafH8c=;
	b=ih9E6skoDZxFdmE8U+r3uYSx/GzoN8HQ33JF+HZ7UaQ0B1+QJ/gcr8lRxG+mlhoHvrTb
	 y5nYzUW+j7Rsv+BhUX3B3c3PSHqChgWRiMgTJgOBvvn9VAPjKO7x6jFskqJG0PzsZvyhd
	 kmlbgEhMSAA8KMyrEzjVa9g/5C68EudOUnK4DHaFLapV+PfdCAFjXlqLeCvMr9NrTZAEW
	 5xLmCn8ajI8CYi88HAvk0JnrM4/lrMD9gdo2aFuxp1trv2TrOzFKW5nSKO4HlTsKCBT0I
	 oCWJnY48FAk3UcJWEthOMpeySRS6R9Ul5SmtujOPn/EdMS5f3jnCJpKViNEIXntBkCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=b7HiA2eZ;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=L6hSVhPb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F951606A891;
	Mon, 16 Nov 2026 08:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F951606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=b7HiA2eZ;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=L6hSVhPb
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNO1SM2410813;
	Mon, 16 Nov 2026 08:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=prkav2Ycin3aCy5sl9/3WZIUZ+EPzqxPP8z3jbafH8c=; b=
	b7HiA2eZVeN4Oqnr9wOWoP8qOu8GSzWS/WizY07NSrDbIn0WiO4v5PFGIres8NSz
	+CFiOho/AyALLSukLKCDyQaQFouxGPvH9nm3Tcfbf+PKw92mxrI4EPhOBZluu/XT
	n/mJDmG+3o/cR/Cg1aDhk37InrGXw/3qTh9Q36x3UNmIThr4LmXenuW4a+ru28s5
	LcKoUw2wUQiXehz9sCPX0SBmcjgd/wdpqhY+z+XUIkjeikBfy7+sFtWXLaNbzDfd
	R31OMmcvE1awyydaH3fT+4ku2zcTQJ+0t6ALNa4zteZEGpA/iG99yTGWfQ545+zz
	OWa+YCpT30HMx2yX1MnohQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxejbhn7a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:24:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7cc4x1550473;
	Mon, 16 Nov 2026 08:24:53 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv5svk29-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhLUxDztRp32DoKR/cFc7R2pQ2ASLGxNzFbx3Gd8qHayrUtaOwGKmC16s+HPhjFK9qe3K+UhcF+QNvKt3QqnUGsA7cOiJwCzfG2qhFIRJ9mJAq7qbUSmJkGdxxSEGDzcIE79lBQicCG7pAF7ZyZ72vE8IE+JxOS0FcKMwVyZ3K4aZtIqtiG2TWTbefPwH7+wEIBycXikFOkEg9rwfqMZQAPKTyow2yNL/Lw0Z7EVWKachrg/3lrOR5kYnoOYyjLn11sHmoZNeS8BPLLLxC2Ubm66Mk0C5QVzTjhmz29c5NrK9vgVQDC145VnlLB8f41LmRHGQBXO+4NzF6g1FwxgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prkav2Ycin3aCy5sl9/3WZIUZ+EPzqxPP8z3jbafH8c=;
 b=eB25xCFXS71/p9cHLzXPU3qlLq3ZtkC0Kj1fDPo0hK9PhFQFNyvxtCEfXw422hvcJCnH0OWVTxA9NMFFlN2FVVzCckPXUu2Vs3QruN9xKUtR9Yig4fWmSQRZaLsFEhoNQNT4PK9MNH/12J+zSla/ZLkZT/m1grRXwtVo7zaSs4U+uvHEQAzo3Xd2HPjS6ER0hT3qUPRlVQTRtQIXvRjM8SaG2iG5GrbSrKpVsI17yhVS5t6Oa9PeX3UwnEYtS5WT+rDlemZ1U+GthZHaXqTv78qUhZyN+r2NIhSAbTihqWwrCTNBibZ0RMUOVzwr59/9muaIGzOOoH5zVbwNc13lcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prkav2Ycin3aCy5sl9/3WZIUZ+EPzqxPP8z3jbafH8c=;
 b=L6hSVhPboDBIvkTvCEvc2bpU8cnHJxoVRNYBXkp25wqAeGbtTsK2PVrZqKUAfJJm6SfXJ4w3gEczIAi7HvD/GVv8DNGUDezkvLfaZj1z5vHg3vyv/fWNKKipnkukpZQvNO3UXu4OVRm/3nEcbc9lgRELm/o3AJHrtZwRrkmAaIc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:50 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v17 05/16] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Mon, 16 Nov 2026 02:24:26 -0600
Message-Id: <20261116082437.66739-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0367.namprd04.prod.outlook.com
 (2603:10b6:303:81::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 722d551a-ac1e-4c17-1346-08df43bb1505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|56012099006|261028144727099003|261026140227099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	y93+O6QCkMCMBQ/6M2dCWJf+FAETvwm0cJrm9h4IFT+mwEBg1HRAgJ1vcuQq7ys5FgIEvd6orxaRv2oZ8LbKRHBNujwSlczFp5TxV6w58PjzfRRKwu0xKSHraYn5g5QtGYhCA2OOzQDPHXnxDNgJ4U4mO9WYshtS9jckCAJIifL+z2ip7hTJBKYpZOB5XeNimj3HEw55wu9/5ePbWelGYIYsqcNw6QMM+2g9+4oyzI8Zc/QfV7+oNqgPh8CGaM/WTlThpIQPXuamQxALaeF48PeeIk1rLGB0IbDlvY5hwM2IyfecQt/AjvpWJNzlMsesWcwE+uZmE6arjyMpojVH7XItzhjxdSv80qlOA+yaRpxFCOkwbFSisKgdkS6DV7zFSJLvhTT/q6tZMimlP52tsePZuZztEVpC3wGQlh0hktChxtg5DAUPNYgE6xGxRWI6Bi3G0XpXfcO86jpna1s+nqo3zyKE29ZT3cZbyk4GAoUJNyNmZzKGHP0TwpD+tkGZ6CFO8aK3gId5z5MEevQMna2F0k7/UMMifqlv/zCkYyYgyKdpe2F4RfhQhsxeONXbbpiAglgU0jPntLT4CHEckit++oQ9L/oAbfWw2Him1yc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PCEdzpizoBaabyCcZ6YtIp2cgrW9e7XCo4/1Q0r5RlufMr9Pgt/1WT7mZNom?=
 =?us-ascii?Q?yqMTE2NtVWAMsJc4jHeiSA5sxtHHgVSxVgRY2o38ttLBFamn+qEVcOOFcnQu?=
 =?us-ascii?Q?isQghhwR8SnWoEEx9Xb4ukwfU9IE05SyzRXt9LOx9ueR5JRFVFddmaXsoMmo?=
 =?us-ascii?Q?3lsj+mDLm1oVFYwalZ8XgCm/KeCaO3CqrpYlXv1fZW8LHBWNFzjdgjah5jev?=
 =?us-ascii?Q?DwcI7bCdC2aycX1yDwO4l+9H8Tq+BQtJnFQfMxgypjV/ZGrHVaqg0R/ogOOx?=
 =?us-ascii?Q?DFtn9CMXmwoZwJblePkQJnQGRc0VrwusDSEwRNw8Oblvw3f4uJbzMQRJ60dE?=
 =?us-ascii?Q?AnjUeBemcbtO5pChjghcXbUIUYbOPy+GyLeG5uhHJTQXbXMpiYrciS+LJoAk?=
 =?us-ascii?Q?gTXzRe0YvN4pxMyhAMDJV3f+KiC/QnBn24b57nKpALYDAtaLViGoCRYCilc8?=
 =?us-ascii?Q?iMRTYqyiWBRNAPRBI9TAQ0mQASViEzpelTXCua46RjzYtz4R8Nd2EZbnQTaF?=
 =?us-ascii?Q?zS+Bu9tc/fQoroor3i6v13H3k2KiegV49MpXMUj1JsBvAPaWZL+OBqsyKNz2?=
 =?us-ascii?Q?vCAai7SPgdKFzZ7wAsWcKPLCnYD7AbbGHI4pr0SvjL1tovPdpP6fvoNBuNYE?=
 =?us-ascii?Q?0rYjmtQG3UjjBbNjZ+Mf28mK8BNHKfE2QGNZVto9xHyZXLR62Vm382rv2fE6?=
 =?us-ascii?Q?PSvKfnGvros1InJpjsQA+ZKyJv4JbzaQcYnwXY/cSphkweq4exIxgRlrLKlj?=
 =?us-ascii?Q?Cj4nTLn+tK9JnwroFEYPVgsyJQOBsb/snFvQL7QqlaSdSPYxf44bBijEcY0e?=
 =?us-ascii?Q?Rr+mDCP+cvgyRRA7Ez3kPnpZTq1rS7t+yM0z1pfGuqQazam5ef537q3tA5NY?=
 =?us-ascii?Q?Xr0fvSTm+FX33oyXXe9FYcMuStzFWg6ttmv14Wuri6AAZWZ2Sl+zNDKbMODb?=
 =?us-ascii?Q?KemV6xNSElL+OAql1rOcnieF7yY0Yn5NXeTGnAIGdY3njyCQE0Xa+ditU0S9?=
 =?us-ascii?Q?BtEJiZMNjzRniM36ebXMNL7nAU57SDRRm2vUZMQP9WRvic8npZSGbUiKNu2C?=
 =?us-ascii?Q?ooiYbpbhGOJLVHidTn1KMkTGn7xSmTG8EtRbBcGF6aUW2ttMLHLzQa8d0slF?=
 =?us-ascii?Q?iCPEeOd/c/nz4G3ZgMG62zrR/4+5nqxIrq05gl23EBIOdfLZa7W2g67mLwoC?=
 =?us-ascii?Q?1p3qlbXcTeGTq9bVB9/tOyDdQ+KOUjUGSW2VdwyAqmI5d63hO4+SC8OxFzEa?=
 =?us-ascii?Q?o9Dg4WLNTiLkTUJEgl236MQOqeqlds+bKSgxKdKW2FsK8hH5vWmxHFt+sybr?=
 =?us-ascii?Q?eUJXDwYpPLgJvRreA9oSez7UHXVcXC7PWJibmvehhiQHP1J1ee58TEZiNLnz?=
 =?us-ascii?Q?eyvewwFnjBEUBH+wWfyKAXG2lj654o4FIb2LzOoSKL6edoMM+Lv+vTgwiO/o?=
 =?us-ascii?Q?r/CC4Pfdeb9HZqk1d6A35E9eaviBxP76I31mZ72nAjYhPUG+t86SPOpwqUHD?=
 =?us-ascii?Q?gq4KNlgAuUFoP2tMfKo1u5w52wyex39Z6l0dQ+WapVgOas4V4Bh76BO/dNpD?=
 =?us-ascii?Q?5JTLNQgOMStg+Av6Woo9+y6DDDM1A53U+cIWQvQwfzFcpHcqfl7Uyxb+sBJG?=
 =?us-ascii?Q?AeoA7Rjept18IuA+ACmtuZstI4dy0UrXENab93JEmUlAY+irVwnDAzLFtx2D?=
 =?us-ascii?Q?Ni9Zg/qy13+dSFz4QBHzzhJhxDkjHH8UNZk96m+Qrf7bA4LpOUv/bwy3oaEG?=
 =?us-ascii?Q?C9LU955Z8g=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	gZ0PY0S64c5DuNnplLblRb3vS3EdMDkO8VSvPFSB8ivwm7gAwo4o3l/CX4jC2i9bc5qmBdLL29x9gGwsutKKxij+PrxfZd0gzFtbyi1lnQTA/bz2OKJ9uv3dr34MZPi7LoDieugn9k4vFrQRBavImkmcogWzwdCocOqRRj6GKzml74NYVSzAZBfj8W5kZ49rb0c6/zI2jL0UGz3NFTPE/r5x2dQVWhRVem4iqE5bbocrEZ4oN4abyc05mfD0RIwQcAZJeOmHfDMlry4ZoqrTwtFq8IR2kLYVus+IKYAWQMZ1vux2bc436Qtd5AvjjqfMSBphINZMfisACCnYGayG/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VkZ5JAc4Gs3uSUFEHROPdkT6QfPta2qIwNJExa4P8+Qy0ihJrX6KMatDQpNrEXz78cJ1fQR1JWxm993jCvO2qqz10/rC/7c0/uSxIlyHDCUun4LmDyY2MzdWE0lsXBsZ0h3uv35KqN67RzPbUlgV7dq7CQE1gF8qoZcYFZ0Zo2gYbnj/+Lqf91+lPlok0V3fgs2Nm9Zo+1RMHRr8ZXwWrCYoUVnJQ1i5ZwRlEicApyL5uwAtDvJsWjf/lv8kIrRfopvw4WPAdyFeuWDEG1u0b3ACP897nw3iu3C2VCFbVlrPrvRXden2bc49xnW02q7qZurDZLNK7wvNM8HjSIrDeuOrABOmnU8PeES/8jPgKQ3qingFGVO6LbSkzXBe/x3CFM1B/AkDrEVehg4fxQK86vPGgt4fQm9LnCurcfHwJGn4Yse1cH8nraxwLtK0k/WIZ12aUWJR9V8n9BYrTtUMObFT2Jof/oJfKsnrohdFJdkGkuBOwzSFkP294SpgV6NQehlpPQAyEStoRERPqZ7eb5x3wVK6f4N2kcaUSTx9hDCfNgK+J0HxHRo8qkKY0JNf9SnZ0ToOiNwnUzVntexIhxQWAd4t18253QqTtMSGIpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d551a-ac1e-4c17-1346-08df43bb1505
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:50.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1RL5tPcEf22PauX2zfHHZKWcKGfmWafP8N0YyZAwEbM1n2RUkof46JA+GDTsRODCc/jRL3FBEdFln7khr8hPtB7sVQktamyk3b9tvboyyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Authority-Analysis: v=2.4 cv=NrtE4MdJ c=1 sm=1 tr=0 ts=6afabdd6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=PuvxfXWCAAAA:8 a=yMhMjlubAAAA:8
 a=pMBjG9WjWPNDpSeUJj0A:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: O02xjLpDrUxWoRZMkn5Q9j2qbqyaXER5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX2XyBb8+8OrxW
 PcIh9ENYLT9dZj/NYrvYJj409sSfXS7tZk/rBt7Q2rPMkebPHVgZePRHX0+qmRPmZcJt1J92GZS
 XlW/cn1gzC6Rsb6zjHGMm6x0amL/7NrGo1Ul5E81E5mM6Obz09kt
X-Proofpoint-ORIG-GUID: O02xjLpDrUxWoRZMkn5Q9j2qbqyaXER5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXybzjzP+1FkNa
 bha2FhndRMmaU0DCAKjyXbfcE9qrGMGAsinyHjqnnwT3TImgFuSSBw82ML9qtlBLQvYbhOPw0R9
 6mT1ZdkSqrtSBbCQXsWoSq+6c35cIJjq4hON3PJIMnnjA/Xvn54Lnp7nhNibNFc4w++n0WHe7+i
 vNN+Ox01En8kwReqqypPysP4U1XMzaz6U3YV3ydhVynCR5BE5GRx78Azc5m/Y/R3YfxZW5dkaIS
 oYKGUhxNuo+aC2guL0rlyUA2hvt/lvGNyLsqTTceoiYBc5wzdRPEsBcBPGKqvhnXtAE6Or2vGIl
 fpjw4Ozoe7lrwsF9xBQBCSLT02oQclDD3//pROcVj3DZt1cmDOgEm8hMI8mUdb978GLxwv8aAom
 1uEKEzIn34NCiXJitSbrwrGjIhQLUc6ZxWZklDSR3d7WoWO0kcarmqSyR1KmT84cvNBjGUzS3/2
 u/uqst0OGI677HKhhsKoz3Mn2rqtbT9oP/GnTw4k=

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
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
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

