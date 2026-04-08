Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18172459DC;
	Wed,  8 Apr 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651545; cv=fail; b=CQYXaOF8YnlQyIZnZMma3xEcSSjUAOmquw9InH2xr4/tJOw0jW45WYWj377x7Pnes4sfWj8A5oj0jqoOaaBFW9/xIPXGvKsrf/0vZyUYVcYL7tIEC9EHFUFjZ3YPzSaw6PT+CM6xOJTgO3PcOOVw+0SUEIM/GwQUs6l9X6D0Kso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651545; c=relaxed/simple;
	bh=PFT5rG5/F+SHTERKtv0STIs3QyoahP6Kvg5/BO7yjhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6pZFkygX+fwWY45BelIlKajbZHR8KuRT6k6IhcrBH8Pg1OfK3mt1g4wY9vJv5p72xClor3vFByt0LKXjuuFki+RM3sCYqYiH4z3bN9hzhCQUO3jolvvb1b5haw0jdI/L//2QeYzgmfJ9W08NrRgX8IOaMNmv2uAozdjUPXqSpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xa2TTDQg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eKL8w46m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xa2TTDQg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eKL8w46m"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638BmaXA3238351;
	Wed, 8 Apr 2026 12:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=; b=
	Xa2TTDQgy4sZiI9FVCha8DzZMLc876MhVSjZOL8TI8AHuxvBAeGKBNxMIAmlA2Y5
	DTyn5zQWfLzra7uuLrywPeM8QTujqPY2i8J7EKOiY83MFjIfjlav7tXfUw3KRpU1
	hVZn+8GGS9oy4Dmk+JkpdxSP+cKzDdcVLytFjZXCKSueWuBelU+H3pHRZlP0Issw
	iGrJM6Z26uySIsBTP3/wcosgf37HNu/RpYokE5GA+ROFeuOzIw/7Z9RmvXXrjdlC
	mT2ZPM7Jqw5C4xDogihqeRHfcw4AdMmAlGAuIICNWpUaC6UnY99jXPNea8PTd17k
	RlYPaFx0lskDxVWmo8R7hg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqb3dj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638CQdgg011559;
	Wed, 8 Apr 2026 12:26:59 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrfk9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq1+mZcG/FzeYcPX+YTixPAr2ydL2/EhgAeYdVsSPSSbozwGVDAGeyJ2YcYnFb4Qxaq8TB0/jnKpWU6wsXSMZi0faJE/zYWOe2l6xv0dZgkLNZ7HuN4J/FpZ0+NBYlw5ktsyAsV/vUgC1QTFwM97zghVZccQbpX0HbUfC1D9HP4ZNWPestsOuIrAnLiOenYPYNBeYpOnMMCjuYU64IyfTKhGvWQ4NEDXcR56s1SH6RKnAW6unY0xUXAdAyqJyVd5sKn7DzEwOp1zaH0F7JuNK/beMNDcS7ntjflEfLJa9eNN8Jj4gKByJb8K+P8N94NgRHOVu+sMWd86E55qeRJNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=;
 b=w8QOmSguhHeSyYMPqneUiWoP1gmTQfXx68qCQWEi/Nmwgg8W7duGXlcGOVvkkO2OPINhvpatHOWwiRDtb2NZMpcpQXQTukPHGmr40k8f2K6X+6TgGwy/dVwWAgCj9JsmjhKIfxZbQHEWig2/bkQv51o046mtnA5lmfTzcbf7lYn+p+yg5OUZiYc28JH5qDV0RmjCpXpW6PvLF9clxx1GymVep8AF9dEYyTLiIN0D7xb7QAWijuzZbYw/UHM0rcssWVKLojU2GMri/BYDHCWV8Rs9krX20iajXHkrHY1/UMYjGYbEy4LHy/5lK6IMfouwtbj3+0+FZCJG5BfZVH7IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lg9Ao/NY7+O+dHBfbLTCASHr6xXDLmXSvijPaYixZc=;
 b=eKL8w46mUBN/f6HsbszmK57Jorcs6rRiJ1keUExDAygmvAO5c2Ov7OJI70wsoWiI9T5deqZAyDpOW0HZ1lLDyFvwvJrlSuC5xue09X1uaWdgKRWpC7qMXEq9WFOFrTOK1xrIqXm/eApCSaniue9zSV+8yR0wkuShaSDpVt6trTo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:26:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:49 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v11 11/14] sched: add need-resched timed wait interface
Date: Wed,  8 Apr 2026 17:55:35 +0530
Message-Id: <20260408122538.3610871-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fd8f18-4b70-4a96-582e-08de956a1b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yy4Fe7osbDFyjUl8iqOIMffmCoCoyeXpfFL/9RvhE01AxePh+RC5lWS1PSqp8LWiiIc7LPC0dAZCV1+sU/7DWxjGZ43urDRYD4Np7v51xAeRMRfs517VKRzuQypB7HOkKkPv95MTYqLiQ3MJxJj7czAmAfMJp0Xt/klAVoImrWAz970K10rvUQST8kMe9lHTfi6BiKNvurZSfTGQpSuFNtKM09+f0cJLvH/6eAXUxV+1OGpM89+dA98fFD7CJjygfo4kaDSiUGuakavDvp4mJqkCG/ct+5JQQKUyz2QmMzpRcPujY4S6w5/evXVtUskXb50hL6ckBkZ1GxRNg4eZED/PYLQIHhwhGLcP94+v08ShMxpwB1doXR121jUTEnnmc6YsGpJxtcgxkxSK11k4r5VZYWuzrWC5gaoh17icGX1dKN84DvrkQIikr6y0PG6ItwmcCwQz5UocVDDFwOtDf7SFgUxSsSbSt5ijn8qYMdUD1ofWgYh6Av+S5lMBN9vbMRtHuSEKlzXfBaKMVSWFZ1nk6z5WeNzCi5biEq9i/ZzqSyv9dl1q8cHNFyIIWz0FqIRqTMQUBoPLPdZcrnHaUu3/MEmZ8s3AnyVhz4CPm4ObOzysb5tJIJH29biXRJnp0LV3tfXYcxFjQisBSCfKSzMnmTUjP9ax5mt0ilD1cvRZOkQm3VkMFr4sGD4pB/sGw8v06qnkCBg8T/+WJNmcUR39WX/KaBN6qw+8VuvPEso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/JMhwyNhjh5Fnd7AxIhcmX6lSvE9h0Lzjm4RGDO+70tuVbt5EC2tlG3l1ehu?=
 =?us-ascii?Q?1//QWDXAJepC5QCZYV9xJMIGK6YfwB3oT296JrAuuE8ZdgSw6YzlTGzbXLYH?=
 =?us-ascii?Q?Fk7zeRnNWEHTi+4NqbNuzTp0R4XRL7Ri3F2kfE2qV4JQDRprhUf64/M5ZPXM?=
 =?us-ascii?Q?ayjtX0/5tSWRwUdcC4xynrIL3P0TXYnZ/x69SHd8R7pEbbfsZNeiyMrbTnv7?=
 =?us-ascii?Q?sGf4RGDak0EI7hzOahuUGgpMXcWJtI9qecLF/e0t4ltHI4WowizRvowjqEwW?=
 =?us-ascii?Q?7SR1SQY3HFirAAxToNgs3FsE8PxaTkXKROcBkUyYXIWjlMdZ+K6D14JrV3ew?=
 =?us-ascii?Q?7dr+c/2rIZh/9lPkM20BptrkCiioddgILnsRE1Nn/AsV+512tWkiucXz2087?=
 =?us-ascii?Q?YkrMe2x7tcfk7fmIRyhClrHK7vltj16FQj9HMjrg2aSLcltnsb6RY+cL43+T?=
 =?us-ascii?Q?I+MuxCz+8YS9Z2XXpTcRcgDBdZW7DMSWYpmZh4eUT4nINuQq/qEKVw1bA7/C?=
 =?us-ascii?Q?y6fXxYzP3PQusNCZrlQk4uZjJYPIPrhVqlV0m5EdVgsQDD6hUAlPPPXT+kqI?=
 =?us-ascii?Q?uoN8s8V0+cZ9wLWbDaQHiHypbPxc/XvkPP8lBV9Yqt05NS1tgkqESQbUF8oA?=
 =?us-ascii?Q?gUHtXDLPsDWoa299paPa4cHZCBJNo2MPeAWR4EsUCybU8wCmsViRi8hrpEiU?=
 =?us-ascii?Q?dRZsFaJJCFKot/v1DWzxGFmgKDDJdiNNr493UeigUsoWT6bOw6sTtqjjjg80?=
 =?us-ascii?Q?bQlIKJq643o8ejoGqTHVKSyo5Lil5juPFvSBLzOc1Xlly2ictQPk6/pgyBor?=
 =?us-ascii?Q?cppEXPBBJSjat35iBWWgX84VRj4yenOE0M2IQvusc1WHYqzPVOS5I7nd9iMm?=
 =?us-ascii?Q?iqO72CtneReqD6ujTegzobcjS1S+fh5uv0W76QLhYl51qEHZFpPtf8kDHGLE?=
 =?us-ascii?Q?EEsC7eqwgXiM9vlQCp9uT6fiO/GqTTRmjeclX4fKq2EHviBqfVi5qcNMYcnw?=
 =?us-ascii?Q?hiwHIDNDu8yjxCqddBwDnu4wa3AyM968wWp2vqPzO/MWJrQSbH8ORpTnczjy?=
 =?us-ascii?Q?GjbR1r5EVtXzq0KIQXYzN1QiyUg5oYcl/kVJZgI3ZjA9LZi5MT0vAPFGvewq?=
 =?us-ascii?Q?URZza75say4JpZfOv95I7p+/ujZZLJETQSjkE9pSyuYe6mEnUCp5PgMl/AGj?=
 =?us-ascii?Q?BO7H5eHkjuPJZBtvl8tv0y3V+8gdzJjeTM3unJiUmnSV4QiwkyAJ1A/DlJLF?=
 =?us-ascii?Q?rDrTWarSAXldFCjtnT9o2agvo8MwZba5MDzLUtsKcmPsALf3DwtIgfRz6VPX?=
 =?us-ascii?Q?273jW5LtdYNA8mG1Z3BNB9FxFwxs2a7AxhCUJus93/jl5IpgqJaTw0BCa1Ea?=
 =?us-ascii?Q?s0G6pHdDlIT8B84tJXLiN8Ey4M8BqiayRFxVHoeGunp0vocNMytokWaU6JLA?=
 =?us-ascii?Q?W9czn0JPbg8Z/Im/WSk24f/aNMoVAcbOzCZ95a6D9Gh7/3mgU4aVSUvYQpue?=
 =?us-ascii?Q?iTEwOQEJ5ideKFWbq0pkV+D7hg3PbacH7/M1FkdX85o9xk17o4+hnfZ/oVpv?=
 =?us-ascii?Q?SImowcE8wFlvi0D/Bb9HJQ+EiJ73UbRxT+ZwYh8OqJu+Z9UXI/m+Ul9Yw+Q7?=
 =?us-ascii?Q?iQ4bWY36XbWwnePtsuVpE1M4piNIB0g3+u7a0CHQLHSj//Dx9b9X1knmhmjy?=
 =?us-ascii?Q?4/mL4m8OgXTrk0NEUz1GDZMeoxGjBOEvXXuilSyQpLSVy/BdCRlNtiIOfJk+?=
 =?us-ascii?Q?gE3hDCuw3kFmUg1dH1aKSt4iT/3ClFoLkxfIx6Z4tj0fLTNTe0rVYvSPhVBc?=
X-MS-Exchange-AntiSpam-MessageData-1: MBVJfj5UcefK6Nl7ADtJi3tpcaxEHUkvCiI=
X-Exchange-RoutingPolicyChecked:
	KyDMv+mOhk+qNWADD1+LdVbBpBa1bPOiG/W4N569EMk7vr59ME0RnZsAMX4uDLJyTdKPcBan2koJsVUeTuOcf3v0WaR/SYfscKKxYFS1/DDNOQjItyqAS5NeAIYtzqoa2C9tMZUgiakGlmc1Pg/1yAd2jc8yqXjtjZpiO2On5mka1GxWdegCTSrnX5/gyEdmQVs7omNcMUKCBpFpFthQSCkIGePBN7b5DWAsNzWQuyGOKmtM9o0smBlj3cFVMp7dU/qfgql9lVY1dVvUnxNj63F53daO4ZexT9dSkb7jp6x5vh9wvL4T7Fxg0kZESrUtalBXIzB4vXHjzgM52bSw4w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0yl4lkhHRoLwJpXte84SAO/JIj9i0LtvPsBQbWNNWdiAiWECguj+1RoxxxuFEwnxyEbB4ksX5NSkhpr6KtNwfucloy7nN2NrI4eZO7Y5W+NJlc84ivdA3xRnxPxmdfjbyOkUEzdQpYmFb8Al9uiB5qoWyxm3Zq3RgCMquIUAlzvf2EPic7hhnJffeNdXB3htEwp4pHv9YTX4B1CmTXIfUJtJ2XjYVkSf7u+6HgCbDmYWl+gEcbcWQZyIuO8v8hGovzTyYfdmYXhSwPNeyfF/w3HFpWcf9Ux48bxXonCge/76q6wSJXt0d7I/ZM412u8rHWP7+Z5ZSkEET1rW0XhYlS5oAGjohrQqxk11fVDGX2bVP05V+7XFU8LkQYzg2ajKMvV0Y2QnZH29PUVA/yTXWy6n+6cGRynNS9hGS9PopsUHNDbb4XFeE0QjYU+FG+m5E6rzBF9t5n40RUw4PEncMJrOoWljsEw2cQ/WGvmiVoUxzJCV077iuCtU3XjEJPR1n6hlAwAgh3mCiWH4cwbC7CLWPVchOz5e9kxNNv1f9dWL4/oEplhWEbKliClU9u61K7tHpHa5kfhZccFSBrSqUIrrI+NN84jUY4jVwMKld6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fd8f18-4b70-4a96-582e-08de956a1b38
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:49.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIBPYRMtG2Y1HckRmhRDPc9nkWeojvBW+GazJ1agkdFp8t0j7hiiN38c3x4KiUzz4ebQxEJBCTtWjQJE9aILJ/JaDob+ouiKtY3kqWUil8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXyT/vJC64IonQ
 E+gXGamykbY0IJYEP4BqMXyuRplu0xGv9yq5QSZ94vZ5rN9vr9J9BeOQRP1VdlXhwJRi2o5wpV3
 DIIL5MEg2cu7U23AlU4cFEGaQ/pjvaYn7FhkCWywJoVrAY5DV+OJhtun+PP8hgx7I1h9FVxpUnR
 foxeYllRxJ4znGljn+cHaDPIdKTQCwW7wCHy9ToY2ofvGhuRxOUIolQqGjRtY2gXy97fv1slon/
 ocUlkj6bRy0/b+DtmfQKa4wRMLCp7rnbMXWaA4w8kJMVW1On/yH9/Qz6RHniCo+fcHzFzkz1QYB
 wR3WPwFH7p0fY8SfYuYz6XUxAYyrGRjJVyIWcjgbMeq87InW51mnDFGaXM+rN0y4yDx5UA5vElT
 ypbc78wGX4cidfVk1bmUzX87qTDGkkCDwbKVW882SZmVKfSFAIlR01y4G5g3zcLiaBkonfyx0dk
 b/UIFM4r4IDEcd4y+lQ==
X-Proofpoint-ORIG-GUID: VVAOajD0L-fo_AGxRKYsv2WKY4JCQcAR
X-Proofpoint-GUID: VVAOajD0L-fo_AGxRKYsv2WKY4JCQcAR
X-Authority-Analysis: v=2.4 cv=cK7QdFeN c=1 sm=1 tr=0 ts=69d64994 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.31.1

