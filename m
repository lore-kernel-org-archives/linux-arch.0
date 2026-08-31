Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AE396562;
	Mon, 31 Aug 2026 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207832; cv=fail; b=kLVQLZkBACmKEQCs1GNVrCUV5xJZWc/1Eew/aRkxrEWGD4B6vONSWEOyog6UzY5KhbG4d8V3eBbiBIfPkVrKYOkXaU8QvfppauEVDMHYpJzb057ENwtNUBzgWdRc9eG62CekXG+x93cpmHR69SoyB535MTLSSTFTPSubbd3aJzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207832; c=relaxed/simple;
	bh=JsCeTIBiyQaQFX5gS1FnXO70lc5QbiOSm9Vha1G1Od8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgEHQmT8CLDn5DPPOnrSFwUbK1QOAQ8JZpMiz408ifD1P9NpY26eL0FTUBzjB1I9Jn7pAsJc53k7TrYtcqkrxt9X5Cf23U83xfuDVj4xuyDRYLONBoq+L5lWl/ORnraKHedo4Gzh35jKpcNq0+Xg6KnNZvuhyJBEzgyycfsIsOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FSajAyj7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UUylGkmH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FSajAyj7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UUylGkmH"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBpWU1799641;
	Mon, 31 Aug 2026 20:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5Uky4nup1PUr2N4RqDxNphYdeI4VFHFKuRHo2tseFYk=; b=
	FSajAyj7CWpuAFJWI4jlSUL1EULIZaolyBDdKrAFYMGtmLJtZZnKNmi0k3prdKC8
	1gRp2q2o1t2hynyrokqdcfJw+KM1OEliRIyPR4D3tYVHr01eoNflU7ulwrjraRoL
	P/JvEgY+y+LY8GHZJsxS1xVzKFHKaEm9I4L+n7Mr9VcETrombat6h1HDLD0VHIkM
	/MF7AA3JH0cH/Va0+ynROi2ZQK6Malk1EPmJgjPMxv7KOT8gkUurSDa1g38c5HRr
	MHMCd1vzSS0lg4YblczAjD/RVu9tRzXgBHl1zUARWy0yr55V678Hl2Rlzughu0bF
	FD3swGW4oFpk2pqVTNCPAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbq1skb3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKFWr7002916;
	Mon, 31 Aug 2026 20:23:21 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvpkddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2QEuSoGbAjY8ngOORZZpRXAreVj9+KhOUNE8HLnAf/W92H81b7tp50hcZSduAZx28VEq/kCiuz51ARwB58wgVwS7KGu4Iz4tC3EeDdcS87lI/tW6H/+UbT/K7wqC33JW3lyeIJ4E6LNfr0CJayCMsQyot84hhT0rlIdJ1r3/Ov/hoY5ouaA3NVr8r2RqU98XRYSeLUP/VxO5LyIUw+PGPJdwK2DzoHo2U5N7Q7c9aF4Gwmo642v0Suc21geBHKcG8Hama/d7WCxBX9NOf/zpBTIOxfR/FiKjMfyRMyzj5ap1DJ8Mv+3M5tuOjax/rF4cGL3AtBNwlt1fle3Jhg3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Uky4nup1PUr2N4RqDxNphYdeI4VFHFKuRHo2tseFYk=;
 b=x3SNhTr1r8J2eJ0UgiwDd8luA2xqRmDYyDc42LeJGI8ahcSst6lYA7iTQCzEhZ9Q+TqWsmfrf66ZyELVwIgF2jocaEjpEg+AMgHVanYWK2LIA93TLTPW1ynb/vAJMuc8GfR+uS2T1A7ESGpGYnukvQFBT6K4kXj4IE3eTvsIFJnkanajj+8xv8CBzz1kKxMET8pDYr8d0MZgt9+tSeOeRMRvcwRIPItZDiZU9OP4dn5V7JRREt9uXPRaw8x8W2y4UwAUIznhNYQzerWerzzPoF2v5ncAlCbgb7ZWVZlYCTPXO4fEjYd8NBUUD3IpBm4IY2WIK3C60jFp0Lt8ZYj35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uky4nup1PUr2N4RqDxNphYdeI4VFHFKuRHo2tseFYk=;
 b=UUylGkmH+YBIcjZPgTdGxIpTQoLBYr57UfDR8WGkdOUrsMNiLotdN5yD3u/CmZH7Ui7A1SH4tqznalsmRWxq6t40AtfhGcgsi5Q11+TN7SG1hWc9KETfB+Trv7RTlH/P3EiMwVJhIjIm2b8iMlY1pRyYsmaYlh5gukuCE7PlCvc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:18 +0000
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
Subject: [PATCH v15 09/16] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Mon, 31 Aug 2026 13:22:44 -0700
Message-Id: <20260831202251.305046-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: e37a1556-6fdb-462a-fb09-08df079db1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j86VMZmSjx6c5JFKFqoDoQBhZdiJ7pf3/RpIA/9rqVyt+4oSHiDzrTxj9ve5TlZYzJ4R9dg18P9Q5oeIPz4Pc8VWN4H6+GhNe0eVb7IsJFXw+JGH6tmfyNf9JNqk4zWYFENrPDdmtZFxvojgTz5TiE9nmsneuwS92S+/3tulICzEr7xaM8nF/TrJHqU12PC4HmzpjQJlZ8yTVue0SrSeLP1778/PYyRLZt/ac8mBe3mBfZPYncCCL/AFsARkKuYydf3BabE7YpgJA7NJUDF0q9PxhAiYRXLepkQFbVSiKsJjrwvvl9A302eh79sEudE1IehwItk+x1jJXjIcC66C/skcE8TySKzXbWw6DeUwisEkw5wQrOrfBIF4tMHKzlCHxox9TMNYTTam/bvoTXHAcpf3QkhwLJKv9YdmTTYQ3sehAfDpEdNz0C2gpXYHyhGeQ9fjB23NTMWdbIgejZqISe0ORiVcPErMP8S3UXarkspNqwcdZnXglNXgBCH67K8q7Meiw3ufgMqTxz4bdvTZ7xVH2SPMfkPc/O41Xq236cK4jOhWtikc6HkgqsvL1/nqm8uoaiLDTU6c4Xvq59+GSiVXe3kSmnG09c70gNpsaBMKzznbmh4Ewi4S8AKYbOrSW+zcatkOTcjTaHRh+We3Y267qdLVZzElBw7aD7LHoQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWeubgj9yRwirRcz5x6bBw6YK+YzoVHXfaOSyWL3ij6xM7cmNU4gaOL9V9q8?=
 =?us-ascii?Q?uzzS5b1tcpwvVTacbjsniYCCx8N9VElm4o6V3gKy1kMpvADmT9xzrqqHG+S4?=
 =?us-ascii?Q?HUvBZGf1m/c2r8DNf9AHiz/pxHSWjG/g4oLIkm9ANRl/aKqyQdg9Bc8EGTeT?=
 =?us-ascii?Q?+Y0pGbw1KtcsDg1DjZp2JYLbAG+kflh+HfKMMAOSAmWA+Qtf0SI8q6eqxBnJ?=
 =?us-ascii?Q?u4hfRrNqdM4t60mhKDOxfMaQmnSaDCOTL8WUxRYyALLIM24HHuCfNDlmfTD6?=
 =?us-ascii?Q?rXRzBio2DUX7i7pmKO2+Mx2DZVJHC13kGnhNu+BCuLvPINlcLc77qEYMGoq6?=
 =?us-ascii?Q?C+6mQcSNApN/dMaD3bP+QmIiJ3Wt1xDQJWqq5mNJ6lnfvNP3EYiFt6bRnQKq?=
 =?us-ascii?Q?Lv3gUtwkPFjEL8SzuSFgKEcXIpHYtf7/TXyW1S2bLzhi590NQygCfPl/jAi4?=
 =?us-ascii?Q?h/eZlf62O6uvqjLU9fqRh71yW0pzx7o7sjUwVTx6d1RhNzPQ02ZDvRSkzSuY?=
 =?us-ascii?Q?OSG81P3zxcqwL6bimYjBQuUHRZ1TAmzB+Xs+SkfKeixbKBLcbVoF/qnKZUp5?=
 =?us-ascii?Q?cS61VQXfQQw9cYKCW1D8uR8ipNqAL7WvjM6r5pv4Vr6hyaGb7V92bB1NY7gx?=
 =?us-ascii?Q?Z0/G0Vtim9V7eMOmE9iY6kgiipCA31iMfBw7j4SCiCEZ8GzFoGIrdFF/59cA?=
 =?us-ascii?Q?i33pHQ1+dDYbMP+PLmfgo9hEqh1nc9qmjyxIBBzW+iNhbpivdcbS7+YhnCAu?=
 =?us-ascii?Q?ldFTJvd/7U/Icjk/wri7tNznm/VHtufDlMVEZDv9DL2bdC1rUZgxQGLC3qEp?=
 =?us-ascii?Q?ym4R51CjozpGTAH1m3NNNViWGghiNvlzpvYK83ggk0I5RjVvus2XoSGsJ3mW?=
 =?us-ascii?Q?l5BP8X1o/FBnqRQ4mx6ilh7iXxgMqu0sHMGY8lI1/helLqeyHqmgx7zxCvcX?=
 =?us-ascii?Q?kQo6RrSJ1sli4uR2uDCG2i+sXQpZ8m0uddZ2L0HMcU0r13NsLutC4b1vtAwZ?=
 =?us-ascii?Q?CCYzhnVRtt/K6QH+R8rXllJ88mmFuyfS8zlmpA1Ua8RF57g7cUU9/bMTiS+b?=
 =?us-ascii?Q?Zpy+iCGY/R22gkkipBF470Ciw6x6jLMq8cpTiAJ7ORMHXJ4H0s7KZ7Rie8eW?=
 =?us-ascii?Q?4PeQmneP/Nab4+RvysHNDly+nIgO6JnRCrsne1qjhKz9T38doco2xAwrm5MP?=
 =?us-ascii?Q?T2NXAOlMb5JEW3whU56eJJDADyuzLcneghF8Sku5zhqKv35M420fwOSPIDug?=
 =?us-ascii?Q?ivXs9odjBCSMmH5oqgCMoEVtV7CjUZr+0xlJ0q1HUZHPOUiaoLJRRSexAhkw?=
 =?us-ascii?Q?oRFeOmWnZyEFw+yrlZjJV72lLJvA/sfALKS7FWgz0f56vD7eqJAK2owvvpTx?=
 =?us-ascii?Q?OR3LaKrBW+v7u9S7hPXrfEGgNrLSZKb5zI97OG8GgPPeisx1pQQ5BSB+FBIr?=
 =?us-ascii?Q?wW7jAeTA1jU1bMpZs/Nub4UVPFUo7o3tj5504fw5szK9DMeFl/gd2m9o6hJd?=
 =?us-ascii?Q?3BLBhE0pjSKXlfO0CLehprW89iWhZHoHY/PEdKlcAbOY8U4HtiisLGOdPqPw?=
 =?us-ascii?Q?/yvCECxocC1yl1o52yojY7wxVIEKYx8IS3sJhPCgWr4oJP2SCGn9FXomm6DV?=
 =?us-ascii?Q?Sz9HJIHskjdqbJFul5sf4BS9tqLEL0HXabZqJ7cQfmPiYlLpLwdjIWtgE9H9?=
 =?us-ascii?Q?ILBzc67fzYtiFLaHpNZTWTSJayvJRAJx8y3vK8+479u4dscO+qN2i3d5dd5x?=
 =?us-ascii?Q?jEP/U3Ay90Iz6z9zItP4LSjNfN1lVtM=3D?=
X-Exchange-RoutingPolicyChecked:
	0P/YAngWXkv5HoDLGlwVgJOi7bk9fZX0zztekSKlILxgHtaEutU2Dlv2aCyCaMEmbE7rOB+hZn56lmmTrh7LUYM+8hhpY6VDa4hBThWkKEJ320Q5la9BvtMOH14tYVo+JAfCHGqpGGI/EqAeo81hcpn03xdSEh7o+jY/SriDUtkQ7Q+Ay+W9n4nfnXkpRCn2w8gNyPpeftfepJj7ccBW+i/lADMvEjJQ+KORvz5ecC9AvkqCWWiVEUM7ySiO/zmDiutsXsQq5mKX9s0qNnSr6xU778vu0KpOzB2pJFm6gJMyrnonOpYTGOmEQd9ffuKy1s6JqvtqirMdoacXM29GOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K2XuQE93owzJ4T99EO+7ZFpzip37tuLKThvUkfkooXWCGkdy73U0GDYz6ssASDCPzr4vugFllaz2wY6YfpbYuTD0WpVftwL7Ag7WDKrUHM4fk28kBeBDX8/qS5zLzNVLt8m+gCIjXaDaiPBFSkdEDPoZSSZOcqcEvZiRsJlPP1pFLt55yqsZ5j8MsOWHPpqYsOHJQjymWMrIfIK7Q+JOcsWAUjpRaopRueGh13I4TJ5z/0mjubmB2VhSsjwXe8eL4b+HC3MOdRiXv4p59vWCjtPacP6ZDeeENQz3Q0cX01qSAOEjNL+CBK5B+C7yxA8zFVSqREqunM8M57nHIpu4NJNzB/SzYv5At4FySa8oMaafLwR50u8T/IHmJ40M10HwsZUw/7Nm3vP6AfA+NrMNr9vu7yXVMx5jU2xZbhzLMy8uXXaHyKCWbK6DAT9WVh3U5kHmmQLCCkzEGVqzPY8Tv/Dz3LOuJAMeup2JS8uJBlAWE3DLznWWJlzpeaQC0X6oZzlTfRgmahonFdUBV49TjzpQ07P58595Ar7uf6ftPmQ0Ra+1r0QhpnJcnJcqwUEkP+giMapVKNmoqpV84ZUAwbiWjfed7S3MeQhbICbCX/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37a1556-6fdb-462a-fb09-08df079db1f1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:18.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooH0bQEAJW+Q/0S9efN6KUEVLSyPXWA6GYnU5ziLNxOVp/5dPv8u0W5mWhQPIL+tmbsosfOSfkGJfBhQhQQ6wq2whM/187c+BD/S/asQ/hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608310175
X-Authority-Analysis: v=2.4 cv=Vp0Txe2n c=1 sm=1 tr=0 ts=6a95e2ba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=LqkqbBbWekfmbT-3qckA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX1dInFC/6RY0s
 xwLUtlvPwih9tLMDooIg86oPcGjHzmqJCrx5fALrOOKMCSf2UVlHZFwexDIGD0QJF6taTb6KL9c
 NBgkozcXMP/ImEF/QEW6aEyVR/tYdphHN/YoJ7/V22KdqpIU/7A21Tck2cZ3jK6mL80Bh54esnq
 tkY82zir8so7aktqXuqF3FlwVm70baWUqqvOr3x4tdGj/xyHOgFAyfDvmlAPgFCHf0DJ5z5/6rn
 V3kP2rM6APAFeJfKujf0tIrpcrh8iPJmY+VNL7jF/L9etFn3fHIcLYooqSilnT4gEqTajGFptj5
 cqUIr5R08MsqVPID+n3wnSNLEvvRxvm0+m55gtuIcoGLzfl8L+wB893AknMKZyzJG6jXL5ClqCZ
 VWSAcT+6v4Q+BOts1HQ7qJUOoPsH3UJ79K0T3v8GEcPFQirgMgfl+xqCMa/JlfhGNPJKe+3QWRi
 atbET9SVUaCu5ZFybnZruN7MI1uCEW1HdgYutMp4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXwxNeYLUSLfme
 FJDPwPLJd3dMYlvXz8CEI0zP+wcBEU9/RG2NjlXKtMk4rXsfr8OAVJF7SrCFQlJXPYPUV2HePrI
 OKIpQ9W5fl7uMzgRxezjGHs4ltBI8Lpgn/kv9vbH16YMZQmZDRu5
X-Proofpoint-ORIG-GUID: dP_K53jZxJc3ShcvmGO-ls5yXLOsuwWf
X-Proofpoint-GUID: dP_K53jZxJc3ShcvmGO-ls5yXLOsuwWf

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
index 111ec80ea958..1b249c6f0674 100644
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
2.43.7

