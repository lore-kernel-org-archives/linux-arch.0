Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D93806DA;
	Wed,  8 Apr 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651240; cv=fail; b=CvEPCwHVbqQA5yOJbR2/ECGd0b8N9RV6/JiDaEQnaCJA6rUgLNDgEkpcI+0fu6XlU6SWK8wgD4G2RIv8Fx0c+73h/LiuyZa5XkCy6b0pN626J35KYeFGOf2gK/jonW4FJFWHKQwRtcAHI8+ZFdo03HiEVtapGYwGOuajRc/WBH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651240; c=relaxed/simple;
	bh=lIvdq2ptReGCR1ITHOBzKBm4LMVb1Gv7EaE/NdSPZUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LsbcivQZ4/rA5uqSPmi2FGmfqQimd9nDxZGIpsSnX1iRiAXe1umtL3U8LBJGyg8+LY8Dg9RiBwJGsmwiRrGe8V+7HvHVH0CfeNVbOWH201U8fsQ2j1aUlioZKgUHxhVJIL2dVLnNJco5hypQ7YPAuFZzFWo9ldtQzAXGaK1p4GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h0CZw7jS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fNOf2BF3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h0CZw7jS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fNOf2BF3"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6381VBcr1718173;
	Wed, 8 Apr 2026 12:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tuUS0TFhzqO341CoqvioBpprDqRr6Rg2beA96f0n6C4=; b=
	h0CZw7jS5GNGf6Pgc9pV1alpmxKd6DaEICo2ClTqG0l6uK6VIyVp8Mb2E9Mngk5u
	JPl2dPS7+O+EdOm9XIaOHOc/P97yId/pqkNG7TUAeZpZAwsrTIx4U2ACeAgYPpwM
	oiWGx0JYRN0DoH9QH4rG8ljQVLP/WWN9KAgtur4C5jefTgywXHpWhvl/qGhAwVZk
	s18gmdrkLXVLXp0d2KCkHi/6qfONC72KEu9GIpP5TClNjh0uRJelbjwkAUJT7BgS
	GwCeHdLweyzFyJEMj6Gj9BbUYBBq+ZdRVzDNSOS3RAqJfZ8KBj7uVrpKKSgEfnii
	DPc8Q4rtJeDmfzyHu2CpoA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa3fnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638COC67007071;
	Wed, 8 Apr 2026 12:26:50 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmejqnf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJlmZLnnb1Dor45XdcGZPT7kV5lP1XN9TQgFYT38PNGQFpUOuahnpqEwUskJtaEjbwHPdEAYYTu/2eE8ImVpEbAo/ZUmzVjkEXoNh9gNF9kOTmS/Dba0fQ6lzcvqBFivpCF0JWKbGwQcNNf+gWKSN2ItxoqqqxTuL4jRPYXBjGml4+xAF3nYOmeYgiG+TsO624NejAERGtqS1uZq9X740hPL3LfJOwEg6p2gjnpfjObUzNwOLN1uQQaS9H3zL/Ja5l/VoJvEEw7qFsSbzCR1X92jN7X/q9o0tg21NhTU0DVQXfkgJab4TIGWPt3ypruy2UIvc7enHaT4Z3hiF8v5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuUS0TFhzqO341CoqvioBpprDqRr6Rg2beA96f0n6C4=;
 b=rE3SA31iHFXg4gccpDTfKBtipLKr3wwJQtsCFbfCeGHXuLOZPup2XmJKBiZZugZvSPksqcx258XYcGYcr1+RLpAjo9nf8nLJsMUsVLJdpAla3Dkv33AfzSG09L73QnOqnR002xMDXotZXwTTNZJj+rVIohJ0tjaI63O32YuOXHXiLZ8E+ey8qx/mqavd2Y96JCYl0ijj8MhoSCk0q4sHglhbf+1aLhNPMpB4O7Es9/Rxaz4EK75rVx9A3WgaesoMveEp5aaqPnM/+SLAnbghcX+qeVZflgzstqWx2RtCCof1gHIGioRuXayMmV/OjxGhgKCSnoMTBdejUCpqCqdb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuUS0TFhzqO341CoqvioBpprDqRr6Rg2beA96f0n6C4=;
 b=fNOf2BF3tklwyG/P33uwSUFnhrngAWP+anmMTjEGPxt3KRbhOjE1wqb0mFClenvXZ1IBPQJNnV9sDWJPGWs3ZnxggfF/UP1cribyMa96NfWCrZKkd+Ob0QC3lOsv9n3ViwaLVhrsb/6p54azV8FfJsQdxyOWd90BoVa9u7HX4ZY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:26:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:44 +0000
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
Subject: [PATCH v11 10/14] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Wed,  8 Apr 2026 17:55:34 +0530
Message-Id: <20260408122538.3610871-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e829733-1f5a-47c3-1932-08de956a17e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eKFBdE4V+Z3VTQljlrrYez7XlOQMLW4X+6xyH61vVVMzcQDyRLooBTI1mOQ4BiaOcECozeCLHsSqNOlHcJUNS2AaHtz8j2FUF2X34qa7sCpIkcByEsjCPHyUyMGN7DiEOjK/VxNiZ/1oaOh/VBuWKIj1R3qqpHeYFed1iJIIzNUvO8zJwrkH2pzqRYEG/uVvkFiJTcboDVIXval1nwmD95IPHzoLyK1UnDxr0BttAWfx98QMbfN86AjNy2nW09k6VOrEzg0k0piX0vR+K4lFJ2jnowaWt3AOO3zylSbcqIH4mmH0Nyz2yAlH4aMnbhKsCues+bd27qJR/I2BeITizE5Ta6c+rLyJw1CrXhAvLxmoChq6Jbpin5vc2pXf3opAW2ipTdcHu20DIFjgx2KeuLicKxZZLN7hxWeAQIfso8axrO/8ow4MfrkhkwWWGCIzNCichzA+LQ2bw1bVSX8dV2yCxYp8njkTfvcokHU9BCIHlJ7wN4jPft8000dNEtn51MedjQvwW5duUPf7J/YSrPK+1xU/bohvz8JkhG8Gi1ViR3KcvfTf3p70Iirdneo82orduEJ+kPox5pPsEuI4OfdoGBH30F9+JRoJsn2WGK43aknwh9hydKMiqvrej9HX3wYFasNUeQHe+08tFAESBjhb2cWsGjxvQs+RNutnfjp1Tidi9uKHGFGKN+IsJrJZLUgLwvPk9f4Je+aBTdm4tHzcnuBIoaeeeEjy+6wWqGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xuJ+sRThJXy1H5zFd0Y9nBqxLxjktQrjop6KGyePP4YFOhcrut3Kq+TvAvW5?=
 =?us-ascii?Q?r6lX0aJqb/F1+b2YoS+DMQcmBnqVe6qoUPCEWuclG/CJUSm9Barag6BgYIgH?=
 =?us-ascii?Q?5+nL5wx+Yh+dPtcXAvRvlXXOoooy+lZcxjkp59/g/NVQVtBzBOR2Ro2Luklu?=
 =?us-ascii?Q?P3niVxyyPbWnv6HhTQqCzW3gdXWgNj3lEIwVgFeMhfVJCokf1YMZzU13wRQx?=
 =?us-ascii?Q?5gDPNcCWGifWINsnw5YRlK8zWl6OiCSSVgRh7lZ7MvHn5BxMRT53jQjgZrlu?=
 =?us-ascii?Q?QFhqkRLsz+b8CsXtB0ec47uo4zP1GXEa0socEe3+Nm+gBsQI1v5+RN4E7N6d?=
 =?us-ascii?Q?dWDzzXAESF+OEe19oKHxSIWgPj1KpJ9NwHj+xDtfChAEhsHmS9TZ5TJ09+al?=
 =?us-ascii?Q?ewxIp1g/Kbc/AxqeAitP8iCI2A4ga1eDcjuoirgwF/uDDLPPrwCzm8mOsMr+?=
 =?us-ascii?Q?rImzOHBL4XRzXV08OwKjS8K2gwozgJyt5ys5pFTBA8S3l1oqOT9gDziktfA2?=
 =?us-ascii?Q?lePS5Ff2018lwtL4Jb4tSe7vkJ+qIU1USzU52aO5s8GFFeN03l0NsDL8RGUU?=
 =?us-ascii?Q?SH0RFfUEjscVV311Ke06l2bNPU41uwhlTvyKCsm/SDoXYB4XxKteKzlM1pbi?=
 =?us-ascii?Q?vPwHIccUqFaBXI+C8zaWOqYNqr9FG0Vy/jOxuV8Qg8o9nkYNM/Abiy5tRRQP?=
 =?us-ascii?Q?v+c4sirz9R/Q9YZkXJUMS4zDtYc2V2abmTtwJFJW7vVSt84UjYRIPykrjYre?=
 =?us-ascii?Q?hJLfI1rGb6NQi3kODdsVSfM88fuZhOvvXn/+OsdUxp1y3VHWnYpOfybACBoY?=
 =?us-ascii?Q?HOWMVhMgmsk8eNGpUqE1r6b/lYDX0qUymI2MhRf2Hrp8JBos8UHYnCUCGQSQ?=
 =?us-ascii?Q?dO876pXIImCrHpsd0tNBxtkewlrsw95koaSApjhAqZmm7irVWj5JdYB9jXzq?=
 =?us-ascii?Q?ylOhViTL0EmEX8bZhC3I2ni7Rb5yMGHsCh2oXyiSvGLdIda4V3tJ9CQNxc30?=
 =?us-ascii?Q?yp3+JXEF0goz0294fLtAGm9Nc9KjqrJNL9RFnyrcIQoVVeH4arDVe4Gy07OW?=
 =?us-ascii?Q?2lJpmxK0FaQTdiOOzihP6hSY5Mle4Uy+NhXyT0nnU3zTChIUTkLICSsNzNZg?=
 =?us-ascii?Q?o5/ToB2JlMxBIa5QIltc78lmW5t0vD7soq9qffddUkaIpcCDDVB+efNWaa5i?=
 =?us-ascii?Q?oNPVdNaU/zj7RfVWkPPauuRwIbifZ8oG495PBqc/74kXltko/D1qQKU12IUl?=
 =?us-ascii?Q?h88fh7fhUuOGNKXUZkLF5ljnwhxXZgD4YKeAsV65ycEfCXynQefwc5xSXf4z?=
 =?us-ascii?Q?cVGSeFVEz0AeFNl4XLsTxIrW5nawFhjfQRWM/XV0N01ieeJdR8xX2NoubCNk?=
 =?us-ascii?Q?NQZH/JW/MAAn9A0eYXXPpwJ8+qkX6os8ueAk/lIuNcRgAiYwJfavJP67vhB4?=
 =?us-ascii?Q?DnBATQjSUv3pzPT8up3gMhPaiVhJf2wRXi7DApjDIGpt5iroe6uqCh2cAYFi?=
 =?us-ascii?Q?qs2MLpEerjsAUQYNYB3DxBueXHgtXidXoVYuYe/Roj7rOon2gkcVmru2ioAY?=
 =?us-ascii?Q?mxxIsiV5dSRAtotepGzxbKls8EWUaEdt3J5r6VpelCHVKV2JCCRIv1/wbA9c?=
 =?us-ascii?Q?/f8N3y2CI6pQ3Qn8n8U4HZCceTHzEcokBT69EKAe0RBBjiVGZ150FrAKr0F3?=
 =?us-ascii?Q?g2JDceLJZIsJ/sHT5+9lXvc4RLZ6FFVSa6MuYLqsUqp6HOHgpa6++86f0ojU?=
 =?us-ascii?Q?AxShRT9m+SgR4Mbui9auIwj4F2Qz8sZY2LGsemKC3VlqVGjI72np/06MgoOK?=
X-MS-Exchange-AntiSpam-MessageData-1: JqIq1lAcwa6IwcGeZf2ioahnkep1oxyQuEk=
X-Exchange-RoutingPolicyChecked:
	CTPGvdAtJ+Hy2lzzs1noouqFqB2oq0HihMHYKFZk7u9Hlxt43CP+DAWXrUuWNEOIHLwooS9HSwg3zyfllzNDqkvFd17U6DXnasEtV1SFmz2kVfbTc8b6vEK9lS+snI6EHnG/ZBXMovPSbNjiVzDJnrcKHyeiOZS0qWNZllTG3LShLFVUJ+tT14PxweGXsdi0qWJHWXp9tPfFDDLmE+Vp5VveirFGFA3BBhd9h93tYENKtU5L6Q8BM7b3mv8Ds5rup1XAhY7y9UBoQYu32ZGosTLjXqva1u4r73TYyKLRgoZgkGiw0sMpCw4IPKCSONOD7drkDpRtZL8seXSmCVbrVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZkRPzanRT7en6Ul4v5g4T90aajTSDX+s5nIq39DpzPxzyg6aeVscV+bM7jJzee0mvTftPYbbjFbJRn6iyPSQp3+99pwU5R7kGwh0vaAhVxEB9KZD3v0uedLnjgocxnSXIRmTfvUfdWmNizbpvUmTfGPIBi3mClTgCXZpFcrz7vIyfVeiLfZJF//9pBwcwcUYpzIC4BZKaoPVPceCrfSbbIFWCP8sg2sBamurvfO8MMZ2kYa8iVR9knilk5+W57tededjIu/FJfJDTHZzZRKhN9xOIc4tLFSAcG4Y97UVD7wsvyfJXt/Yqmx9YDWwjYz4EG/hzK1dyt4bVqz0u/8sNFuBbrHtajVtrRpMWYKEVpKwKurgnWTEDG/7Va+eB94o2Ckl/MmAIHrQ3sudQdK657f5T5h6B9fxGSciSAPvlOex8kqMxwSnNLmRLDCai3ue4TAhjc1NRdNHo6l5/ORFlG1mE/BXrGWmsFqSXlcaAyMah2Ny7kLZc2oVgIot//ZUcHQD8rA3oMQghSn6m27LaFnA+vR5YXcsvrBEdDid3hZ6EqZfHA3A9hQ/S9qRIQSp9DxUSSh+5a+0NPjj3aXlwNfTAjNWfK0k0oPxq3WnqKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e829733-1f5a-47c3-1932-08de956a17e7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:43.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAXZPllLRs4sE5KCB7xkfV8OSpK55KaOu6fUYp6J2HzoZWFJ0DvlrG/+L9fhDGPpbpoLHjpJsfQGOv/JkOxkOqIqlKxePleT9MaLrCvpU3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-GUID: 7jPzORqznO3LIP2eLddGL7JxTONr1phN
X-Proofpoint-ORIG-GUID: 7jPzORqznO3LIP2eLddGL7JxTONr1phN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXx+vwzhE84WA1
 6FbTKz4BPZHZJardiJyKx3FaVIkS5NjzN+ET+sF6J5CJJAPaxMzCUW+ZsEL7jnmelp8C/MRIYNL
 qiHWbDp2ksOnhIcGIalRWz05yIDbpooRcnSODSvWpSHQKFv1cfe8BlbP0BkUi0SsMFbSctcc4ep
 czYv3QpexkXxht1bOsQemTdZAozIF4u8B6vk9OhBLJpXUhVraJoXSzdoFD5TP1C73ARMNgxCF3o
 oPHgYP8Efo4WK+QVWzxHf/aFl1l6+XMN9z9uYheS3R5R7tKOK/ZnaclLuoWUYEEnsGyoNFKaMwB
 +5dHAIIFTx0UZ+vGwRUWtUiaJL5o9v7ZyWu23DxkyxvbijuyQyV+FZ8f3anM3pxDNj2LmzOhR/z
 QZ3e2BsJ3GwRyMHMbi/9hw2f9yzir4n70qfyc7gJwkEYPjPN5YiIo/QNbxmtU7wUXnRsGQjGcrf
 fytjcNH+QZ9NuLfQGcOwoosjHYt09q8ulUZ0hjvc=
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d6498b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9 cc=ntf awl=host:13825

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use the
non-amortized RES_CHECK_TIMEOUT.

RES_CHECK_TIMEOUT does double duty here -- presenting the current
clock value, the timeout/deadlock error from clock_deadlock() to
the cond-load and, returning the error value via ret.

For correctness, we need to ensure that the error case of the
cond-load interface always agrees with that in clock_deadlock().

For the most part, this is fine because there's no independent clock,
or double reads from the clock in cond-load -- either of which could
lead to its internal state going out of sync from that of
clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
non-arm64 as that uses a waiting implementation.

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 0ec17ebb67c1..e5e27266b813 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,11 +235,10 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Spin amortized version of RES_CHECK_TIMEOUT. Used when busy-waiting in
+ * atomic_try_cmpxchg().
  */
-#ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+#define RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, mask)				\
 	({									\
 		s64 __timeval_err = 0;						\
 		if (!(ts).spin++)						\
@@ -247,7 +246,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#else
+
 #define RES_CHECK_TIMEOUT(ts, ret, mask)					\
 	({									\
 		s64 __timeval_err;						\
@@ -255,7 +254,6 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -269,6 +267,17 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value not superceding ARM64's override.
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +305,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +328,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -421,7 +424,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +587,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.31.1

