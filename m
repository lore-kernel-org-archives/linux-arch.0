Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A40394792;
	Mon, 31 Aug 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207823; cv=fail; b=ZWpuY1T43PiUJKu8c0b/02+wff/0lxsoNmJiXFsbTxhuo9vGVxy79vjWn45RxQEjfEmha/FRtGe0BfENrVsOWmi2IQqAyoiMx+S6e5ya6KxexBcoS0qdo/RA7HQWa3hreJdSVzCn7MWvggtx1/nxM3DLhoSHIqTJeNS2SkkqgpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207823; c=relaxed/simple;
	bh=9uytM4lvs+GPVwY/ioej18Ma3K8UPZyxLlMhYwvuDLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCqEOvRmo/zfo4kI6V66M9i06pLWDfS29M7QJVBUSkA/9AAuxQrgDOn0SIJwl7vXILPjF2nwV+D4ijYoeAiSjHs111+WvQ96ACOc3cYKaF2Bfzuf3NgW4gcAV8kvYGbJO9DXwJHjhqj1AR+dI6dpi0keC61Go3a0AK/j+7VFY7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dtwEIX7z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E9nIZfbg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dtwEIX7z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E9nIZfbg"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGCIIA2333545;
	Mon, 31 Aug 2026 20:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0lUX+sGvlpo8kl/Ks3tfNpwTCxvrr85sv/38wHY9cf8=; b=
	dtwEIX7zhWcT40YJWdd1U4mtku4zwvVUbkisW6rylHisOO/6gRhY5AbqK++lguOf
	YCLIuzGqHJt2t+a3PkTC7IE4b9eNcwXiWgt6ngDLq2oENtlrfp82Kxi6UyaOIHeM
	PBOmfr1QKA/y+FrmXDskRMKAwK2KqBVX7iWzdppf1YnqqKKsmmtQpMuMB8X8obrt
	dsIOlLw3MUfHHOVYmjd2iXY/+OWQu1LH5aTJBru5ZSKvMTG0o10jJbxImRuYNaue
	o9lCCqIfKMy7pLXwbh5RPPEkcKmBve4prZTRMTYJHcoY9WjOhHglKNzOoR2fTyS3
	orEJh+RUC8M2R2VMKQMlvg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaudy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKFXd6003016;
	Mon, 31 Aug 2026 20:23:06 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvpkd8j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW97XK+J4BLZIkdxLHGp39kK7XOcCj+4rYxUUIc+t6dTFBIO0USiqgYKChIN+/W8pDQjt1hc4dM+5PLumBv4edgv9Qkd+H6FjQyVbS4E3RQeZcJ7glE+uL7qXHs736X0mMdlYtGtsaVPGUBUhcR1myc8X4WOuf8LewC5Tldwtvn5zBZdixkfbdIWhC8WhNh1ALIZlqwQfwOkO+fMukjOIWN+il0414CeMeZPrqGrhV/yIGuhwACaU2SoFhQVHzmgPmbym2Gw0Zk6kqL8A4LllxEsFpIfSaIDVjmeRWwXlXDaF91FLrMIeGOmOqV/EsAm1tI/XbFW0BBvnlRABLmVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lUX+sGvlpo8kl/Ks3tfNpwTCxvrr85sv/38wHY9cf8=;
 b=BQzjzQJ6W/JD1ylODK6Umd/+HoguIuxP0Ftdmv1bE9IIB/cBvZLofPoy3pGONdlQ9o1ACKYuiIFfIaHXOdSwwqWpleuSQjuXxXNBBLadqIhF9oCYQ8rOgvacJ8A9zTxZgvcWejBoe5zafG5Db+oThB0BJe6A+cAjucMQCNMWyE+TI4JSrVsGFY9m/WfBvYpD8UlkM+Pjce3ZOctsOi0Ym78mrA1aFA8XbWbekpfivQ0MjTB2jLKeq+LwLCv3jrdWvvpejAth69X++iKHQB5MF0wlU/X/F1nFtAYFoLJ3aEk7JOyNIWbdw1jbzS9IneWGRPLcqrTBWVS2NG32KfQLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lUX+sGvlpo8kl/Ks3tfNpwTCxvrr85sv/38wHY9cf8=;
 b=E9nIZfbg4Ex1cFgkc1zlnbGw3mI1Jbynzmzeweb0PiHLg7j7Y3ovFeIfLIXjJ4T/2h3fQhyPU3TfbB9qDr9XCSAEea0XAeUHA07odvZNg7wycB5QaWT/Nkvzm+fNJWu9yWecdbzVa8l0voyA/E0l86I6Vx4JRWZEbECUzArzW0o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:01 +0000
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
Subject: [PATCH v15 04/16] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Mon, 31 Aug 2026 13:22:39 -0700
Message-Id: <20260831202251.305046-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 4243d131-7962-4648-ec4b-08df079da7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ChuYnYWcKSD55gYkcoANavTCztkRvNAb52UUwS+cgwJjQjWA6I2GWftPaQS6nodPTsecL7NCEJj4WrctnvvEVrh/q7NCt8aQsFKKFuBOXBoqnP8N3U8ie7OIMQa6+XBZLywsfVd5cp/SXkpPkwaXpHE90RRviquhlA65mmpGJDwwWNtvYdY/K7e4VQBdmMzlLA4bIGr1UkMkyt8sukNCupctqsH6616RZFE3Xm43idJrSo4B5OqjbNVoeSr2N+EPETp5M/c3H9XpSY8xWpFdAJL/Ffl5OO9qG/heQ8xs1HiNkoiv6zEXdc41ASoqkITOg4MKH1c/3hyuqSKwA8OKB4spFI672mpZ5D0T4VeuGY/KYUeRrm0fVpIZAhKqsFUY4740Mc0HuPz8IiTc9HN2p+qktIC9O7JxsMGEiKmE1D4NfEV+gJfyT0UY0LACRumVSMHHtnXZImuVYB3M2YvItpPq5TiNRcym2rV/MR6Brx4E5/d+peBpQvoiQfO2bLsfkrCfoxp1+B6Z0sE4T4vCfR9Ap3lavHqwB3KAZJgPBaRkQowjGaH2ElQVpR7c++vF/fAhHkxrU4vpBZ7u2ujclimL5bCF9pxyjHyHABcQ7ec55MIcA9tV9Dx/dlHqTivGR6+lGU4LdTKBD7b2n/L1NTeO+48rqiJ27TwJ2XLai0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tR0d6JeRLa6MgfbIp04ctoBmrDFUnYGLcy9UakTK2fkAHWHAkaO+RhRhqWD5?=
 =?us-ascii?Q?dbGm3BoJi7JOVLaDR8cyuPlHsYGdX/K1Wix5oS0Gc0ZumbXIi0em01571G0O?=
 =?us-ascii?Q?wN6Ul9RQXwQMaGuF6Tje8ahi/yiksqRkvzWqVPR2/2Pl6iNLlv3WLWSzmPnE?=
 =?us-ascii?Q?LvOa3i45AXyVSEhAiZ0Arw1zUL0F8+g9+OGdytev6daQrfrP5W2AuEQd4UUm?=
 =?us-ascii?Q?qkwhU6GyXxzKwploUARsZ+9jAbbYA3NU42g4mhMsnUer1fI/JLYz654jrHY5?=
 =?us-ascii?Q?3ufTguV9YlRqLc16exHcRRNRqVMPWRvZjpgBzZG3e8ERhZV7nOsS8f/bTvaV?=
 =?us-ascii?Q?bf2WpLXTsR5CTfC+ii/deC1tbCLM4tY2OaRrTyJmj2YYeF0Zwxt6uqzqLU9N?=
 =?us-ascii?Q?9Jnl8ET70WcSa7Ww/PdGAlct3hvEnlDgKErfDYiUBCGKoUYV46XmyquQ/qCu?=
 =?us-ascii?Q?F9qKXy58f6Ys+1UJuGLvJYGroMj/fyHFONQdDO4C4qQv3zxUQdNklKe1Kgxj?=
 =?us-ascii?Q?4q+zp7+Y99zm4sXrLXkusgy3FZJA9gW1yCUIXp6HWnZgEOlXlfHYATwHlvUZ?=
 =?us-ascii?Q?qagJWpM+lHkpAdp5W5mXCndyIqlvs7H9bi0sTgSOHP+67Gw0CEtz6O2NOoCx?=
 =?us-ascii?Q?6BD8oQeCUKRbO+UYRqVI8qlX14JA3qn3aIkn7YxZXKIGztdgeLGPQ+FbaKhw?=
 =?us-ascii?Q?VOyLi4EyMXMsCgTqnaZJ0rnG4V0ei23+HHlorqr0vu+wM2YMTrvc30s1jKtk?=
 =?us-ascii?Q?Wk9nlk9kRXdZc68hocw1YwLBXzeEpJwc6sT7TNxh4uAod3Kou9uFV7YbUvq4?=
 =?us-ascii?Q?6y6Xk/j0AC40IM0VXJ0WHe/+hwZ9KlyQKXwjkfYjWmD1OJCqK1FfNMKq2DqG?=
 =?us-ascii?Q?KteOhDk6VQUMQ8hwVHNDZd8wt786+1MnWWzC7IuCsNmxYvOF6982HdDYZH4U?=
 =?us-ascii?Q?a4dQRAEIXatrxquHlMvfNCKgCgW75+u0ayxtg4QUfBhLFFXJ6yWNp5nL2gF0?=
 =?us-ascii?Q?dEauSKrgwlA+/Kmwb7LIqF0nivUYYWcaHDHrtiIfCASESn3StrTHi5dSHskh?=
 =?us-ascii?Q?cC04YeLQJ9mT73q1eCzCUrHxWk1vt2RG3PTpqARY0qNFLLeqQKJdTwqjo40p?=
 =?us-ascii?Q?mZVrFngXBmRA8FsjlPCEqyxv8imxikbQF0Uz0Tq2TpJFFzR+oz+1ySToD3f0?=
 =?us-ascii?Q?wfTcPVKs4e6VG5SfTMh2lYuf+Wv70DJ3USAImEMC8USBuKEcs44VEOqOQlFj?=
 =?us-ascii?Q?Tbp2cfevLd8LzGs8syX3+H/vpSEt7aS1IZkcniop4LH3WIClGNXcZuxzUvXj?=
 =?us-ascii?Q?4+tYOcQBlvO3dFAWuIEww3e9dICYybMQVUts/qJYPw1RneavhgOtJOAdyvVM?=
 =?us-ascii?Q?+FLYbflAasAL4ipXN5CRdtWoJjjFfW6Lw+36cC7b1kGdIhQ9Q2VZ7GH6bdaK?=
 =?us-ascii?Q?2NPtt7A3e7BKIZt9+iH0FnO+o9XFX15ml+eytk4ifWwHECct2l/XO5A3yZ2U?=
 =?us-ascii?Q?hqimikbu+xRE8uvpP/tFLGQkjn0AtDbNBwx75HyMe+Ko7ugOujZsNcWByBHB?=
 =?us-ascii?Q?DmHE54zE1JeQY2zZX6ctpl7VKOh7p1uaIu1J4NWyphIRsGAAWnV4FDuEBUAR?=
 =?us-ascii?Q?j4J1oFN+z5/KtXUULQSvwm+IKRPwJ9SBrYT4ZI14oriXYvDKyjgfPx+KILWf?=
 =?us-ascii?Q?ilbNu8j6XDS2XeJ+QB2c/cJDwQPNIubW/gWHrBQE/FBhjqoXc6xD7LRX6xex?=
 =?us-ascii?Q?7M7KQLZ5Z9iCVBgekK2HN3/tWHNjkaU=3D?=
X-Exchange-RoutingPolicyChecked:
	Qd+Nyiw/YDz7b8tYFoepZrh0cfCW0HolJcR+hz3WnmDS3sV30DQj/D83MRCEkqK7juQB9fe9Kr2SO6ANMSl4LZeMP5z3hNHc6QFxaVlNfqQCze9ytNwza3X8yIFtD49JHl67ZaQc75MQOkJ4ZQchBGhqrHwM6HhbdRPKq+6xoBfkpZipNVpPHI4acvnXw3waPAW8um7kZY723HQCi6lJjXl2qCtyUPOpvV2st5iaa6jcAW9wZwD3ZzcVeji1JVPr5ExYE/3GHEmGRJYzX9nfUGAVP48KvTBOFQJ6THNGj8Vk6yBYh5d7Hpq+EnfH2BLvaXI9BEn4HlBqula7s69/bg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JZFgFf+9gDixOaLIzYFcrmpzfSKkoPGwj7OMJNL3Gv0QVQWGYDR5PgVmAvX71ShpZiQjbqd2LbgOSgkX8va0BP4rUrxHx6JfdkaQEKBjMDKn0GW+8HKAnqdIybgzoL4y7GUSq/KkEvpYKa0IFntt42xv6dN2nIj/rLeLvEpkhbjog4nTlaTjsLYmrfZ69LAvuo6/btGCAitl35e9Z3OHvuOXiHbptd/KDwOujrgsDbrFs5T9UPJacs8d5FA1iKzy9XfpfODhdYwAqg3eyU/ZaiJIRPDqJ/csKRWQrBU4HUuhqDwyuPLxnqPYBDOHciZWonsgu0pqx78kaLPDx25jYsQcjRkj8kM041TGro1bnob59UJZcPw9byfs7LliI0TkFqdL80rkUx/QElHZDXKnKpgc7h0OtdcJJ/GxPDf84KYz4H/RXyptJTHGywtA2mv9Zn+wz20HNiycK2b0Y30TIfc0GS23eflHcVRDNbqwc7AEtmoj0o19GRYIKwEKwQJ094shQFGCW4Q0VYWuOXVsBxRSiN+N1JDwcPKGvzEtKiwOa5fDf8R/wjm1ReHi4bFcmEbmTIDw5nqOINEB3qSILan41DoiStj7AqhdGcUcu+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4243d131-7962-4648-ec4b-08df079da7c0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:01.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sysgFVdnJarSac8Nkn8vnoDTtriVYwPGtXifMDfwt3spXBIhUv/0VuHk1jY3WaWyIVzcNbR+N2RmN34soCUb9TefRZVSkmvjLujEm6QtYi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608310175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX7ssxtJCAh55x
 0648pDVLucmP3XRMZtm5AujkxdWpXaWhSbMIfUwJ+OA1tEs39frPKqm6+oUnotKqePFGXdupLPP
 j2naumUSwEF6jw/xHSxNirx8hq9zttYgUWRthwnNovG5a7y3qHA8
X-Proofpoint-ORIG-GUID: C8tWb10wWkqkCp90MmK8VjMOBhdgvV8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX/fjG+u2Z4g+A
 uKHII6gf5LdYj/0WWxJhAvwrj/7TV+6erlHvMdUHgd7VJZGaO4VYQTynDqH28olPWnw/M4XoNzX
 JtfY1mnwle0rs0ztvgPv+Qf8V0687R1TFI5Q6OLCdlzQDrJ8lIbKZjjlcMRPqkhZ2wmQ0ZyRaNd
 h6vtw1LqFroXyMXevpn0mbaOGiCYjTqizcBYViiqcWvQahfURTpbXMnMugMzT0y9dMvGjHAPGTr
 uYNKpRzs4ISMazm7A2lJSBRvnBD+9n41QNh4N1InOgMhavCUPlxBW3Cd3PygnNQzddkJ0Wg6Y9+
 7Ffd80B/0n7W+iBAkDHwmtilpxiVfdu8ZY8gMgZ7RvqDJwTk6ECsHNXvTafNoS+whDgheNGNBXD
 TFqO9lNIZo6I4ySJMRlZV64ZVwtmwsO4d1zoRaIcEuGXtpG/7kAXWGpbWf3WsyuwlUXlmmyFZHP
 tRHYztiE/V/zDEX5POl8j96ts4v97WLESm3lpdLA=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a95e2ab b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=Or_-VBqfnECsjC7ky4sA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12102
X-Proofpoint-GUID: C8tWb10wWkqkCp90MmK8VjMOBhdgvV8K

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
 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index d186a4558776..d1f4f571adaa 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for @ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * State this by defining CPU_POLL_RELAX_WAITS which enables a time-check
  * optimization in smp_cond_load_{relaxed,acquire}_timeout().
@@ -233,7 +233,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define CPU_POLL_RELAX_WAITS
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..7985ae5ceb0f 100644
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
+			nsecs_to_cycles(timeout_ns);			\
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

