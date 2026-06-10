Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C31A239A;
	Wed, 10 Jun 2026 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073219; cv=fail; b=mkIHxEdnDQya341vxL7SgvbBnW30/d0T5kcPQE1ki40ub8dKuHKn6wrY1tXEU+2h/PDq1wxvrk26AqL/jXN6veP2mb1Gsf8mlDNjTL4qoIoaxoVxlylvqsMg4IPlNC48wA8vKcTnC1nKMcI/iyoFPvcJi8/cPmL1skpVjPjF4wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073219; c=relaxed/simple;
	bh=uip4TC1Za/VUjYbYVHii2MtlGeZ72pd/b6TMwtwaP/E=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=E+Y68d9Tf7DkS5Ju3THbIToHIDeHKMlmJFwHBL+jq9hQI8uTJNAhuwlgucVM8n9xWcRNQJ4zxhFP1Lf4XCxJ/K1VDi4bc9Mi8Ilz9jmIJEN+nDmmaxzEruvHJwP77gPKeEdZPv3SvnJDyYd1y6qLCl1otWAgpE2am4S1p2jjcXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ortOgNb1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZuT+yZfV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ortOgNb1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZuT+yZfV"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6PdGC3559529;
	Wed, 10 Jun 2026 06:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dx9I0x9AMRliv59zG2
	zAHkJLf95xcRJFi+XZ0H66MGs=; b=ortOgNb17YLK2rxzOFDEl9zgie3NST7Z2a
	t925Ri1qzkM48q5YbJgI6AXBFF+qIHMttdq7Qowpgz/GC7qe0aMXDj4C70rIi9Ve
	LNO2SJfKlp59N9dAzoLqQHkl3h7UuS1gz0qMvfQJcJ6pjqr9O/jpSGBHHHBX9+P+
	2jqknuO9HqXGQeV+xfqQkNOVcjh1bxe4Vq95u27PCWWFwIKRPp1eLy2GjBj8fDNs
	PByRn5veGAquNO7wqH1pcIbGJeBOt2GCr1jyf3v3IpaCkDBTKdwJuzZK10N3TPAY
	qfxP8UfRVusjiAngSpH25t5Iswg7vHlTezPLcYMt/Ik/3fLWYEvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkje0wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 06:32:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65A6S8hR010720;
	Wed, 10 Jun 2026 06:32:21 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eq0drmh13-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 06:32:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIFSyt8i3+ligYMu4S8qkoFws0+nt62+Ipcdciew54439P1pmnMYL0r26daXEHv9pWB6lvBXLNlY2hldUJjXsapVS0lZ92Uyl0ky+cW+CnUdYGko99qKOMRI9rvBHkvSu4eDtxzkij6tYMrulFFGrcpqVQjiVsVjaIVdzbUb7v64eIxcW72ykSrGcyBqT3oaBMQuyjozTUJALzxkruiNoa2jxmHXK8/wZBFHZVKSFgJpggeUQh9/sdl+GfUY4D/cvmHp+Vnz/e9P5tsxSqxw43/EBgl90REQD3h3V4o+4P57CTqQZmgyXSpc2bTW8DCkKZT2TkUEUdD3ecSS+3wmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx9I0x9AMRliv59zG2zAHkJLf95xcRJFi+XZ0H66MGs=;
 b=ZOCCRg5ft0J8gBKlTLf1mQ87PeJykaLcaMuDAYpXBueeS/qHK9W3vRJaLXRRxPK/ZwUv5ZYxWKPFAAdrKQv64492Cp0u4nxaA7SygJE7AJRyudo27v4vOsZ4XeAlS74lGRo/D8kkzTr1JgseeTWhm0t0h2ruCygY0ok9SRvY0mLRV0//vq3RrL+T/Q3vllYk7PwwuJRYgk0r9XiQaxzwFWb5XfZp19RKebAv9kkWPlZeoCs8pywkINxxS+dPRxie6x7HtC+fbK9Rx5Vr1slqjzQ0gr5H+5qf8AhAZsR/LlUvAt/87FVJcq0g2VEqpyeaumHx+Rkv/J6PrB/ZFhueXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx9I0x9AMRliv59zG2zAHkJLf95xcRJFi+XZ0H66MGs=;
 b=ZuT+yZfV/i5niMUWI5pDtYjuIEmjhNzXf8bYyntg21VPvY0xrqCfsJS66kxltcIAlNWk6KQyrfkV+UDw5ZLJBJ6107YGT+YFnchxbs/dfbR29b9saYxmN/z/UoAZiLD7Q8lMrXM+gxVZUdinIad43c7SYlD1E+H4zDk08Ut4cdE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7979.namprd10.prod.outlook.com (2603:10b6:8:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:32:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 06:32:14 +0000
References: <20260608080440.127491-3-ankur.a.arora@oracle.com>
 <23edac0734ee3ef334237165500d8f34e3c649081db7b3140a4a8596a202f339@mail.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: bot+bpf-ci@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        ankur.a.arora@oracle.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v12 02/15] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <23edac0734ee3ef334237165500d8f34e3c649081db7b3140a4a8596a202f339@mail.kernel.org>
Date: Tue, 09 Jun 2026 23:32:12 -0700
Message-ID: <874ija7vo3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3011a132-196f-42fd-6cc2-08dec6ba0260
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 dYiMJrZUANSH7HoSS8uQJh7GXpr84trNPDBh2ygJGifyF5EeX2BLUaeIynZ2TLNyl20nhc6kMa+jZJ9P3O7aiBzhUSBfm6X0U9Jj5KOd/iDIg7JLB2Z7lLOhmD5C1J2nfNLQ/ikcKMLBwK/8/ctvTzSD39XPh3oI7hRWJanXQN2cTYaY0vjVlb0alDBMvZLX0bI4BeHQXacuTFDRn2BFeptN4H+v5wCFRO6FFozBBoS+cGoZIqoS36ChdP6JMdZkYR8hDk9vfrL/NBFUvti6Qendc9nQIgedEHY+FriD3/R1+RQzSPB9aBvJQVDiARMRWAsN5IlrpUiaMlejEOljxLB+JgPlcM7RC66/QEa3DWYlqMQ+NFZ+d6MR6SL/nuBrXmY3tz8lvCrMVMwf9EMT0i3ZSTD4iddyKu4WGD11ktEKTlKwnqibq5u+LJDtfF3IMcTV0ZN+a644uhhH5tL2b9Eqx44yDi109aU5iiieDO5mM7HNVU0snJ+DmNET2hTRqW7Pl+aWy8Iz4BaKUsuWpxzhVKRHxq3JWkUmiLhGiwmbIb1cZ0mdXhr6nZcI8VZeg3inbHWWbng0bx3a00jyU4+hLYXXZQ49wJGgak7KUTglTmGyL62l8RKDCWWPApo6frvJ2vzT0/4xVOv0IbWPzcQigww+xsXQjn1m9cEOK07PfM3o7c8PfDe9NEl0sUre
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?MQ/w8oc3RPv/MXt9p/a2AAokZaO93XFYXQgMP9QjR8uM3WTGtCoF8OTiK4W6?=
 =?us-ascii?Q?yRM+u6rkHYEhUHQojggfsVEVptvDZgntNXMpey1PKq5YKaZefva2Baw2fTqI?=
 =?us-ascii?Q?1otJvi9OwYzQ8ooIonzeVvZuKUGDRXJb7Zns3lU83gLosCRtR5qyJhIKP+4L?=
 =?us-ascii?Q?EIaVi27d+cAoFtvOP20AuhY4lYOVk2ygOEvGgCX83BX8C8TJBykoNvAx7VU9?=
 =?us-ascii?Q?B9tXBMLZEP/mbtc72Oc6AbaFkEOz2LlSK3zbRFXGrj5SqiRcjHXRInVk0rPN?=
 =?us-ascii?Q?XbwkW0n8NHVofGwpnfHPa/LYnaHIktFHV0FB6R78jF3d45dCMBob9NY6KA7P?=
 =?us-ascii?Q?7wjY6JljY7wxu3+NrfsY7Wg1X1SLYJ9P/eQnaHJReh6d+j+u9GgnaNGxktd8?=
 =?us-ascii?Q?4VAdEooLupPxfZ0VyE0yJItfOmsfm8e07aqvAbVUSH80lVRE45XHe7H1W9pi?=
 =?us-ascii?Q?v/PYlmo42/Ku8PcZeMyzF3n4BEMW5QyNfqd4UG5eDp3n6UT/8Jnd6ucTVld9?=
 =?us-ascii?Q?yRQPHMSe+0d531IKRy9Ym4KvzhzfgsT1DNt4jJmvSsZ/SosJbgbV5h3mGaJ7?=
 =?us-ascii?Q?6hvBdcB/v6IVdgyyCWa2PD6bZbedKCSzPqAI3BLPpZlo2HKfX2WmrquE+6Hm?=
 =?us-ascii?Q?tA71+E0KwMDaT345T98ntM2Vhg86rgaObjbkEeTgnGmmIYykYCSgCllTMvWM?=
 =?us-ascii?Q?SPhdTJ/VAsS1m2UEVkUKjwhCf+VTjdix6Y+zsxr6+w+y0muLfttJ0Peshopl?=
 =?us-ascii?Q?iqxQtkNiZv7+58dkPedOzYux1mDaupRMMUtoYRNrUVFQ+NjmerxIe9SP+GVK?=
 =?us-ascii?Q?N288+eTw+ut41X6pSPBZ16yXwD7VgNHddmy4VqBI0VLUFZQITNw4x/f9ay7M?=
 =?us-ascii?Q?LqKLEDUt/8X/DGgTHX7YX7GcaYyx7FtM1v1GPCQbIdyPDiC33KJoT3XVYZIW?=
 =?us-ascii?Q?tXxCK/wSPS1YP/V4Gk1sJG/VyMC+BKtZZe8J0VbJ3mPSTHGycVCPWg5qwxIk?=
 =?us-ascii?Q?ArxmfUEOBv2eG/GtcdzV427r6mAbTmV7GMaBctDpTBskqfKeBgFvBlc2Wp6/?=
 =?us-ascii?Q?/TZQrDWaoKbtldWJbM4nkqSYns7u9aMgrVzz9KQJA2GkXH/TDi05pX2gCS6o?=
 =?us-ascii?Q?d571e86caZRo1NhbG41YysqL/lPBzbf4kSXuXkzCmj5ttovVdmwhvVq29F0P?=
 =?us-ascii?Q?41o4hAVQaK/S3e9uUFxQz0O2GvWCeyIx4SdL9pSBGho5+PQ4ELuORCgs3lQS?=
 =?us-ascii?Q?FxgQyn/MeNRzxI2Kctf/xfXf737YUkQ8Dbf/ikbCU/V+ABDx8cvU4CVXgrsU?=
 =?us-ascii?Q?huSXwPNJfHuMpqH0Jw0eBumjNp+wOkivwy1WlOzNwc4VZScKPK+cC1K9pxUc?=
 =?us-ascii?Q?QXrsWFuJ9rIAkrCueTQOh2m78GWvH1IeHyoAYr61eyKGDPGIHx/7ebilIbUB?=
 =?us-ascii?Q?sPP3fdwx14OMYXBUOpjc/j7+h4wBKtlrGjD4x31iHVbn0MIj3D/nU/lO2jpN?=
 =?us-ascii?Q?CWUT8Gd5VrdePm1dJu6i8SK7PdslNUBA5duh7PLM2Q40JwXCJAxwd1ZXvqNj?=
 =?us-ascii?Q?7vYeSzXuc9xCWEhw9a0yv3rY9QlPLmWgCZf1qy4C7mHz2RWyWb9Y2sC6rmzx?=
 =?us-ascii?Q?TDRZhcwlze+kJsOgOl0IU0yn3eF7tiSyVtffPudpestMaGIwueRvcOAoyCFG?=
 =?us-ascii?Q?Jv/ZrmLz5TIH8gnMv9ObzOVtQSpJpLztNle/DkexUR52jHF6XZm5ZE+WDpZH?=
 =?us-ascii?Q?/MD8N9Il+kdNzVDGPwNUPb6yxwBR0nU=3D?=
X-Exchange-RoutingPolicyChecked:
	YlODrKm2vMEzGWB2Rbj2jj6N51r4BxXXvHJnYlT5vU0/u+stHz/U4aofyIB30CloVzRpU23Ri87YSL7Ym2/BUo8R2tl2XSNygmiGEtdAHlww+362HoWdGXeDyJPeGunGY9Z9lBjVRvNY6xZOvDvXuWsWbguySCIh/bg02lmt8oTp0/wzW+KMr6ysZwt/dwAW9y/WZ495+yA9XxMGcbyf7eSpgEmtJ4Fz76scxrs3FYAVaPFJfa4iMNBN8flQgEAI/C4zDn/DwOXOSz0fAU9NOlIvhLj1qQm/EcX+hMyPoGDmX/C2xOuI3RH4V8KII57vdT5rlzZxxgPxY56xqQZmEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1X+Qm+lrZQ4vNXrMN9i9zU8hxnLLh6aCgSpT4KbxYH/9yn6MNMf8sXRNYZ9JQ1yDs0DTlPDR1kMLdfmAxanTCmWFC87h9Nd71htUipRPzawDVv43zUvD7y0IGTvJtgW0P0lQtN3VjrfcBYkCmsRME5qRssBesGnl3omi/WBMqQ9nGrZVIXFN5AUqw1vFOnORKaA8SR3PN63HptPNHU5DwZgHaThm6PtizvFIs1WEM8URcc+XrwCbyuaMaOI2HMpzKvDAeHu23WzkmO72Ro4QBa9rQYJzoxomdfPBnxge7LoqdMwZJOwqP02oC46/1bcaG7MUpsd2rJKvAa8nvpIdVwYHZYVeQx+Jg9HwvOtTvtp8l7VgsA7j0DDIgcDVjkpxcporyy8UxCFYyEth47afA0zdCciyZwjfdeMK0gexjY+GMZZBsVO1fMGRu+E8dPctJeEONsn4nviL7VsJIJHuGbB5SbgD4vnKagSZc/FUmfFG/99pRmf4Q+ITx0DESv0iAHT3UWV87qKKwcA48o7abcH2CPouh81mKjEPe/Ru+wpryWlMcxsa0KQDEh3twn4zYiRYjZ05hDuUMjQt8G3Wtip2YX3hn75p85LPMoslzzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3011a132-196f-42fd-6cc2-08dec6ba0260
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:32:14.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6u+jJPDmKIVwAn+IzFHr8YQfcLf1mRU3iJBl4YgzeviEQ3ZfUMWm9W0xmN+rc90Ng2lTnG/36QUhrhjOSghAALEraKCYBzLUeHy7jn/oqJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OCBTYWx0ZWRfXwccbtk7U3k1A
 efi1dxBghYqiQRTGKaeimM1zSYA8u/aKpOHc0ibNebrDg6VEUxl+OThZx+9qHz+ooTVXaD+dJTT
 ttF1D6IEmhHirzv/dWl6UtM9BVlMnPhYqOUjbeyh4KXQzO1vOPGwQocraU7SFoBKW7AjvFv4gFo
 MTmRizRwmgnzufb7hg8rhtK7PVwe3elwgyXpDKdehXeSamYFmWmvqFYYd2IJT1A3Z20iUMnRc+K
 FpS+XsMkU3UW6Fmdav26gsFdQbHpcci/lEviAhBeMwDVJL4kcBGT8Y1mtr7MdaKECJl/YS90LEs
 m92J93gpJETd/u2M8NxFJ1LBKOFiKz1Fxzfpdd0naWunrevDSeu2p7MHFhWQN3+uzNCQABbNQsS
 fCyk6vVognSWfmdnvrSHPRsrjz+94IQj8CgVnwzeWRZGPxmEQAqzqVU7uYovdgBnY37252SD0Ho
 FG5CUiYna6BKT9i9jpQ==
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a2904f6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=iFABrAoMAAAA:20
 a=NEAV23lmAAAA:8 a=frA2QZyva3OOzxedpysA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 7gmSlz4g_Dpv0W91nIh7QqcVLmLUef39
X-Proofpoint-ORIG-GUID: 7gmSlz4g_Dpv0W91nIh7QqcVLmLUef39


bot+bpf-ci@kernel.org writes:

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index fe60738e5943..fa676428ec3f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1606,6 +1606,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
>>  config ARCH_DEFAULT_CRASH_DUMP
>>  	def_bool y
>>
>> +config ARCH_HAS_CPU_RELAX
>> +	def_bool y
>> +
>
> ARCH_HAS_CPU_RELAX isn't private to the barrier code.  Before this it was
> defined only by arch/x86, and the generic kernel already keys cpuidle
> behavior off it in two places that arm64 builds.
>
> In drivers/cpuidle/Makefile:
>
>   obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
>
> and in drivers/acpi/processor_idle.c:
>
>   #define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
>   ...
>   if (IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX)) {
>           cpuidle_poll_state_init(drv);
>           count = 1;
>   }
>
> On arm64, ACPI_PROCESSOR is "default y" and depends on ARM64, and it
> selects ACPI_PROCESSOR_IDLE which selects CPU_IDLE.  So on an ACPI arm64
> system this now builds poll_state.o and makes acpi_processor_setup_cstates()
> register a POLL idle state as C-state index 0, shifting the firmware
> C-states up by one.

Yes, this is a bug. The additional POLL idle state change wasn't intended
to be registered as part of this patch.

With this change the first c-state will end up executing a NOP poll_idle()
since current_set_polling_and_test() is tif_need_resched() when
TIF_POLLING_NRFLAG is not defined but this does unnecessarily register
the additional c-state.

I missed that in my testing because my test machine has LPI states which
need an explicit change to enable this.
(https://lore.kernel.org/lkml/20250218213337.377987-7-ankur.a.arora@oracle.com/)

Ankur


> The commit message describes this symbol only as indicating "an optimized
> implementation of cpu_poll_relax()", and the generic patch describes it as
> "a cpu_poll_relax() implementation that is expected to be cheaper".  Neither
> mentions the cpuidle/ACPI poll_state side effect.
>
>
> Is enabling the cpuidle polling idle state on arm64 intended here, or is
> ARCH_HAS_CPU_RELAX only meant to feed smp_cond_load_relaxed_timeout()?  If
> the latter, would a dedicated symbol (or decoupling poll_state/ACPI from
> ARCH_HAS_CPU_RELAX) avoid the unintended idle-path change?

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27125050324


--
ankur
