Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C42BDC26;
	Thu,  2 Jul 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956065; cv=fail; b=RGvm4GqazGvVSXLdfpDoWEYb2k6bEMeRGM6FN7i4VpR40eCXgurl3vwGRScCiz/0MOjIL1i6SVfWXuN+mJ2upud+H4AXj6xxdSMvi8hdCIYXyFR1KT/U/V6IAZPwaWMzerbTKqL/lXE/SBAxMzvhczVmk17bHf7h65TvRPJx1/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956065; c=relaxed/simple;
	bh=JWPT3LnB1V6bdyGmilhpoMvePt+FtIdp7sEpWKb95tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owx7eyShKrLsNQlQthuxoxP0g9enuFmOgEYeIsQqE2Kk6jR6HSm4PkCrPxTOjIUwhZVLcQiINH6RlH5wIwr0B2mfr5OdkcWSxYp5UJ2CrXYsasQ/1NRFi3nW2oy2AWTCDJJz9/LCpeiscTzw2K+nNq/DwBstw4DcVJpASrNz6KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cwf5eBuR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Eks/HutX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cwf5eBuR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Eks/HutX"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EKFEk2784251;
	Thu, 2 Jul 2026 01:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TJgQdJYGoHcstk5lBNCmodKo7PpByMzwSisE0oj+eaI=; b=
	Cwf5eBuRSahA6EZ1wgKAxiKSxaRJ9p1jJpEFnM48QqhFYu+5o6IiSwWVBBHD+x2O
	6t5TY8f7Motz3+a+zAKaBikLp+9i47gytXo83+JroP1KTY7iCIvpc44poxAZ010R
	eaoKRVG0XtZmba5kaV5UZWvYlgB35CPoWSI97UpIV4J+K/sCgiPt0BPTh4Jxz4tF
	aBkDGVjxaojt0L7UXRd32XsaHOwFPYUrmultMd6m2o1r/jMA9IO/t/eWukhtBXqg
	vGXQ7LC1g6lccjWRbMEvbwaI1NVXaKQpDM9c+4Fb+m3N4EsXwUfIKpEQta9Sm8Ru
	uhq4d2tbPL6V7qn1d2qhrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f272qq6s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X6B7036125;
	Thu, 2 Jul 2026 01:34:01 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f50yt4f7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiMCCcGm7uzpeCY+XCXi77HSpOBHt1HYVGydgVPg76zNZoBqG2fCWgJytqUsZvFX8PB1vtXDjLwv6QHQT/X5nWmXQNfK+7EE1q54RYyPOX7HHaIP8q9Tq/j1+WaHbThvdS42ITZSI4O24HNGJxu54+O2IdLetUoE2NDz2Y0N1007GQ6O+4vUTHUfi0nIcPrt7vVUxmb7fS38L8ox7AysGrhgySpt0mnx9awi6AS7DJ5KE5jst6Uf5f7+q4vcKbYpfLVpz5tJTbizaKvoYEm0YY7j9ktBN0gfaBtBwANXt76doz+MqsFmAjH/54jHct2clWPfGisHW0MwlzZSfKEBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJgQdJYGoHcstk5lBNCmodKo7PpByMzwSisE0oj+eaI=;
 b=khSFrBsAjVWGZCWIYS+MJjpx/E2PpJ1++a4kIELRlPdUX3eFidbkVKb97Xhke9bSPbCCwEN6czVQAB5uCED2PB8BXorNdx9QNgw5hZbk8ZMNv+6PQZwMpxjGff5L9OF+F1ggK3lB9pA1MQqJJTJ7u7sQDFMVltB9NttJ/r2lh8urYaPdfgqQpc3JTbefOQf+ipR0vEsh399h7clLzqbP2r8Rt5rcUdICKoXKzWIQ2ZCAVD8292l8KILei0u7bXJeyPs8C3N2it0pNR73NTK3F1ifkQXXfB55hlOaxlvLbu1w4wH0EAWo8HY5T+RaJd993fFgr2M8gHOHhsikNM8/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJgQdJYGoHcstk5lBNCmodKo7PpByMzwSisE0oj+eaI=;
 b=Eks/HutX30bS538cbFif3cClIXaE8m3gbl5KM62WDp0codX0pIJM8Yn/OsyLBR+58ooqN1ryb7wyTaIPjLMoSutx+bkUFUs5oAfzlEOe1y2WG+GTguxZOB0GVb2VdRq8MCsLeOmNAGSGAvq5lhsD0DuCofLYt8jVLFnImaIYR1U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:33:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:33:56 +0000
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
Subject: [PATCH v13 04/15] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Wed,  1 Jul 2026 18:33:23 -0700
Message-Id: <20260702013334.140905-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1996124e-8e1d-46b0-94ea-08ded7d9fbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zvxjQYD7YgsN83DH+lkd1ga1Wtwp1+lHMH8BqfnlauE+iGnCDmns2EzCvs69elRlBMxy7ddHy4r5IY8M8rGzl7dhVRaR1ZfiFVAEis9NkN0sE24x6sUwPeTbEymJtCGGEOhc0JnivM0hW1igFA5MgyZvrpd6rHNl81Ewwv6Hbd7sU+3XzTELqOC+nnqPSu7xDhprzW+B7Z8AbW+EID0NQ7p7vheA8z/l1HWXEBmhbudf1tUAwQ27N2c9jujrOBHn4ArUaxsjaEj6yDefp4HOdrBTdRKcgiUJo8aTqYSbioL+tVigi2866NB39+F9Q3t8dVLMLIJaZhTqESBiGZzoEzMNS7VhpVH4vaHrfGFRg1uMHUxX7bgBU5f3O/gTMjjaVw+Yez9EcFwR7wxaAgSsaznGYxo9/sFcCppHK+772NG38/lI7IGJCK7N/xK899SOAojWFNMKjUdJd7PCfY7iEw83obakGKluT69P7yGym5+prmp5yejwfr1xhMqV4BdMYSZOAtqpu27XzxfSA2hyPD4jFyV05h2tQ/qr5U+5YDiWUxqI+ZOq3nYBtpnV3MvBP7Byqp0ct4KvaAGci89KVXTOHfYXZJ+tdkI8wtXwmY2iDuiBFn9KDNIzKfrlMF2g7K9NXZYzCmFjb0R/tc1sYlSDSfFN8ggX2/5Gozem+XI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BitVcNbpeZgNwiOqBbaoW2haDjVkyUOQHT2+KFaxeGfpIEs4xpnGvmUk5OAO?=
 =?us-ascii?Q?jmC1nLFnLqtgXcyNvHXQiUjDoN1bCyA+HHhN2sJ3nap/3xeolrNAVPI9ZwPk?=
 =?us-ascii?Q?GGjkLY8C1HRIhViU5Rx/+C/YeGkppTcNwo1SJ/vp8oFR7F4gx5XddloiKk/Q?=
 =?us-ascii?Q?ZyJzMyBl+d88BAoC/irHfB/UN1iA0wh2cdBzpPf18CuqFS0Oxk7WKqBZimHL?=
 =?us-ascii?Q?+ltORFcRucCzzmQ44NVLaVBmAWdKIL6PmZqaoXew1tx91XG6+EcqbAdovG2a?=
 =?us-ascii?Q?Oq8v05TENdXQebjw6ikOjNifEL/gneLFi+zW6n8hjEEFg1WpaYJDHlSwQaGU?=
 =?us-ascii?Q?pGs/QGxWen/jmj/NupdL9A3MBABm2L680SPlNnzFaBSVSYb/1c2hIQCKDOYQ?=
 =?us-ascii?Q?8M24Ny73YLvxKjJcCo5tDIFlTfVrcyYvaeJ+tp3raMh68kVwilTktPmEXj+4?=
 =?us-ascii?Q?T3bW5GJOWK0FApNsMZfUuP3LCxyT1mRzeBx//vhvuQzEaUNIMZy+8X/iZRUL?=
 =?us-ascii?Q?/2h5WCgkFrHh2S+IdX5cNkBLoUjlGooALXX9TCvQPQb9qs6yVZ3jFIsTNLcE?=
 =?us-ascii?Q?bBj9MTYrFMRosyL8VhXLulRwDAC4if1PEpbz+talcZJonb/WANltBXdrNGqi?=
 =?us-ascii?Q?sRCQjiszKneX333FdCN8ZDYUU7gzSrAhaO//2FmzHX71Vuw+LZRnaJ2afEXb?=
 =?us-ascii?Q?UsLItoEdA0cAGkFplQFYhCdSrSY6TwV+srhQ17Gb/FxIwNZVb47l08HEUSCf?=
 =?us-ascii?Q?NI/2Ba7XMzPUQbnc/30He4ZZeoj8On0wJm27zypAQrYQajN/QzJuNZp2yiri?=
 =?us-ascii?Q?nyQttoHAlq+TTesRGTPHZJrYCxLKTiqWBNZ/GRflh1VzBX6s/AK0D+C/3Lp2?=
 =?us-ascii?Q?33rgAojhIZ4imjZ7T+nhwHAnFwiOsYQTFGyKLrvio8pTkqA69bN9SOvn3vqN?=
 =?us-ascii?Q?E/t12PaU6OqbW5t38VybNbmbpvTPGWFwQ/6s+VwmSJh8LXNPEQeflTEBlXJt?=
 =?us-ascii?Q?g454+TuLG6xhGd22c1Uqbahu8c0lkEOM7zFEpQDR364Pymi0ZTF7X4wunjZD?=
 =?us-ascii?Q?0d4ImCNGGXeYso1bV5W/rUj+aS2pV62ijKcGuVhwZNOT3Vl5B+F7wWgoPMI9?=
 =?us-ascii?Q?JK0NZulDGePsWHjlIXZXjavDtiAMjTc3tSanl6EySVpDOQ1+yYFXF59GinQA?=
 =?us-ascii?Q?PwuYu4X/kdiac9D+llzBa+SVhkyWeHbMMn0wN0CRpRO/fSLKC5YC6RPD7N9q?=
 =?us-ascii?Q?wkVYSt2anP3z8NwnwiTZzYvYB/Ggl/9Mgyy2EK3uxCPfeIpq8bTO2ZW3dp7Y?=
 =?us-ascii?Q?t0LXR/OqSMse+EkwLHYjAkJ6ZK2oqxjkp1I2EyuNM3gxbi1emMG2VsGvTIsP?=
 =?us-ascii?Q?ax2WP4x2ZePDZoJ8iyF8Z8bT1XDrUep+mudgNRI68/hWWUieE5fmLoc0cL5g?=
 =?us-ascii?Q?SXm1/YVqsxY4VP8aQbYQ7EweCbby8Agtiv2kdoq6jsAUttbx2Ohzx5O2YMaK?=
 =?us-ascii?Q?Oz6FS3PUY4m5wOXMZxd1eL/M57IkXfcLgAcOeshzvm18ekDJRJzvOzRbM9xs?=
 =?us-ascii?Q?Ci9gOMQzNstoiev5MdHTjFTiGcSOTK6Grsd/brSpjFL51venmF/mW+tEZBHR?=
 =?us-ascii?Q?J7OczAnHPG01GsC0NZRD5Vrotub3k5G3ZT0GTK/CsGZFmfQVQ6Dun29gFUqr?=
 =?us-ascii?Q?ElBSnrISaO33DXfSY0vUbEfzp7H/6H8wEHwAcFnYgKkerryx3R1lQ83PgBwe?=
 =?us-ascii?Q?GfHiKwQqnGhWMlhSZvIGfDFXAWPyTso=3D?=
X-Exchange-RoutingPolicyChecked:
	bUkX1I/HUrrC79Z5zDeVlcMdPmI++qP9efvRAR64fU85aW9wDQby90b52T2HQQafv6wKzM9kJTjyZgqF9whbbRks5nQe+8DIwaSX1CKHe3IprPwDpJDjI2UqqL8y3B1ts/gn6mG4SyDZzEcLszhjQeZhwZitFHF9iW8O+awp3eHIGkvGMypWnmFADEeAnisL5PfgjCxgyXdgdu2c+S8VgfKYAUOMIPW8wCd2R6mEJl1Kmv7ESv/4JdS0+/+oGnyefsd+1KhdS8JA1YefzzluIlVwo5IHfEONp3zIRKh2OD/N3iwr7YNmSn6q9f2skAcuft3uP/mhQpiasJRDklDDng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EQ6QLcY5Sf5ZZ2i1G0X3T4MKwszyT92u2aTS7VuehBB6p9Ge8ikg7XaqgGJc0yJALJXvnHAdWRlKAm0qbfaEyO7Llh0fIRH1/eIwrEDucwq5luqdv7eFq1Rs1+EycOKpdV/e8Qi+jt4HZCFQe4JGspkXppbAYYbpfRLIBJ7aMt/07xL54XUEJJDpwSKYqKUoYOsn3FD7QZIXnEy7JwbyvNopJellKlHRmz2ThbfOKscJ63zF6uGAsrBedWjriBEbv0wQNmUi9XcFKzl3BuLnPqrwqwjVZPW4XshMbbDhrCNU2AccFNNQu8gKNozYXtiSAkjbGkFCk1ghUCtowwpFJwA0UodoUeZD5QpcrBg9andAnzK+P9XYk0EStptaGe8pavvLI1jqk3m1EzMwCovR/jykawpVd+vj27/DLSWJCxSDLuqU+4QCMOlmLlpxSr/tBLudSzVaFVPA97ETQEvKFAulGVJVcXBYlfPtfU2Ls8aQU6KvycPIjhYhGxmWrhjQusO0PDqlEOk8p0xMtJitI1qfY3lT4dJ4Gtv3pZFC3fYRDEvx7xji+S9DKML6ShPlkQmH0Ge0IvqGyhXcly769lIyHQiI4yIsqIMOXjrU4ik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1996124e-8e1d-46b0-94ea-08ded7d9fbd7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:33:56.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3QfhUiWhhazOLPDZNzx/QfqH4fMSFhA3ZnbgEH3Zi44JrnZtkeRTuNmHrjxK+i4Q563h2s5Tqp3rW/PDxicOI5WBEK7tpYEYsT82rtaLIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: cUmiP6c8jcU_6K5ghxdnyJzGcWvTExPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXwUjWk3g8kxFi
 MaLd7swu1AWA+QyT2cYyV7956/7STKJQelNdnMzpWGpW/1aVG9LVWqjThZX+KaVcYMN/K47gzcR
 LopmNumzGW5AztDVhEe34V+nPCVEeMqRZ0AZfOGGXr14HdywJE7bw1WSe2/z+Pigg/aat+zi/LB
 1GzzOCz2IJdHHIe+UJnR1nhkMxu/bwTLCizVHi6oJbNp2bWCGp82gc/tRL+mhKFcE5ZUS2MkHN2
 7/NfvaJEwq2EqK2K/dgY1U1kyBdhSokfnps1kCFT1ny0DC8gUMV0LV+EKre3VmiqSvC9QTody+M
 Q4T1pQA0ZkF4YvCssPwAm0w4b4qYAH0gQbm5HCttvMFIgvxo/ND+bviSbg6JIKRK78A7aLQYlJX
 RBjsv/r5+S0zIvhQlmNnAAUW52n2bF8Nhmo259m2f4fBneHWYJxMp8MWJmW3VpDMtXCfzzksIHn
 HyEUQgkp0oJp1rsIjtg==
X-Authority-Analysis: v=2.4 cv=LOxWhpW9 c=1 sm=1 tr=0 ts=6a45c00a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=h2j_Ys_cKJEXrGAlRtsA:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: cUmiP6c8jcU_6K5ghxdnyJzGcWvTExPG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX/pQa2I1gStjg
 10tINjtrjmbDcGRvtxYfTgMEDI4wBLEg8CYfIaXM+BsGqm0CuUKtcj4LSmKdyStiQ/GD1UCB01W
 5sGsDTDgEtqquIY/BszvxAcnDOLCvm5ljO/QfHpVukS+O0xN6CvB

To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: does not address sashiko comments on overshoot or range
issues [1]. As mentioned earlier, these are okay or addressed
in review.

[1] https://lore.kernel.org/all/20260608082735.830451F00899@smtp.kernel.org/
---
 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..9e4cdc9e41d1 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -212,7 +213,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = __delay_cycles() +				\
+			NSECS_TO_CYCLES(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"2:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -256,11 +290,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.43.7

