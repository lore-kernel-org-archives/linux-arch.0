Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3913BD638;
	Wed,  8 Apr 2026 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651225; cv=fail; b=DxA0LZNo1leDFCQWNNnHVBHQ77ParTEty4Ztdn5zga+PFq+BOJYxkIIM3wJKC2ApTtEb7Vm7p8wuEGxs9v3B/5tTPsDG6Qrpy0LHFWpU8zTrIypR2WS1GYZap0DQlU0EmJoSzQ4NoKZ8apgI/t7PMeHHSEHIVCZIe9z8ezHM/Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651225; c=relaxed/simple;
	bh=tyKyeS/2jLpr49Q3e1dU8wpSrToIlZAHNWmT99aDwP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=As+SGRY6oSdeeV/6u/T1UCkpRbStrMEtLpM5898soilesz/lL0ElJ5pDljVMbFySI9XdSm3ga+34oCto7rN+kQPTB2jgdA7xh7wdmJiFq+xYKWAbr1/rTQXORpjmq2aNFq3yancXziWkCRyUB4IzMbJcWAu+HepyoJy/vIrT+qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DUuyuRiY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xSXc81uF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUuyuRiY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xSXc81uF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638COHPe880135;
	Wed, 8 Apr 2026 12:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=; b=
	DUuyuRiYhyq5CkD1C+L+cyYF/iJWfmeRIOGmjJNnKweKljjwhrmdHIJW0J5wqR4L
	hnaTHmMZGaF3qQ78qkuNf1KpvAPOxFdeLT68Ts7WoNsoo9SZQ7Wl+YAMAUkeJQU8
	Pob5rBUBODH4E+P6ra+JH6jOXa9SO7jMp6So8NOLZTU/86RIGt+G/pLAL9ApbNR3
	pg1eCKAxKYYeI2pT1m76Pqbvzx6Htn9CyRaJpS6Fo710kEV0LTU9aC4A6AU4qet4
	5rPIL/RhEt5iLNGOf5sQtNhRyFJLVo+S8B4hpRkqd4II2W7gqm/TAoKXWj0MccEL
	45PRGJIRr+td6GgH1q9nbA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqb3dhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638BuVQf040687;
	Wed, 8 Apr 2026 12:26:35 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmn9e9vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYojSBLxF9qHeOq2q3s2Be9jnzeWwytdFmKSG1NgdU2ZsIDwQcoHCcRiUcOxZ3iMpR50rM8iFre9qOplneHO7DBV/qhlZsBewU8S94WDqlnSBAuypYfLuB7iBD52TAlD6ftqh5cQTNTGRdEMQ6DOfn+FbTOUujfuCHGWKw/1aOGQp3LD26TELw9r6LJyvNMPECoGz/kF2EnBEKAtujlPRT6ml9vplX8Ot/TVqnlaL/nll2aiobvESOslEGfjgD23BhE3rz2D9Bow25n9/FdEjmesMRsluW6ZEFHbqxAKHmhNxUBg4olLDGyW56dzu2Hc0chKb5Smam2moiqqYO/ycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=;
 b=zHH9cCSzCu+pgWPbFOhZuVs+wkenFdSkxOI/r4QPO2h//kE5fJ52Kloyu6L7lWCyZhjp4SpXptHrwPk+9Ji4lEkL5GqrpjYWh+fuJHHKwPMy4vn7Rb4xFCGMvcq6nEoCO6WT8tEJaoyTe5vMJ3XlsIiVB3kAgrCaNnrsnMWFZ7A1L6WhWWX2Zl6WNn0/y+FGnOUYGf6h1HiTdSLplMuE49oaLIXSzbDHnHwWy39tdOwHX74H8soq0V+ggWi1j/tsL8j/rtxfiLOmgX+ZqnqAwMTejwgl7H4MaAUyGqlFhFERLVMdQCRMaKr85wKjfUjhBLpR6bVfltrhz/VlLamWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=;
 b=xSXc81uFo8VjJvsYqAp/Jt8oqwxQx5d4KHaRYtFyOVU2NzzUViR+Rg31dsIEo5keDA4PXbjWkTpLi78MF2hUXz8atTkv7V6GQzY3M4rS7y1JcNd5b1EpEfT59+/Feqo3Tf2mMGFrdlzPwhNtXeUoInprnqnWjNTdBso7FuJojOQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:31 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v11 08/14] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Wed,  8 Apr 2026 17:55:32 +0530
Message-Id: <20260408122538.3610871-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f9136e-faf2-40a4-3585-08de956a105a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W5CPZS+2KP1YGwW80SBUJKfjOcNPsikoUyyhHectMsoaJm5SWBZ1cbVzYjHv5yO/MSwoBgQRfFX5hCSucloQHuuTEowoucMN0Wa/0WOcb0/v40tfW3hcJ5WOj7Hy9X67/kAKaoABJgvH5ys0MjQANPEkJtIThQk8zgKv7aZL6CQ+T4+SyVEm3uemafnst6XA7GaKIfNJiKkII084LsLVoU1PYpixb8UnlH3tmgm94STkWnmGISBD8MvyB/wjiQ5oGuOGA0GxKPN2YMgAKJUHMWWMpj6H0xIpYSzNcQHkq04LZwuVULxBs49lqSjmjWHYrCmj3S32Nq7uAGSYJHX37cB/7qs+PtS1/iv9OpjQbdECvzsJKhPyM/UyGUc3gIiNIc9hESzNOtEV94qTSHWrkU8daQ1XPUYjZ+e+9Mz6hR/N133MUnetrkCTOv/deGkJc1SU0xsWUkpFtLFGrcZYOXy/ZyXyAa/KPQuz8TJrAFTGZ7mQUz1Wh2CfzrHSUrAg7Git8xdpxFy3bDH6WQg7hp6JmB3RCKxg+KCYR3sOuogR+9Ew3A9SIoFgVrfWhQbTTfP58FZbV5FNFDH6AY6F9Bjni8HM/tfIcatqPdesYkVzH2TQeSZZ6xiT1QsbZo8P3otmHrASSymttKX6Qc211scjiPs/FCw1gCZWhfOGchenkzAnC+yT86ygoz/yccvHUD/Mg1Ea/S7FaZ1Kh02oI10GdAy2jGCtdgvTVNaJX80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTiroZKqmtXmjSOt4rM6bk1v4t2PIxGuZ5fu8Yw+U3hxm8p+d9batiEGmCx2?=
 =?us-ascii?Q?u4El6aquYJcPMd0QScZVMkoZfFoctExhW4wfgMjaOEGIbFtj45r0PFRgam1E?=
 =?us-ascii?Q?iTe+/BEh4DFbiweKhU1usncLaeFFtEszTgR0hxcLoQJcFrBey4AGr6sH4dCu?=
 =?us-ascii?Q?+6t6F967aZqIrkFAq9sBqnPTc2awq9MzKvWY0b1WJrQn12DmZa1M4zpOMPGw?=
 =?us-ascii?Q?NCob2ZxIb9zyIG8McWRVMJPngqVU5Q0PfI5keYmXPfGQ84FHEVkGCYmMpeXc?=
 =?us-ascii?Q?hHELODm5mmRUFZY122zlO7cuKebB8TMHDo3I/rvmIZ9QhkcgF5rcEFRWtxEB?=
 =?us-ascii?Q?Zwp8PL+6pzjCc8yaH0XvWRzY7IFJYzRiRahuXmh6YEbt4nStldLEfbyVTAGj?=
 =?us-ascii?Q?f6Kqn4pSbRxwrjfdvCONF/r8LWttr+UfnTdGUqm9k99ZGUo4uQYiC5ir0mUD?=
 =?us-ascii?Q?hzAHwkgSkA5UAZFGwAkyAZnNdpw8O5G2PedfJ7VQnbGNPf8EkbtbnyB2txLc?=
 =?us-ascii?Q?FEwcNLREH/ZAxXGhPMA58gLLYdFdCMY2T6txgc9GSnD/5hikcLfWr3Nscnm1?=
 =?us-ascii?Q?JZ3WCqE/VBiRa3kd6B74+oAVTTnVRHkvdotMHs7tCp+bK4g0xMBNYKYn9J8l?=
 =?us-ascii?Q?ZjwaFw/8LkGvgfy5ONFf1f1nrs+295p1vaiU+a7vVAwmbGbFFRUZ1S9z1zq+?=
 =?us-ascii?Q?YsJzYF2Uv9qC3/qtKErb3k1W0R6V9/NFXmpvYE2FUIJkj0MqpkbbSV7Fd6Ge?=
 =?us-ascii?Q?I3F+e6MByknQjUp/Zu6kDy+bnWfTeXVHoy8H4NCKgPpMMOcfTcz4gSuHfSSL?=
 =?us-ascii?Q?OQJOqgQgvwQ/sjKoZyGLtoS5G5ULFe/MTg9SkwS/G7sBoMcvXF4wUGgCfhJf?=
 =?us-ascii?Q?4giqRWRTY/ke+stWBnq07KOQmwNsI6UYDRkKy80Y5/bUbuRAYg5zAdj0yht3?=
 =?us-ascii?Q?dzIPoT+mGxby4gc76+33LqdEZGMK2NuLCe5auWEfTjI1Le2buuqv5DwrWssm?=
 =?us-ascii?Q?PNweDVp/UxY3ZfJY3JS0vPuCOXP824n26U0xJng9aDXyZNoPJLhkz9Xu2zC4?=
 =?us-ascii?Q?pNln40T6/wXB5kVWySOnthO9zSQen0AJNIFOHcPUYFPoCiCeulQqFgn+68p2?=
 =?us-ascii?Q?LnQuGsxv2wQ7Be1g+jJ/44bXNVqz2ExUT4GuxsQbz2T1zxjCnmUfROKaxNVQ?=
 =?us-ascii?Q?iaihDj8+mFrY5LPX4IBAWsjx8qLmniPsh/cw9twzV8oZjD3kmzjtiPhVyInA?=
 =?us-ascii?Q?NbBXHatY8NuonnUzzf0k9qTvwEpOS24zGcBw90/CD/Z3ZU2puGpeRXX8BCvJ?=
 =?us-ascii?Q?H0r5UO4Bxd9ytE9rqoSEHhegab8iC3pAbEqNLOxTiJJu4D0FylyUOV81b+HX?=
 =?us-ascii?Q?9S+fjrK2FhQQfcnG+atkITam7qtwzEfFJb1cjJgCcycHN5eYr+1j4qLDZVj5?=
 =?us-ascii?Q?DkKhtAOz9Cq+35wLaarwIjquMiouyTdo8IECVh3yPruAfJA0r1fNsXgFDRpE?=
 =?us-ascii?Q?Fp0dlfbirC7qL590Eh5Lvlr6cX8rlCNMECjNiXbxTB95CYXCwgSkfIBAdPq4?=
 =?us-ascii?Q?hpCLUtGpAw1Aq/hwUcJljVqfI2E3kzge8ufrpoeER2rSTsd8i9j4pXHhEzYi?=
 =?us-ascii?Q?a0Gnt+TzIq0D82E4Un/IBRvOjAQN0vV3G22rMlz9rgNOeVYqFpjW9hOMI4nJ?=
 =?us-ascii?Q?3tGsJ5LspGooTjiE71whzXPTDTid39n+yBrRHJAt+xdx0JBfnpbY4WWOviKq?=
 =?us-ascii?Q?/GbXgP7Th+PxVB4Fntv1f1g5yQinn3rfRU72ju3A+tcjr7TpIlLhn1S0ghiA?=
X-MS-Exchange-AntiSpam-MessageData-1: YnDit3LZcNz4znC99lZdGgbqmeaUW1oDnsg=
X-Exchange-RoutingPolicyChecked:
	RlZWDKryzEAoGw73deYlHC71JV7mUWxGQbFunJVAD2yZ5xvv4oHJ26fSCuZHAX9iPF3+wJKRHjZssGV0UeCDHxw7MY5LwmRWu8X9E/VpzdFqIla2ppwpySXVn1wNyUra3851Qp0i2tMrxXhWcrkX7Yx6sUYOfA1F3Kep1oA2uVJpTegG3RRHpagEAKPmMLMc35IlwghgAoe6VMY3sbHDHmL/zwBQmM+INkgpy0Wh8lvaSjj3edfFL5J4mxepy/2g4K6Lz1D2JxnRT4TUA9g6/TNTF9VCIEF17a8NU6QdCDYKOgjkZ7Z8SK4dHpe6GaM72k+FUcgsW/3PAhEJPsTXdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RsYc/t8F8Ni9qvZXQ526OwvrpG04dn9jkBaV36hz4inW3Bx/DsWGR2Iu0wO8v9D9wnY96FdNo+1k//aPQC6tmi3xHzdYcvwOlTOY/6t6/iAUZ0ILqLq5vbN+Au0hDLl4/wSMQJM+hFBMXehYredUeSal3NE+oifQ3EbPqmY0togxRDbz5yAgkBDr0h6Lwj4+J0poQef0eOl5W3ZtUNXSHCJFJRmNm+YaSepdx03pJNV32W/6JgItW/TtICVFdl6D8h3BMSraGjukrQPkBZJqJP/7yoX4VcDTE5EG1+F+x/JwFBfstgm/rPPhP9q5I42FPMfzycamKMXl7TKinFU0FFGevD55OwalAj8tfdLoMgKbwQyrCdoyX5HRnCQMpLiqYphVtpXW8L/2L0ArdVPJUzKpq0RpVct4zYwBMS50VOytmsPBE3bcElHWqdswA2116cVWAq1FXBZXzqMutHKB+Y+ks1DqDSW9ReuJCOcVN0l4RCVgrCp/5dy6AN2LuVTajPP5KA1xGWTpYTGNko1uH9s72oalehtgYWzErgiCEuFuZ2hiHfhh4PFvtF79+fkBojnJHX5EiBiz8QP7eQyDwew80Hed45tHkVKqYqcuEhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f9136e-faf2-40a4-3585-08de956a105a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:30.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: el57iZs56CAfDWGu4xCK7Jyw9rpt6GkA9iU7nVQd5miOv2y6MK4T2XpLQqWN8MkeuYNHpyp9c+0vJ25ItVXPdWW7vUxNWgRu4L0fBcSOc6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX0OlleuPWWluv
 XlnPfNLzrhhYhB51sgcme8Maz423NzKvA2R05tqfBxY5KEJem8F+Pxc7HBGKOQf/Ni5v0s71/B7
 EeHCn0RTj6cOrhldZ6SIBZx+LM2Hvz7CAmkIoSyI4PZfXO5dUfWpqK8dle/MrX8cFWk7uFt1BEv
 eTu13t27RCfsLujFeHyQrme2dceuW7kvz2ntkdkrTD8X41MELwmzbPxvxTG6YoG2AJ+du8uJzF2
 CtTFnjOL2RycbpOR7jsoGptfi8hau63cOrNdUBTtRcy3MJhqHy1rZ7iCOUSXIn19vTGndWXxTln
 uvRYlfVcaDUrzOwlhlpB7vnJEGjjBuZ2wAAFtITbunSUmCgvvcAvdc5ujwNN+sEMtpuCfyCxGEA
 n+0SDW9JEwxbHSy2Iz9B4A4khDgIcdTn3oZYXA2GbPWUApcsWoSHCOoZrqmngzVedW4WCN2I6vR
 pqrWBzm36tBKVHt24DQ==
X-Proofpoint-ORIG-GUID: WR7ZJR_lsN46yNpmYIUmFjr_-6a8Yx3z
X-Proofpoint-GUID: WR7ZJR_lsN46yNpmYIUmFjr_-6a8Yx3z
X-Authority-Analysis: v=2.4 cv=cK7QdFeN c=1 sm=1 tr=0 ts=69d6497c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 6a4e47d2db35..553b6b0e0258 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4b882bf19018602c10816c52f8b4ae280adc887b
+// 79c1f4acb5774376ceed559843d5d9ed1348df99
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.31.1

