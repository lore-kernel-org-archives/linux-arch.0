Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B043328FC;
	Wed, 25 Mar 2026 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418277; cv=fail; b=ijJc1VUq8UyKo0Epy1TzAgNw6nwPtp4p2C8+QXzCfkz5sNZ6lKk9W9chyiRc+akTZ8fXJ8Ouxuq3FA7KFMnbc1rQbv6Al7n8VsaLGpDlhj6owS7dnZguGapGMO4Aj91fq1IQj0bqRjv5jF/vJ3H+9WXnodjYp+87Vzly4ia4WmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418277; c=relaxed/simple;
	bh=4S65MvPb1AOzLhmNL2WwblkyIUluenzx3i1BDVWnBus=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=IEJ33Fnh4k+EO4Lq0nVRsyd3ix3+lN9giOD5xreUpgOTL9wEXnLNY2QGX+M0IlTQRE/EcYdP/H3msN2QXYc3gFv/FM2VlPaDCKwbIrZ5wDuQ3wpb6tE/+JOW+A9OFsYGrxs115+lCR8VSMg9FUT7uLYSLqQ0qWzyfLx+WVxKGlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OIA/OVc/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L7k5gQmo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OIA/OVc/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L7k5gQmo"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OMBugM2196140;
	Wed, 25 Mar 2026 05:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4S65MvPb1AOzLhmNL2
	WwblkyIUluenzx3i1BDVWnBus=; b=OIA/OVc/yX9FIg06j3aQnr6E54/kSkuAML
	+Yrlrac4pX/79yjv11bv7W1cE6jgMXhTJ1eb2oYf3mZJTkg71RXibl/9B8u87leK
	Z5d01RsQaZE3rCuKPQEPzrncuJNn6wTWMjeBkwSvbzJPS7sHIUUKYcspTh/LDeBv
	8fsukh2yUty+FnfvR4Mtcf32tBlY3QaiOPh2HOiR1lyG0kzsBCZoDO0yB469CU7J
	Rx9Ps65gtVrhG14SRrsEKbyBPUQCo8juI8dx0+DcvSP6kOSlcaFVWntdxvKQZnvx
	OPm1tT7/Ytjpyc/LY8kJH/cMX+r7FKzIYChsixw0y8q5oOE7wyFg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfnpee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 05:57:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62P50KoV012334;
	Wed, 25 Mar 2026 05:57:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsh0gdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 05:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elykEvZWicqlbYRIAUCKjjlL6rvP10J2dy7OMVLnEHjJZebGRxBNgJAXs4srEDax77JEdDK/qBrHVrtuYyGMV1KvYt0pRDI34VXotKpkCfVaEOuzpUNTG86+FkKSAO2aklwVmJ81IauDtJ22revf0Z/xNnVY+LdXbUDOLS2y5Xyud26rPZ52w4RMRjEwAPNux28amTGYgYv7gQJT7Td+yRDAseXkSFPVCc+v+DQOtwECcKE3G2EHoyCvLebBlC725vxOzOy/sCl4/SjNMtedUhy163iV0yF2QlfgTUQ5f2LE2iDh2jc+ZIgnApu4bnIqXyij61RdReRSqc6OiSNKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S65MvPb1AOzLhmNL2WwblkyIUluenzx3i1BDVWnBus=;
 b=pKoxikELCzReQDFffh4jBDm32/OQd+nCZe0A1dYbPK4mDiF4ML9Sqkv109Cbj7y5xJ7NqN/ygCs3PDJUI1es8apMfOxcZLIjaSUqE8qZwUVjsSbppjgsgi3m5U4w5L6cwndjkI3xJH5SQAl5A/9ktLxdRe3JN1h5n9B989mI/oKiaTahM4One6sOXPLUbCpgH7wnvH5COJN9acSI/Km2ttiZJjr6UFkEtaWsRFqJhB0/STA3gS4TPBPEQdpksGaMx7VkrpxHqDygbiLKf85jZZ0hbdcpNMrKDs2fmC7YsZaot3vNH+R7yipMgtWUBxfqExir/hCiqAF6m86JVz9Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S65MvPb1AOzLhmNL2WwblkyIUluenzx3i1BDVWnBus=;
 b=L7k5gQmosl478s0zRFZwwyvIJky26MvYuttK+t5aGSXqnAZoId3izpp6YW2XWHn3eiEsVRKm/vEDWoElivVggVDvADgDXwrJ/VQgetf+FZs5A2+JaW6BYrKTaAgc+uIcXiKrkbu0FsalsWDrOUlJKZf3PEUz1wGu9SuS0sFzaxY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7184.namprd10.prod.outlook.com (2603:10b6:208:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Wed, 25 Mar
 2026 05:57:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9723.022; Wed, 25 Mar 2026
 05:57:08 +0000
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260316013651.3225328-10-ankur.a.arora@oracle.com>
 <CAP01T76iJAtfovOAhm+9-QwtbVJRbiQgUPWLBZZXYFozLFK=uw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v10 09/12] bpf/rqspinlock: switch check_timeout() to a
 clock interface
In-reply-to: <CAP01T76iJAtfovOAhm+9-QwtbVJRbiQgUPWLBZZXYFozLFK=uw@mail.gmail.com>
Date: Tue, 24 Mar 2026 22:57:07 -0700
Message-ID: <871ph8sb7w.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 15734325-8fcc-41ff-8a46-08de8a33599b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HXA9CoIeWCqKe5a0FHoSei7+SEs0BTLQXIbTQzyLCM5yQTUlMaOYpBvThiBGJJrh798lNOpEzQOx9M5iGxUxbExKdbZOENtACnI9P08uvmwI7msGJ45dpYWTwLMSnhYpZCu6Vk/sTeDoXwzT1NllRIwwBUTkXYHx05feLtIyOhU3NKtU4CoFxSEeOk9kHpLnJUsChIeIK4+DND41fbjrwLz3V+aDpXjvR5MWWz7Mbf/TAAZePVLUPzE/TvU/Jj4PxZXEoiigC03p+BFXp4AxyHvgJWQNylB4EVbdJWuCdsEoPKjkL/jsA/UNWQWhgG4WInKSfTaiTRgXW/Ha0nFKEnycE8OoOQ4W5gd9ld+eLk3S2iTWlMyny/5BY72fsu+wX+uwDYSCKeenDz5oUTw27d41C0ASmTwH0HOkaSSqrlZNme0scgsd9zlNBrwEo6sSBL90n2bnnn2/XpZPkeR7nSvjvUKcHIDGhUdoCCGEMZT6OwG6ufLG2d1cIlb8182DO0yToD8sKkwdCeYTp1LoT8nISgEdP69/RL4xC+nWeUrNr2JTM+2pCOApS7Y40VGEUdv7FCVWYXr5beanS0CTUryQ5xs8mq5Dfq6ECm2TJcLfop9Gvb7ywQVVXWBYhq8qIsXy4ppgF7SWSwaoKu1hLAdfm5e95fwfDpOKZuaffXCzcNKjrK9sYi4EekX87eEmyZcYvtAOmMRfSXA/YEU0Qjy1WJhH9ukcUnuSMAvHDqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xa3F10wdN6eefQHN36jf9BG0DSxQjKHTyE7Lr+bQdkUiQjHkG92iWQzK1Qws?=
 =?us-ascii?Q?NQ+zuji0hagh0PFSvJh2n7Qk0sAYL9qkH7OlCDJyQbZ69f4vd77U7bFDLfdF?=
 =?us-ascii?Q?DrnUJAAON8SMlgt22RJ10uOYBpDX97YipiXVuy7fHc+HuMPPOwhKiDKIzgW3?=
 =?us-ascii?Q?DEw4fyYMz/qOtjVk67o0Kh9Z3dDMGFKwUC+JIHYqOxEeRsG57rWdd7vJMNWN?=
 =?us-ascii?Q?NVFdrrcv3X9OIZqoJSRIHMqVtfvVhklzLo8JEtXDNLXcXEikeU6eSld+NLFI?=
 =?us-ascii?Q?WZOMvE9vR8W8h6+J/QbRvxPe9ExQs/eojHbSWlVbhRtkvg7vbIrrCaYzjI7J?=
 =?us-ascii?Q?C6B07/+2ZD5V++OpwqM5/pXaI9ksKdBbLDfV4Hgiykwpvke42A1Y58gcmkov?=
 =?us-ascii?Q?xTpX3hPyOKry2uwCwWNjGfIhWmTklxAacr+lX+DZXUAJg17x+GfgftWEN+Mw?=
 =?us-ascii?Q?Ubrc9DCO4okvW1u4slxKioxe6Ew0LL7sZmcvCXc2uTTB7oUnnuYIf7riQQOI?=
 =?us-ascii?Q?mLsd6RsWhgEcQGfqbzbxthgRfQU+3KrMYyGpa6NU5rnANXioMEGFeDGuYhWz?=
 =?us-ascii?Q?8NdKUxQ9wiXMDur9JzeCoiE1hjAWmHIba6l5Xq8LQZJ+mqUGmxU67Lc/tA+r?=
 =?us-ascii?Q?dO9FmNoELf6SjbX8rCgm9nKEKhGb3sK4CXmalgL+Pe7iFLCYfRi/KqVV4iW0?=
 =?us-ascii?Q?lH2vJ5SvOexXjEskQva+ci/b1ZbByU+PW9XcIJIlnXm865/CHKjLDcurSi5M?=
 =?us-ascii?Q?DpQ2biCDvEJF5IKQKHzRnBE1Uo4HazR5nF3tNnch1rt4t44wWqWdoAh9OmjS?=
 =?us-ascii?Q?LEG/ch7ymiujYD1oLUP0qBzmRSIf/xyJfnYjayr3C4mZrHO4DmDMANdtQpJd?=
 =?us-ascii?Q?Tz+Ws5XkkGjGR59OIbT9fkXcJ2A6xXgoak2yloKbXRWr2RUAfUwtD4aLVQu/?=
 =?us-ascii?Q?MNCKCfJj+ZWoU6R9X6Xz8kF5KPFHQd1uJL+39F39eL+QzWOyt6BLmXyM3B+j?=
 =?us-ascii?Q?W3VeaTr1lRYVr7HWaK/zNAWpLknYyPNPpXVi7LiZxXymTsybOYB9PCSRm3RY?=
 =?us-ascii?Q?u49BHOFU9UsNTwHcuU7Jda0Pt2SZZWocfORBPI6a0bEiiwFIERjl9Ne5psZf?=
 =?us-ascii?Q?qtFMOY6OGF2PSaOQ2xTVOeIX7Gh2gzDI/tOl+uIR1V45vgsn7bojH2VVhTP2?=
 =?us-ascii?Q?6mG88WAuV/p9JRUSVw1/cmRyuuWXcJ74jmqiOZST6RdSXXL+8CPxoE2YFyYj?=
 =?us-ascii?Q?QftvYxBMZzVHO4tjgT5JZINxWiJHkMrFOUMj6VEkFLMdLXjgXmLKscXdblTF?=
 =?us-ascii?Q?OaSLrY5eyYvZGyomU/karhn0FwnSO7xFWmog1fCnIOXaX/V1KdbhuovFQBwQ?=
 =?us-ascii?Q?yExmaJGT3PTpQPGy8kah54SpQVwglnv+YJFVhYwt5f+YIVLifuaPcdP0SGUb?=
 =?us-ascii?Q?3TH+BM+Zz4+s4+d3Vrcyspw7e8mIgnY6MM0U53empnDeYMTPhB6xpuPSkmdh?=
 =?us-ascii?Q?X8xDQpWzrR7sdWxVkJ5NOd2djyQxJtdD7NtvWuKv1eZHYZ4VtUhmMv9Zu9Ci?=
 =?us-ascii?Q?/mOeriyvW/uqqBTjp3X8k17mD4QI6FY/ED/1vUEh5dD43J7oFv6+BpOeiJfr?=
 =?us-ascii?Q?l3PJT0+hAIqzZZJ9rCZiL6BfRn8B7rWqfF1yWSC75bUC6zXI6Zq7T8CCSOwv?=
 =?us-ascii?Q?wQ6gQuCNspHD5/JdQTkU1iopkcTEWuVynW4Ml5SUUzsdE/vb3oOE3Vd+kJRC?=
 =?us-ascii?Q?wvTqleDUTrFb2ekCv4WIXBB7/hxICZw=3D?=
X-Exchange-RoutingPolicyChecked:
	TBLmCYnHE/+jwe8DrW0yGlcXII4dLCYlfkkTr3rDOOVFVYVe0LduddDiAzNmGV8V1KDBxUNTU+yX6Z7zHf0fu1qGFFeinO792Kt0gPvBk0Vh06BgynBdjhUuxNTetFPEu9/j6xXZmomwQdniUQOmuibuvDU0aGSXXfUF8qd2Q8bzXaBGHiBcmhSfgmuf+v6pqMYaB5hoqTyVWyv04/5qNRxdpXqz2I4y1F2BUmit50hFrzZziMQAMy+pCgFYIE14ywuoK2VOYhxMgsSYb+9iPUT3dK5SD8flQqVQtdQr5wxceXGipVgxRALElFvRbDpHp4rVkuoaeCu+juUd6vrcRQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ADuSVk8W3KErHJIRSFmY19jyAQ3nS1cJYzA1fLBUfzu9r++fwUSba184qYc4JulGS+cNVevhQeZWeptsfU8GO2uAd0NWWUbKjC8dfX4+XsA+t5N+YxrEMg2jVRfRsxPEuiR+X2cmqWzzzga80StUNT9BBTubu7YbTt5Nx5oSJ8GRzO/YlMTVj2GxGUbWi+O0lGunCcXNp5VIATeB/Naa1TzH2inpksRZ8yWF0p4snrIrDrOdprxTa/Q1GnHJdGjkkmzoRvjldhkGMTq0MT2hFIwlbTqSfV9akWM4PT4WfXZvyCtb/VL98oBZaILg5OUgESoOYns+le2QIWBQu/ezFxGJtrVVIda9Qx8iMeZDNXSYT4PsPkeB9csD6BTfqq+RP82kwVyQSMjirBd3B/DXNSaExfEmilLDp++ZWthQwonsIsNvj6zxfrpBksbQcsk/dVnjLkwyXxckW0vbEMt+xI66/vkN6vTvdQ3gxtEJSQghteRW6QTJqdC0xTsRyVbaOMNC0M4KzzJrU7A4KJM2qo514Isb261MDxVv9h095Of6JnJq8jGS2BiyzGOpwbLYBDwzIcdOOeFiKB/JEpmFNTaxYcQpQqow9FeqTxCplM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15734325-8fcc-41ff-8a46-08de8a33599b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:57:08.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMiP6njscqCELW8pA6c127JRygsxq2LlwxvVBqtqkM6exaRer3gwJ2x67SVaRWTGFHOg/Qeym4DRRSvCFfk7hJ/KPeurqAx17zYt+jUNAUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzOSBTYWx0ZWRfX2Ll3yEq8EO6d
 udo+OL615zo2cNEsic+lcfjDcdS5tfkKWeZPvb7jojKOxdl7BsC30CRNy3uQY3yEvkxsMbdK+yd
 bomLMx6EslZ0uJMfz62+vt5oDsTi9uuqdRW5ltbHgVFCqLHmPFsJUZt5uLQLddz2ZNeVpqmQxqV
 Rbu9uY86b9WzXky85MaDZD1p0PGZsmvLspj4xR8ppeFnv4/8tVgjROGzaLWR5im07ubx/OwLVO9
 oZmbpqB1Lpgz3uNzQFs0144EQ0IDPMz58PhBAv6QDyepONOAzzn8yP6RSoCNRbLt8FwRxLSIkKA
 o4hcBSkClFWlMY5LGyxygTeuXyPlcjyhD1kDwW/RMe5K/Yzy3AKSZeCYQQFjJZUZ+K93QfEnsrO
 Bgo5lW62Grl0zt1Yp2JpDy94Dsb+wt/Q9zbrs1/CgcmTx6qJR9PO6gSqVMX8h4xxyyJ6VXs5Pja
 2bIfcoI8g5Bi5zmhd12IpM6Cly9T0TpMEeUOJEwo=
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c3793a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=YJSbm7Nwya5guDgmsisA:9 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: ZvsbRTHu6AE4vNxVDJBoJB4GFQy0DHSU
X-Proofpoint-GUID: ZvsbRTHu6AE4vNxVDJBoJB4GFQy0DHSU


Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> check_timeout() gets the current time value and depending on how
>> much time has passed, checks for deadlock or times out, returning 0
>> or -errno on deadlock or timeout.
>>
>> Switch this out to a clock style interface, where it functions as a
>> clock in the "lock-domain", returning the current time until a
>> deadlock or timeout occurs. Once a deadlock or timeout has occurred,
>> it stops functioning as a clock and returns error.
>>
>> Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
>> when updating the explicit return status.
>>
>> Cc: bpf@vger.kernel.org
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> --
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks Kumar.

--
ankur
