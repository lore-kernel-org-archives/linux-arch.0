Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75C426D13;
	Fri, 16 Oct 2026 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134618; cv=fail; b=Em7BvvIjow6OkxP88YJYtiEVfGrKTYM9smgFhDaGBr8dWQs5Je+9ra9GCfHv+domarrf0mQn3kuscNIAC3VV9U4vTdBrU9Xr/aleaXXBt48hNt/lrL6iJYg0gIUn+Lz8mhjYxaH/PDMZw0yZCE9gkLQKg4krggNPXlD7a1FeKOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134618; c=relaxed/simple;
	bh=xEYopAPhGFEU+XTUvW1dfwLISPgT3Jv/TtuPHSw+uaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IE6oeGw3tja9MDuCo7Ova/vqK6JBNd7XfAdH4QpvAoS0Ro2rrx/6FhFqLEuL4SD/D2uffp6hGtEBC98iWMjsAT0Y7GXQermrJpK67HhbpwhZ3ZHCcYtWUgwPubvQG7LN+a1WXLys5X8B9PiI+ubgSBItOlF1zsQjknavu/xvKjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ly+JYpxA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jM6rJFtJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ly+JYpxA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jM6rJFtJ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6nRE3989691;
	Fri, 16 Oct 2026 07:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dxN7zk8orL4yoyP5oP6XPcoSLnn7dwJxIQND6CcmPkc=; b=
	Ly+JYpxANI4ntzK+IXvma9NCoZrzw28vlSYz35iVceuhFOLMj0mGe/5iDaKuQxhm
	cIPAJYGQXPUhmRUIM0I3smcVzQ/ikD4pDZVmHBKOGWKTThCWPsgQui8dIoWhptRD
	JQI+hcvVDdExI0j/bTcgqFS9bxl43RSvCNdsHV4znBV4zTFW+9JiaMinVTXO4DQr
	j0LJdBw3gIe4lNum9hlhDeAcBg9RlsFMN1DXbOg960pWsxuUO+YRVPa1oLU/9hP1
	0glTzxjtRqagjMpiesxHrfla63L1XRg9tWP0nPpOV7jHOChOVYoB2bxD4pamJJlh
	ktiJR9078qkK00pRud38FA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ha5vgktyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76MvO004365;
	Fri, 16 Oct 2026 07:09:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btcty0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+7GK7VhruwIDiQRMG1lGkWGnt8s92xL7hF/DUipTONBOPXlpKw/PD7JJA+ach/B1w/lYJ8hDU0+s1hpNuYilwmxIVhWVTgOWRzOlkJHYJYJfriqz2tRh5xoOv1jJy2oYgIHWzdIu12oWij2WonVLy1cfL0C3bf0CgPbN6d58Yi/AAk6de01GPRF+1yZuwkvC4t5MgiPt6MIjry8iJ6MHlkJn3qw+RBymQcglEOpMR6TFF4yun44IzDt0zRFai+eDnixtQoX65RiRqLxMxmYUYITN2gBaxOMnE6fwvDXny+4UU0X/jZgUndzdjSu/hMEJWm1qkBp/DZwl0FD1Kipuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxN7zk8orL4yoyP5oP6XPcoSLnn7dwJxIQND6CcmPkc=;
 b=wdWgvb5r1Of4DlwZNszSZ97bqF4arMFoyBlkcBu3FjN6zaakacuui0rzhsqh9efbyCW3DGB89B5JF9nFpR/8euZUR1pXcE8WYvCAIjbL788ZnEEmNU0vSkT+LcY8bRmW1BCazH8rpzjM6egCrKolGgH9T/wVSiBYtF47o4fsMxQGJEmTF1GGWKLARdjZxKrfj3MO40NJk7xm2Hf0P6yKOekZEbxSOzLcWOrV58nL0l1mLJaF3Qhfkrs/FYY3cWRFnxLES/NoXiZ9QeGvqOuMd93cyQcDe7QMgKyQm6fPki25yI1W/iRp6wvwM3wSE+0rNiCKaapZiVoS6yk7LfeNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxN7zk8orL4yoyP5oP6XPcoSLnn7dwJxIQND6CcmPkc=;
 b=jM6rJFtJ2DP2S6Lrfxq7SJWjFcA5Jy7Qr0xjmDRiLwaFWY9nVkmAMgpJ6GgtIPbo4Jc+CwoARSr79Ke94qa014U5P+ch8hiDtw/O2ll0w/PIovuW4NJvOx1m+Hh61UHFIkahr5gwlBrPlvzjDUnIovmN9C81j1CmKq1fBIG2Do4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:39 +0000
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
Subject: [PATCH v16 15/16] barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
Date: Fri, 16 Oct 2026 00:08:36 -0700
Message-Id: <20261016070837.440748-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:303:8e::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 821ac20d-b01b-499f-b731-08df2b54719b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6qD+IkVjwhwvvcuAi4RAY9zjWpLF2MnToO2Mix+rHYKR7FLOy6tDz7FiBx8/yz1M1NbeQ3JD4X5D1OoJFi89KzaUej+5OVbpQ4AanqXssLq8k356VgSawdD3kAYIm9Am4WtT/57MRmYbScS4Bp2B6tmN5mQN3JxpkFwIKAFgFNf2+vThy/titbP6DG83VNMb8EKRiPHnZ9LLyVITE9Z71IxB4YSXOXRRJwo3YCmjvCRkmAXTKeO6C3H+5AP4OilaDvY2VGPIgjOytj/MyY9pZZW8+0NXAkOmnqmyx/xcK1hjhYSBwslEf2NkbiWLFEctAiO/OQj4kP2minSnS5Eom5LpHFMBMf0Z8tefMO5/5sifaITx1DQKUP+eLpvHf5e5kwJKBvmVMhbxGNFu7eWuriKzwCaqdQ76yKSZiyARWmyGdr4Yd6aNJRjvUxbj1nO7nnbiHqE9fjWjdcH4ZmcxBKGji40rPL4cPwY41D4ejKpMUNksCNQK2Lkf8TGqP9oaQ3buDcTRAgesPbYG9owdtuqu/NOYHfqdPhBkgqse1DcfPZpxySJv6g/ASAm3IQf7HfwR6u4O8OdUijre2wEY00Cj2UJsShavLfcjxhgOLQxp52YG+3anBK8ybYaQ3XkKSb3MdeNbf6xRacmF2WZfFa82AVymOCue3ewLWX7/GLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/OiQOHZ17zObFEuiX5HN1p7pEuO7XU4oWEKb1AC018kmXrooxKQRP2sn9Qqq?=
 =?us-ascii?Q?8E1m0XTn2op10qxT2nY1Mg0J2yNr5rRw63vTroRRkvic+mcN4AhAqyfKMLn8?=
 =?us-ascii?Q?Tq82Gcnw4IrJM50wcRBr5nneaI4M39jfPiMzZ/S/F6YTqu4c6VFhnMwlm4sL?=
 =?us-ascii?Q?J2AELpbqQTy5jlIZFh6CNO4IDlSh8WhOK+vMQEmugRKMcaGDHSoARvqv4lI2?=
 =?us-ascii?Q?OYb+plLBTmR/uYtRWpQSIu6zfjWylPU92dlDRytE3XYHOwGW8eV6u37TXQ+Y?=
 =?us-ascii?Q?og8Da7azuKRIMREPfrUY8D6oi9GszbAMbGQ0JCWAu73Cow12gqo4KcJzyEw6?=
 =?us-ascii?Q?aFuARAFvclkIbDe6+T6aYKleFfQtOs3CZDQCxtCrIaRGm0wlaYFYXBw2aPOX?=
 =?us-ascii?Q?+RaXhKxkYT6v8dXmPrBI55hPQlKWnZwXTP6UyI22MU1e2E0hB2metbHO9HIB?=
 =?us-ascii?Q?QSUCCIw3Zy+9Ffv+PiyAtOsTDRe6ta73N2HRmpcULzSlyV8Y1hpC9W1N5LHK?=
 =?us-ascii?Q?9W9ygvGyHUmbGsFtyKjSanXrefDuk234e0D8GX6/z7mRP3ZtYisYdQtKQo3b?=
 =?us-ascii?Q?RXO8oUNMP4TNWkDK3ZjYF8TfcIjI2BiEMWPAtoLgbKlR5Dh0td9OzBwJLYlY?=
 =?us-ascii?Q?LhrP+vgUX1jR6WrWPoZp2tPXb/6pACFbeIn2Hn1xTuWFszjXnPI0vsOmDljg?=
 =?us-ascii?Q?ydPR++S9jBwVYhQQl+WK6u3GXGfLa/+CqF6XLiIqu4+frDlZUsdBnNu4hXm6?=
 =?us-ascii?Q?wJ+jABu2+AhfHPulsMCx33oWqRBfIQQ10tyavYlqJD680peQkuN/Z6eA+Gy7?=
 =?us-ascii?Q?0mbvVho5GcxxYqQ1k0lOwY4eKpGKQZFlsCX7Rvbwa83UOGXTCyozAosQRH/d?=
 =?us-ascii?Q?cGeWX4HwoxcvzhQ+Tu0HJlNmqJryZmacTmR2QPWrJvu+EFwmdxg/h3KwrgUW?=
 =?us-ascii?Q?kRD+fiXojgwk7f9XwinoblOl0KWOj6f1JTwx4BjOVwsQgfOhXkcZm6o65/85?=
 =?us-ascii?Q?GosEJ7cpNTCVLOBbM45uNzEk4yWNQP7TW1Ik8FCNZf26U/MJ3WgKqmXBghVP?=
 =?us-ascii?Q?/S2QJ5+UxkBxeOtcG3ovfkb7bC3w3i8bShKFz2sp1Wq6hIlCQX+X21rMamci?=
 =?us-ascii?Q?Ke/Ze6SRngYKsurcubqAPEAVQg9PMZ/vHFeEFSoJIDvKPSBPAz67RlAuocBp?=
 =?us-ascii?Q?vH2++6sDuk4zW7ljCYUXLw2my4qrGnM0NG6itGZCUu1IVJygIJlSKLfC4jRz?=
 =?us-ascii?Q?JyqdPJgxgtfXiLOeNNeH7TKhx6Yxd8XTUk/O47Yx1llnLbGU8hw6GgF683/N?=
 =?us-ascii?Q?8AV/jhYo4MK+5LNe6VE2/T8u6ftHHvZ1RsDM3BJpPyX+3iNsOOe8VIQSA8B0?=
 =?us-ascii?Q?wVbtahVBhAswjzzAg+ilgY6M+wipycVBa90XsvsnKdIgErSWLb9+TuMbrV/Y?=
 =?us-ascii?Q?fmBR+a8oSnXMbWJAd4FKGIBgNUHgI7FjAt6LHHE6i8L57fXnzGtfu8KCxRBa?=
 =?us-ascii?Q?RlIlnoSgnFo9702IptIx1IpmvYFAx/KVHJxCRKGShlyMbbWgpUx2q+JJvjno?=
 =?us-ascii?Q?9IZFzP1Qa2XGZSxDx+DlhqCfd4WqNOmDCR8ovFjoQUgcamq6obJoa/snZmf1?=
 =?us-ascii?Q?QaDPi85jTghJgKMQ/N/iF6QP21bWLCxs8bZWnNc7+KOoiVoLNHDV1A8ho0tB?=
 =?us-ascii?Q?zLJaO2L08DswLUMbYFAQGzvZLZsHN8zYJRIw7j0W34nzaoSfv5toRCVAsREu?=
 =?us-ascii?Q?cSfljuN1EgJlGKeFgEVoRyToWbpQm7g=3D?=
X-Exchange-RoutingPolicyChecked:
	v0qhaDb3ViacJWzXW42kLapFNyUy7a3e/+R5v3rVdK+hlVASeGTBtT2jDL9ngZqgXfNGlcjs5M07p9CP5/wBl9MjtzYvt1BeysbokHWmas508K5f4dfOzZXXHYkso762RWlxG9e9x0tgZz8nX7vIpK90uSkKEJxyb+WmpGbBvwGqqTBlwZO2GHLnGvcqiCQSRZ+zWcxwOFAJbg9oDxD5UduBvXMHf2tUwkp7pXrau0490Y/thCXHuw912XlPLjFoAXcAY+21/AqLQbuq5d+flBNDmQI3hhPoIqM5SAdAu1aQJtrWSUdH9NrkAmrcNH83P/VFYlgoSDO0rUliYFrhcQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y2APyptVlFqTd8zdVH/xuwnMI6ZF/bz79yE0ZmK5KEaymXK3DFoDcv8H3Ej8cQLGjC6ZTXjL1zWlL0n7H+aAUxqLkRRzm6xLwZovymK0cJyPH/nVvMEYoeVvnFQaAjkfZP8p0zDlg+6GfgWAobxzch4oYRQOFjgqHU45X9I7HV3vzRbM1iPm8bR4fDY+d91T+gzl3xh8TbzrZNyUfQIjslQZe4sf4m1UIYYadetWwWtXRxKzo5PQ8/tQDzUNtpb4udkpMUzOL4wEWJ+ZffB5aYeAOxrmvchHEf6xfsg9XHjWyrdpJXFiVpUKnT+zn8wskbXAuIwHAmoIKCjmyPHmS3XSC575WDBQcF/lrKeP+bHKEHlvWxhLLgSHed4jx4iEMwlggOyTT85JpBDRZw1E/d0xSUpf/mP8tULDnF0PrBPS835TDSMsNPHn0VQHQrjivrRCVU2mZkk6gvVUkjvuK15LiEVIrnZLBBZLXSklqoYPjZk1GIevkW5S5DAh8KrTQlT/7VwrsAJgSUrDzOe/rGQYOAxM/gBubEPDHRCnrF9p3yU6VrseToCYPH7KFqRhGFDWWeqWBKF3zimwx09qI8SadU4IRUbUixpNIlbHpBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821ac20d-b01b-499f-b731-08df2b54719b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:39.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFRQl82bOFom9E0Eq6Ec/73/w0TsnKLhwdLUgV5jupaD358xd7m9tVuziepTgmFupI6+pKitEj9BUT3uKTWpau6MxUeXflvurmmMP1Gjbfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX4SC/3GgCYH3F
 j8DZZ5kEOOjlXufVQ8lp4tT+XAUYfAEQPooet8Lf96pQCElkenCnp0jYD3hfK24RmfteG8hPbIG
 DtYzTwP4TXKggQii/tox+WUs90Z3xtp/YqOAQHjBsHLx9san0WEyGRDWszh3tF0cOEBV2PJ1b/F
 OAygayw71eIlnQmNwiqssTywkVxjKq3Z2VCM8LoZYa7q1cKgkwjskKDhccvWn8CaOtj+LA2X9WB
 DOzK1ZU3/8RwBPDrDxRIDijAvRQV4CybVZImjpDj5junzHwXRl9Irk4MMmhVaV3wfAfg7Ss3FxR
 nmmVWu2w/YDzG1wS2aigwSSxXGJlfeSIzdFcd0BCBsjKRjEmOXYfGLoy/uuzfssP5EBRS393Sm1
 cnjdxewjvR6qfYdRT2k0Ly8xAH+k7LSeh/wkUI7aSZpH1nNN/JO3av5o1lA1iw0aPXl5S6UDypG
 ZP7Id7G/ry+KOJBd88A==
X-Authority-Analysis: v=2.4 cv=OtvaWC/t c=1 sm=1 tr=0 ts=6ad1cdb9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=gJxQClgCQG0ChMIF28IA:9
X-Proofpoint-ORIG-GUID: pxvgESody9OAmIBo-80sUti0BhhCDaXW
X-Proofpoint-GUID: pxvgESody9OAmIBo-80sUti0BhhCDaXW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX4tcftXJZ8Zgd
 VHPnTylDb6zoCSiTzmD3Py932oT2JEvW+5HWmyk3uSEEEJ+/obMhVKGTdUbETzY2D/ad4TRN0w/
 Z5kBO3FtEnc2QjMRRegxugfnO5Pql/tmr+utdGrJLfcUqecrkkxn

Add timeout tests for smp_cond_load_relaxed_timeout().  These check
that the implementation returns early on invalid timeout values and
handles edge cases sanely.

Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier-timeout-test.c | 112 +++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 9c12cd36e7d2..88b374ceb78b 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -19,6 +19,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 struct clock_state {
 	s64	start_time;
 	s64	end_time;
+	s64	extra;
+	u32	niters;
 };
 
 #define TIMEOUT_MSEC	2
@@ -113,8 +115,118 @@ static void test_smp_cond_timeout(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
 }
 
+static s64 synthetic_clock(struct clock_state *clk)
+{
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	return clk->end_time;
+}
+
+struct smp_cond_expiry_params {
+	char	*desc;
+	u64	timeout_ns;
+	s64	clk_unit;
+	s64	miniters;
+	s64	maxiters;
+};
+
+static const struct smp_cond_expiry_params expiry_params_list[] = {
+	/* timeout_ns is invalid/out-of-range */
+	{ .clk_unit = 0, .timeout_ns = -1LL,	.miniters = -1, .maxiters = 0, .desc = "invalid (-1LL)", },
+	{ .clk_unit = 0, .timeout_ns = ~0ULL,	.miniters = -1, .maxiters = 0, .desc = "invalid (~0ULL)", },
+	{ .clk_unit = 0, .timeout_ns = S64_MAX+1ULL, .miniters = -1, .maxiters = 0, .desc = "out-of-range (S64_MAX+1)", },
+	{ .clk_unit = 0, .timeout_ns = U64_MAX,	.miniters = -1, .maxiters = 0, .desc = "out-of-range (U64_MAX)", },
+	{ .clk_unit = 0, .timeout_ns = 0,	.miniters = -1, .maxiters = 1, .desc = "degenerate (0)",    },
+
+	/* timeout_ns is valid */
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = 1,		    .miniters = 1,	      .maxiters = -1, .desc = "1",    },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 30), .miniters = 1 << (30-28), .maxiters = -1, .desc = "1<<30",   },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = S32_MAX,	    .miniters = 1 << (31-28), .maxiters = -1, .desc = "S32_MAX", },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = U32_MAX,	    .miniters = 1 << (32-28), .maxiters = -1, .desc = "U32_MAX", },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 33), .miniters = 1 << (33-28), .maxiters = -1, .desc = "1<<33",   },
+};
+
+static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
+{
+	char iters[32] = "";
+
+	if (p->miniters != -1)
+		snprintf(iters, 32, ">= %llx", (u64)p->miniters);
+	else if (p->maxiters != -1)
+		snprintf(iters, 32, "%s %llx", p->maxiters == 0 ? "==" : "<=", (u64)p->maxiters);
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "smp_cond_*_timeout: clock=%s,  timeout=%s, iterations %s",
+		 "synthetic", p->desc, iters);
+}
+
+static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
+{
+#ifdef CONFIG_ARM64
+
+	/*
+	 * WFXT waits for the full p->timeout_ns so limit it to a reasonable
+	 * duration.
+	 */
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT) &&
+	    p->timeout_ns >= NSEC_PER_SEC) {
+
+		return "runtime duration too long";
+	}
+#endif
+	return NULL;
+}
+
+static void test_smp_cond_relaxed(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_unit,
+		.niters = 0,
+	};
+	unsigned int result;
+	s64 runtime;
+	char *reason;
+
+	reason = expiry_skip_test(p);
+	if (reason)
+		kunit_skip(test, "%s", reason);
+
+	scu_flag = 0;
+
+	preempt_disable();
+	result = smp_cond_load_relaxed_timeout(&scu_flag,
+						0,
+						synthetic_clock(&clk),
+						p->timeout_ns);
+	preempt_enable();
+
+	runtime = (u64)clk.end_time - (u64)clk.start_time;
+
+	KUNIT_EXPECT_EQ(test, result, scu_flag);
+	/*
+	 * Check if we do the expected number of iterations.
+	 */
+	if (p->miniters != -1)
+		KUNIT_EXPECT_GE(test, clk.niters, p->miniters);
+	if (p->maxiters != -1)
+		KUNIT_EXPECT_LE(test, clk.niters, p->maxiters);
+
+	/*
+	 * maxiters == 0 means that the timeout is invalid/out-of-range.
+	 * When not, we cannot return with runtime < timeout_ns.
+	 */
+	if (p->maxiters != 0)
+		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_relaxed, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

