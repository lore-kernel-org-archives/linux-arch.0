Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8533B19B3;
	Fri, 16 Oct 2026 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134608; cv=fail; b=VpZ0TPdCX4F+UiOe28qzXjVmhFtnZGhwwJM2uOCYvKmAEA5r73rfJ9P81PkIpYwgI370/vSEgV5xGen6LV5g0260bPF9JZlk9qPobvEN1gI4csiIfiUsFKxFwsd8d32tQksJpL41vWV/vlmtoBoyWvFD5ef+bupUgK9xhgvxWAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134608; c=relaxed/simple;
	bh=CA29YUlmMvIGzsiX+RSlm0TtAP8S4HAFVjUwJadCmx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1uu/qR505hsVK05fIuf+VEiIprKEVGeNvq9R2LFo7tEJLlArCy3jk5lOK/KLYdr3Q+UpMOua33L1lpap3bNVc3b8teZCSSi+mw0XYTBbLfLixrYoBkXTCjpHT7MVxtTCsFoJSKlF3WP0AMPolNXoraXYfrpKmkdVAPwHS0Tz0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CfW2rhAe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XRYQVvHB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CfW2rhAe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XRYQVvHB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN7T7w2718030;
	Fri, 16 Oct 2026 07:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zPDLzDJoIVyTaGCxWeLP4qaYVSTHR1bgfuAE5f9O25M=; b=
	CfW2rhAesM/yCT3RXbimM/AagCMtVwo13D/MElnMOnzdv166fwYOJtZKM7YBSJ6y
	za0YW8jutDKCo0aShPkGKy1pS5gFcP2Ej48sVdd2UeCU8i+9oKmikg/jSPRCT4at
	yRJc3eC/GwgJx/tMBsExfGYQZwHK1373lsNrEiGP4IYaEh7yzHfWmJppAGhtad+4
	zRbzWGUYfVpyAg66E77ztlqooAUXvjDU071KsinBZV7m+iKz6WcHaxOPpaX9H7Lf
	Hu3BUDUdFHReJR4a3OIYL7rrb8BWBD9Np63MtsSwGO0HLmzAJ8HVmaIgyy4FvugS
	iNjLoMg1rDVzBz3iJa0LfQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbksewr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76k89014480;
	Fri, 16 Oct 2026 07:09:31 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btt1w3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2tdWA6xtdg+t6knPL9aGDAwqc5K4fQzgOkwIOuekpBx/8fMg3KdxcwNG2YrpTZ6WCZe1B2JRCujvyuPf00oGAfpk3x3TkfNn9VeaCHIhMmREE1U208kLarCNLczyY1OpwLNrC8zF6MRvZRtXymhsMxPVIj26NeGSddOIFvTUI30/0jAUgQfcKF6IVh9VBpNvFZtDgAJLWU22iZTqj1mfh0PzuFRSREJDczeTVNHQHQV8ZoTU2vXitK8IexHBmUOiLfVUituVYio/SCrqxWVUNNXyhVOVl5r69ablDdfHLOWVnM7SuFYH4cwqdXLXq889P/4CFfFaKOgHAa9mFmysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPDLzDJoIVyTaGCxWeLP4qaYVSTHR1bgfuAE5f9O25M=;
 b=qoFG0R63kVwuXgItj4ZADzxvO+N1TTX7TL4UYJnvRl9QSqDakU6wH+gCKWL5MfezjboutUhIl0Ld5jjRGGGTXv03TmJ2w1ftXB8CP69gaW3a3Dnhe7KILKV4YJticlIstNURo99BhgFkxbFB0Wm7OehnW9DNhuPF4BX/uxdeWfw+NOh49JeeCeLAz/ZcrJlYiHApQ0F5oZVd4eEoGRHbAzErXjHdDxWZmdz7f3xAu34T91eHi1Caz22OgrUPzUZqUNhyStCuhvOidJPeXvA5YRr8MmAf14C8Vf/YoexSt9nfjbbD0eMjxnXtZVoEWj3+WXg0zhSkw1fI+YsfhA3/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPDLzDJoIVyTaGCxWeLP4qaYVSTHR1bgfuAE5f9O25M=;
 b=XRYQVvHBR2GmKYcUbfEvjqX+CDEnxdvF7QTCWQeTNh1TxvWL6lzVnHpMkyiW/hOlY45Sq8wjJXezTCsDy5Xerd5GRZHZBUU8R9RnwjXuInxK9S+lHX5Y5FcrRsrJB1G6Oy/Cg8//J8c4np/AEcluRYdJEGHOkeRN680qMqG5U+k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:23 +0000
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
Subject: [PATCH v16 10/16] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Fri, 16 Oct 2026 00:08:31 -0700
Message-Id: <20261016070837.440748-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: b52ead79-4679-4975-ef14-08df2b5467f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|5023799004|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	x4TGFNhn7DdjKZ9fHNC+40HBecrKag50o7ffPP3rcIWCL/k9/kesl+JR/1gEZ/7acvJI+IZ/9r0WeSE7JPYfRDMvganQeZs3cwTUM2p6MRrOeRIOPHJ3p7rOLqd4jZcAYXZzMjsPw/F7zQ5JT+KkPr60ghzSHabZdQm90EEgC7XrqJtcwqvGU4qr+IQqVmBI7NV2fm9dsutiSYMAjvfNSG8EUE55HpcNlPR+LAysK3OT5ve/QMC4uu5kpQrgrhZ4D/lIQBy2VNA7l+BipzVaZzpPgl1MjTWqNfwlBjmADbXcpZaOgBKVRHDKSA6bmQ8Wjsb3wi1s2cGZeJewUJ9E4A2rsbLZMP8Pc1oQnTUk6c60aUw70ZZYQk3NdCR2XggbAjeVuLSk9MPx4Cz9wq0klGfpvrfHOYv2fLIsY7ufiwQzjut6Pj5IJf24XCYqDj5ZkjXqKRnhFaveeq1uuh6rnyqxA0Ezqqw87wlMfoTLbBOcyETSAVeLnB8Y+ToYJysER3QmFJzvZHCyuh9FNq/a6bW6rkkAywO7EkYfE/Y70r3i17YPco4h3S+oZ0NLBVNzEsA+vrbGx5b5eQtq5rQcGHHcmy5c+cndFDiJR57dUkmkbG24Az1CHyzCV5BD3oO3iUEJBkk89MszPJmYeZh3z+P1M6Ti8DOwFG4mJPxxZVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(5023799004)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AMWEghhOLn4FoxpF+/f3Mpq6iEIFflDLurJS9ZCml2t/PLY7UqTlKkoZpGNf?=
 =?us-ascii?Q?0D+WqIji/9/bCE+HUct3TaYkrBcL5HSdbwqxhWe4q1RTq7yiqU3uPVfMpgFp?=
 =?us-ascii?Q?o6ygAGm2BBkHMBl3a1PbCTPHJy9EcpnU7ZUoVcLdqlPpd3ClRphxdglm3UPW?=
 =?us-ascii?Q?supo6vRt5ghydcx5TTBnOHa1ts9fWTGFe7D69Nopo21jfwMaOPRR1stI1Pax?=
 =?us-ascii?Q?X5vf+Nfp8m0izripVwuRQBQA2H7hxWashBhn24O9QQ6XgorKM28CI7VlIbLW?=
 =?us-ascii?Q?pznq44N5fn8rGRxcq30+OHxtyoeDZESbVdGAWpapJW3mt+WMQ36erU36vkRj?=
 =?us-ascii?Q?Xj4PDuD132kPINP3X5fSHslBueahcKznnz+CZjckCOfmHIpiyBJVP4TO6z5y?=
 =?us-ascii?Q?S9ORXKbhgHGmM0NSJ4d7w39oSNt9rSkfFwhot7JjNZ3+k9j7vuAsy/iwxVBC?=
 =?us-ascii?Q?W68P40Dlv+TsZTZMB4yoj8RxNzKkRy8BnnwDZ9oZI2huUxaxA3VG3l2jMvQC?=
 =?us-ascii?Q?j/L5I2HSQBAlnHoh//RLGguzAOG5IgdS81tyiUn6JbNn7hOnR915jMuoE3RH?=
 =?us-ascii?Q?h1/oJQFIgeqZwnERu2ntJjs0Ug1hxeQKgkOdwW3fBD8zeKX3aGE30Haz864d?=
 =?us-ascii?Q?qdzy1bt4YROWJFI9CnvUr1GqHX33qnqFsG/nMDuhCkXxbLauIBJxmiWg86KL?=
 =?us-ascii?Q?mGNxkgHfNrA8SP8J+yF/2BjWWr3j2WvPRzvfRLxW6g2taSA+1t4ghYUZyLqq?=
 =?us-ascii?Q?E+2E19jVTecQfy2yq9yhKRCqcLsHCG2B04gIE4PLC1wWhj8d2UkM2qAPsAFC?=
 =?us-ascii?Q?lWMWao34RSlebe12WI5zYrOene9jgpJroF+Dv6ekwE2Sx3e5DMN2kXgHbfzo?=
 =?us-ascii?Q?UY71pJQJ42shM5pvNAUJMpBa2FCMQPCgJwQL1OD15Xu1kvoqWfOma6B8zqXf?=
 =?us-ascii?Q?WPunrr7eIj7GRWZMYWG1R8nDBPR7Wx4a7xhB3uP31VII1BmhcHSTUpSfcy3n?=
 =?us-ascii?Q?oTmWRrpF/mzz926VFyKK+nDNFwVMBi1bcS6+NLrxTQp8AX/jDedcU+00eG+P?=
 =?us-ascii?Q?OaEOMFz9bJNNKDqCQ1jTESn5wxcET2HNZO9h2DBdySUUY04oRlOViqCD60yI?=
 =?us-ascii?Q?UqcYBlvwGh+ABKwlen4sO2dDXGNr/eGXiMoEebtTP692/jGQ9k7Br5RsI4vM?=
 =?us-ascii?Q?awsNHeYI2+tzWnzMiKVyyTJVW00a9waYp65Ry2z4HSOcK3MscwPIVt7uxFEp?=
 =?us-ascii?Q?sNS80wtMlambzWVtM6/J8/ai34gtyB/lI+zWtqqTa/m2QynXCgTWc0gpw48H?=
 =?us-ascii?Q?ws+lQbTryAsKh2S05kT5mQdNG+TaspcT3RFP+VvrX7e/YLR/ez62/Py+bxWd?=
 =?us-ascii?Q?b2w/kzX/+f0+wnyuBGXjFx7dk7mvquVMOfu0q+sSGpofpMBPPpAEShrdXYCx?=
 =?us-ascii?Q?9pJ6KDkNkDOP5W8X0OGr8C/a/1o/ReFKNOhp19aveM9sjTDuCBuEOAwnNytj?=
 =?us-ascii?Q?IJaZJ1uvrDdvdoIoLdBDNj3ryPmjFuZ6sr4XsKJ+ecjhXVqeZ50L5NHRImEZ?=
 =?us-ascii?Q?1P+MVCVW5heOQRUtthM7amPN6RuDh4iP/yGT9wmVD/D0fRd/VSRbPX1Io52D?=
 =?us-ascii?Q?v/72yTmoxTSi8z1gZAbOrlJjRybbLprLrwQrJF3plgPgJm0bclJrfc+5fmHH?=
 =?us-ascii?Q?I/yBQ3FP95Dz0cXJ6OzfrwW+aggcwJp09gRsQ3uTxddKwNPl5kYTC4g3sm6s?=
 =?us-ascii?Q?AZ1xmC0AHO+QrDXv3+6EKnH853dpMqg=3D?=
X-Exchange-RoutingPolicyChecked:
	a3AqSv4pB1S9QoFX1g68atS3PkaBjoTAymdvCZ/lb8p5BcV3cALCiWkX1uvD+KB4kBwtj7BpXbgVEe8LvHstxNlbfvkmsJggd05lxcm6rdUG1n3KmhZJD3wjKY0wKWuaolXRSzScCHJb7u4h9fwaali0Cp+V6dOtghkFMJ4I50YfqzfZQJLWIWy9ln2sHKYA5SBPQiYsVHKTCMXicS5MQbU9E3ZjS4OA+4vrWIOzAAAedFaYM7xw6JrdpA9ja3hI/r/mzohkSsib5eXHipqLC0E23VIlaNNwPoLHZOpwRILUF0I3l6QigXzOO6JtSGK2sMkcUM6q7xZJ5vqWs8DjJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0eBtP8cZ7jo2+0d5Y3ACC6434xbTlPe/iqNopKf6xKi44gyjHP569UzywCTDDOk7k0jwdga8lcwehP6cYTBaiGRaFI0nIeF8+wXhLz+zJEgQQJpadtOC7NtoaOuKFdeYxHPDUuvUEXbr8nS+DU0m+rMFXSvBfhhaRFCjXzQY02RJeKCqU7cA7kwG/v6Kl6fUim4CYYTmIeucSo/YEMyVv+F4AHtduvJOsNSIrImEbat0NbPwdS8pw+Re7e0OdNYLmIBkGP6NXliAn0YiKXzBsOx2fB6koOnR5uHXyfAc7PMTU4z1AygKDQ3fnY9p0RiYabKb6de6RiMunHKAhuyBO0dH7+p0z5ORaO5IbB14UuibLktnXtLJRWF4oOuv8Q9tTF1+0hF49eiGWGN5EY1axsvtghfS9TfeLhMu903zrw1H+uLNLOeqaYcaGvn+UEC0u/RW62WdteRKGZXJE7mtY2jJdJ4bsN60TkCJQeAz3DOwIIAl7EQKXUvi9cV89cztLfd1qAjg/nq6PrZktt2oBr/mOHhBG/dsGdnc4NxuWX2ViNMszKGTMfJKpvvn5lGa3j+nqb2QBApMnHdL0Un40zSJ0vKZ6Nc2aKSiT0tYaz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52ead79-4679-4975-ef14-08df2b5467f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:23.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTfNJ0+TrXZRhRuQqrSLj77wiiQxKw32ryzmZ/Qbg3G0Um0fO/BxHjb4NQZgDETP29vKPJg7jBUJ4ekzDzyLlYnlL9CFDvPRiEsd6D9Wsm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6ad1cdac b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ru_WXoCZngTtvYUXGSoA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-GUID: oo3jSuI3dlr0OJt2KFCfKqxlNU7kVg9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXyP5XslrGKX6Y
 4mH2xhhk0XUXp1gHPzGdIC1DzSDdnxqMxGfGGr5QA6e2PPnLFRY6zeXEKsc6peDHVtRw90605uF
 S+VKtVii6+vyu2AFj/ADAEmVNbtzwBwR410uHKd3U4+WKmMjX6CIcO6cEJi4kXOG/pb+1MdeIwW
 gWtLBF39WVdqa9Ku1CzxdoaofEm8iayBIsMgNqCcKksoi2XItiCgfa+h9vEHdnCcUqXpCosmLET
 tPu5U2GYJyLavfh+tD7CBMBCLhvqwhVkp/1xUtTu3V/TRxgjOp7PNVnX1qgAPJ/fBYwp3+hvuKw
 5GSsGZK6uF0nGW2hQGKK42iNDy8FM8mLXzWM8tzP93j+s6K/cEJUhwW7In+YyS1b20NcwJy4+XJ
 kDpm9A/2RlV/gv1rT6aKDASS2nAp1Gr5apXQ8YHyZpsz06FoeyT9ZA119LoxczxvspqYNimyETY
 c1WvWRvoZSTSLy6BdsOZC9S3P96hr/nWLuxdigSY=
X-Proofpoint-ORIG-GUID: oo3jSuI3dlr0OJt2KFCfKqxlNU7kVg9w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX0tJZ7JUJ+duA
 rfytL3J2ct4FCIUfA+xzEnsSMGJmHLcX9fD+V/avYGVeUkbezMv9WZpcPDk2NnNCv8IAdtNK0Y7
 ut2ROLIrKEJWgaFhLNdDNCry0/AtQBy03DozXErsRxTMrA7InXVv

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_load_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use the
non-amortized RES_CHECK_TIMEOUT.

RES_CHECK_TIMEOUT does double duty here -- presenting the current
clock value, the timeout/deadlock error from clock_deadlock() to
the cond-load and, returning the error value via ret.

For correctness, we need to ensure that the error case of the
cond-load interface always agrees with that in clock_deadlock().

For the most part, this is fine because there's no independent clock,
or double reads from the clock in cond-load -- either of which could
lead to its internal state going out of sync from that of
clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

	if (__scl_time_now <= 0 ||
	    __scl_time_end <= __scl_time_now) {
		__scl_timed_out = true;

		...

This runs into a problem when (__scl_time_end == __scl_time_now),
which clock_deadlock() does not treat as a timeout condition but the
second clause in the conditional above does. So, make clock_deadlock()
check for equality as well.

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
the spin-count used in the amortized version. We only do this for
architectures without a waiting implementation of cpu_poll_relax().

Cc: bpf@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
  - minor rewording in commit message.

 kernel/bpf/rqspinlock.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 1b249c6f0674..9e8f19afd7b0 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,11 +235,10 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Spin amortized version of RES_CHECK_TIMEOUT. Used when busy-waiting in
+ * atomic_try_cmpxchg().
  */
-#ifndef res_smp_cond_load_acquire
-#define RES_CHECK_TIMEOUT(ts, ret, mask)					\
+#define RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, mask)				\
 	({									\
 		s64 __timeval_err = 0;						\
 		if (!(ts).spin++)						\
@@ -247,7 +246,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#else
+
 #define RES_CHECK_TIMEOUT(ts, ret, mask)					\
 	({									\
 		s64 __timeval_err;						\
@@ -255,7 +254,6 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 		(ret) = __timeval_err < 0 ? __timeval_err : 0;			\
 		__timeval_err;							\
 	})
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -269,6 +267,18 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * We only override the default value for architectures without a waiting
+ * implementation.
+ */
+#ifndef CPU_POLL_RELAX_WAITS
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -296,7 +306,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
+		if (RES_CHECK_TIMEOUT_AMORTIZED(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -319,12 +329,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -421,7 +425,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK),
+					      ts.duration);
 	}
 
 	if (ret) {
@@ -582,8 +588,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-- 
2.43.7

