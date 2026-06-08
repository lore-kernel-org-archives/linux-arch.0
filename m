Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE139B951;
	Mon,  8 Jun 2026 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905944; cv=fail; b=o9L2ZdqvRPIHz5xHVIy+CWgoOwxiwbok0zrPvPwb4I/ZA9I1Q61ojr5oKbjK/CJf3P+nptq+phYuhKYQpOhXuOSvUCc8+X0vBoG70C0aaBmBeNMTFhCFemTpyAb/aSpfBXMazsJEGXoxHgIAG8/TSvvL4UM1gmS5ERydHcXzMPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905944; c=relaxed/simple;
	bh=6XIgY7TaBRHsz4S4u+4vB8tExQ4r4RVz8iZ9or24fL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7JpC7zxp9ROZ4G/UiFfMFL3MCHtBl9EK8mlVUIgLL7bIxoVGToqcqY0dmlOKB/AAxz2+hAvR3AzK5mI8jrsNhHi/rAU6U88YMhYNwEz4qz2r22qfLiVDol8is5fS0mGpRhnNO1f2pdsUUqwjXtEQVUlYWK3jFhvMxJe2+517c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ma4KikEY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dS3GqiWR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ma4KikEY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dS3GqiWR"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65809f1a3675269;
	Mon, 8 Jun 2026 08:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JLMdsv7FCPI/iT8Tn5ckV61PIBlZzJSnbFNVrSOCfGI=; b=
	Ma4KikEY5/gluQVi76wTlL5R2NHA7PxCULSEtzuoTujOdfxL0jmvtK5IezTME/f1
	Dd8fqCjI9mJZmovYLoLZ5HN2vPp3X/17Q4Pe5RuI0CdMH+wwC6hl5SpXC0E8mAdV
	L5zOr9bbXtlJpG6IybR0o5sTbuuTbWb9FEVCgEuVsNz23eogOfkx7NyBHFaiFsJY
	eBXNSaY0m6EN8ciPqM3BY39+8agyOd0VXRg52xLelr2qDtTQeGAxl0282kako7qj
	AKe+KSLI1HFq8ouELNWc5E6l3rvxUaM3LBS49xO96kAZT1BRBx19fu3JzCMLywCP
	HsAv6+VmxPYhsdxC37pnEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4em9yba1c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w6h6040442;
	Mon, 8 Jun 2026 08:04:56 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0dg6kn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ/izDrRsSgRhuYgmcNHyC7nLvgWITkCdx4XvzU32bTVCpy64XG0YbKydCzflmlqMg3jCJdryj0clByjMiwFpDFuXZ3Yvmq6NFiKiOEGg8pSWo2++SjJAIo3v4vEH0JpkpItDmD0+KWgpZB326CJd+PVgEEySCDwOmpC08Mu9w6VJnertGpOw3hZ7+qOgBgMB0y3t+SY/c9RlI7AyuK3z0KUUaIi2Y4e52BXCaqpSPlUNgJRNyS+Dp5u5pxcHTu6k0sYKFm/lQJRutkA02pN0qmjqWVbUfZjM/kfFvrGOXeiJp7mPbF2SP3rBwHMyPz6EVrVqz/+ThaGii55w3KMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLMdsv7FCPI/iT8Tn5ckV61PIBlZzJSnbFNVrSOCfGI=;
 b=gtxhs65MoHtxXDgATI/6oHmAczPxSYxokt3/ArtYhK2qlzxjq7IN3RqWK3P+suPZ68jEsVONCRh9NpgRPChxS+F+CXYfmXDyhD22tQGngHP8TLy+FHi5ivC7C9qdpOw08fgsw2s/rxaMBvPLYy7oPVS6nmDlToZoU5LNvy00fKooIWoQZ1TP2wuFKESquthWcEpBL9E8CHEVYR7dm6THsXbGPtrdJ3aU1DnbBRMXfsL8qnYvO4s8OAX6jgovgt8gVlAWzS8rQoLP/wWZMvKLdXNdNMhIqWw/94LuWTiJSfseI92xw95v4jIzzR0RgkaFzBJEJSSQBA0gkqqiP3Ebgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLMdsv7FCPI/iT8Tn5ckV61PIBlZzJSnbFNVrSOCfGI=;
 b=dS3GqiWRAWWuVPBJWbTCqX7daxluQUrsUk3Msjn4NmMFlt0RuAPMxo5a82OJ6DqcCCPgJGuSHzEpzVG+jF6liFB8+vZI8SqaUzV5fpZWP9rtfaCgoPEkL1/9SHri2u2DboKV38Pmok6qYbHtOxs2TnVIXy2HAxl3BLOXjniZ1Ew=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:04:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:04:53 +0000
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
Subject: [PATCH v12 05/15] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Mon,  8 Jun 2026 01:04:30 -0700
Message-Id: <20260608080440.127491-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b116b63-01f3-49a4-40a8-08dec5349ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cJ2PXM9fZyDSHGttHpRCRxp/opCaQ7Tb0NTkoZz6gEfzT7PNwy2j8Bs3h0DA9TjxD76L0vdah6faoiwPA+CHIzymFkBvctMZCv9XQvPDZoUuAo9XqcJGXCNYzJtQGGuTnE/5WQHMAynSix6Hyeek81xHCrLkzqy28CYzsqkk3t2+ylfbM+2FOuJpNyhp6k3iJiTVMacmpcGXmyDhKPhxbswMt/cPNSmH52V4nazCSyovTrcrpjjV8MYl/FCPsAiWkLNEIB/BQO9CbveQDXMEXnJt9Qwgxl7zLEw1zafzPsm31lzdLda7OmbGEHnVXMfJLc0RkZfmiAKu0TOyL8XC/tI8z9DlCl7KTie7CRvuYLMDPK2HqqpUz99TN0uPqLBPYijoJruqLV7KTmJZB5lC2v5oY8pFs7qmNMy9270bFqMGxkM0btt5ZUO6QIjmGhu8hGF3kbcsZN2is1HosLWDjrVWaCpP2+sznIYA2X+UCUSQTsKbh97k9itksO8l1oJ+lrCNLNS9FC52x3W9NU5Z7bBjwesuIwLBIYvkHO7/trOkZ76k2M9JV9M1Funz9DSwrf22NUSridWcDbvlO3fCrZJHn0PYAp7u71HCjZ3nmlOKh9QdX3lkq4GYV5iZJRoPuLCZMiEQKGhQ/dUIzqxX/V0duJDTFkUJqqffHxD4SEvCJ51NhDhB9X6SJtziSm0Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L85gM6P/hPLJ8X1/zDYLxGGyFXx/cqkemqNpKRHElVnQ9GlijdVJ8P5aoQ3A?=
 =?us-ascii?Q?jdvTBvb0ecs5YDKLv4pqC64oC5lWADXt7y1wxfJ6+al3yeYYgULy9cd/FrSe?=
 =?us-ascii?Q?mG2Y8eBl5V/jWM6pVmByql1L/xnxHbmvda24T4sLNJSuatRiKX4/DuaoZwEb?=
 =?us-ascii?Q?NJ/julXUHAl7AkntCRCxAENQ8AX/rcAyjzN808vTfQgrCTqotuniVC9J35j+?=
 =?us-ascii?Q?LyRBsXaC1NFSXmbwo2g8/wFRkD6Qr2wYvAMpPM7Vn4DzQErNi3i5NDrKiGQH?=
 =?us-ascii?Q?GwCAZ9rdoYHqw/Suhu5iex6b8JJuNhIhtpZjsif5CTjPbtQo/UX55MRPOQxw?=
 =?us-ascii?Q?dCSvSngv+YPR0CawONKA/RHnLAmtKqsPHbDZpvDOYUMDbDfvQsDWrYB2hWGU?=
 =?us-ascii?Q?d9lbc0y9Z6vfmYBiVuobzQDzLaP3Lu/7PV8tHVg5vsH97COfVn1tL0cN4iJH?=
 =?us-ascii?Q?loqs5BsVbfB75F8BxKqobpxxwugj9MILV4dKrri/yMQPPPlYzjSMXhdC2bW1?=
 =?us-ascii?Q?eW29sWChfT34YOipQDGYUxDUTRQlXWwGI9Jr+6FkJmFX0yhB+Li9tCm97Cbj?=
 =?us-ascii?Q?lnnFAJhcyPWUjVij+SaUEKEuOr7ZhHo6AlMur2FLmurqttfevOG6UQwg4u3P?=
 =?us-ascii?Q?UxYhbv6rqaMDfp5iJqsrZspmJRKoWKY2TUC9o3fOTJHrz1Ff/EPh+NmAPAbf?=
 =?us-ascii?Q?yoBLjV0J1HF7hPCD/pAutqpNzKwqOpP2v7QZY5QaBbWkgv6bkqHKFoMYeBsk?=
 =?us-ascii?Q?9Ct6HMx6t3x1ukTND90ixZbCWW6BMFW80ClUqVQWaKAqgLepQc1Bpa2lqW14?=
 =?us-ascii?Q?YwLGZRcrHh3o1DukA0HUN09E2BtbAum+5WL5otWcY6kEIaiXW1l7uFEw+B9w?=
 =?us-ascii?Q?QO/A7AducIqH8c7V1OpCCsjOATYEzG7EnZh5JSKASAQfNLmL0wO+Sob43Djt?=
 =?us-ascii?Q?od/cEIInrI7i0LdckLNG93JgJK1rO/Pa30ZexLHa0sG7qJjZ4ZBlACfYVqcE?=
 =?us-ascii?Q?KJNVSDo+jJ/+Y8OkClzSllbrr+XgRU08KZjL7x8vBgQXbzMy3+UJ9tFpuCAe?=
 =?us-ascii?Q?DK61jL6GPxZnc8QZRywFMtY3utvBk2S03qkFQuJXAxvGD12YDW5t+c56l25Z?=
 =?us-ascii?Q?vZmskGlIMidSmZRLvn0pwiIZTg677Dc+lCDQj75wm/chs+DV9WiGzjZI5FID?=
 =?us-ascii?Q?LDM/DJQsbaVRO8x1VAFP87CFFsTtDeKAAghe7ZIHaF5WNtw4LMVVnIAqXxKB?=
 =?us-ascii?Q?3YbY6HJkaPPJQt305Z91WkDOalGFjDL6hzZXDvMD8z5KgVKXfHR8v96mHEuS?=
 =?us-ascii?Q?4Bo3TPFPWMkNWi3K7wjaDUH6HnW7vuFpNv0UeOYBkE3eJkMSg8+eiJ0ImX60?=
 =?us-ascii?Q?cu9hse4NIGLIGVH0mVWkq1nIk5V7pKr8kQ3qgX3aweCVJlq+k2uA3f6Ad0Ss?=
 =?us-ascii?Q?l1WxNULKLH56BxYXldq0QNwfY7tdTNp5+WMd51v0+sXVxxDwAhm1+zed8O/q?=
 =?us-ascii?Q?xFhXrNOQYUtqwXC+qdAh6LfprTbkVWXAz0umwZl5KbKIFZHGubdO8kBCBrZL?=
 =?us-ascii?Q?ldXaTjiaOONvmkZRg41KZc6Rzqr6QC8ukJbKCWOqAaNJEAgI4DTq0Vg6OMsH?=
 =?us-ascii?Q?nzokmlPQcAMMJyc9WPmFDgbKln7RkiqvGKvNxU6P8B6CGoBuxo8aB00/P6B+?=
 =?us-ascii?Q?fzoc28I1RRJqO3H542fYqqbCP+q4g6yZJqPvZXhBQ1FBKDrCoAPpvsXdqSWM?=
 =?us-ascii?Q?Q+L0IbOkLg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	cz+5EE4LTdkCDsIRtSAch4XdYeW5GZ47zkCQoSovmNQVog7UVzUH8LY9rkYWd642RgHZdYqABZbhiE+9ctUjQkSQ6y4DLplX2TrsaeNExneP7CBTqwDg8gpnRuyy4wLi+lqbHIna8CEHyZ6CiSw0K/WOxllVmPaRyVD0W3bP52xUhIBOuavBmM8cahBYiodwSl5zA5rhQiXzTTbA8FDlKL7sAQE63zwmf8tilk+0qo12LK3HdyP9oj+7eXqUV0YItLm9AFkSYDqv+vAtIUYuQtB4r0LToy6mN02asn1ov/ToJtvhKHwkxd0M+AFY8pSJfKcuxdvwkfA3Acq/MBxcEw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Xfa9yYyI/DR9aDlb7kaDRcAGo+d1wxprAWaYqGwpU0Y0IV9PVnTcAo/p0e7oxoxK1znvhIGEYx/qkTODztCgrmZB5nMNrSJAAH4DQGqn6WTVdOeiSXMFxj9cXuSaVtyiVHIJACixX6O5CQLfDexdZ0sohYplI5V8x31qXhvp1aNqbOPZ04CnqvJ8PdqDmLSdSKvgWgPMCm1qyDJTuRuU9fpFGT2q+gMAWnjG2y274Of7Vev+wI9ByuMJGv7ckQ9O7/0rhazjuSYH1sEicH33CVrS3ZtWYLRxwCOx2+utB8jBep+7EuCS2cJbh3UVIL1Pix8UXoUrXWbcIiVu7SJxCXUgV+J+Q5bacVKlw82figuDjqjAqBE5VCWOtk5UcNMu4iQ7TS99GCnJkgy4GylC6E/oUj2zKXjqCx/GAmOchkOnZ5XmIiXXDNCMM/d4bYua6RRMOtUktXrGMj0Vo75CyZlswJd+wA4LdZSuK7TO/Tc94insq17sFFKLZdWgGHq8Y/81BmGFyAO93NuZo39rhP7/C96dLi5XMMiUwg5MEOrbIuiqkYvbHKiEi763RrhOQCaA6pljmpIWKbfU+VCQGKY244iv7jLzFhBkLvllKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b116b63-01f3-49a4-40a8-08dec5349ef3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:53.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7iXJ2AA0qnDislHSM8k5BpRWKxBW3OxFZwOcZINs4HMZwaP4m0IfuVx2gOtoO7WQFM8mlN9dhJSjilv2SFo5CcP8yjM5yj4ABRVfHqQkjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXzzIgzWZgLOsz
 1PJwQz/JF7hjsS1S/ANPRsOZRtifoc8o6bIAkTbvpitKJN4c9tp1fan1fYZhsScGK48t06Up7Cr
 RZAVEODhIUcUDueTrS3+wvr4rj0lnDzC1zK1lraOQkEM+JDX1Wr7OQhh+ILHpJVFjRlRLGFbJA5
 JuqAIaG++y0lT38iMsVh0SYxS01fOw+8DLhSuixjDLpZ0f7Gp0LoPIHRGOYsDXwQ86NDwGwJ/XH
 PYPADpVnix02ywPnslV2s6qCD2EIi8Eum/e48vXkt0VtznycLgMelkXCIT7plsnSjH426q09tD0
 r/UhquAOTWh1bXYA2LYG4Yw5gx2dMKK6P/px1mXE321tI7J2tNLQDFebcXxeYqmQisbwnSynIn3
 2GEn6h10B9xPa+OCu4Rf/JNG6GsDynlMimykHqet+XF14sGmTngFEBl9q2N++2qsEwijpS2lNdx
 Nw0YB8uYRyQCSSI+ggA==
X-Authority-Analysis: v=2.4 cv=IYK3n2qa c=1 sm=1 tr=0 ts=6a2677a9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: UxF9dRgKbMyPHdWV_NcGs3BrVbshsUvu
X-Proofpoint-ORIG-GUID: UxF9dRgKbMyPHdWV_NcGs3BrVbshsUvu

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:

Sashiko mentions that this introduces a bisection hole: this has been
discussed in prior versions and doing it this way seems the cleanest.

---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.31.1

