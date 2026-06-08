Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3639EF2E;
	Mon,  8 Jun 2026 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905931; cv=fail; b=a+lr/OXPmSsgKffWHMzIsLig9Gk3nzXDx+8Z7DyGVt0PJ58GOMXL+DVu8UIvtBq17KGvjJio/uX+ymSSv5d4eX6x8FXBhTALZmals3WggxaJ87S/OeCK1JD+FpSsa5PnV0jBsn14yoHp0W4YJxEtYSifH9smGSIK0K3lBc+Nb18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905931; c=relaxed/simple;
	bh=JOdHMZgrv2XOLFzbdCY/vKyIvIOObUbzDzogYOOqcw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3L6C9lZd09WR1BtQ+dzTFtTGxfOr7IhYdSeIyVn3FI5v/puSrXNWmsmQn7C5wOmDPNTtBeO1wCJ0a4ApHh6jyIQW4vKPzdA33YQ5dVn8aM8WeXnK4Mjo96soiVbb3bABj8jzhubLjPmcJn9EDs4O0i/xeCxWk/blFF8apajpFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q8pe6LsO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iWAkupTe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8pe6LsO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iWAkupTe"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NhEFO3923557;
	Mon, 8 Jun 2026 08:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t1WD6gdmDnveHpNY+b+GQGohDkpQAxKXixOVozTPTFI=; b=
	Q8pe6LsOhNZu0QCQcuuJtyPUMadEX4ee/vpk5HW3XXMzq5WcXsPWECqFUkhLXJ3g
	HpIZj7GV3nUcEew//X68fr70hTq/pOTmhtbNHh7pR17Z/VSK7IXRe2Vb3TNEJbsB
	lOoI+K5wUaxhzv21KVq1kXDXxMLosgx+YPrDT/NVlea0ns5UOXVROJmXUcMVsOxc
	VHIpg5OAJNDA0LJNlioOnhULtrzM2syz83IhFmSeVh9qFNM6uSdIG9Yce2tzK5Zz
	rgXk88BA3OfOYXuu7zG4Mfd7MsVvmpMzjPGfqgr42ZyL/63NRcLXAVmfmmTifJLK
	ap0h1Zq+dMNq785QqfCHrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5st0ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w8Ft036830;
	Mon, 8 Jun 2026 08:04:52 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0d89tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ5OvkK9XKfPdkjwZBxYoR6lO0xaJfmoP200afrg9xB3Ydm1kJrRNHPEmPq1x0AP/ry9exY/zVKEKUD4aM8PWaUq0s49NCoSalvUotq9bQ4Tzlt1tpy8ZxwSRc7afLM9uoMQvFh/ROpAL6nib9/zbVNBP43v0Vzkqq17F/V2ABdgOH5T8ccthgIi5Z1hjJPo/Q7zFBqNlavOciBCJGnf0pD+Tc3kStltnf4VNTrx6A3nyr7lt4uZNSh/S6NWW9OTP5wTY/LYbKd1tYEEQMuYPnDlNW1yTBr0UXbmHCmxtvnUEeBOGFCEx5ZnUETzveRfgVAdlSmbS7wJJP7OwXXLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1WD6gdmDnveHpNY+b+GQGohDkpQAxKXixOVozTPTFI=;
 b=yPkOc0ei55oCzCGZNfrMrqXRVm0tV9HRZkV85bhT/a4hYwAnlosMhsQE0f9XKdYZ1aYxkbHPJU2kfCHLExyS8trPW8NCiZfIDwDBk6KB57GvpI7/j8Tnt6wb0DNcnzc8ycjLrSjqPKw6jLHroS+p6Dm+Z8zQbde3QqXCHr8gBMwpwak1zkDJXqvJhpCubRY9G5UiqEyny6Xv/JXTQyk8CO/37LvQhFsQ7RqmCeso+ocBOdYMtUdimm6UjoRTtXRSPdcwIpQmOUUHyc7AnNKidtH/1fZquhhkotdYSlr4gxG/GAQ0l0TLpmHjmkC2+XuSDVxNu4te4pH8Y0+kax+fpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1WD6gdmDnveHpNY+b+GQGohDkpQAxKXixOVozTPTFI=;
 b=iWAkupTewiUJ1EGy+xu/fmXTp2Ow1Bd3FDwfNAVk26UJRdPGhyUtEL+Qmu0j9+L1G9qdWNZKRpcwV4R/+jX3eciRzdWFI1yIjQQim/3wRaxvAedwFAiAz6Pi1ygA5dI1j5s6DI4rrkd0qSEEtMM7HzmszMoWEfxLMBU/j6ld+B4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:04:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:04:45 +0000
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
Subject: [PATCH v12 01/15] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Mon,  8 Jun 2026 01:04:26 -0700
Message-Id: <20260608080440.127491-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 847cf621-b5b8-4df7-87a9-08dec5349a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	c5soNVvtgHDw/bZXWhJHPEPkf7zGrOXmxByJ5xvRnmFXgjZqqafh66+AHeiNqihxP/GlVIMJZuoGwNpHMPdwm0WUAcQAhcNUWZChJ0zMIs4ZKGZcsRpW7sHU6B48R97790adFJLVKzBhPb5x3NelU3YdvYauODcOqrGl5HBSCofy4tvlfCeZD9tN9wHa+BOvw6ztFHX5oy9fPoDHOkRvKweKIqMWi9oRPdA8eLgm/pyAjkA5trSUwAIaSQ8vVXYhm2kMWme9wbQ90sKoboZTrQYmbLbH/x1t9Lsx8YTKYKbpSZvyTy7BDlkBQ/3k7S3Qh2EYYnrHKfprqL/5rT5LzwUx/NbFfNmd4T/uaj5EOWO9Lqy8Qv+bRYjq1W+SHjZNL+0nY80B54PR0vPSCT1hHwfr2+CWlXNEmA9PnGbx3v4qEMhtvN0PQEfoC4VdtY3U5GuWG3f0392upapg61cbk5ReRRRX+4H5E5kg7fHVp3dNl058nICPZBKqkPM8cz0DZr9cIdCbTcTwFPlhExAjTY+rqz0Ow/H+BDh/9O7lmgvz5bNMgmpCr9OKHuudAvOuWFNbWmjwgvZQH/gaGu67XiCAsImFDyHx++uXvUw046/Y7vL10jNyoRSuH/r0oupOywj0vIYGLJkwANmcEvFkYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IllpuADGx0SShMnPym/wZ2K6HuuN3ayO4LivZma4r/0InPcKiyJOcCa3pBNI?=
 =?us-ascii?Q?UtnmVOAscnGvQwNJQsQUlTnUbTaqgnkOagmtRTYWhGv9RzMTdu1Jkwb4I5DE?=
 =?us-ascii?Q?Rgw1wR8kzH8Hx3Yda45t5FgMJiH7DZgMxXZxFMpXuxH0YjwvFqi2pT0ea7Ng?=
 =?us-ascii?Q?yuTDxfb1BY1Z8FUQdTgxUNjXg2I21xRW9UHsV17QhVd53pJHyvOZ2Q4efwxO?=
 =?us-ascii?Q?XxwAi6GHAjF503PUi2LAz2phvR1W8OG+DTCNIlJfEaRm4+fJrcePhbxMSljY?=
 =?us-ascii?Q?aYn34kgKr/Mh4MPbLzr4wboM3I8esURVXjcrSHIfh/lrT2lC0TAbSdCm+TU4?=
 =?us-ascii?Q?1xr6cxDTD5YBVSyH7fyq0lE4Y3RXSnFi7uD93MkeqQ5nvxwFtY3Bc8aUPpTk?=
 =?us-ascii?Q?9Ggew03+Od0a87UjEPsvd1J43A7B77JCK9WUlk+GzDw2/56x/75dBAqYp23/?=
 =?us-ascii?Q?Z4kqgkxcoe4ph8llqSEh9MSONMw8C/Hg9cq9i80aQ8PE76xIqy+g2yhhDERV?=
 =?us-ascii?Q?fffWHtoxhdKbP+aIhEiP0AOZtszOgMnSN7+ghvTaiIzSlU8ojipb+reY3JXf?=
 =?us-ascii?Q?ReackHbYYA4SZcZwDacDUqC/vIJ5gjRv3MrzJOOq5dgQsBVsEBMigVLHzBQJ?=
 =?us-ascii?Q?/IZqJZXgJ5xNsSPmem1hXleDuWYrps3dppzH7tX+HN+7NDpCdMm/be2PZnmC?=
 =?us-ascii?Q?3cVDKnGOshH7JGOwtAzbaLnjeECvEeuhAXEl/dDRMxKAJLggArsyJYcf9oVc?=
 =?us-ascii?Q?DJUTBPWTcMeJ7hucIHD0Crq5MDwQoR/leKdxx5R2O1bkZvFR4g5RpaZGjFJ7?=
 =?us-ascii?Q?gOvh4LGijpgAVGgEuRhglIjOe1R7cXoBhZdGIdqCDNAO1N2yG/TvGHW5W9Bf?=
 =?us-ascii?Q?tym+kBXvxsIzpIqCTwJKX0OazrTx46tAZ7JdU4O0Z9vJUYRFC2BwdNuaoD/R?=
 =?us-ascii?Q?cc+Kp3Omz2fbUm4zj9XfkXC6SA0ccBfLCQ8XiVewgTqIHGKdKinMx8wrKH4E?=
 =?us-ascii?Q?3JC9zuO2htKpjki660Y3eqPPyyC2Ue20Z3s/vwl/ILY6Dr9pjOUiCiSkQKZ+?=
 =?us-ascii?Q?rGjRuu5BxWmacfjrnMIy0lX2xBL7JkdDiG9INbeeB7YjRPf/8Ab+JWfQypnW?=
 =?us-ascii?Q?qVQZLoiqGUPUlQcDPyYxptPs/p7H9Z1+LI7CXK6zDJuXzdkt4jsrCTP5VprS?=
 =?us-ascii?Q?f2HOnUzJPU87t51RlHxBMdQ1yIfsGQ1OiVzPKImcnHMmeN9Hu/aHHj7/M54Y?=
 =?us-ascii?Q?a2G7wz2F4pL4m3M0VMokK8qT3ouq1s8cFjp+LtVlraEBdY8m42n4wySqQB35?=
 =?us-ascii?Q?iVIDafHziE+tOd2Ua9/0Sst+IJc0VD6o3pbVxt7p7+WbVYUzLVqMOzozu53I?=
 =?us-ascii?Q?Vcw2SL/UA8UiweKKkahf0BX4dSI9C4OCZyu6l7Zl8aiQM1Xe3QMgOHPUP56Q?=
 =?us-ascii?Q?vlM1QL7rE4clK+A8EJrAnnI0sgBSESPxH8R8+gk1nYpTQ0o31rp4kfuKYB0b?=
 =?us-ascii?Q?nTWIvu/KqzQQNpuAp17Bf9jwuuwM5geamwj9ZF4C/qOZOww65WpIuLBxIDgb?=
 =?us-ascii?Q?jO0DEkmmv5wwfYgYa8X6uXmH3NSiE7BsyVOz9WvScZuoyPGb9Hvaha6qopF6?=
 =?us-ascii?Q?On2+uD+Npi9ZRZkAyXHR4hjhYat3aiQtrK6vtR9VZoGRLMKEXdgM1KduoID9?=
 =?us-ascii?Q?jIk0j2zSLqlYxUS20gkFTB7z8cWASJuScUJxCAqN3W9s73RYyf9f1xbS4iW7?=
 =?us-ascii?Q?FPcBf9IyiQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	OkYlBBdiq8Gr+6ozUxf5npMXhrGIbssYGBdh+v2aV8iUpmcwTZUX8PO/4CR2//kzzyp/WIkyX2eqox0VV4XcgDpgeXUSfiGpRnQn+0T4ejvwzTFOa1p55zFT/WpjSuxuUivE/A+PwU/63jpd4Y/7krg4XyURVTedw4cZ9ZtA/JNBbTomN0icrDuAOSKOV0iQaOe7+oyLJgbRXGSR0iijgzZe6rX+L9CBMF4tUmWanLPZ1WngJcJQ82iRvxicS5grovdDtuRpPJ2pqdOfSHXZF7TcdzvVwhzydZwldm1yi6hH8iZDmebEcjvoAg4WT193SFJk0OL9taRNQiBCJs0meA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NKZQwDf5J90AJdRTcvQhdZjo+4jXsU6BzOm0X5iNVEeXc9BxKgM6ds2zIXoCSzhUBRtYERxX5JYkvc6AK5lBkGDRL4542pibNCKtfIXB9HBaKXNJeYhfladj2dQhkOxOI3t05NxZzB0NJw69xpxneZOIUjWoUTzGTcdO20bqWAl0KGMTSeRGAvce5gkgI3E5ZjKVxu1yS+JkySTz1N55QfHisELGI1k7GcmvJAF0OEOVJIZ0tWDYZ3yPjqwYxXsz3Y1nQm9aKHPuHzsDL+AUUtw2r1zX1cUJTLWSenfTldW8pGGs4hwRvaYf8g0BpllwhOz0jZcyBBkDNUItub12HDM+SAjgO7KvcyNpdfEaVspcHw7caEt6dydl0Ib5rihNrYbU6AOYBgYhkOJo3FLsQg0UPwcg4V3KO7iFvcu5Dn9nJj5kdJK7JAOyz7ASda+gtW9/+yLRa25ru4WnV3jozfSP86vB+j6EV4oYJt6Ki3WDP/6CM2bkBipTQl6KVCE83cD/p7X/CBEL7/9D9DsilJrHvLGaM8erSH5XqWJ8K/fcJqoNDDsukuofp9BmJ7iU+/DlhjJ1EZ6tPS0AiiWijb2H78XEj3oFpykXvSwx0cE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847cf621-b5b8-4df7-87a9-08dec5349a1f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:44.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldqbRWmtd51dKrZwCqsSN3+GRtBR+6cg80gstT7UpLJvQ+ClFP57FRJAvtS0fob7dsmALTR1B6cjN0a1mUoM1N5PdGU0Y9DUaBK4cedHPys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX5u8gm7Nu1XMA
 AK+NygujSdBncVKg8989l0He0J08FQtxfQEK5skK3t492iAWk/5Rm1IeSfM+sRzmqtAp5XY+daL
 UxkjDB6tTH3MN13c337JvoF5KOorwoO0Uwx+MymsQDM5qMCRi7mIgfG+Skhjp4S5pCeJKetb0uH
 z/k+w7VpRofiPWNIyjQCYjhbHRbYiOWvEXuC9aRkHtufC705R3mqDNz3IcQN4Dq9UQqhkSsHCl/
 PeYUdkQMsl1juPt4ZA89eJiZkH9ajIUFLqN2RyQ4smqazRITqTrJa/ziUJRmIk9uiYw1KR8ud8P
 b1+EZ1WOGRWHZM2zC1ehxJZoRsm7ClNHlW8ls1isMOHlUq+dNVYTQ8QiG3jP5YaSwuFI/Tv8WVZ
 GPRIRWiWI4S5MaE77tgCyORmN7kgW14UD7yaNDjiiryMis2iZYYGCBVAdHSI7gBRNPiLjkPEEjL
 Kv9Xk16/9xsRcX1NFKg==
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2677a5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=c92rfblmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=1Vp-6p46HJp4oqU_kr8A:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 53FMSXOjMjNbS7DuwclncFqB2LmX9kTp
X-Proofpoint-GUID: 53FMSXOjMjNbS7DuwclncFqB2LmX9kTp

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax() to slow
down the busy-wait, which, unless overridden by the architecture
code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: the timeout
case or, @time_expr_ns returning an invalid value (negative or zero).
The second failure mode allows for clocks attached to the clock-domain
of @cond_expr --  which might cease to operate meaningfully once some
state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

The outer limit of the overshoot is double that when working with the
parameters above. This might be higher or lower depending on the
implementation of cpu_poll_relax() across architectures.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. This might be relevant
for cases with a long timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Note: addresses a few Sashiko comments from [1].

We leave unaddressed a couple of potential timeout range issues (around
S64_MAX, or during early boot). I had proposed a version earlier that
would address those in [2]. Since then, however, I've come to the view
that these issues are best handled in code review instead of
overcomplicating the implementation.

[1] https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora%40oracle.com
[2] https://lore.kernel.org/lkml/874iklm1uy.fsf@oracle.com/
---
 include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..c56df9513a08 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,75 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ * Note that the iteration count assumes that the loop condition is
+ * relatively cheap.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+/*
+ * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
+ * that is expected to be cheaper (lower power) than pure polling.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are assumed to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want
+ * to take into account the availability of ARCH_HAS_CPU_RELAX.
+ *
+ * Note that @ptr is expected to point to a memory address. Using this
+ * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
+ * tuned for memory) and might also break in interesting architecture
+ * dependent ways.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
+		if (++__count < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__count = 0;						\
+	}								\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1

