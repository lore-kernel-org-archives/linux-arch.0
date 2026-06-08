Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D63395AC4;
	Mon,  8 Jun 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906253; cv=fail; b=oO4PXL21Q5H49nkSvGr1eoUllHICu0z5+4hRkNUnGeToTUunIKPC1qZsn1mzpZCJ2BfEbk6vsf9BeRg7N+DgVyUqvsnKzRDjs3UOMcpoeMN6ly8EOrWcxLKjdssz6LBIyRe0rNi/5EC5EJ8d78mra5k847282Zcyx159QkmEllQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906253; c=relaxed/simple;
	bh=d4gRDdvJqMFSUTNxWZNeK+fpI5wn+nxfWjJZLthdJEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEMo0RXI0jHRnQOUbxeGpM5RwKgboiBI7fFYn4Yta6Hdh8ItilCWm+7cMwEuANyMpu9QKhEZ1hV/LHc8Z2LBgw2NV3ifzYeAJJTnBjJ6gpGhOOJMv6N6r8zBWnh0SVQ2jpyrjWh5n//FV7y5pXAyGIT6zT94RWSw4MJ+JbrfI/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XvigtKoK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OgdLJeBb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XvigtKoK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OgdLJeBb"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6581KUkY3791268;
	Mon, 8 Jun 2026 08:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=don0OFfZ/7DOC6BlzY+fDiBURFg1EnbCCjhr7mhLjyI=; b=
	XvigtKoK/LURfnUDItpflNkiB6dANLZ2m4uBGAVpsFXw8HLNVFaG0A4qcSdcBcQn
	mz/MJmrAR3fD507EAswb1vZxCsch9Sqydx8BpXD2VWKzs13dXeH/E7IVvEmPPkQq
	UtYgTyuKW/7Q4y/TZ6mq1yBkPYk1hJHug3t2vJsPhIgaMrOQb3MW6KTr4VZbxCAL
	NPviY5c5bxKrX+RRbLCvjDjQ13i+ndA+WwnC4lnRGrGbtAw+yK18xpTCKQiF+UyX
	NDdZKgdm72VXHsHpTl4xoQTfLSvhseBubJ1YeetHTmn9CH63AmOdBMDzdNWru680
	9AcAajTpCPd6eI2nIqy+VA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4em9yba1d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wTDF005914;
	Mon, 8 Jun 2026 08:05:17 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0nggnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc1qEJK35bMI52AVaJgq3SCt1D2VAOUBOT7G0xzTdjb0sdmQUOfOgaKcVXks6hLMt4EyzJFlBgQzZe3LVzZ4cUDNe3dadgthvEKbKZV5RTYMrC7nFov2XQAIAMXutUAGmU/xuOpRoClIFMNaqKJ4gmlq2OIwYKqt8seEbjfZkDaXAcYXKBoMVLtpEbMmgVSfVyOPjRvWbSWd1Aiqg9/Yu5Wny0ZiCCsDSi66vsqT8kzHU69ieZvzL0ReKfFWHMntFOSOHtvLYxNQuA0GH/pczkE9ADch+BbjaxGo28eGQQ/HnQ4AsUcMscz6+QfvGkI6kMOjCToDhdl1BqYtrCyrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=don0OFfZ/7DOC6BlzY+fDiBURFg1EnbCCjhr7mhLjyI=;
 b=Th8yQkJhauGZw+ptyvdAR7rO6kuZ7o/5VRUAxzLrP6aO2fiHnUBdFbaFsSGFzJn2vG1YwnBmVKUf5bZOp6vb1X48+BH9Xs7Rcn7ZEN038e69zmJM38G/1rtPCvwReLQA9W5mqn0McOCjO6Me1wsnIXII0dq9z+jhft6uDzrixqeJ4hlsF6DrmfLQE/vy1U/smFpZepy7ohmW8XFcI+PYGJVJj6ePJ4vg0uyCIWfxEVJU0C/I44oXD4wo9lc3WutEiG48Y2Ih9/NxJSJPpO/ZFtkgJj+6DPiSWjdSSzqefXRSrmT/w+BNn5RCqBi8Q+uxREe/+OQOiVt2hRM2NRJVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=don0OFfZ/7DOC6BlzY+fDiBURFg1EnbCCjhr7mhLjyI=;
 b=OgdLJeBbhFPJvkHgqFEAkbjUlSQc/bcY9vKK4MGDlRiyl1Y8jg1zwzeKiaFMnYw9MB2r0lzVgkcjP33bcIJ/SJ5TU5ZGrldvFHzcGMMTlVPOi0+6ggP+UZR3OPcE3upYbP+6MQjOYctKG2sqBRx9G5/LhEZAhgV0ZGvTC+BEaFY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:14 +0000
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
Subject: [PATCH v12 12/15] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Mon,  8 Jun 2026 01:04:37 -0700
Message-Id: <20260608080440.127491-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc61c38-3164-450d-e7e8-08dec534abd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|3023799007|4133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mhg9UmtguGePSMBogRY+CpN4sYsZzoyMltQMtSzenxJxnOZkwFm2etLvffzQqcceuqXMotaspin7asct6EXLVVqRokNDZjSZd1rs0Lc39lm+OvwxmSv0i5X5cmaxd3lwi50Yi/wTdmHuQVP46UHZLJnNVzfiIyJTvVnDADARwVnsOpoGtAn3L2612dN1mFtVlqgP/RnhlLTOORnuBTxfL6BcmyHN96cvQld/ofQ+R5JoYSy8FTfjgPu2Yn5eJc9N9LuPdVC4RQV02pB+FfhMwaUGd2r9jFdwwO/nkYePfVSyoZMDy0N5mZS/ktUZZs7fjPJaUpX0LJdFRO7v9he/XZ78GqbHhstSQdQKoYs7PgON6arIFof4TI6hnjsg5wnAKidhxOzUmYoiOx5v8RaVrAwDeivrzx75uD8vjM8G0n+Mx6NYrT/gNkjdKf25QWxK0hXYF/n1R8pD22ABhvaQqB8RO/oQJkIIrBGT+c6UszVR/WIbx2igc31jNe1jDxGORg57ODYDgy8sk1Pn+sxw8dmKPxRnrUVSayVp+tkGCsqYi8SGUt6WK0wo/mo78RhG0btl60lF7Y2P5j+R8v6TcFCXOtWWwrODRjTLQ6j9dd/L7c+O1GVTswFszDNArB2wjc/qcdBK7LPrkcNPs4cTIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(4133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wkl4SKc8fvhUednYyKb2sX4BeYamIqx1s0FVKMmYObvJrUCx5t12IkQxqT+r?=
 =?us-ascii?Q?miwLwfq95zdHkFnMtnhqB621lthNkaSaRRKZZ8Or3AdIa7ze3eEoY2dQUIJM?=
 =?us-ascii?Q?0xBYGtFDtwrR+u2setqMp8vGn3zrUQDTK2pgllGjILwDEWq1Eg0inSblNfBB?=
 =?us-ascii?Q?2mEXTAJ8qzK3RuO0+S5QtCp6+agrGR9lpgkd9TN2gXh7QqMaqpMI1oOdCT9k?=
 =?us-ascii?Q?rSG28rxG15gHJaeLoSdmEOQ9qNzVPiUGqpyZKeKcFWH4D7GM7itQaHgcrjzE?=
 =?us-ascii?Q?UOWwDGjjgXluBAJd8A4f2FNw1qF+dmwOlB1VtyEsg2tcVM1H+hqSrsM0PFJD?=
 =?us-ascii?Q?7ku9ZakuihxH0BHf15TsTCh/MdJ5bL4u+NHUZ83sYckZZtcQdzHiB44tLLoP?=
 =?us-ascii?Q?PVW7Mt+nd+pdlGUWd3QYKyovuqJVV6ycJa4zRONT7xtoUN1f4XCzz2nvAEOJ?=
 =?us-ascii?Q?o/NzL0rgzM2Nkd5N/IxHKZgDE7tH6vfCzAOrFYnt2MQjTZa6o+J7pwbIccq7?=
 =?us-ascii?Q?2dnCO2MTbaVojNhC8esSvRhKliqtYUfFWohdu3hUkl++rMNuQspRgWP8EKwi?=
 =?us-ascii?Q?CKlRlFnfyjTJeae1z6/ciRwdXsSD9cFmQXnlQjVu13e61U1OKD73pUzIsMUz?=
 =?us-ascii?Q?lZnNfqJwbx5IQJQmYdL707Cl5KS7jCLmPZq0XZ2OBWFVod1W21aTUk2Ox7YE?=
 =?us-ascii?Q?6igGWjr1e9hiFLRfpqPfAxj8sPBTBaRT/Sv6ZPPIvMPgii6UMGTgigdZwaTv?=
 =?us-ascii?Q?mo8SU/wRVZHWLWF2Gf0bf26y70xEgECFkfEKJiEkEVMjt+4Ue2T7ZlEP4ShE?=
 =?us-ascii?Q?K2+UwGhE4t9DhCvERy+Ia/fAYZEzw0poMQ/eSQaVPH9G7up5R0ljGSffyjij?=
 =?us-ascii?Q?Y1mt0QbdZbdzT0wl9wlYEEZCEKaIpAvA4s6Joem60dYgo7HXhKNSD18rCmFE?=
 =?us-ascii?Q?XiZ2YzomUHY/+2EQLKQZJEvdnMV0ZbhVH1e/ZXh7A4YTmQ/l84G4OAvof4La?=
 =?us-ascii?Q?OdssDA2unxID+VtBTZNoXQwWFRKZVWsSqJKfQd53RKZis5f2djiiGB7FQCuN?=
 =?us-ascii?Q?q+dQDNDqL1iUBPFw3WeGCgxcmgHS4im5UzNauBa+k/7vJmOAAUL+GmueQCt9?=
 =?us-ascii?Q?d2DV7gRFNT+6/R6ziHjfSq59QP57I1AoA7w46DR/iLZhneHgsLLhPL3cxUUW?=
 =?us-ascii?Q?s0L802gyz/ERhqtdfxlBEzo+Cut935bQL45XVFUDOAjJP9Ja++GoY2cKdNwU?=
 =?us-ascii?Q?BPUHImp/23DPUvn5ulCxnXFn3BFs+wgReU6iMMqzjXK1kMmn3hKgIUgukxWq?=
 =?us-ascii?Q?45z6W8cCE0WRfAeQj3Che5Hl28cU0tfA8wyihKnqZ5lahOIpmvf8YrxIzsQp?=
 =?us-ascii?Q?GnkyDTOAVmgOyuSKOzfu9IRzqMUv7JFJ3/LgS62xcg6+g+J6GT4B4jRpe2PN?=
 =?us-ascii?Q?5W80FAbmPZXDYcx9Aqn9HX0TEsLgzDQK2CBPlttIgbuu5Q9k+DuBQ6A/wMMn?=
 =?us-ascii?Q?PSyNrK3reInxzlwX/27RqfnHrxoEFWDL8iptt8FCx8yB/u0No7A2tqSCAnfb?=
 =?us-ascii?Q?gk/T74HtiDqazkqxZn6nL3MzwanNgnwCcfBJq2QHdFge/mT7+IJZ/8tiA+8D?=
 =?us-ascii?Q?4B0rxF57Jvbq0zMnEI4FAPDbOhZhvwlUlqSltceiNZNs8pkoTQnbOaHfqLOe?=
 =?us-ascii?Q?HM2yMnUyXtS24fuqxzNhCKkL0FHkxW+cZoY5eGt/v+VXdA3r5rMZsipXvzqR?=
 =?us-ascii?Q?rSzhNXx3aaW2TMidwWzmVmj+F1vgICs=3D?=
X-Exchange-RoutingPolicyChecked:
	MxvJiuSpn485aG3zxpDCJuRmOCqze/DkRBKrwPif8ps0rbfvq3mTp2R7N5ET6P5uL/CQQwzS4Ple3sJyAfWjYRVjrdcGZzMam+n8lWz77MHe2tSmJx/Fman+Dsh1tFPvUFYwNhmOBRPC4EI2a1VpSJKQMBUlScCXNyycesqHbeLv/iMptFsj4TePZlbMNAT+vPTIS2vnkkaqClxXW+7ShsniUXPrXPXbRWlW7lJHitiRA1czL9p/9sB7djC9mBZfbdW2/f1wDMNLbm55Bv7zhpelChM8kWy35EAAzDfPgrUAINg12oSA8Ibb6235RNDeqzqXHHp7lxhJt3JYT0ykRA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yJU7qX0ml2oteEiy2ZCXpX0VOCh7pp4Wxf6MUGwk81V+UAe4NueQfZC8m54lPnIN7UDLidd9JY8z/dS1fnAV+Pp5zO6tB1tJsuy1WK/GmuBnexRfC9lakOVEtXlhOI3hN2Zx2kDXEGOJb0J3fxpxH69JLpmdfWXZIz/27B+/s9AsB6PGvbbOGWQ6lmQ88uFNpGeQRRKv8gf5J6zvaiAgb973xpi5HAo/QLFJ9s+2Eku3JBFgCflmJhOsjUnfXWAcRmPxLITSf5jsRX7d0qFURVzW7j5fRTLBOU61cdyarZjVTJbff4rZaAO0b6++UALOaZFXtLst07xL3nEukLMGkb8KEpyVo/RaATbuVcXl6/QVJhtD0mL6pelRCWHXFZYym3GHMspMulWZ+gN5icJhZxWdVrleRCXDCoGGBLEPjAhox7scz+a0pDQrvzwj2t6+J8LbCgBC77FAgcdp/LeEpXLQ2APxpfCT4mV0cr2O0awD5lpl9zcaMAhc7szQlcwr5V+sfft4+s0Y9biw4oEJHwv0Il7XKwFqIX8ymjO6vXa4f8qa2Ac80dpVlBrQe0hgFVD+LspqQU7peW42nq7WCei2ES/aiBTj8soIFqhDYz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc61c38-3164-450d-e7e8-08dec534abd6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:14.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fbLXDvl1nNOjnKPls9/O3L2wxTliSGaNyKM6BIgksCRedf0Z2/RLfzCyao4nN5tXrpdLpzrKd602cFJm9cLPDgd+EVcT9Aq8sKMWn28hZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX8UrGvEoNXnDt
 dhPPquFG/kLrlD5SbeRhoaKuvcHl94cMWo4WqP8sL8GwG108RWeeBDzl2kZ46MifbuFkWx9UPjZ
 nzpfGwfisicO9h2n4H+XIN9c6nQiKpKv9D7YqObiY3v2GkSbqT1Eo6xKvgVrcdHkilkRqC4WeAI
 Zs51W3GPzmyCaCD5G3wi++I9BzGm9COXXozRjf4gyFbZZJjY79TPgw27lfciySPu7T3DE7g+gB6
 pOhWQs7iYTlJFrj3ilsz//tj8MJW+qWwP1R3DlZ2CWCrCqUtlMQEgS75+EZTkOSgzENyZxQ1m5j
 mk7M5LpGNou1Kin2MW6tHDDsO0t4G+WFhDUGfcrraxbzssgInpUIYcDN4yR1rpfvHYZP96nEgHF
 2z7gnnQPO1PrEqm4OVpTIss7qPOj4psO0Cdd6BzU8s0dDDYt/AfLKDl9LWhLn1zOT71j8Q99rwk
 jI+X8sQhe8om/Kgpk8I2RwA931fiors09xfz0ZVk=
X-Authority-Analysis: v=2.4 cv=IYK3n2qa c=1 sm=1 tr=0 ts=6a2677be b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=c92rfblmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=vggBfdFIAAAA:8 a=7gr8-LgUhGOHEYCj_R8A:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=cvBusfyB2V15izCimMoJ:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: aEQc16x1jGYrzvdOn02TMikBNYltl5pn
X-Proofpoint-ORIG-GUID: aEQc16x1jGYrzvdOn02TMikBNYltl5pn

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, since we want to minimize power consumption in idle, building
of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
as that serves as an indicator that the platform supports an optimized
version of tif_need_resched_relaxed_wait() (via
smp_cond_load_acquire_timeout()).

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:

Sashiko notes [1] that lazy initialization of the timeout deadline will
cause an overshoot of the wakeup deadline: this was discussed earlier 
and shouldn't be a big concern [2]. Cpuidle ranges aren't meant to be
precise and in any case we are only waiting to go into a deeper idle
state.

[1] https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora%40oracle.com
[2] https://lore.kernel.org/lkml/CAJZ5v0izSBR0_DeH5HVnSLFGRfV9WoSzbu9Mh5yvvuyrvw7fLg@mail.gmail.com/
---
 drivers/cpuidle/poll_state.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..7443b3e971ba 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,22 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
 		u64 limit;
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
 	}
 	raw_local_irq_disable();
 
-- 
2.31.1

