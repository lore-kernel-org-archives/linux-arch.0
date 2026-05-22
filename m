Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4B379C23;
	Fri, 22 May 2026 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426674; cv=fail; b=RiqZ3j2sNxV0kuJE9R8ALGtlfo33p7dx/Zqx+GkhCC37+1E2rJoD2qztqVsdixFsKw0S02Aj9mi1f4KEnMw5B7xzORDxrcNcOwWT8BzAnZfCoCK1xOZtruCOp+HXptb9jK3b4aGLAx0v+0n213aVCMnfWFZYOtFvqivntmKph14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426674; c=relaxed/simple;
	bh=VKP6KBB2tVhefzuShc2+c/YMBlzfq+L8C+97VO1QJ/Y=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=GzpiRxYjyk6h4DIeVRGcgWTJYHIuB9hZ0mtb/UasSmU5JVguz1T26gfOc7raKUqi5ctJ9pqzGRXhbDn0xxMLGNOw1ZmDG5KQpB8p6Q15V+z2UIkX6LVXbH33hKnnrpZlZSjtwFHOYZ/z018U162EF0dN+QGJWORQIhkjtdhYLw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JAn5t7BU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nOjEdFIk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JAn5t7BU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nOjEdFIk"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LJfjrN1583139;
	Fri, 22 May 2026 05:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/H5yVewy3237AioTwB
	hJLNHXOMZvCLCO/FBrGg0PqjY=; b=JAn5t7BUuxL8c37zGWQl1baz65F9ipxVu7
	rH66vsnN2GKI/UVV89SdTr0xBZWVdET44iaaz9IPOr419NVzwKfV0fOvqr1MS0Ez
	pe0plRycV9Gn+q9p2MJS7dpDfWXeveCHDjjPvqcBmS9OV0nixmX2tEl82om1ZXR4
	0Ooq89g+3QoJKDGCRJin8bVqltrsBDfMkqbEfG2P4ok/PF8+UCWNG6rUbyN4tFbh
	hQI0yGXv/WcEZF/BCGIDTdtze+mn/5iYGzr8qdJVHPvzeVMx7EvDgYKCNnkjY4p7
	CEAzgNtrfjuj9XXtYlyfsswmE0lnQorPfOKbX5tdXrwiFAGIZREw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4qam93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 05:10:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64M550jw000439;
	Fri, 22 May 2026 05:10:28 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1kb2da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 05:10:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuVzjJ55QC0+/84hIqSLDc9KPUS9TKNW8lnsTRNtzpMHCkM2EIO6Q5EGH4TeoT8ya1ZBuLtv83W/+GsMkcgU8gJLCNy8Rz3KPQH1ein8xZ+IeR3bLwroz1DWTidteyJFZVj6+Za5VWkUEupzsJNqR87EPSP9/S59XuhX0OE+vtccnnfdZGZGWnQOgVEE7TEciRh6kA+WQ8hvsEJ8/VIQIuCi4FPkaf8mFm/B551Ez3V9GbMhmpKIA4YjdvU8U8aaZgoNnil2hb0IsxBdNzspzlcmNZ68/XAeXh874ejfshvPjEiVKGb57/FEV725wQ4s506jKnUgu5+gEHE2lLrqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H5yVewy3237AioTwBhJLNHXOMZvCLCO/FBrGg0PqjY=;
 b=D2JPqjrMD8Psq7pGtBy30PRbR1gG6S8hCiWsL4ipS/jOz0Ck2sx5rvAK6Z9bz9+/JcNsrbXbdr9JgJgERRz5llOV5bWrj4ZhhWEKTdlNCa8l0tc5XGLEQOL+B+m0hn/cyJK/D8vadvD7dwgdtO3RwybOO3PSWURHJu9ZH1gueEbyzUGfDfjX78GmWErbzLWBw2HqTvLU77/D2hILA31HBLXZe6Zik/d7UbSkA3l1N7nysuE11ZHQYoE8HXSuhpjHd24vt0Ig4/auPfW9xKRn9VhmnFawXgkcztVkTuAz9FhJRbcy2weNiCqrLT7qj+Em4GjHUq5ABuiwB3u2XqKxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H5yVewy3237AioTwBhJLNHXOMZvCLCO/FBrGg0PqjY=;
 b=nOjEdFIkFTftl/GLeUoTuYZFq76d4XTlX9lVFv/83TRTSOCR93nWpNxe359V/ebb7cmr2fpbgiHMxzKotF1CZkGMqGiodH1LQPZS3Qf3kvCOQThhzEQe9wXIlv/DVN3q9NRNtefulzUBUBVMj3aIlJO0L68JFR4gcKkZljeJhlg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 05:10:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 05:10:24 +0000
References: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
 <20260521083038.134260-1-ankur.a.arora@oracle.com>
 <20260521144629.11ee1e2ff88c5387a589f54a@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-next@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Boqun Feng <boqun.feng@gmail.com>, Boqun Feng <boqun@kernel.org>,
        "Christoph
 Lameter" <cl@linux.com>, Ingo Molnar <mingo@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 1/2] kunit: add tests for smp_cond_load_*_timeout()
In-reply-to: <20260521144629.11ee1e2ff88c5387a589f54a@linux-foundation.org>
Date: Thu, 21 May 2026 22:10:20 -0700
Message-ID: <87h5o0ni6b.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN2PR10MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9242980e-427b-4fa0-5acd-08deb7c06e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	wacHV/qgXo00u4F/kj9Z6F4kZ0B0fyROo8JmFUYP7Zf96WgZgfubDSLe7gOHnI90J6nHYJa0S5YvGhiASNahkMMXRPOiitb9lfknWon7x4cC41mBp9F08wSkLcW6RMlQP2AXLc073/xIJHRVpWB++D8B2tuoqyixIBde99hoaFu5qrJ+DVkn851bTXtYzBqRp9TGoC/ayrBafBqk4Ng2GI0PHqp2oVOjBAidg1G6D2oH8XQBspXkZ2/E2MNJQD4SXj4xohx0TjgciRNwOql5sBt1XGJsuSOVM/Fp67X5P1Rywf+pMlnMFsTSVrMuiDCwFjmrYOWYuLyxRi6g0JsIiI0nH9QjqOqTMm4TsvSFgqrZYwMYOONyH67gQWoj1JNGe+x1nhE9SQEv3ojYgxtbWOJsjr0aZD5q5DFkt4E8F280ScKxjuP0Yj6dCu0TL4q5GmYAYv0KAh78wNHIr5n1UEQazBDaPvxMRq4S15dxPtpyzISHzykK6BIYcVQ3EIIDycwA77VWO1dkMW4neWiMlkwxDbrxFaBXSZwtkNL+kQfbl2Dkh012PJ11CLsRgFy6bLGaj6T8/EdJtbJbyBFxJ9GNp0b5Ovvkd89+CWeWghx8bjOhu9qtkje4SmJYuusRMJxIMwhbihyY4nO/OAo8dPFdOdQHjZ1ZeGrWcQ/tx1McVXvdR6ZyIGIf3d63Aym9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgrZspIS+p4DLJRXmxF+cGP7ByN4i3VLtMjVgDgJTMbd8ZR+liy36sj5AzXp?=
 =?us-ascii?Q?4nzyXVYg81Pl1imy2mP+XZ34siBnnLMgHVNdf1YHX5HdO+YaJ56VoAV1fH3o?=
 =?us-ascii?Q?Mdr05ma52XSaOe80itHAiwibklJ+A952bdhjZQ+dq796VSBlJGGy5kbNYwna?=
 =?us-ascii?Q?83xH9DI84oqq3Qj+H4a6Qot3CgXYKeXghkyIqjhSrCj93ztPSMS8Yf+ekAoK?=
 =?us-ascii?Q?rCY1ffT17FVhUSrdnL5+miO2CbILauPzMBTEmxrKrGKfE0l7I4dR54Pgjg2z?=
 =?us-ascii?Q?OPcElVv6UipYeHhMvfNz35WUHdlp6d2/7ZS8yrf/s7ZQrUbDiiRmfFXrtZfd?=
 =?us-ascii?Q?7knJkMz+AgcgS304iiiNV/VejmKzr7AAVpp7LNgbsY1IZ1iC+5GelG8s0mYg?=
 =?us-ascii?Q?iNo00IDnMiN88E2UgSLwkZo+1AZQPaCqi1OoGAABjStG+f8qbDySyeSfTC9K?=
 =?us-ascii?Q?bthqXfOdKs1JV16JxnvAnYvrYhUlowLOV4xDLmbUiKqJ1J0EV3SnqoZYWGoD?=
 =?us-ascii?Q?sgnf0SNhFvYeZu3wpv1D/jZ61hrgDJaSiEAQjlIbH1aGBOVtRY5KUeAbU/H7?=
 =?us-ascii?Q?v9VLxOxexf8AcaL51/mCWQsWPuS+vFKasfMqI8hSKyT6u8eigW5wXuHryWck?=
 =?us-ascii?Q?aDTvA48ZYyNZBj44MNSNP6EtDYTd4jFt222tofecuibENLQ1uJrE1ZYiuWbM?=
 =?us-ascii?Q?q1W2/qW/BCyHIQ/mGrr7rO598z7DzWmcPKFRAjBMA6ANM97DanQcB8LsVpWk?=
 =?us-ascii?Q?ScMzvWxzIyLIh/xAxTYo0hAdvOYHf9lLFJySkmpC9/txNjuoZHsywt1wEiIf?=
 =?us-ascii?Q?8Zf3KjMWx/hQF7H2TzZJMrYuyMRztyyd31EDH4pQ3yivc7RtEnNBZp/hLGkP?=
 =?us-ascii?Q?7e0c3jHRjj3dY6Vr0xIO4dN9F29QMpgK69mRq+BSQ9NuU/7cRMr3HTzfz7Ep?=
 =?us-ascii?Q?Z+ynGJteq5UZwLda8No+21vv4zMD8loesPL8DETSCuJEnDuOd8EKlzkDfPcO?=
 =?us-ascii?Q?bg+dWXRBYg1Ug4tMOIW7yZTlNIMTTIuCyoOh+VUmLR2WOW8JMNVIxHb/hOxi?=
 =?us-ascii?Q?CG+kFVV/Gw2vYJ/8MJFdP9XHN4TeTV4mVNceYbQ2YG6FCUIrct6AF4LHwrCa?=
 =?us-ascii?Q?zeZUi9orMdKAi/u7eQhUrDvJizQz5TsWu7CPQZ08zu3uy3TVJ1u5dNJUEjw6?=
 =?us-ascii?Q?KWFE417GuycIR0C3fa5+SSiVp6+dsfyE+vPqSJttqjM8zsyAFkFNQl2WzIbc?=
 =?us-ascii?Q?0Ptk/UYNe5tBgFyA1Aq23GJRkOJ4hZboB1VtqpgziotNRdwPycsWoWWCqU83?=
 =?us-ascii?Q?rHqr643tjvpfkQJNXEZuFbS+ffScd+MblGjDZr7mngobSzi5bZs5UZYtcXmn?=
 =?us-ascii?Q?r1yTVL3rSPvYydxRbatGmngI2f1UkrCE8KM5OY7MephQLqOndRFRXAEx80Tm?=
 =?us-ascii?Q?3PPKomQeW2+igtfSxMWrN9YRxTcRWDFf8FBbAHY92W5bdKdhCQbz7ANThXhp?=
 =?us-ascii?Q?y7q9/2Kg3wwqgs8BgjkqI164TfCCRkWolxWNA4FNDD06j19+2TfREKFH0Ydz?=
 =?us-ascii?Q?NsqaC3zmclYlhfua6HXI9z5Hi5wuS/hKtnmI60prwdv9boNzEic6cASTXlhN?=
 =?us-ascii?Q?2Yo/bH1N48vplHxx05hyB+8+hD8ZH1aECubTuKkk4Z9zHQC/7CWizSjoFW98?=
 =?us-ascii?Q?i8l4QypTs+aDJqcqU1qQ+mmAy8jI5Afotmb+fypHBdV09o9BLPpPks4RflKd?=
 =?us-ascii?Q?purx1Av04pGv19ZNUm0FLeFju2C7Ex0=3D?=
X-Exchange-RoutingPolicyChecked:
	qMyIFOKhx0oZ3GZ8rr9idS8AyEH5Bm2QGtb7Uo9gZP3oh+ATgISd5DnFLsymXti3EHaOSV99JyqE1ll9zJIogQ5EM1q1HEy0pR9TRGz4JMNDzpJQsxUz0Q7QtZEOqYPo2WuD40EKVld3x72IZZD+LPt1onY1H0yWyzkP3heq/ugldI2LccAK90N8hTmOVisPQBuRQ2GjMkiKf8zBnLm+TMHiOl0QWMx27vhx6meSfWn9qaBNIF7H2iGxUKbctR7tZ3a+CK/lTTAsnMumraE2oxixJv5N0g5NSnnSgAk3U3qjEIflw0Ae29jzJW2QSbhNZkp+rWGRJQ7lHUM+UASV2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1PH7W0Bg+fkQvB5KkFapNj4PDhksgyxn0T90Gq9MHSDvzjOpwYEPjsELJJ71k4y424BXtykhOZFgXvWA5YkO/pg1s3cHlxBpi6/01tIk5SB5+4H6CjChXWsoI7Tj3nq4awVVfsdmcVmurVGpX58uCNs1XBtYWeOYR+0YUD/Sx8A3Qvi71E4AJ4THZAvnMMjHxYGtxpnmOCQzusOGLFPsfMWmK9p3Uy/dCaifJYcizny7898dvG667MYfdxW0JEeDUeoP63lW/r+cK/QwDK6TcJXD34qczmWZ1vDyD+SfraGsgYxSRbuLipv3vRZqbOeEAd55Mx13oZiq45ia0n5MN87eYGocV0ArwFhWcUjfWiZs18w+HATppfC2OVcTCFRgSr47qCbrjJ08EwrleGUM+HQQj/QwOBNYhxcBOT4kpnwL9WvSazqMKSvOgxIk6CdaSfjiynIXpXcFbcs6IYxrzcexgz/csIt/drBp4npNK3fgBEIwb3Nsv05EwXTkle2T+/XjlnBA7CvLd6p6/uAbzlqcNSpovwyDYqbBM2D154djjXc6z/Zg6DUrKQB4ickDTyBL2fU94Wlqmlt7hcZFLoXanCSUMEl1Yu1exC1YzjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9242980e-427b-4fa0-5acd-08deb7c06e34
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:10:24.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMJXL5tzPY9RUjs22P2FoZYApcqWgIslAO9KloYeunFl1P9UL2IcROFntViimR9SJEFE49YIdie7eeLoHjf3GWsH63FGBFsEzc1VaOIXQIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605220048
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0fe545 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8
 a=0Wl35Ixz0fAfV_QcqfoA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-GUID: -tBC2nFyeUYxsI2P2I0SeuZ5yKwV6BE1
X-Proofpoint-ORIG-GUID: -tBC2nFyeUYxsI2P2I0SeuZ5yKwV6BE1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA0OCBTYWx0ZWRfX6Ch1Dx5L4qhK
 TNN46c3WbTLWz9Wz+uPa2iREy3LLXDjy3g/dP+KNx6IvSXAE5EoBoS97i5aPt6PnxZMxGY0fIbg
 yvMGDzr7ETHbqqq2DSbyMc2ABm8M4Mn/V0l+CT78ujkRCBU2xmvCj2u/RUl3w/kZuCNTNOrLc1T
 /N+qYVorV9OXwQtaG2A8OQ1xiBCMtxUyR2yQ38mC0qBPxujYyS9Vj6SjBijNy0vlt9bOROoUTgC
 zSXaKagq+WtG+Rz9qcufeIsFkA8ARm8dNzNuvrfPvhd+oMr3ZWjSG5jd+WoR2toz6D45WRwEuUs
 4QJCLTn3E1rs1PUFtJF7JAvlJwDneMU2jbzYOnRaojDgdLOqaEWCXnctHpzH1lRBF2F0nWLyJke
 gY3V8noW3BocWV+4C/4EQyZM7/IYlCKq96x+BaeaZR1lOBGRFe8IL0iQJOR8ixOu+rNoKWlGWCP
 qFZMFDNcoiQ5pkRsGbCajEkqCZWAyZVw7v33lgOU=


Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 21 May 2026 01:30:37 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Add success and failure case tests for smp_cond_load_*_timeout().
>>
>> All of the test cases wait on some state in smp_cond_load_*_timeout().
>> In the success case we spawn a kthread that pokes the bit.
>>
>> Success or failure cases depend on the expected bit being set (or not).
>> Additionally in failure cases smp_cond_load_*_timeout() cannot return
>> before timeout.
>
> Your title "kunit: ..." implies that this is a kunit patchset.  ie, and
> to my mind, this implies that the patchset makes changes to kunit
> infrastructure.  This isn't the case, of course.

Aah yes. I did miss that.

>> ...
>>
>> +config BARRIER_TIMEOUT_TEST
>> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
>
> The patchset which attempted to add smp_cond_load_relaxed_timeout() was
> titled "barrier: ...", which is a more appropriate identifier for this
> patchset.
>
> Anyway, I removed the series "barrier: Add
> smp_cond_load_{relaxed,acquire}_timeout()" from mm.git on May 19 for
> forgotten reasons.  So I suggest that the series be respun and resent,
> with these two test patches included.

Will do.

> Again, I'm really not the guy to be handling these patches.  But a 4-6%
> performance improvement in real world workloads is not to be ignored.
>
> Not by me, anyway.

:).

Thanks
--
ankur
