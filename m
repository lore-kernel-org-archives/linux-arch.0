Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713993C1961;
	Wed,  8 Apr 2026 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651215; cv=fail; b=NzNKC/7KEp7+uQGokRBPC56/xidDNpbJWrPp5QGYFfRp2vhRlmGrwIfx+H06xyoKMzohDtlsOAEsi9vM8KnRnsiV0P9dCym+3BoJChmK11nbFUbySYzKndlzlDcwUS8LJi+xmPqusl/lcXbbUWmSIwq0Rlf2mwTCjvUZiL6SUB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651215; c=relaxed/simple;
	bh=nmizAUs5daPDt2KrDdPJHWUrUTZracySsdJz98tizXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umNZJ8ZrEa4PneTenMH+kYju5jkfCgv7ppr+eCJPh9w8jFjQZ8C76pRMoFVgvpdtdNRcKc+OeyKyr0u3p8eaUA45DYDeexIzh29CBCLvGsYpsga54m0Im9jDm14rfkscbhC73d5jHJ7LOenIveD3eB+m1aRz07OCPUGc7sQOyoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D4gC9oVM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OmQidzjv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D4gC9oVM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OmQidzjv"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6384lard2039629;
	Wed, 8 Apr 2026 12:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GdKaqhmMrS9Jm6R7XDPp/ZKZYy7r7QWuYV3kuvVtybw=; b=
	D4gC9oVMYttnXtXNQCB1i65hJLm7SDZurdF24/hJ/4Mm9Unu0shQSdNoDuV3tka5
	UjQGu5qPBfo4OlOJcNjulio+nDTpfvash8gqI/g3TM0QAw/X47whVFd0IVj4XwMi
	zy1wlEgE7PVSb9/5+z+4Ft1DQfIlBd7BHus2fSRPpHRxPBHx7tAzfK9sXk229wCS
	wDB4fq932tXL/s+tcpkE8UY1Hz0rR+BeDeHsyAfnUovWo0kk+J8/KWbUHSTTAmCf
	5swxPfpW9WJopdjy+CeM2Xfvlum72HqrbAIDy6LZG+tk6Zzn6Bq44AuLfAzp3b6p
	MOwO+kHVoYo3WI6ocXAD8A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa3fn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638ALllm005303;
	Wed, 8 Apr 2026 12:26:18 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ddgxqd7w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeUde0l7fCjQcDQaF7LOcqaeJd0M/KMPtasj3/QIuLzY172sbophck3FY8+f4+AuGLYcSPtvASljkIQyfJN7ONt1k88SNFzeY/aXRdzxPjlPNF/6pGCtrPbBABT/fqCYLxCK7SfS0GzQjOFgqV809HHh/nBuqRiaU3qkr9a/WZKhKN38igPT+kHivjVpQAnfmLZiVxv7R+IKgz4FF9xrRab5mlUL/k7LPY8rCOJncx1ClogAIzSizw8NMx76JBXRTjdde9oFVuCKWUNDZDyle5/w3ukmO0hRjk4PJZw6cQESg//yON3xScLfy1EKZc6I5bZn8QmAZR90IMrEl96bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdKaqhmMrS9Jm6R7XDPp/ZKZYy7r7QWuYV3kuvVtybw=;
 b=EA0Hr7qP4aEQl5fl61X/9jc2wFDkrnWZnKQAioR7uLQBPu5h62+uTw3Njmo6xrTigbg/t0ilT4F2TzLuK1g8tKxNVSZ/dSm6yBCJesEZMyJvmbpJzeSGAClPZh4pBztWXtoYQH/6Tk3O6kGhsP2vMTjfN4uCBZN0jb7yLbSXw0RYCSpBbhWsk6uh8Ek/AwGpP7sNhYHBJJOpasOULnly5lfVt202hjlxfgGD0+pBe78kYBhn2Nn0HNZiVwy2LZqqGlSoYM615k3Mm3AViTGstcc/Cz+Qp4LyMQDc9Md5GzVwBJ/0LzDCWXMmxEdxTwQnU6r+zn1rLKNeUU4dw2WWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdKaqhmMrS9Jm6R7XDPp/ZKZYy7r7QWuYV3kuvVtybw=;
 b=OmQidzjv0Uqf0tybnEdwTyrK25h4B6F06NGOJmmBI857OMOUkMHom2PruOOnPWpjfLA2o4u6h0JIVpGNZvtYoBnsjN6BdvhMOjEObyLHhwQDjN58IHcXPXhbml1Ov7tvwQFPq4GnaNK9IyB8cfE1J/UbjEes3pRdAOOAuzfvbK0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:26:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:26:12 +0000
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
Subject: [PATCH v11 05/14] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Wed,  8 Apr 2026 17:55:29 +0530
Message-Id: <20260408122538.3610871-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0098.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4255d7-6bb5-434d-8744-08de956a053e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	seExIujwMJs9gYhZGeRSdFx56nx7SuAckr+uQf2DCje+kg9GBNIAbaEyjWkI7J63qVbVBQS/c6cZ2Ku4vcPF15YBGnCAguIhg6Z3qYZGm4DuklUUbeKMOQOhlrawJIabK9qAjk1XaqpOQwWFPbxReGENMIsex7IcBNgIGAZ/0TlWB624ERckOEXfwWbJ6pNkXox+30dwNW/X2eI9zExvTl/Nzpy99rfpL1f40zciyFpPyArfImS1USgM6/wZdeA+/vAxi8QfG3BkljyxDwOFWFjd+SYOb7fnxlt8RTC59AtPh4wX4I3Ku2GQ9faC3jiL6fI3NkIoyDsEkHWqUmKi0jMYWmrmN+t4Sk5WzMxadr8hfkqYDCVFYQlLTMhyoqiWZ0D4dHawR3lTFWZvDutXgphxsA731RPpNGFTLoHpETTzHggxD8rcooGce5LeqlthzuSCOgv17JmoEWRdpSwDKAHZ7mLMY3NHPqK82DuAmTLAF2dMUjL77OcRyftjJm9TI8Bmq/l9YxKNeHSiAxiz7XC9+ERQSVHOcWWJsckHA2CTn8EjFLbyTevy2U7gOMjuIMPR3Pmh3Dy0IB629LXmhfFNTmr5Gqp0iuDs82zaRFS1nvt7dlX6qHxMV9jeYO+utZLwRN/+VMK+sN4yFzaVYXpCJlRBcsQJn1hm4+hZP1rjozbwM2PnAQ0Iz8HECf10w5Bkg5KrwcCJD53hqKAF+RfEW2B21E0dsRDzDjDWd2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbs0GvE6i3kG/TL4PGvulRgDq2B9lQJaA/t77PFu+Rk+NPev9JFd+V6+Szor?=
 =?us-ascii?Q?LR2WkSxTIqAwHRnaCdkUnUEKwn/2tgbNacrsLIZI/wCYxm7/0fmLWIGpE9W2?=
 =?us-ascii?Q?fPGnt5SEtrTGGqbScfC0/JMIkFxiy4iyNR6tL0M5+1bU/FvVaYFj1srjk+J0?=
 =?us-ascii?Q?cbTpcvliXquATLeGNwbQ3y4SEO/ciQMQc/Gx4Qd29/HOnn7ZMD1k1UEud+su?=
 =?us-ascii?Q?9yWeM3MOVJZ3ZcUtLNp0DE8YBY8G6GkjwQhDChEDvb7yGob8G3Pa9nzRzMdg?=
 =?us-ascii?Q?YvFfW1Gy8dWct1+yqoTzI4+zOcKq37WiRLHZHhIBIywr3RCdThndjpM4e7ZU?=
 =?us-ascii?Q?e44QRj9y+GkhVcwE1i3EPLGU1HKEcZ8eJuNIWaCfLEt4wz2+FwLUGx+lAC3M?=
 =?us-ascii?Q?rmhNrOp74gzk6HNHZ3F1oniXjC+Yqyg6gIbRufhErD1kIyYUlxVgmYh5aB1e?=
 =?us-ascii?Q?ZMr3Nc/cMIcOy9DVx+Y/qPKhAJoEvlwmPKtsd3sZgaImAhIzpP+AX+OXu25H?=
 =?us-ascii?Q?ftcyDqyq9TrizYCC5bNRduZbEWANA2GwPlDgcDQg3P9il53AxYyNts1/tpOz?=
 =?us-ascii?Q?7aA6ETHdZP4GZynyRY7ApxnP5IlGzWm4+slmjBYmTM2vAJsUAPr5cXo/ParQ?=
 =?us-ascii?Q?qF359x8ElczbnYxJaIrj7DU/9hLBKT3JuYU9eUssYchGJ0dRCS/lxLT9jud3?=
 =?us-ascii?Q?rYxHH9Yz0JSNkx3r7CSvD4IaS4MwLaGXvd9SBBvOYepg5P/k9ERczRWyont2?=
 =?us-ascii?Q?a3a3XuffirsvQdhREfTvnQ7FZ5KIO9B6+ORUM0AQKu7a+3k1CsQOtjHN1Ujc?=
 =?us-ascii?Q?LxPN/7NEIhDUXXv2bhhI14iDqTdBCrOO+lKOoeUj9oQR3of/eKmG5Hig6Bvg?=
 =?us-ascii?Q?BgYrDnMzqHysNyruqJKEGupRzcsa5fQWl88JmmmW/gelu8EU6SnBhKQQx0PU?=
 =?us-ascii?Q?F3QDUU1uFQCx/rXtnBKwwXO9qfIhUxkB76kx+T0avNeDi4jfAgljVn3AHnRC?=
 =?us-ascii?Q?W8YTzWWO3wO7CKIScSEPx/Ajd9WCn5GuBzhEXBE4cIJxriHx6V391MkPJwsa?=
 =?us-ascii?Q?fVZ7vWTHMjXHEiqv+qpn1pPtKQ+1T9f0Rn0eHf3Vtug6GxtVWwglhcmxV/R9?=
 =?us-ascii?Q?xnarRQ8xmLjmjqlo5wPuHWte4EmmHY/IU5d5irytHXs7SDS9hDDHut8EPF5N?=
 =?us-ascii?Q?sGhfyrSpmgG0cG584i4IY9XbZkrvIpIPA7UFVnpKqeqQBJF7ekMi5IVFPBT5?=
 =?us-ascii?Q?B4Zi/G1yV0NANgFEv3gm6ilESBiSBDbNSqhpVBeSdCj7/IufVhTPHz94WZi0?=
 =?us-ascii?Q?XXz63iee2R4Ctafat2MzRiyp1ntCD4eBoqMIKVzWq3nZ7kXLjY6GBp27Y8za?=
 =?us-ascii?Q?WEp/C7u88MujB4k4JG+E8iBGTsIqeTtvloCWcyczzjbMb7QTDIiV6Bz6E7UT?=
 =?us-ascii?Q?Z9BV+rjFD//0ASvNuUbGiezrqXKrZOyGm1tXmVI5OvtrmJP9rC6c/di49XLk?=
 =?us-ascii?Q?oggzKGT0E250cLSQWWP4dfnx7zko5vg3XzduzQ/O0IjPW2Rf9n4rXUzdLMIa?=
 =?us-ascii?Q?nGMuAOIaEbTb8T+DaGMLx6gpV7Mpitzrjvhhe6oBlk1iQWCthgrEbu3xuXx0?=
 =?us-ascii?Q?EbAO/4xEcj17w/RdGQyQXFfqFtvffN1q1Sq0uVg/WF5TObJT+I1CRS7I4XK8?=
 =?us-ascii?Q?v0A7sgEdAOqSdBDDUMKGJSi4YiXNd/4UBLTsnPKHJo5mxtiQN42HOagV4+vT?=
 =?us-ascii?Q?SotjguAYwXRK2pqgxDIE2/972LZKZjfzDNQFt5oryHdPbi1u9FmPvBTIiAGD?=
X-MS-Exchange-AntiSpam-MessageData-1: NVOEjNmE/FlpWCyhvNMOZkku1evZvffB9Ys=
X-Exchange-RoutingPolicyChecked:
	IXEyq6aKrrS5bWpo7fA4FTBwbsQuvqcdt6sLQwRjIbljTsicd30zNHVl0kyRdxqLM4N346nsWTtgxg20oV3VWaBC+pyv04hw4V+3iGr615e5eWzEw5nuSGJiox21wZZQrppNKcCjAwM+qU8MtGANtujzKjzAetiQoeW6vK6QT/ps4QyPpCpnX9DcwUsd0KHZ9qb6ZzD83FSxZVIbuJEEiMG3pnZlAhrvub0jJ8TNMxpNfmC2lRTVgNqy3aOnKHAXT55TTgegHflQCr5vSOFCnv72s9F1YevUZIw0gmWrHuA3BcwB/0PV0JVccioSIMghIaEC6xJSIt80Z3UWKDyOWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2WekWcDZtefDyGlzkjSg2+XWvkD+Toaw3FET+qQfPE790uFjmlD5RE1Hfu/gQ9eaOSl93GnnaD/DBOR5wN6XYZ0bCYtyFXDRWeUgBnI/QFDKnqHR4GXDVE1hy0CkkeeM4RgnsRyZ/d5rzNilBJKUzF9lQcDt6JlSRGWt4r2bWdCAmkFnKpjqswOYa2p5iYw+DtFeb8w6zmeHmIMUiqSqlwYeegFfRTrV3/7/xcRa1xhv5foyt/l8JSc8zswy1ZphF6n7y6NjOafbTtSJSt51XgqJBcNBt+pkRrQCjCnJuznKGNMxZlZmgZvRNZY1cZOpqKrQK/uu+SdwFEi9WieQlLWaHfvc29vCZFYUHLZm6TUZYgnJPjB1RchM1sxCS24pj14WVrMTt7K9Sb8fcHfWpeon8WfBD4iFfmfkxvtVmfVIqXKTZ8zPVV0339DGH4+4OpcS/tngx3rNfXxbVM2KWVmLhgsQToCc2uFl2UohKe0fqMxStq4+E2ok8LHRSDsYdAUip8RuXXAz9EalFan+z4S9CrQ8D7zgiE+2itgmJ+bhXXSt+uWh6fHJzX8Yf4RnL3nWthYxz0WhqboTs/uKO+YZipJF7C+ldzB5agXMFGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4255d7-6bb5-434d-8744-08de956a053e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:26:12.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW+xU5ZSsTnN12wlfNAHOKXtegNeDwyd+8qixLmGCSUhU+AAB2KYDs1fkbI2TGA8bKCPk1Dn9hNjEaPZMUpPDmCeiuEoUSxQKgGxBdbpR+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2604010000 definitions=main-2604080115
X-Proofpoint-GUID: BFa1NrPHwrT798P0Bpw02VeRIraVyV8k
X-Proofpoint-ORIG-GUID: BFa1NrPHwrT798P0Bpw02VeRIraVyV8k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfX9HiqIk8Vh9D/
 GhH91LO3DOGjH1go0aFNPhN4u5G3RUmFLARd8gRpAFT/fLI514IdYcZygIgYNrWI5Az6Ykqg6wj
 CtOKqNrIN4AyPGi7fSkhLQmmF31zJRVFXODMNDmry+IdoaDQojisaZTS+bOIBy/Xw6i7HRJsQci
 72Cb0sOKhx66MCD7GL9PG9CNY/hJY/BhKPqMA9EWXEWdyuNuEvNt6rBOjIsWaDoD+nuQ1wLeyDh
 Dn9bYzc8kmuGP+/u3wQoZJfxeVDLo/B+y1f8vy5ckMOTDZ3rGBlGBvy2TnH6Co9SziiJYs4IRWo
 bth40dkRqtPjnWPaxTsX7KUdMideEi/aqy7BYCXg0GvKe0kc9Kqyv6+Pqwv24ktXKQ3g9uo/KVK
 phAW0aE1exehbQtSgwf4vpFgqpVqBpbARW83Jxv1AH4hOcrgz5CRpckXSi2De6xbBLd4iDTJO1a
 DTwA2WFOXGhIR1z6yFQ==
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d6496b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22

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

