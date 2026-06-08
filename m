Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023873AA9CA;
	Mon,  8 Jun 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905952; cv=fail; b=eBr6VgmQT21luxnRMkhOgEfyLXy0GYEQiHka01/jk2wyCNHr9oIf5ISs3uEhEW5m686St/04dr3B6LhtXrCUofZ58a5qPh4hbXwHmwTdr7uOfmhxA/WAnx+1DBI7sZk5HE71zjMTelJhstZwbtZ8CqiLOBgpTACzBUPzjZZM44Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905952; c=relaxed/simple;
	bh=5x2tK/Ql+7Zqf48PmfkGIoyFtOYoEf2nKlcIq33DQWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/fzvu6XTANRQbz+okkBtEE6B/N/X94qYAY6OS6xPw/RVEkU2gfszit0BL3xEV0SkOyzPHqD2KvAEPUb+2vb5FxJWEND7JkHjQW4zd7djwXExIyDKaQrNA+ojMS0jqiGcPnX2gt8VUPgJhJW6SR/AwQ5oZ54s9zsCdSB87+ekM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mbn1vyYR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PtLnNUZQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mbn1vyYR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PtLnNUZQ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65809f1b3675269;
	Mon, 8 Jun 2026 08:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=; b=
	Mbn1vyYR1cQR4ILGYUVl52qKZHntyBZ8RdeSA7osVRudvufcwG1vDJGh089CFos0
	5uqbM4mVWQ+p0dv1tj6mF91aNtN1rDVVHONxrtivj7W4Dz5YwtVDjZ9ectr8mW2F
	6u8YzfJgsKnkrvnTBs7SDGHKpdSRgo9KXzI5MhAw5U7ZD0/BbVwfRVe3eHX4sUjT
	OJ87JXbq83atIyQZI4Lyut5u/Cr1k/KqUO6WgkQZJdO0ObXTiSq8NVpaHFb3K6ul
	lpZjyrBw6pxRwy0Gaq8xYlATV5jePe9cEVTu8yiGtphMU8sW5I38wazXpT9LekqD
	HsvNuckkq8j7zQW+IUDAuw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4em9yba1cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w7p1040494;
	Mon, 8 Jun 2026 08:05:05 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0dg6pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WteFRc/vQesnxBhhQkv3/bdN+ThGlMQDrYFI3trR880MbeCRjzhSo8Te47u5xaccNU8HiCe99a5i0KGZqFLngLsxfyv4AkXr05WzmLDJQ/xWBMnQHw7wfpIq3Fuml7E8K5M1aslXB9tJFz1NeA75bPQrB5oJLlojXQfQFI7gobMtUeqVIbHqHeYPx6fjGT7fxB1h1hbUBe/qCX1hCUmJJwiQdDZODe4GphTxvFbhawGdRX9FmI5eAJ9UfKNJqYYrNWQ8Bi8dXitpSr//hAKk5U9tZ1gdMoboin/+Ju6EkV7+6lkY8jiMwyMRWgvzL3Ad1s6U3VDG9Vc9LHdPLPxx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=;
 b=jeJb8HRNWL0MDU9VlB/dyBa6ojw6pIx+e8KtyO3vtDxv6/BkOtDXYzUfA4OwdpF0/xQMfnXJ2mVtSX5L5PyGTPDrTgPvjJTs+cOKhKUgbknth6HevNMgA2X0q88o6O0M2d9ewB/BHbvN2ozWidXA62fRbkG0ltl9z4WEjibPiLThVNGCybC3TGUBnZ0e7UigwT/qyZphP4Pf6puDYCyguw5qPkAED5M4lsOQCIJx5CFNy43+quFgfNQQNp8VoQjjVdlBDTOlXo4HTnPuMGC142JtPdp0sOnIH+Xg3mMkGnYMLR3s1y0JTku8zyDOgawhG0NLjYlLtE9SqYw7+m1nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=;
 b=PtLnNUZQSmuhf+nwKifZcyusOy0zJkOrE9LqM2Cb27l9kBL37xg9M0cCa88ReVipN0c9OiXdUBCMompfQ7cK7DW5DDDTqiH9ch5H6yHcvgBc9G7l8fgZj6S38a3Io7RrwSKvsleYKdZhJljaam72WgAdWn7geNlfFWM2n/hiLfo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:00 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v12 07/15] atomic: Add atomic_cond_read_*_timeout()
Date: Mon,  8 Jun 2026 01:04:32 -0700
Message-Id: <20260608080440.127491-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 00287f8f-d031-4ec8-bda3-08dec534a320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oFEUhK5tMQZwlCQYunmyEypYCPSvomEpFKBpN50bQkgbSaqBKm92s6LjQI09j12ul3K3eqQ5kP7eEgwmshZpB75yjCIVAaFHd71KG07FHEJAG3cwkBHs/Lf7wx/OqjbZfOqasD5b4IRwBwyx7AfLrG+U5zKNiG3kyR/woWD7kJTMV6xByCd9dlxR4fuihKKh0SM+iPPvAXlzoicalrlNKobkrckdG+PgOyjcMHmfhAAxoRKxIQimRMwqZW3bb7W8x8v22HlyHW7bQMjeX71qPj/8LLGBb1TYBWR5H7Ok+LsD1E3BeGLaeNLnyQa4lmoNZLMQ2zaZFGJtJxvwMm7lKRvPn2PRl1EbAWWX4MzDAerrHIhc5/8duGr/6J1qyJVAkYDu4ds8v/RdoVL59Xmk7nqTvRhMS5W6S5cy6Z+FSGJV3gHV+4K3tOb5UPjho15/0iBKzEgiW3qJBX66ezTjjZO/UtE0twBawnO5zeQS2x02niYLhAM7CHE0KAjF8V9by2FKpNk0Ad688cB3Mp03zONUZdqQNQe2V32gC0HtAYcjwdxYlqathCM2RKHoGLEWayvUIcYwhRvvAl0SP0HQEQ2Pq9oOVPryGXsLqUN1b9t7/kHKHX/IwwhRtB42Wuz16hkYXuXFWNLR18iL+UkVAIHK8EgcKvLLuJOzXWCv2O4MbZSVhlVeSFA5Uz+QAi6D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxOUzkvBsKhCpljgVLERqiWkyxcsPudux/qrYDNJ2XlRR/x3QRiZtiI8Xg3h?=
 =?us-ascii?Q?pBvHQveq3krNAF8iMMTcymtBaOEYPqT7m9XP2RfBA82aKJ/YTDH53WrSqRgG?=
 =?us-ascii?Q?VWANjByurPxairETu90GQ1Tv6+GDjw1iFGwsYBmdRjUGNXZ5Z0PZPJJatC2x?=
 =?us-ascii?Q?BqlR2AqBO174mwfN7uYRuLmDyxRXHdhO/N0L6E2PBxu6YZVN3bqOq4ro19qM?=
 =?us-ascii?Q?EozMBHCqsdUF0pSZ3bhMXV5Hs3mtj+LarTAfWjlxxGuVQM6pfpDYJIRfF5CG?=
 =?us-ascii?Q?xQYbE0LyE5PWkpeNbxszS8n+nn+POPqBrfQ5Z1zKX+GMc5cHbabVJrnVI0U7?=
 =?us-ascii?Q?kJvgK4homJiK50LPrD6Fv7m18OlQrEBiiJtPptrh/vkM+eo0vxRKfgcaM/FC?=
 =?us-ascii?Q?hWh339GdyWATbwKeqHHvA/uId/kr56o7JIF6VNwKUBWzwBw76Pbcv7F26bwR?=
 =?us-ascii?Q?wZI5d/47kFzVscCKcFPyJ/wgy+ybRJosynFRb2jI8O7CbQNBHNfIaQwbaiV/?=
 =?us-ascii?Q?y7U/8yeUneyOM6VUED47L1nvm+UnETMvVOYSSOebdQHC4UEfwFju/KLNOU8t?=
 =?us-ascii?Q?rEuvxvne6s60KTlbHEB7QJrwM6PWU2OLl0LN+c6eczX800nPQp9gAu0+NYs0?=
 =?us-ascii?Q?Jvm2gG1B5ip3oSxkrzmYPsuRPajZnF7qDaLewv6IzUXv7uJ/NpOQdXUC9o4i?=
 =?us-ascii?Q?+HKL464ZUmLRmAbALXOwKcuWoxiUvVq0wXU1sGc4JeHKohrNREceybQTvvkW?=
 =?us-ascii?Q?oB54MV80R6W7YOhsyMFA5MW4NRfjNlxuhounGg4QWciHgBtubWT/SeNwAK8Y?=
 =?us-ascii?Q?dCqB0CP3dOMXaUS2OpuWBhK5WfYD6lt8BSDA+V4TshhDhBdViVlMZAqqbcnx?=
 =?us-ascii?Q?DyISfW/b3sfQdAE+slGtCdVxegUT/d5wQt0/nxZhGZIoCcNmDXYlr5LWr2LK?=
 =?us-ascii?Q?RijJBXg7tTQmnmYjYdeu3JObY2vXRPZTm2C0RZQ5FhZA3H/9c0NrHfWDyIIU?=
 =?us-ascii?Q?DSIajCnH+eKXxro8LCvlPQU6vVfJttmgjpLiq5EMOTS2sWyf+MDP6zk/7dzq?=
 =?us-ascii?Q?jN86KL9BJfa1GI8wlMM/MWiNgfIUj3RFumdbyDpnyfqtNzYr5i4Jhke0CmPd?=
 =?us-ascii?Q?UGHGhyVVdBnw0xC9IObozJ/fZuIWPXwNfELtpOWY+yFmEpOuvIrBoKvmDwW4?=
 =?us-ascii?Q?YAX0E0k8NySF2coktJi+NfqAvjqDrnD/kujVnDwH1rU/X22BRf8FmlHUuhde?=
 =?us-ascii?Q?23XYNyNyJtfPcIk8VNljDIY+GvPOT77/Ll3P2iuBCGlQ3Scfwx5b7bblvPYP?=
 =?us-ascii?Q?araS4TrnBMutbqDWgpSbsx+6lZ4F8Rk/HhJnUfmXfMr/QxTB447ik7dZD7SV?=
 =?us-ascii?Q?sGaffp8o0+FVk3dQorhseLU6hnQLTKoYDBTVZhNs52K+3R9ntOZVkez4hZ0D?=
 =?us-ascii?Q?Z9FE2ylvg3SD9obMhx3FvifH0cmkwshWfWIqcBp7OkDTX3iz57odYEDSmZr8?=
 =?us-ascii?Q?Q79gzhzgGZ3X2/Hc+rrdoctHJddBiXC4rhC4ZhZyBAmiukgW2iQt4IEgqRFA?=
 =?us-ascii?Q?Y2JM4zJ6dOGYmbXtylON7+TYId2HiMIfwtCmgx99mtFZxJda66TANMaVQKK+?=
 =?us-ascii?Q?tpH3fnXnrTBZm1sjxBi0qB+kEn7Qy2TWdPjUEnfYkSCrXNEVwh+YV8T+bl20?=
 =?us-ascii?Q?opxOy94NJm4kot8JOltC6EuDh+IYWB4/iAeQ8UxpgBDByiFNsVr1GO1tr1PF?=
 =?us-ascii?Q?yWe4f8WrJQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	EduQKAQ3iM8JwEa6XzkeAp6QSHpY4hqT7I/ESDEv6j6C3iyNtH5fCo5A94OF2491N96X1ErbBo4vd5/QOwkDLe8SK9Kbivj0UIUsXZv6E139O6tFFgGfXkmy/z7YYm1ssDnCb4xujbzCPJy+VASeTkP0EHwYD+nTM6XomixfeStGdtGsC2fc+gc0NdUttSmOcU1J6ijKJetss6q7QwLtT+1gKGbBNLXaknBVSIIxB+b4mDU3zEIB2qjAIuSc/88V00cJEQ0geF/Y8VPriTqow5QBxyFdie69lnEfHNMDHxS6d43+vMq3g8hdxC5Beao9piO729bPvxRQjwc0xkJjHg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	znQaWn67MOeMOlTmt1Ix0510kZmPRLJ/ffJea+4qgwfzlv9lFIHfRgR+tBTE7bFXZhjulZQnJe3jSI3w+sUJ1/jHGMyIKYTEgGGE4xD/BBtdnai0kPO7FvhNZBESTQK6HBUruyulitPZzH6q8OeLUMhjcJgSZnKo+Q6DW2Q5+1uOhibAXsL6rTtMbJmegpUMWVJxTFJ4NeE7uHTHqye6nljPKuTIiFKsdoaQhlhpzAgVIRAh4KSRbo1tMIv/cJKJwRlCeG3SGJjMGgAcWgn7DgZtq+0XchuZw3ibWwNNfuYPEviC6jFNDVMg4dt5GgKd1w5FP+loaehgcgrkTE4yQWGQ2MFGFHpj/lBf5MybPbVxncyE48deQxbvDDPM9Tox5P6d/62swIU6qF7T6gzDIjSAn9g+GPYMmfWR+FJlzHUBBjUJVTBnNhBTb+zyiBsWyrO/FI/JiP9lhLVCzUaAQHH3Xdb5WBOsA2iMRoW9JICzPE3nnLqGj2PBB4gI1plOIQHB1+SChPDO6GQ7ifD1+ee5aK7wUVvh9jdjNX9FwYDah+D0VwKvIhbibzACO2YwU+7WBmenOhEeiibIrpcg2iyTOSVja57rAaINENCqRWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00287f8f-d031-4ec8-bda3-08dec534a320
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:59.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X79uh9RZAhwMyggtoEUNxLwSebpJbjGpD3eKLyHhmH6WQ3tTimvG2B4OsnQqrdd4f03HXvkTecH093pLHsWpepnb2fW3zdLeEJWBZWtxkd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX/tRd+AIt68Ed
 BO8RUIjOMjJUhJ4424c39OHkLYzhLehFqkP6EIuPvQzt7wHrqI8j18qR7r/jmFtkyTBUJhAQ2s0
 jF2HdFOn1n7eFMEmkaye6ty8M8qmJU9bzfVungpEZhuB8BbG+xQvqVcGIBkDCcgSQAh405yJnRP
 zhv1XrIRX6CHIDxLzSZS3Kfy+6kdIqPE5tF5sYs+iHOtIiG376sW8gUMfg8wRObTg1EnZqY9HcV
 MLh/oS3SSHvv1mMtQLZtIrrRW+2h5lj/1UCuJrIjZ3euAi8crWFqgioPVH8oX6aRSCl59Xk9/9W
 F1++2Kd5/ffosGe3MvkcnKqc3DqgNATBW2gXtIZNnbNWBqBhhrWZryDCuYtFYkmOxsrQBD0Mvyl
 XHxqTC+BZafolScczWLguCHX0fjxBC58raJB7kR3qerIonfvLbJjt73gOgRY0SSvt3GO0z6jkhF
 uGN8qLMHOTiNyskJcXw==
X-Authority-Analysis: v=2.4 cv=IYK3n2qa c=1 sm=1 tr=0 ts=6a2677b2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: RX9gSq-w5Y-YdY-aIX0IjnJ9dMehXzKi
X-Proofpoint-ORIG-GUID: RX9gSq-w5Y-YdY-aIX0IjnJ9dMehXzKi

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.31.1

