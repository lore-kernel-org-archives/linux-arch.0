Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2124229A6;
	Fri, 16 Oct 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134614; cv=fail; b=BnGH+dL28d7bEkHy27hpZvxNywDbbKgabn+L7CZSJzkxvKhps0nCVHMm5rbGiNcDoImumv9AFyDWFhLFMvRKhw5LJIm70AhoZ7oUMQGLIycnHsuWdGZN0V7ZsrVqRZbrVj98MYSN4QTkgXTw394qYsZlTsBWhE4g9tA55HW5ySE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134614; c=relaxed/simple;
	bh=bWIMRAw4aFCddKERQNaX0CMa1naekBt+H1NtmwuV+gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPpP641rUHsdTZvqs5sIhd1DAVSm5oCtAnw7/q7EeCM31uh0U5KGjJFiwsS+kuygYpmEqOdFmsDBMku5HxFlbJIjjR2oMNPgifV4RA0Y/nFVs3jMlemfzE/jd4KtlllkJO8c2WbWefGAqhWiQdzsa02D+ygd1bmlF3vodQtnUW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WcsrQ9/W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JwXdw0nK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WcsrQ9/W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JwXdw0nK"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6xcH2066304;
	Fri, 16 Oct 2026 07:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bV8N2QIoA6qFMdyMFwvqedStsZzwALk+PcXU/i+ExoA=; b=
	WcsrQ9/WzaKUZWYqvVqeZrsjjk7qUvJPXijPoApmKrO1VWy3RP4LonXpjfB0DxI/
	0or/wTmxYHbbKCz4IDkmz+CGx7rbB3UUVLXmYsxXV0nlam04114HIoci6VBEmgMX
	LY1w9qLxvX8Xv6E59bC3Sup4fqUIzvqWOos74PK5YoQPyKrh5jmpd+zkrRjZv0ir
	LfJGHD9EHARq75zVpUltsSUZuJPT1mwrVpB8cT4z0GMSZvB/FxnDUJTJAHo2gbw0
	YMY1xK22Y05C2wZMRgy9l/hIyXm7P80v03rZeWbZLhMI4HMIyz94DBJG5rVbqKP6
	kVrFYUoodkny607CI38U7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1sc6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76CQD027851;
	Fri, 16 Oct 2026 07:09:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btd3mnv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdaNAQ8fYlD0UEoEcufi7j90FuFHiya45OHcAaY8BE7xKRlqnndUMlaLpVcqxOMpH3oIcfn3X9jbMTwpsndvi0ROx6N6HMQFNsXr9PpPsRovI3Y+wIsK2tOZp5DOl/1LHqsOZZOAAXQvnteUShTlM3EIsmT2kBOYJoQyLtb5eMBt9PDvWpnp900OQdr7N/ncrrINCri+OG1Nzebz7NSPMZEWXzgvSGQkh/7/Bt0aW/PiAKTtZAT/0Pt4erZLzPS9q860ZbzL2hkhdUyIOUNzh2sXbI1Se1T7+3Vy+MJ4epDNfvkU2feuJ8vq341ROgm8tasSxY9NcZ3Dum7ZcQ9Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV8N2QIoA6qFMdyMFwvqedStsZzwALk+PcXU/i+ExoA=;
 b=OiUUYgRzG/Gs+k/mYJYyQ4o+4Wf+l3kuKiur39H3f8eycSR8aheL5OVNXrWtlFdZ3BGheSA8QGjItfRsnrZPoyRNUSmpg7eeMkG399VGiNVsEQue45a4t0uYodebotC4Dgr0JAx4i9++XbkR4pu7chbOnTrrVioqTvHswrnSLyf0s9zqMLSOioSkkQPfVrqDsT6vljo4ZFIb1Iqu3HZ4eyj8Iv3ON0ISs7cQxvR9yK2Ylp01upEk800dvsKD9hSGtpbUWfQkIeg9q0EHewgqU3nm8V8UIDSoW9CA99VM+9xJQ1Q6jHpq5LIYshd5efjelisYbJ2lNYkDCXZxVr4HYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV8N2QIoA6qFMdyMFwvqedStsZzwALk+PcXU/i+ExoA=;
 b=JwXdw0nKrGDe9+V4gR9H1GLE21xhub8D4fi0puEZNYz21RUocPPIrBOqK8ih6z2aflixfZu0Z3y+a4WBTmclh7lEJ6S/qcs/5/SB82FGjvx7mvOJAFS1p9V+hmlv5Y8Jw4PG6C1B2DQ5o8N2JdWgFI/u7K5adPJWB+W3bwkCLBU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:34 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v16 13/16] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
Date: Fri, 16 Oct 2026 00:08:34 -0700
Message-Id: <20261016070837.440748-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 286db133-b703-4876-8f6a-08df2b546e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fxbLawaJo8fnL5q1hbWkRNQPc+cco58TvJCKgCRIizLzaaS5qBjFdmJU2jSt6eyhVADHfJpAYANXh3vEmkt5cg5RDXcLdch81I3t2WYvBWFlriaYR2sC/4CbQ08XJpMZPCA+hsRMPZ5pVCouDTMKdlBa0x7sna070v21i94XKCoqXnys5yzcs8crkixIElVItICkCE1XCXMb1U2sEas8wOrgDzsRcGIbCMXvDk3jE9UaqPkm9LUg8VeKCseSApzrIKxhcTRPiUBnbwBiACWDn1V4QyGH0na0StxH2WvTC3pRenJ3JvHfQLPFOVfrwK5uYyEhnndADIkiXgwHgo7D3YjrySeL/0Ikw2SrqrvkleB9a7JfS80TmSy1UxL6g6sy7I1iIWSRbeCbP9xijsxpbcdGpKUWNk2y5IialvER+MTW2Ow/QVG9gZHmpqUWGfXsy1zG/DDD5HlwNOZY3RZtJ1xz8UkKIV98YN6nzPNbBlhkpjJtN+nlTmMmTUfgux8o52e6u3/58+H+gT/5sm7+csHlI8rlxc74Hr3dZPK5CUlQxsd1DxNQiFRKTKPvllPcoRhzwdy5gFbIuO4HK2pPiGuMNLRbd35gNebGYRq3Gphx+n2AI92Z7JYjPP70SBCTNOqpkO7/71nBgvmPO+Sdyscb1PHR+FSnnsKsfZocbUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNsuZdxu7s/l4EEvZr5dv0MdeVLPpaNFp/jqHj9FrlGYKbQn3DuAsaa+AE/c?=
 =?us-ascii?Q?qiWINihSORT9pJZdOWFuE1Di+Z97w3/4seGcnfBLvbVpmNcC4QdC/0Qsn60Q?=
 =?us-ascii?Q?I0wC+I4RRPFELbhoXTc7DGNI2+4iImCyI9R6zQBPfF9sz/VmxQvS0IngwjLZ?=
 =?us-ascii?Q?28c9iqSAcrhmloL5b8jAO5n3SG2tOtrST3+qpwxBVq+eFuqBysjS+mO58zI+?=
 =?us-ascii?Q?9Z7B6BmA/oagrCZPJiVT68M2NV5sprmfQoZNbqGFk8/oj8xreefKFnNzxllM?=
 =?us-ascii?Q?8G8c3i/+4o8X8x4Lshsh5Is8gIdikf3ZlsMpzGuMDOTR7XWEPuDaSzpJYY8+?=
 =?us-ascii?Q?+ryGFcNcw7X93D0jbbVjk8vF+6DsmWLUoouikbNPDGlmXpwEv+qtL/eWbrY8?=
 =?us-ascii?Q?ivUge76i3cBxbaxTQ1Ca9sxLpcvIkWLKNaTn1ViHXbNWaAGuc3NCLJyrMDN4?=
 =?us-ascii?Q?2TigzByMwGdbp4V0Zvhzpqhxw0R5eUbEe7+gGvp5xAYGfxNh8897TIRYXVT0?=
 =?us-ascii?Q?pNkCX+TqrW9foi0GaTMH/yUXnNQVUpi38y9IBjHIxLQzZt6f+isGTd2rfuCq?=
 =?us-ascii?Q?gKPUW+7YhkSeXcw+V6FrhPNHgJTLkFBOiXvKWAoPrI8skzaxR+bkNf/AMCcS?=
 =?us-ascii?Q?LWvqYWRhZTxEAn1DFXxUeRjzsMRhaqYSbHc0EcXc8DxUyqt005uqrXVHdLEA?=
 =?us-ascii?Q?X2/+fbh3bY51ydqrQKmYpFHbrKgytdvNJtS+GtkozIjeXjPLPqvGP0f9zOB6?=
 =?us-ascii?Q?vFQm4+wWMRBEHEM85E0hwVMcjkjVWs6a2AVj7nCT6n9MFEA6gVGUZOsfHZsb?=
 =?us-ascii?Q?r1DgGNHF6TRoVVGRpeHVAM2A1y9ZaMoZMh+wl0zxfzOiNVlfGMBO7UL1NNmu?=
 =?us-ascii?Q?u5AO/XRq5SyXgFuld3/uFaE0NARR4cdmmQC4sxQkn6gmPXj9GggP6cfAtjSk?=
 =?us-ascii?Q?bgvvd6+Bcv9uHiYauGETcLdfaQ18BviokoXZcWT8GUSFc3XXlXBMcXGY5lVl?=
 =?us-ascii?Q?M6B3n7s3w62NV2GjsdpUxpvZNiDYHqZlUh4TUHe0SQhtQlXr1t7IiCokCaAw?=
 =?us-ascii?Q?X+HZHDuxteoSQZ68Xwwh9tvOgfT7/PFtFd+r/jZx9gg/8ZETNPIo/2LcOZtD?=
 =?us-ascii?Q?gioPNj4PByPgUB+WB7MtkJUtvzmivUVIv67/wGXqlcfHt64GtR6LBrmEpqOV?=
 =?us-ascii?Q?xYTYwUGoAfNu2h+8WjXPf+1V+tEDeX+Dmq+CXOjHhxIV3qzxbSLR4QmNaIvE?=
 =?us-ascii?Q?X7aBlNR/TZ/JqTgDDt9lXF3wRlxO+clH8fj/6XyMNyI/exUNC8wUgLOBeKQ9?=
 =?us-ascii?Q?WnZFWDNRdpbSL96/dhoXRQGHdqPmDruii8JoSlnxQLUIhG6HubG3ywcaYP/K?=
 =?us-ascii?Q?DASZIqnT6Ef8rw8Zv9KLBsN4HRcRjgQCNpFbxwt7W1pJSENXZ6x6H3WN2i6r?=
 =?us-ascii?Q?Eh3UtFY08v+/PCcxATngofeEGczjfy2Vahy+VYmQihDvD203f3Q9uhsgmw8g?=
 =?us-ascii?Q?UFNJQPtzIOYApbwlBtxO9P4kHQMh3D2mb8UPngZfUtkVtbk+HA9HILEJ5vkb?=
 =?us-ascii?Q?oYt6fZPLyHuG8lY9mKhusvewm7Xb7//C5NaBn5ahNpctSGPewXxx+zSKF10R?=
 =?us-ascii?Q?2h27pZ7Xu8i9g0UpktRUN5SAzgKEEJbPzARMUBwo2/u7lznmle5hTYFqlbnj?=
 =?us-ascii?Q?o55DOlyZPfca2Q1EL4nrH4SgocgfCSQjebM3tbqDJhOlbHRUU3kBASG26W5b?=
 =?us-ascii?Q?ZZMD2EQKYgGe3jVz7KdnJVLx+I18BbY=3D?=
X-Exchange-RoutingPolicyChecked:
	Tw4ZyTMg/WdvFz21RUH7mB79dpFgJiJ2AY2aPkqOAM+ZAYbNmGYiwVQxwjmY35L+BF1ikDaiPntizzYx+ulDd3Kj7JDkX34hkA/VE2p124dia9E1Go+LMTRJNUbeyJgERRsn6WWYCYyLejuJMsET+gV2nw+AHVnCZm5HcQ+9/VK0UmF/GFsnRhz0TtLoloRIS88UPOnEV9OeOUoJ6eceLBljCF9u2K6oIwPt2F6HFj2u1bw8Qx1yTIpaBlyzl9mpCofDGCdkVgtRFGXnzRU8Jr8mKnCZFQRPvFhGp4DuuApTv8F2MdYJD9Kj3OYqGaYL+9s0ntlFOIN4QSWU5IQOCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2G2C/V3it3WWg9GfLHhQXntKNlmmVsHhtN4SqEAX67PaT8BiiPt05ULc1LU13BWe2I1oTWR8FzozypZTD1f9v6oouVcHHcNkc9+xYRHMuLs8CpfehBXjHyv8+84mWsRwRo/5ywLESZPNiarl0FiO7boWiuJ/mCFDK1d+/5nwM7fCJKtjUg6siAMXs+M4p4FHwJMUahjt6sRQ8cvjalz6rDkQJlLnKETH1nzyy0/shqMGkmNGau2uhPFrqFk8Zgo/CsHBgV/BDjSqrhUyMz55MLuukAPRnBcmGPJYHVcidQGcV9MDsFm6ueMql1AapvElIk+uATnvTgl7cuza8u4l8glW8AA0FA0Yzj7DU8ze8Ml0uKlh36y/JqxZGLpIIERFyPU0CBfcr9f/BFj56xOs31J/VWetqVxDxVtJJ/OJmfmkwjsABfHUqvva9fIH6k2TTonZAbwfemtz3x2v4U/ZgOHZmi4MJYb1tMIE9FfGXb+ZoK+Tke53c9rCI/m31CN8ljc9cZ8KzSglkKrID1WEYBcgfC9Txbl0FYahk78VYdV0/pNfj/VNQOxTLEpdRMat0UNocGjRbMl9F/QcQKryWhFyDS856dxybJpdmkwHfso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286db133-b703-4876-8f6a-08df2b546e72
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:34.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQEJdd5Ek+zk+dGKCjwZ12VQBi6pm8G1cnD3UtQHg7FfrMlwEHSwuAGHubwMsUWOXxRTNHXscL/4Vfjs6jflQ6oOj6zPnAR9yPQzsCISQ+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6ad1cdb3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=bb9Fw_vXVJAL2FTmegcA:9 a=WmVTiCyuxqgg3mnwYu6p:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX3byhPHVA+/yQ
 ywmdDFuoNTmpL+JCp0cfpdCJPTZgtY7N5o8yso4ssXY8DNK8fRckLMimTJgnPsjGOEz6LaOLKMe
 Y3A6yVjN4b9ob1euMz4eFDpuyqghZjZMyt7ub7W5ed7C5+seW762
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX8W2wpaQfKfcA
 vsYwTt11a0Wy2Ov0r1rbuCyuWu46zBN2qwiWfuDVwixqfi9dOjRsTzS7SP40b6DWhI1W9eSXXBC
 vlQWsphY2pwNw0foxBU0QfiCIZBapsVQFbC2hyDbD+xfd+x52VsjT5qjHZ6faE5oo89qfNwIRwn
 P5PTzz1DIpnuj0/2Gc/BW2yyp6uHTnj6IYDf4sgwdZhkBMmIU1rit3ns6n+WfLDWkoqSaQSqytt
 JasiliTvAIpXcPN2sU99MQCwEU6NJWWbj3No+eAzSz6fM20T2XiN5fqEKjTt/ihMEaQL9EYnpB0
 qW2cGFhgU1WJ0gYRU9hbyTvGJ2z+Pt0yhJOacrjXi5q/WtjM+mPxps9FQ3dxMLxT5lZt9ivcyIr
 y98EQE4Ezl4wycnbCCUzv3t2oNFOngy+JGGp4fNaSq9d0sQ+rGwj+KW+R3DE8xvRXZRO7zRFeH2
 0iBDVhi5G8L0olVbMAw==
X-Proofpoint-GUID: 4uB1Re9I155_gVoB7xIWMgzuTZUpylyx
X-Proofpoint-ORIG-GUID: 4uB1Re9I155_gVoB7xIWMgzuTZUpylyx

This enables the barrier tests to be built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/lib/delay.c               | 2 ++
 drivers/clocksource/arm_arch_timer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index f08eacef2f0a..20bc2894b65b 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <kunit/visibility.h>
 #include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
 }
+EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);
 
 void __delay(unsigned long cycles)
 {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index cc9a8b399004..227447b19b14 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -893,6 +894,7 @@ bool arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.43.7

