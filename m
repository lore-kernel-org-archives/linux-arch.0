Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12153B0AD0;
	Mon,  8 Jun 2026 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905967; cv=fail; b=ceP3sqWf6KxA1MHjWkpY/yu5WnZFOdRJgFscfdWX53dhrsyz/Bgn1ENbqA328J0+q6b/JkoLadcPnXEJld5V/p57x4LbIiAqofi9t/bDLIeW99ogKjsR9fVO6vhe96C0lWbZkdZ2XNRgQq/XmrGhTejw1X7NABlFbAhgUhBctqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905967; c=relaxed/simple;
	bh=OyCMfizG8gBKCPF2ewoUCdLDLz7M1InOcVcF2dwpbJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoXeo3Y80VHMBUvw62QDFQbZWG0IruB3NaQPh2pZkblvnAvonY9Y6+eqIamI+LTtHSHNk0Wi3BTVjRBKTk+NlxMaJky7ZjrGNDNi2Nm2nf0UdOixbADnFIDHWOI2q+8iPkTUoUJzyYU+cUOyMQfb/7i81Orw7sfNZ+fMFa2+RYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o9XYRXQw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q3TyVAb9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o9XYRXQw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q3TyVAb9"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NNrLn2141520;
	Mon, 8 Jun 2026 08:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fTsx0FMsEW4lh2neV86XYQR4cm6OYXFqcJemZVEERjg=; b=
	o9XYRXQwmHsZJ1sEwYxSyBZzrEeaLz5W+Mfnzf6wPCr2H7C8NbVoYG1sL7M+Wd+T
	hwEHcv7pmopYuItmQzZaeitELBI4NDhjnfXCwYbbiByE/JJU+bUgZeNnab4ok3ui
	gnyRWMdSkn7l8ycuW4p7bgvm4XK0betmlmq3wpG/LkfEOJwjxjPuo9TIiO7fi+Vy
	TPYvhFjSm2sfYlHAGI7HzxHmZRDDAh6gBV+3aIdGly5r9drgI6sfXRNgzVi8xBLZ
	Fy0aLYjQfvgNhu8PIOpbOkmUKkaq4jAVZxYXqqROUXlM1bRsBblIryHVZc44e/ue
	NUGiLIbQ4aWcStb5I7L+wA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkja0td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wVG6020472;
	Mon, 8 Jun 2026 08:05:30 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0ngrf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlseL3Tn8SVfvwD3e9aaiVfdsF+15jgeEMx6w4olzbyRUgec7YPxJtAMn6893OzKU/HXFappawTj9/xvhDMz9uwX7eas18xpI52sWu9ZnzNDRp2dgVDr+VbCI2GMLltRCmIFzjaP1kl0FcC1HE65xHtObHFgLx+A1TMPnTuT8Zzi4Ug/tisUzuteqOuAspRds90bx6F6lFPYbWXb30sGiM/ovCPl8LF1alx3v1q8FtjKGgkoj5TesPcypR8RLp6MtZMTs8q6DFQMmkIFIHeiiIloIj0h+PR/rnvGpOO9t6fpwxv5bmc7UuD45t6SdZDnIVG2cjXqRsU5rpO+9cXVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTsx0FMsEW4lh2neV86XYQR4cm6OYXFqcJemZVEERjg=;
 b=kDKMXlicbsfYKwYhFNhNm1GB77BAjX2VRWPTPEG5zvFTg1wVMXKCcA8br2its+6Xw08dAYqHoTBeWUHEL6dRJtYknCPJe6Yj29qIiDw6TgYSRx1G4qviF8aunPqNY92LLdZEdZBPSYXW+l3DUek2/l8xDv6psDC3ZLhSV8EvIEEauaRjKu5dI2dd8+xR67ehwfj7P2EhQK4EUecvvYfHSu5WjFb/wuStqYgCCOYKA1PwTSUo4q3G3+Llf72YPKW7Rp4a5NCdxuBCdpxJqIZrjRAXjlaWb+pvc1dYMVdg017WwNnMouNa2qP7BKu9qtEfi/VH4RRsLIoW7wTWKa+w0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTsx0FMsEW4lh2neV86XYQR4cm6OYXFqcJemZVEERjg=;
 b=Q3TyVAb9HCcwZV6XhUhvsn6k6U04uTyxuKvaPt9u6Vmpd0Ky8APmymFXsO1bTa1jrEa75p5NuQQsiqe0rP4cywKes4XqMfRRQk/cKQ9Y8Gr7DKCwzcxo/FpOxcrNC7QSEdWOdcmTlxzSc/bugcGCMy/su2vrZJIgbAV64yc4vjE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:24 +0000
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
Subject: [PATCH v12 15/15] barrier: add clock tests for smp_cond_load_relaxed_timeout()
Date: Mon,  8 Jun 2026 01:04:40 -0700
Message-Id: <20260608080440.127491-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: b5de5be2-c44f-4e1d-3d9a-08dec534b1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qZwYdpPkp20jZ6140cLHS6QGUpHfYbzJY8NMjFkd3K3IG/NlG6KyZOkyRfyonxGrB5bclfGjpPCWeilDWbpedJ+fFeFQbwLUtvw+5QnCYxLWIQCPbFG9YNx3CPEPxkp1nFA+v5BWL7/NoRRtyyLaFIRJDYsP6WR1CjDC962hl38iUmuTrou0X1vlK4rhk7ZDhszv9OHx5wjgk904XQ7r7uLBUIWlZEPkgfPLPmbbVIvjSiedK0qko8+DAJbP/UyKaC7AGBKvT3+o8phvbWAdQqx1LqF22wTjUSG7/bVn4xsIyp1pxky3+qDcnOo8BbiJzdX5/9lLPxax0L03tpCshjUPRhj1H8lepv5k6aqP7tY5QpXpw9lI5etjY0xdkHit89NRvMwErXyCK/ijQTbdgNSr/GjrHap60E1/5ThfGg6/ivzYRPqLQLT3HVfFwJBY+uyVUE82fv5WcKlfznnwc2ucv3B0P7/3kkDn//W/ltRC9RgmjZ+347an+66uP5rGfMtYpJzu+CX+QvDJUIo2OqhOjv9qQBfD6k3m/VPbGqfB1DM4cxQfFgCGkrunnCJSrhz5or7EIQet27HcxY0WT8XoKZuJD9Un8ah/o10Z7xepOat2wSUWpSFn2Kl04HAzZX2yP3ube7XcvXXb8wAboMMC3uVZ0eGrvmpATiVlBMBff8Z41EzC/cvqWaf6CFRG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vmmbGhxkPJY1isyF1pGmvo/IK2pxe4TSHC1J8xVVG20kD4e/h+G/Ho3noegq?=
 =?us-ascii?Q?wRB1k0wZrKDWfItItf2+u+GK0HbQDMREWxyE1wDEFMCoRj8o5KfzX6fdMaIG?=
 =?us-ascii?Q?NutnsBXL2M9+ulU4ae8Wv1uAnkHg7Ck/qdFEjQBWG30/PEmW1HD8D0kydAg0?=
 =?us-ascii?Q?WFsWr9eVe89PKTSP5+H6g4w7DHiYw/PyyJqz2str3kHF+4gq9W9j/zSbcFQI?=
 =?us-ascii?Q?LhGFyCR3p5Mb+RNqOvXOUIRLRXD9muxNwHjWZdTtOW4ylMdxwIvVUgt5QQJx?=
 =?us-ascii?Q?/1eA/4gkndNpnM/S4QPAxSpDgkPcqONSU2poxMo4Q5Pt8v6RtNNf46hqfPPW?=
 =?us-ascii?Q?bATNIMp8TF6tX3q7rLDQXmj9UifpYLoeuwieoXesV6aoZiSrb6ugd/lYf2KT?=
 =?us-ascii?Q?gnCRCS0NES89afHJqfiz+SylvjKyKTr/PkT5buRafr72EanAWWYklZYG43dG?=
 =?us-ascii?Q?3TYt+12Fi1A09gQb1UCsaRTAyVztCedQv3Xs/gBTTyuEsIT162d2cxYQoDET?=
 =?us-ascii?Q?xwBLlEJ/wHxzZzPDB94t9hXEUtB/Mayf4hdBHdNqpXMT6Iz6PpJQd4NUq9Ga?=
 =?us-ascii?Q?+bArXmqThgOYh41Z06W9gUC7SiP8MyEcMyeHKwSS4tQxMT02bp+U8wJ/hRj9?=
 =?us-ascii?Q?rhfzfTSjdHUwnbm/UPiEpZP9G7DtSnspOD65XDe3UeCeJUjl/+9popOv9W5b?=
 =?us-ascii?Q?+ytqwCYxrg43Accnu4fyeZL0OZNus1HQsKC1c2ahH4VcxPzZH6jYlW6pVPlS?=
 =?us-ascii?Q?uwB9BaXr9//eC747j/nErLa2WF/hHoQLH9IY4cI2chA/QJ0GUlRDoFBY+QBx?=
 =?us-ascii?Q?FbZHtMRNAUtYTXgwPYegZHw9Fhk36DLFqtcobyKIyYVj6CumuejH5mcCxVS2?=
 =?us-ascii?Q?KDqdnkb/4UuadhzvNF9RocigoxjtxuYN0dzFDhGU0q8tGKQAztRYei1ENpgq?=
 =?us-ascii?Q?UzM2NvZlobeWwv8Mwo8ddKvcIGr9xbrxJKDLEXXv7PrLmK0FvBZU/ayZWYJ7?=
 =?us-ascii?Q?Z7xV7Ml0phTQdC7QYVmiPrqTg3vCccHFQj1UDzdNZDV5TwODDsSdSQQWeeH4?=
 =?us-ascii?Q?qMlKarTri2XYlldh3YOZn85WfZE8C5SHWhkLv5fHlVXJMrSwyMTmtmuhtlMW?=
 =?us-ascii?Q?7Z6rmIEkN975yH0JlD0S2Ig/uq4vPZULlmSfK6B+HiN5jGzhQg6+h8hfIPkz?=
 =?us-ascii?Q?lbju8QfyRlaNBLOmQQlpe00BuB0eELlhiW00lTg68fgRzuNlc3DtoB3w0wJf?=
 =?us-ascii?Q?49o82o9pAkN23WqlZEnMRChN1TOewTG+8TdimdAYib+mR7SncLd9AvCiRQfC?=
 =?us-ascii?Q?YyIkX8AOZyyA0Sn+6fcALNOB1hxwyRnQDVqhNKzC/TtVCCkHJBMrjbbrID8R?=
 =?us-ascii?Q?F8J9Iu+tBrUWT2s2d5tozVttePDGcLevhVTi4UnphBt/tQczIfdCnbgMUmRK?=
 =?us-ascii?Q?Clf8JHAB0m7s0nYCfjoSAKiAftYdY/woBH7ETT8qJ0abpPwXvmNpW95wojq2?=
 =?us-ascii?Q?uGVU1QtArZZ8x9/OM3j8STOmXxP4tEbJrS8XTTinlcMcvgepCkZf1HnAZ4i6?=
 =?us-ascii?Q?4S0FpsgEvC5q482dzbMhiIu4OhMN2OtGFahly+jXTZpzMoiWdE6ndAs63Erj?=
 =?us-ascii?Q?E8h2NovMFa4JrC2fTi4QU7V1BBycr0dWZP18MthKv2OmlnJHQdaveWWagDgL?=
 =?us-ascii?Q?wlV64cmj+gTNdrUXmtqT0bUXA+D3aMA6cCUdADFd3PGolC6NyLYA916gMpf9?=
 =?us-ascii?Q?E+Ka8cNjVIjFRB4Eov8xlxDHbKEDtpE=3D?=
X-Exchange-RoutingPolicyChecked:
	Ft+0aYZgoi8vaN99mJpXrp+SSPWq/YH7SJG87BGfEXrFBIiqN13Zk0sw5LU1zPXeH4EQygN6dnp2/nxFf015rhiyDcUltQTwpNZ/rW6/6uUhwgLuQh79RUbM/gvSuwJmRQwdj9Msigdvt9gSwGBIleT+EZN31/1VzqPzNxe5dmjh/7n/f9AEIpNrFtxYJzspaQtDmWgSHCrBJd6n+7h/kaSoin6i6Ulm09iAd4BTQVOZPWJT2Pe23LeaKRuIJMrvArtf0BRQWbJzimOE/tntktsmxog0Xje2a9XFC8MywPSCMEQFkk9YEBGTwuVfZWd3jkXoy1lFmu22WxZf6xyhmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FUk/7c1AlrLbdGb/cPbAp3ar8ULzs08bM10/YrvWHMovVk28QX2+ex2tIgEr1ntX5ZUrFmqkI2vAxyoQTMReilib9ejpKBTh6ABubL1wtd7tZa1iDf+TO+NfOarbIEvpHdfCkMYibFMTJ6+q+TXryt5r1n1h+gk38XgmBqg9/4F0Q4/y+BTlqDcImWoVCgwd4Sj95xtCNNsZI19gbIoQB50wgMRpuWxWLg6z1JXo5fdcmJmz3iudQJdu6JEqYQZon+s4md0mt0bY0vOxg+gpV0kEDyCIfdAI868P2FJa6UQnY8jGpAw74k8iVdn2UDOlSAB3s+zrArP++RUnpqwV4WL0Xs3FnXHHW3cz+LtemSVWOUrtgAPsd8YiFULH2PiRw5yzBQuMCcquPrsJ59tx1UeKTRXRgKYXv/RidpDkgfywS04DG8EDRVYEw++F2A7UO+N+aHeoS7o2u9iTeU3Iw1HPDkMpq9axjOavcuXBpstFLlzcsZnZs3ZkpPucq28vhgEvUubEdiz4VdfIWcToJyTTzg+ooKYbJOb1bFNVZX/TbkWmIQDfj422MFKAKE2mqJBtTgVzgN/MQU49Ft7dW0RSu3PnVIuj/ma3apoFjuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5de5be2-c44f-4e1d-3d9a-08dec534b1d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:24.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwbuyLLoTZcLueOrShbLl7SAamRRN5PUmmd9No8AKMPFskCjqrOTBNkKnVULjiJTIpULmhr0YODVtVv5MLtlKRoj74oJsh2s9hXVajfCfzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXwAgr6QmVDLnL
 JNw4Cb5h6hMDpYFIU7Z1LJw1Kce6G5GQZs/2qHLOvjvKeUieZg5nkN3FVF+nTmF5/84I+kdAG8i
 nUEInJ8PGLgO6cX7K6QqartzzFnTyxeJcDmtg5nf38H1H/zMrQN/2xmqyIT4yMdNgHkoIYnriir
 j2lvEwgSLL7X9W5GxH+pEQKT6vmLgldD9DnYlX5nziEiXqPwSIWfiQysHolLdljJqJH6DC/8jI5
 UxAc18XILJCAmbM52RrTArY2JR4Uo2u4bax9fBfoJF/FB8R6GjVaclnLAYc0kQ1gFQFK12vI3ph
 mrELCm0LI9rj81QxwgoVjIXSnlnQL1a5GeXtuAZacVYvH7Yh1ENG6YM2esjCnLCHt04fTkDsjvh
 xxSWWgisLPe+HhYQMiSMgFpyAwQ2awAxNxIwybebUjNTe9UFAMdSv2LBSzPk3Rlbvxk6TMO+KZ2
 /O/tMwvhnZn4QA0ONGH2hdvnOSynZxn05/kbYHRs=
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a2677ca b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=EAuR-l_fSTGrmbixSIUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-GUID: USFBhcwOCo40WrJvPYmDV0t2iBQrt2QJ
X-Proofpoint-ORIG-GUID: USFBhcwOCo40WrJvPYmDV0t2iBQrt2QJ

Add a few clock tests for smp_cond_load_relaxed_timeout(). These
ensure that the implementation doesn't do anything funny stuff with the
clock (like multiple accesses per iteration.)

Also ensure that we handle edge cases sanely. Note that two edge cases
fail: S64_MAX and U64_MAX. However, both of those are quite far out
and if needed, can be addressed in the implementation of the interface.

Also, this tests only smp_cond_load_relaxed_timeout(). The acquire
variant uses an identical clock path and testing wouldn't add anything.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier-timeout-test.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 2160844b27b8..ec9dc0aa65d1 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -19,6 +19,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 struct clock_state {
 	s64	start_time;
 	s64	end_time;
+	s64	extra;
+	u32	niters;
 };
 
 #define TIMEOUT_MSEC	2
@@ -112,8 +114,63 @@ static void test_smp_cond_timeout(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
 }
 
+static s64 synthetic_clock(struct clock_state *clk)
+{
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	return clk->end_time;
+}
+
+
+struct smp_cond_expiry_params {
+	char	*desc;
+	s64	timeout;
+	s64	clk_inc;
+	u32	niters;
+};
+
+static const struct smp_cond_expiry_params expiry_params_list[] = {
+	{ .clk_inc = (0x1ULL << 28), .timeout = -1LL,		.niters = 1,			.desc = "-1LL",    },
+	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 30), .niters = 1 + (1 << (30-28)),	.desc = "1<<30",   },
+	{ .clk_inc = (0x1ULL << 28), .timeout = S32_MAX,	.niters = 1 + (1 << (31-28)),	.desc = "S32_MAX", },
+	{ .clk_inc = (0x1ULL << 28), .timeout = U32_MAX,	.niters = 1 + (1 << (32-28)),	.desc = "U32_MAX", },
+	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 33), .niters = 1 + (1 << (33-28)),	.desc = "1<<33",   },
+};
+
+static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, timeout=%s, iterations=%u",
+		"relaxed", "synthetic", p->desc, p->niters);
+}
+
+static void test_smp_cond_expiry(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_inc,
+		.niters = 0,
+	};
+	s64 runtime;
+
+	flag = 0;
+	smp_cond_load_relaxed_timeout(&flag,
+				      0,
+				      synthetic_clock(&clk),
+				      p->timeout);
+
+	runtime = (u64)clk.end_time - (u64)clk.start_time;
+	KUNIT_EXPECT_EQ(test, clk.niters, p->niters);
+	KUNIT_EXPECT_GE(test, runtime, p->timeout);
+}
+
+
+KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_expiry, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.31.1

