Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C02989B5;
	Wed, 25 Mar 2026 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418359; cv=fail; b=PnwyftFWJhlO4X3OXi5zVWz78cj/oE51+NRxl23eZLxCfcV2PJodt1gqFrs36HKStG5O2U1XaMIObx5e9UO2B/zHkgIfNnbvGPuygAvIJrVreP80E/QTdpBvbRu3p2bwmdp/am4KRfyikgQ/WIUPkyOYnq6+nRZWxFJ27xXAjPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418359; c=relaxed/simple;
	bh=lxjZYMM5MVcCvaA+CpXbeecNCW3BUZHOQCaF624NDoY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=DrqkxHpx/WbPslUxuxylwnnUqCcxxy5ajeCXepNu5u35Mk5F7GrLnz2HiIyRXwK9olkrNex2dxs1FaUi3eFc6le5LOkGPsNBcELnEWBOOQwMjHbsRUB4NEOz3Ab4cpbrUaMtZ7QUVBjgpbZ7F4b3IA1vwwbTdi5LsxhEXp/MqzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WT7pm93V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ITncqaEA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WT7pm93V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ITncqaEA"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OMBsJk869646;
	Wed, 25 Mar 2026 05:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lxjZYMM5MVcCvaA+Cp
	XbeecNCW3BUZHOQCaF624NDoY=; b=WT7pm93VDBDFbqum7bVvkYHRPTMAbSvD3Z
	4aMi2yabpUrkpEeHbXzcPV206ZbS8cKNkwfiMt8rWbKZ7v0EVvrdvOWQ5cLDZEU9
	vexhZQ4cUwyhZCzepqhCp/cD2Oly50x8k/NymIWAThCxOoOZ8L9YuZqSWRci4J1B
	Sn8ESq7p5K9eNftVR/URs00fKMeSfLYIfKuJzNmm7ATU6lQ+DirgbMXtMWhjXK7C
	jGU6G2YvsXACOppW5OdPXaaZFTXeGY3dna+H35o3Nqd9ze3EtiRowBs4lHme6ZLt
	ZO2Qmc+5NM+mynR8vtnXHEzillwRCzqIeV3zZcayInu3yOh/hFDA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2drmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 05:58:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62P3Y2DE038575;
	Wed, 25 Mar 2026 05:58:43 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xqkj0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 05:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAt9lX5AaqnCaC91SleFELcj2BXo+DJUOMw6/ypPRexS9Ps853KaZPw+igLmT6/T7xEK8kFyAQA8UNiFfKXT6GT3/N/E45gHvwqc+WBf4PVdN+swpQfdKTnunRJjaZ5la6eGyrs/pBsHqa4c6TjWtJbQI5ZKMGLEM1chIr05ndPvnyS3KrED1B2/Fknz0HAj9Mxv0GYbbegL0tG+dXxk0KiLQ5J/t1+28yop1AZ7YHnX4o/q1LaO8xAM/QL70j501GjnmE7VesOzHoo8PxNAf3EJBeALEkPjcZSkqtKSuUBRKa2vSfd1FPdMeBvd6AYcdc2/A5ASlq0BqgWbT0ms/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxjZYMM5MVcCvaA+CpXbeecNCW3BUZHOQCaF624NDoY=;
 b=fIC7P3oY2vHthlp67kMezStrQv+4D4VvlgWqx6McdYSDVbVF+7thVCdrgiGd7lw+1kHZXlSmCfFEEl/PTjqVkKIKo/5TG9TkajLac/RR5/pgK0eKpvolxEC7cziXLkdNpH0gXxYDNlzjnDHxlElR+B7Ta0uONEqqhilqi7gvojxQnyPosOVzjC1t4VkW2iOu/ZGYtsPQQ2nTc6YnffVMa3GvLcxaMlXEAPSjiR116b1n+9wqdzNoM7aDkXcn0PFMbRNK2+v4/esHn1jFVsiD1vgUe3N8EeEPcqaEmzLdMDdltJ8JdUNQayGjR/WFTaj6RdZ+jDSZXX3zSJDxn/aoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxjZYMM5MVcCvaA+CpXbeecNCW3BUZHOQCaF624NDoY=;
 b=ITncqaEAFCbHD5yuHTcFelyUXdzRJl5j8Qxiu/qft6Ob6/SRVxrisCKWaKy5au29YXoaKAtyx2Qj00pETYecE6EDEwF/gd3xVSveMS0h6GCSCrBenlKVpE2GtVOvzilLkF0vMZwyMHoZ7TRPK2CTrBfCDzJ356HwQopLbX2z3rE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7184.namprd10.prod.outlook.com (2603:10b6:208:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Wed, 25 Mar
 2026 05:58:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9723.022; Wed, 25 Mar 2026
 05:58:40 +0000
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260316013651.3225328-6-ankur.a.arora@oracle.com>
 <CAP01T75VaNGk+adULuX3q_8uxc0z78J5B_5ECLy2VR=i7pBi0g@mail.gmail.com>
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
Subject: Re: [PATCH v10 05/12] arm64: rqspinlock: Remove private copy of
 smp_cond_load_acquire_timewait()
In-reply-to: <CAP01T75VaNGk+adULuX3q_8uxc0z78J5B_5ECLy2VR=i7pBi0g@mail.gmail.com>
Date: Tue, 24 Mar 2026 22:58:39 -0700
Message-ID: <87wlz0qwkw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef5def0-d779-42ac-7e50-08de8a33906a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xzbIBMXB+DldH0iVCuu8D/0gS/EPjRp8Kh4H4UgbYMv4KvPWNzzD9VjJE+jzsbGYzdDY9ro7+nRYLxY0x7AyIT16xigHlz8i689/XoQjtz5bH4SaAPI2ZFIiyk60lP+S4Wc+H/kGJ17uA9eMn0PBcKlWwwY6gcZNmlNSA19CuvQwwiIuCxhjKH04nX8TwYydlkrlMDKVXMKnP/rRKLpQVKeykXY9YUuCt8OGyfEqL4EhYdj80TnHAOUzhtsAFR3ZuMRZiMrFnUpWvzNSHdqmwZXRhwpdDAVerJvSfvUPSD5ELyCWsqd2czNIOCIHOoZTsTz84KbK0gRRifUSchfmXofRbfwTm0ZEYvOy1GW0jIImviU0K7x496fifAeqdWFUqi6B5332Xh4Q+uUdqSAVSByC/noT4AzC7l7Dv+knxKlstjq7WX7Jrin+BhEiIcXJySU+K6c0uUunq1GzIX5jM2AiBcCKalr31XDBdTGxtXqloSkwljztUnlev460/RCgVO7uzkekAG3xFWx/0GrKDbXo7gKz5tVwEjsmzyJNcTYOP5wn4+4UyMvdzlFyWTc2bgBY4H3wz3noZJlJp5S/sBFlfukM2ZVySHa3r61NqkDlp934wN0kBlrUiL7MXOMZ2h+J6VljjhRjCasQg+0zekA28Hz7LeGH9mArRDzuC4m9iX3w4zYQd22n4bAp2miN8R/QDltDlcRNTcqf+YB14b0yDPGcZLgrOXLZa9Wnm4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B6QcGrzTGUAK9/he4XIKRGkh8QgJ4Dl9YhWpFB77JBvn4rgd5okB//d0kpXb?=
 =?us-ascii?Q?uqPBzus3fVo4dCauwinsvhhDZcRnRUOX8y8OnDVsrTG8NR60AyvYItMEmwyF?=
 =?us-ascii?Q?gPTXg28RyvOkzh7/PHSARdB3IipxKhMqefUigaZy6faeMUbRCRo0Jwbm4Zt7?=
 =?us-ascii?Q?gaH3z/r1Nf3XayLKF+Y2Ims7oOm7l6ThKzmu09oqnQNpsrVPFtMqrRc8lbCP?=
 =?us-ascii?Q?yn/46U/YyG/b+UWP3qNYLvuC+N9aUEhc2oNm3r1YNeqtTEghKXVZ37WGMcRk?=
 =?us-ascii?Q?68a/E8fgqwgXussSb3SSDgl0Vv6u2TCtwI0Tq6rqqhjAEvKDuitr8Cv3fvqc?=
 =?us-ascii?Q?GYxF+kYlmWCJ49HKHpih3mDwfXu/MAjlsvdbJOqbSSNS2AdQNoGqYZNJoFkR?=
 =?us-ascii?Q?Y3I8NLgl3mhISp58LmmzWyPPjF+bWHYygabvvUi0qD7V2kZIDIrNeImZ4nLb?=
 =?us-ascii?Q?5fpRvEkrqMwzpZVZt2YCaVFaRLQQSpQQ+nk234OOFz/X7w1sWMvOuC7Heze1?=
 =?us-ascii?Q?kdNG2534eHxjvQdS7iZ5q+Yz+Gbndm3K/6MJAjStLNvUGsogT8O5LZOEVK2l?=
 =?us-ascii?Q?yJLt8U1MvW/sRpoUypWdfyTHh9UL4ZWYygkizXHcD2xrMeBQdC7tUzFxsPSW?=
 =?us-ascii?Q?Q3D0gC7W5cpmCPbIrNjOW3HDXM+BTorD5gpESzESjytMA8htlBnnjR8F3XXj?=
 =?us-ascii?Q?/duGE3JhrC7C/f7DihG0V6iW8TTUVwXozAKYIc59VbprtZrQo2JVUhAc9EGk?=
 =?us-ascii?Q?qww0LJOPCjWlHxBk6VHdIICosUBc7iDDzM5vDYZ5AGX4cClJQl+NNSRkpkdJ?=
 =?us-ascii?Q?3KcPVxZGwHOZL7kiVw+o9na+yyWhDsThOMmXYjXiimUe6gMe56gdYbEcVbRp?=
 =?us-ascii?Q?CmtJUcnw8z4gOqxeRvEAV5iFojyh9iTOMPfeYyXgGyOhF4PifqHDsJcS50Xz?=
 =?us-ascii?Q?+br6fLfq8fDTatZzKqGRkZRsKrgHWO1z5FHagmlkmJs5S3K9qxnIGucoS0av?=
 =?us-ascii?Q?8ehJeTXJZz8yFevISTASW09AGcbMVMWJNHagildTAxkafLRmC6v7i1jZqikt?=
 =?us-ascii?Q?w+YvrZPqWB5neuqq9F2MlGq+klROmMXpLxj2uTgBvS97ydcRLhzXqrV/PZHP?=
 =?us-ascii?Q?CscqUrnUmRQRvMao2L7cHTDJQ9x+89q/3nujunrrZU/ra9lg1Cgxz1aNv3i4?=
 =?us-ascii?Q?IVTV0nrvSIr2ybnjW9xQMKcI9RvVuj+6w7H1fkvPquotdvs0atu4EUtQiWAW?=
 =?us-ascii?Q?BK9iBKL1+cZjiFt5ooWbZaosF9gFc+T0h25AuPC6waj3Mdn+SeqXd96VJBSm?=
 =?us-ascii?Q?MuXSv1joJ5NKf7bakuDbtDh/sVt/P5eNhaIS51xEzzj4RBJzfNWyUcGAHi5q?=
 =?us-ascii?Q?7OmTF0iD9EMbVIIK9Fnvffntto5b8ZOz0Ydme2WL7VBrwI1O4HHlyktDYhjO?=
 =?us-ascii?Q?nDd3gn01hoyfSOUbHQlm1t5FR5XUniiEqYJBKp91L0HnqbM9QS4xhg3F83Hz?=
 =?us-ascii?Q?BUrjIl8aGZsI3N+dWNjgSVkAGCRdz1SJryZF43wUqzmhqQnDjs9C2HN8EmTs?=
 =?us-ascii?Q?QwN9we5ShDPHHO2THJFRrRuofGv2WRgtlJvyqSQa8Hr9Q8mZAu8NjKA5Mist?=
 =?us-ascii?Q?4iXurrqbENqQi7IIIo0bnb94hcU0HueA28H4dr7qAcX/dHI6fbBEayL7b1tU?=
 =?us-ascii?Q?xWYla4dshL/meTLSLx35CpR6iVamhGpWw/89kZcH8KkFoHu1uTOZIGaN0ouw?=
 =?us-ascii?Q?tBydmpMIA8rK70YvuJ55l7/jbtB59J0=3D?=
X-Exchange-RoutingPolicyChecked:
	I459oxE+XZXeo1jbOC0W6FHhQnl3o81wYHIuh+V+GrQ/0oqFNoOHoGG7Kz+r3vj2OlF1v4SPWs3TdZ/y2s7pBLMqfAHmN1QC5gvkSgOaaW0tKBrcqYYc7/YbbqmpIBXz8je2DLB36Y8Z1BwnJr0A7MmAbG9Y9Fmqmpv6VHcyPIvHA5tEpfnR1ZlQy8IPCl7mXCDDy47rN9jDN/TEJ/0SXSpLUfDPm9vDEIh9r1gzWzQb+2Acn9i0Cr0jLV8+WfZMiw+QdCGjguoFL7yrbNMHxmE420a/wsd8jFWmv5Bc6VHHd0mj2f3LBycm0w6udYEy+y6ZDViP19266qtwXzc9ng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	egXY/8xkKCyGPUCIGo3To5V2kOi4MsglWB+Lin+PHbQvks/uWuvkDBdhRBNyCI3t3z0Y2Df3MH0JQQLRiR0XN3XYooIfhGkIfhw9AgmfLd8XUQ/HGXMyFPR/vmxuVIwEph1covu3soF/Oc/L1EseUNkA3I28obd883AhJ+GdDIvsiEz88+XPIIapRjpdRZ9m8yqbW3dq5EGkvheneMZVEwMw1Rwu6QhjhyNoZyopYCLkZ2Tsfw9I+B83Oz5hV8RIx6VdqDfMIWN15azU2d8haAO8WyDnGeCplB5Dh+Bj5akZHxKT4+NR0BsY72jIPKckCw+VhGf2UVefO7z0fYqXlSFnBVHXG5c96fCEYCPHOMPCZCKr1Qync8pS+VxvSF/5310hanaIb/3DePK0M1LgVojHKkAKNiYL6Rq1tmOieNXvTs3itYJJM7fHL+yoe5+PEZDvGwK9h+7uYjbjpDQO8bvxBJ7tMOABbxFHBUIrVSOpVxlHPosMakIk4i4AJMO+iHeNtL+46bkJR9PxhyDNdPPWtV9MCvv3VNhIQQ4wm9MxJfMHoUrfQ+9X4Wf1dazJ4auvjXpnoGuTO76qtzVMR+wP7JVGiXRC+MD67EEA1eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef5def0-d779-42ac-7e50-08de8a33906a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:58:40.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mm+TzxMYf2oxB871hIFByvOuAkWgVqv4c/6U1mtep0U+wdTqxQBcFN7+CHrez4bnPa4Tc9ypRHoTvP/QPKTyWxUaedkjG3HJi3ORFYPeXBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250040
X-Proofpoint-ORIG-GUID: YR6SyVtl1l0j-eN6GSvpwjqHDqcLXAIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzOSBTYWx0ZWRfX5GZOvimAQ+Nr
 WDl65De4pVcENfL2eZrnR/EPwYJZbwis2npRoRMRAySEhMNtrpvVDofDyLouLtbyTiQYWskncd6
 u05wVWF+TbGi8aLzP5LeaBh2++YNOa6FUj1u+LVEZmioBdSwEYMFkpm2N7mjCpOy1sreMi0osJ/
 2QZPKJ9a5oKwfxqOKvdqoCmS5GFpK43z7DOe6dD3LhcR5PoKq8d/q2GUM4c3sj+P8IuREExeoxn
 gJSqDBXhK4pm2Sr32ptpCI5k0tnDrWYte+XW7ssZSOb+y6U8i8Kci5sEYu/KAScjMNuMwZ2+2xx
 5aR6nssI9Tpyr1IV4wk4QjStEtxtPEBnRdBhGxln1o/Lx5+8fv4b2Q7TaWewv7zgHPUmc/rxlP9
 geI32y3q2q9K05AA1kycCdHWQMvdFfZg/Z1xB7KxJOtvY5mVjHHMxS1NTUMy91bOb0yCBhgOTue
 NJjUOjzWxJI9NIP4z0aX37VUcSywluynvgxio7MM=
X-Proofpoint-GUID: YR6SyVtl1l0j-eN6GSvpwjqHDqcLXAIj
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c37994 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=i3ty_VlxjXHKdmMDvDkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12273


Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> In preparation for defining smp_cond_load_acquire_timeout(), remove
>> the private copy. Lacking this, the rqspinlock code falls back to using
>> smp_cond_load_acquire().
>
> nit: This temporarily breaks bisection (or rather, leaves things
> broken until later commits), but I don't care too much.

Yeah. Would have avoided it if I easily could. But given that there
was a private interface involved this seemed the cleanest way.

>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: bpf@vger.kernel.org
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks.

--
ankur
