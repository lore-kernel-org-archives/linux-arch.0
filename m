Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B73BE17C;
	Mon, 15 Jun 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508904; cv=fail; b=O/aIJGkfDtRidXZ1QMF+PS1e5n7WkkkdjZ2+S57SucwlTfzG3+Vda3mQ0iGMdvEIkMp5IYyN/ylCRiO9OXLj1DKqiT/K5RQbK2G6U4lIVcX6oUrfO0qf5hGPkUXSpEhMPk3GvNde8FtfjjQmO6vVLrdq0L/vIFQqFrnQUKeUwvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508904; c=relaxed/simple;
	bh=8Hx6FyWeh9ykjJ7FXkRgqxSMlG559a+UNa8qdXoHbgg=;
	h=References:From:To:Subject:CC:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=VMp+Ka2tIM0CDXQ9XX2vQaMbsoHvuWnymJNHHHJXErD7Kn3mSbGVEWMX6jE0AafgkCI6mcaIhKe2eNUErxc/qnhMU564sItgcfChuPfLn1kj4T5mcojuCV1F3uORNZywQHKd6SWd3tJ7sfWxxvYZl9OgOnmbYy6Ppo2z4DBaxHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jFRUoLs9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gkL7WPYA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFRUoLs9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gkL7WPYA"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F2wHMd398700;
	Mon, 15 Jun 2026 07:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sPJ2jBzoPzz9/bAZp8
	TBlRn3J/ObxKauXUVw8ZXMpOQ=; b=jFRUoLs9Zmzwp6l5iJlhdshx9awXNgILQ0
	PnFC1m5cm0KYng+vvuAft/GZiTCO+G+kkWSdkBfCzh69k0BKQoaZwiPqfLjl9Kdi
	HZZSB/fG9J0pG4B0JzEoPoa0KvWiOXCyxrRMtee1PmSh3640zx2zsKDfTHaBPy9b
	DYEEXTdjt33sis1l2tOFT6JBfwqoCCrErcIX8NbSyx08H1AXZ+eUhUyrZb8lkFiQ
	EPLxgm8gP8z4JY739WzV+oFyWvjUDEOyMjh3gHFoUK3g1cvEJaU0N3u6jtZPPurt
	TRNQkyHNaelFuOo83pbgbZ++kNsCMziIioAM1TkT4Jn+tZuGRNTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es1ay20bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 07:33:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65F7XdKm013749;
	Mon, 15 Jun 2026 07:33:50 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4erwnnjd3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 07:33:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmL4OWq2mtEqgsskcOJz+AlmhOPPxmffXgPaYDQY0uED/CQ+AMiguCnc411gUgd2HOPfqkpEdbIYKU0xldUjwk4UU3z9+/wROxj9bXgroDPega6QDX9QHIaq9jkNAYEfMY6+5cQPYV9NtzN4eQCOBQvBF/SelXQJtJqdKTiMkOgwhTx/eZQXxXSoVszUCFe6stFy/lCyWWl+8VawAnSoYp0JX+ag4q90KrgWOPe8c3Vm3Fkoqma4Hr2L6j+mdWmJYEisKg01jSiOQGJ7AB95ruiRhdzC6OSC2LtyRbYUHzIZyN5Bov+6hkgToWKiQzKekubLXFXFokDxguRYnya8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPJ2jBzoPzz9/bAZp8TBlRn3J/ObxKauXUVw8ZXMpOQ=;
 b=HRSD6k1DRs0SsEW2EEx7+LjnelRVY3txVz95vZMsSYjd2qIR0OTAhj008Igf+BsYLfIHIv8CEfKQebDTvFgXdMBwsJp5J5WPlN4p82tbYkgVb2zWWtAfHrJQ1eYIrS95SMCaOAKmi9P6HyRr9i9QwtfjlYaBgwhBVk0O+4G+VEPOWBSjiU+87HP7xYsa/eed0cHwO8lQGuZMZfox/o9YEzIDZwb7v8yGueCQjXZpOf2lFQPKf1+iIn5D3j+XbpKu9gBKVlKY5CUxTqNO4XvIAzRB8h9j/3mxyS0H7GXTWNZTvzJeZfuD/1svgll2mRbGjquVatV4wGcWnekZGvIYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPJ2jBzoPzz9/bAZp8TBlRn3J/ObxKauXUVw8ZXMpOQ=;
 b=gkL7WPYAj+cboHvh829xramVTtIxOnZdHHktgnjPR8RnIhpexxXrgyAtH6XOUDRK0GMyjpvMdQNVER4GKXhEbGbCbhC6ZrpSAQA0ky6KMqi7LAmMqGI8wEKctJGbHdFzjFwnimIrQ70/u6h7qanosrLf/7yRwWh86F4mJAoGhbU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8111.namprd10.prod.outlook.com (2603:10b6:806:446::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Mon, 15 Jun
 2026 07:32:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:32:51 +0000
References: <20260608080440.127491-7-ankur.a.arora@oracle.com>
 <20260608082746.399BB1F00898@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH v12 06/15] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
CC: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <mark.rutland@arm.com>, <harisokn@amazon.com>, <cl@gentwo.org>,
        <ast@kernel.org>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <memxor@gmail.com>, <zhenglifeng1@huawei.com>,
        <xueshuai@linux.alibaba.com>, <rdunlap@infradead.org>,
        <david.laight.linux@gmail.com>, <broonie@kernel.org>,
        <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>, sashiko-bot@kernel.org
In-reply-to: <20260608082746.399BB1F00898@smtp.kernel.org>
Date: Mon, 15 Jun 2026 00:32:49 -0700
Message-ID: <87y0gg45su.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 4027c39a-3f33-4725-c0ee-08decab04e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LcK79zXZlneMk1LVFu7BM5RxM66g7dvINh8XJ1caPQL7fXF3vmEBnK8Szmhb5uwYyAMLgmzF2C9YuciZ0qGY37mfpMXYrTs33J5ptXAZxwoKx0GRM2Fi5PpfuvKxS6O3UPb9NB1dhZJjv3U+GuQ/dpdZR1bGnWEbdv2+YJoWCBVjnUVf3PJiDKVCHHpMVZQUeA/L1pLuGg6jVzRa3ZtW9A+eogVlSVn75Y2DTZCzd8Wn898uhMUOmxajvKJSQhEoWocFGaWmtcaSZFiWJExjTebtnJlw3GocT0qSBGb7C+wpoSJ0PDuXjmjlfpQRSglcW7PjbWqjWTvzvqKyqUwN8CtLhhW2x+dR7Uh2lWHagou78EllinctEC9Fysq+eZ0+HimypVDkFME/5E0K+OxJwECB/9EwYXGN4zbzpHUf0sgj2MWbE+xlSauS8bz6EjB4jYa+AXjE7JujLk3FLzBs3RSRfHc8ykMhhiIOsjaf+xMcBT+FOCpF+oOt2mGLAo/a+zB3XQfqXzc6yualpNU/9HToFfronGLaJg07jufzhklCNOZ4Y69ZzfS7JxvCDjeq77Rg0QYfoI+0ZH4JCuAgj5b/xycsXwvq9NFW+gvI/vJZ60weF4xCSiDuZXG/A5Fw8AiWbfbxIfb29ft0TTNoHRAqZR671PMzpKXC6lSbfVUIYupv+h6CqVdldR75Do9U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6o8+hCv5NXNuplsIThx697L2gzVcMU9SfejWprKT2dzoueRzYMQ+nve9gJfw?=
 =?us-ascii?Q?huTHZJSF9aP+sQ0QVaFV6jy364jm56a6hZj/C9fkcuR/Ts9O5ZcDsJkWHi7l?=
 =?us-ascii?Q?BnZ/GBuK0lgSr7G2JBskEBCrQbDa9qz1T/rmkFUeZJLhRhYZuEXTjq5yup1Y?=
 =?us-ascii?Q?/VeVty1IXN6XXmn17twwOJfIkfAZT8U6V8eLnvNlL/yPBDn359jz4QEky4PN?=
 =?us-ascii?Q?Yk1JQBWYWMWN/nR0kv2KTH7mO+dNU50lMzoFNgaJAe/P0MCtAnd2YY27jwcb?=
 =?us-ascii?Q?LfK+7+Uw4xJmgTyYSi/+KeohXkDc95/tanoy7sjiw1rh7vZzGhkoWDfUcTLa?=
 =?us-ascii?Q?dLp59KgbaLVmkSbec+8qTIdnkk7tS+tOUF0xGYK07afCvqS3oFerI+eePLwm?=
 =?us-ascii?Q?CvOl7Bnfej83PGUXjs8i/KBqPxVeTlEwPhZSZjOZkhigbW0kuX30Bx5ASKPu?=
 =?us-ascii?Q?LBV//rjA+7suBlIrE02D0Sd/fKzOwb5d3tP7yYKW2nnxwJWetP/+0RqXZCvT?=
 =?us-ascii?Q?ntq24K1bWtxQUNW3Roe68yDDpqilFi8xQsUTt0RIoZlGR7Jr1J9h+SrlRmbl?=
 =?us-ascii?Q?6JGkk+zMOSI9YQ1y1s9LjhEbg/gGwE9rUqc8wNJJknezJm9S7NM6DzEhPlgT?=
 =?us-ascii?Q?TzwRv9mUl6TOOvbbkLTTJpKOVBAEej/K23sZ0iwuMAfYGMDv+6SB/WDJxG+S?=
 =?us-ascii?Q?YkGchPXX+AsnMUW/W8AQVooLk6oHxWrHWbdvS8kDoFEB2CIJUpPfGWtk0xR4?=
 =?us-ascii?Q?sGnkFQYSO6GejajunKsZOmNn7EoinNdcS1aOELge+ldN4usOSfr/6logHm8L?=
 =?us-ascii?Q?XGjdB7cshW3XwPnRBHrerWuGHvDtF/LvScdj3SI8Ix31sts3WxOu5vTimfDx?=
 =?us-ascii?Q?FHKmVd8rIvttNJe+cElLxFK+SCjidcMABcxxeCytW8AYg9APCHluYqOMcp7o?=
 =?us-ascii?Q?m6b340n5KPTCng2GQTxMfVuH6GfOmzz4WkpBlAtbYX+NJe58zLZbYpUxihUh?=
 =?us-ascii?Q?jbqQ310n2dbE7IuwkeeRD7z3y8z/Otwj5tjCMKoPAy1R1yvKxTZDijnjttjd?=
 =?us-ascii?Q?qFTPuyLFjfFIHzhCVzTi4vJ+ZLJjpqUmhRnsRkwQWjmdj6GxmDTjKD1FKZ5Q?=
 =?us-ascii?Q?QGLDW1x3ICk6HB8dpD3frwSvRkFJXY0DPWEcdNy32aqyiRnSajhs/fSn5cM4?=
 =?us-ascii?Q?4mnUFt0zvG347RfaOzZ5k/UqeFnHWzOD1ZwhJsHzGyWrkDiADueIHY5Sg01H?=
 =?us-ascii?Q?3XkRJ8zc+bt8NWx+Kqjg+eNpN0vM7qeslQt6WKIpmH8KRj9gFiA66OQAVP/s?=
 =?us-ascii?Q?9YGCsdIAMexWTCJqxz4uWy90Hncu5GcXUoT1TBq0+FBRfiWkdcWHvAu+nAHA?=
 =?us-ascii?Q?ovif/6bfO4g3TfbUMafFO5sNinceopKErlqr3v8w2+Uv6zulK5Eo7VVInHsV?=
 =?us-ascii?Q?kOMW2JqvnsTyaUSq6CTUqy2WedaUPCvPkb0jc2Fk7zTRGxzUXyrCY/MnBfLy?=
 =?us-ascii?Q?7+x9w1br7gWjKe8Sj5yF7UIsDqSutAjJerAK+w8FotyFgPb+3x2stpSVy/ff?=
 =?us-ascii?Q?18jZcDlQloc4cHXktJu+i+06htU4zsnRgPZm7JPWkhB6wHexH6xIznkG/jIv?=
 =?us-ascii?Q?4vFNUpboxLtsxzb9yb4lLwnRulMhgtF0+8UPKc6ROMsp7g/OxKyDHyCURdAm?=
 =?us-ascii?Q?dZrV4fGHzvppln1rPvh79ZhlqE84qwdZwDGRbRrPRnWZJESWitthepsEM5iZ?=
 =?us-ascii?Q?C93D8ew2veMjshZ+Cxd/XDcSElu0MdY=3D?=
X-Exchange-RoutingPolicyChecked:
	YqCXp5YwhkYQgkCSmWiFbruBeTOh9/Q+Rq76ez95JJZW8jxidCB+K9P1UhNpoiK9hoHVM6q+yWWXEYL7hQLnyFVG7E6DnSgYJkMtiezV1LxYmDVwoA3xKyFL1s+17irzBA7xHFvU2wG0XjR7YSZCQfpa5AN5QvWLn0UNzEaUb45FmJtCu8JBPKTvGmkjb9jepX1JG6WU0+mIxN9ns7zyq0U3EKc1dhchWujgP2zUpgfXnWYBayBTrKKAOHAxPl/6fZHcMAi1dpxG2gUQ6WKHmw3xhl6rIMR6pFSA6P5BpGct0d6wXMrsCkNDxhkdDx+ZEvfjvUIVVjShpJW4DFXTlw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aIDFsaTS2S1Y/Q7ZhdMrufyFOG9XjL5+zOw2ZjEkW1QlmF7fWNhts5vtVoFrLj0tgAZ9Sz+VGhzfTzz0gkUzjNhIYZG7HnIYVDYgnwX3JizH0WD8zmVYnxt9UMa2v+PdJuFAD64MTGrrPe05MGnIbWoQAIJmSQML44JPRuphf8LhMA4D5aOYSmhnrrPZ5YvBw1xpTIdNWRHXG+vdpkGqXqIRtUsvboJ/y7HDSm0nOgzou7mkMm+bEXGRGRAQ7sMBms7Gb3NC6+GPSzdx+knam7nZfLjOvkILK1/SO8DWB75pitT+XNEp9MCfmfC+2Wk46dzaJsxNoen8yVgMJaEjpYrIqZlerkPO+Cxq8X9LkZw9k2YrITrramtViegIspA2HA5ydCNtto6KYEwILZaMLVe3FqeF2xkmmgBniKVxr4dYg4mqcDf1wnwFgMQARhX0hrIR0GN8Dxo0YzumBkOxAPEqZoAtCPM89vaQR3ZdlQjBkToBxlfMo5x1425gNUUQ6x8Rdec4Fz45VzLEH7LFE+kpBSSzO4WW2+jn+0uQeF1RjIuWlyGGfzJTe5q9WW4ezeV990C/ClRnow4nuICpw1h4OMv704wd0Y4+gKHzwbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4027c39a-3f33-4725-c0ee-08decab04e54
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:32:51.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6Sf4nHoyg6ZzPcmWDblccEMne+XWO2h0C+4xAP332wTAz/Mlr5ymlIYswlWeu7sJrGmlmGn0gHOl9WXMbh6Z7c3KElgXMPtt2/VIo287uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606150077
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NyBTYWx0ZWRfX89bM/amXGp3L
 IVz8blfEOEleZ//pMQOKbmrRhuNqEsfTx10XRq2HLrcQ2sAtWU9fVjmWU3mfJA9+sWtFbr0z9Qv
 bTtF3aJ2GxNTPdZrfWBnKo0uH+9VuW/JvRP288PZNuFyX6CiJWFr
X-Proofpoint-GUID: yrzfPP7QSO96mYxa6q7OFNIGY3oxMEqB
X-Proofpoint-ORIG-GUID: yrzfPP7QSO96mYxa6q7OFNIGY3oxMEqB
X-Authority-Analysis: v=2.4 cv=PazPQChd c=1 sm=1 tr=0 ts=6a2faadf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=6IYHg3olf8674uknDZcA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NyBTYWx0ZWRfX9fvc2SPvOnZ4
 LWAD6WzH9ecHYBWaPDHcLdJoqLOZtFU5TgMDrteP3+BwebIj7QAFYYsjxoXHgBQKAT3as/ejrOI
 wBWuH4DOy5YUT+R+gA3bJjHiGV0qA+9J4luyu9tgtgl0E90qdZdTg4VSvs5vDzXGRNGTneK7VTM
 mgyhHF8/t9P+ktwTWFIoajjZEmoLmyHUgW8jGOUJ4t9ozhXWWmUkO+0yw6Fbg2JhyZC7k7amiC8
 KbXoeKfRFwdd5/d/jujJjOA9NlQerLOha1pXEdd3MDuZg4MMcoaiPUtRKpPcSA78CD/y9VmG7KZ
 A5uWDigwx9zzddXyZMnM/owGibJhczlnRCvqrqym3rt3XANw0w6dqAUyFKOqaMAyEoNsBs+sIQg
 id4tOi1n7CagKItcMgte5MijAXGeuNTOcYcnMaQdQrUoNXtNTQMRuY+WuACBsBDYCbz0mMHX8bv
 3hwWrogQVPCCQRU5Cea/qw0SQjs2200N2zmHPP9w=


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ACQUIRE semantics violation in `smp_cond_load_acquire_timeout()` on weakly-ordered architectures.
> --
>
> commit 0c67207964772b92d28f5af7e4a97ea44a103e9b
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>
> This commit adds the acquire variant of smp_cond_load_relaxed_timeout().
> It attempts to provide acquire ordering by reusing the relaxed variant and
> adding a control dependency combined with smp_acquire__after_ctrl_dep().
>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index c56df9513a084..0ab26e98842c0 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>
> [ ... ]
>
>> +/**
>> + * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
>> + * until a timeout expires.
>> + * @ptr: pointer to the variable to wait on.
>> + * @cond_expr: boolean expression to wait for.
>> + * @time_expr_ns: monotonic expression that evaluates to time in ns or,
>> + *  on failure, returns a negative value.
>> + * @timeout_ns: timeout value in ns
>> + * (Both of the above are assumed to be compatible with s64.)
>> + *
>> + * Equivalent to using smp_cond_load_acquire() on the condition variable with
>> + * a timeout.
>> + */
>> +#ifndef smp_cond_load_acquire_timeout
>> +#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns)		\
>> +({									\
>> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
>> +	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
>> +					     time_expr_ns,		\
>> +					     timeout_ns);		\
>> +	if (cond_expr)							\
>> +		barrier();						\
>> +	smp_acquire__after_ctrl_dep();					\
>
> [Severity: High]
> Does this sequence correctly establish a control dependency for the caller's
> subsequent instructions?
>
> According to Documentation/memory-barriers.txt, control dependencies only
> apply to stores executed strictly within the conditional clauses (the true
> or false branches), not to code following the if statement. Since the
> caller's subsequent stores reside outside this conditional block, they
> appear unconditional to the CPU.

Yes, this is a problem. One way to fix this would be to add a full
acquire barrier in the failure path:

	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,
					     time_expr_ns,
					     timeout_ns);
	if (!cond_expr)
		VAL = smp_load_acquire();
	else
                smp_acquire__after_ctrl_dep();
        (typeof(*(ptr)))VAL;

However, this seems like overkill since there are likely few situations
where we need an acquire barrier on the failure path.

AFAICT rqspinlock doesn't seem to need one.

Unless someone has an objection that's what I plan to do.

Ankur

> Furthermore, smp_acquire__after_ctrl_dep() typically falls back to
> smp_rmb(). On weakly-ordered architectures like RISC-V, where smp_rmb() is
> implemented as "fence r, r" and only enforces load-to-load ordering, could
> the CPU speculatively execute subsequent stores before the final load of VAL
> completes?
>
> Could this violate the expected acquire semantics if the caller relies on
> the barrier in the timeout or failure path?
>
>> +	(typeof(*(ptr)))VAL;						\
>> +})
>> +#endif


--
ankur
