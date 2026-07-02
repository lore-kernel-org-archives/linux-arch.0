Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E72BE05F;
	Thu,  2 Jul 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956097; cv=fail; b=ujNpB4YwHxhSefXQpttb86TRlCJufUF9SVDb8supPrLDWPbWXte9ZSyNMJLuFTLcHnIDfGbk6+oL96PmYbgRkwWxO48syb8jBRblHcylSRPN/mh6dqI5eQjU34t63j2nTADeSlmnrohZ0Z8Q9dBgfgx8izCcX0EWkwbshLidOC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956097; c=relaxed/simple;
	bh=ojN6rotIbIAfJKlO1MyqmeOi1zWc2jY+tGVwNQ7lr28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7fleu48/NWZujYRsd35BNPbtg7S1dSeJrD2VeqNM8xBuK9SbA3wcXdw5hMyT0/OLvKdRDXHvdwHhzSiirPOVp69urKUR/j4msMa+E2KfM2CUfcQorI3TGhhtagCisCRFoqYhyXzgIw3oFXnaUxlz+V0dApoIWO+KpvSzBgw4lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UrrcWVln; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gg96DwWp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UrrcWVln";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gg96DwWp"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EGxqb2817311;
	Thu, 2 Jul 2026 01:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=; b=
	UrrcWVlntUa1JfWIFmbfT1qqRaADWlrzzqkKYaSwp1b1zkDVGomVm1VyWLUM/EQG
	OBj2oo5eWRQdOJSe3bWFDot5ajAOS+whdGtr1hilkMADMkieuWB4j4HFePTNkFBL
	k9GWbtk+48wKhiQV0RlLs09OKRBMi7iYm6FWRNX9x4dgKBxokC7dJQhxm7DLAjvs
	tozRahShIKG63tXOfSHkvFS7KV3bF6uR+U/Qhpr/85YEvDtXWBI+S7IVr8aReS5E
	slTdV4n19DLQTFI+KHLo7W4jxkLre5Iancq+ZDHoL9j+a1tJGslfLwkjH+yDIcM2
	3Tj5dqQ5eXYYL6koXIr4dg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26jq79xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621XYNe036187;
	Thu, 2 Jul 2026 01:34:23 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f3u1xptd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGHsAhibvQAMSZFf53MDm6arDu8hEcX7bxgr3mpnAjnq2Qug3QX0BMiOWvjxLC7bo5phjHPXrI4DcGlBdK+MbSvmTntssfrV6lR8LGFnuofCTnLMfMkb5wRNqpRZi8+iC/rUjkyolsSAW6CV6OJU8GjEU1zbILhguLa6aEkEXk7xXW+w+HRqP4z38WGdnz8RsJPgB9+QvrJasZLt5T33H+27mhI70TRppfPMdv8YIF7v8Z4etvfhKuojfdqEFDmJdoqu8eKzQqW5X4Ekxy5+K5ybnK3t/W+UMz8f6OCYDG2jlTeO2TwbTvYFTa+dd+fdGI+KniTV6mUMtISFlrCWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=;
 b=A6ACdgDWL2F2xw6gEVYcYxOLn3FRDnf+B8oARVaY+M2F3afic4JxGZN6tIyZ3psn9ACCQvmQYfaKhwjuxebdKhHkUKewlMANdaODupvL3Pa+tEFbFiBIsU5t/S9le+tvX5jCk0KVapUDiQP/hceUUXHmPChfTYohot+FL0CE9+Lip663aLHeypqA6XVRmMeQLw4x/0gQ9LKUWHXfgBGB6lmAtvLm76LKX1pUwvvlCulEwxa/5Rv+jR5BfFisjWJHMyV4ZZNkYVVeLn23sG2MtYHtY0+rWSHeFsBgmdjOpo7SV92Ss5P6gpzJbzuURsjmu2EA5vKtm4/rLP4JaNm/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S20dGHKKS4wRGthBkiO1JlrzyRBsuGiJ35trtoHHkDY=;
 b=gg96DwWpHIQ9jSt0b1FCE1xsW4L07G8XsfYhIR8+JxsgBw8l3z4Eew+uELpe2vfRxSh5EwugpWai1rZCSd5RzAi8/7QNaxyFjTltWnC4Yqznbgmrwae7u9uKZwYmAOKq+2feF9qSlkJYt2SkADa9QnDmNvbsR69HQHUF2DW1CvQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:34:19 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:19 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v13 08/15] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Wed,  1 Jul 2026 18:33:27 -0700
Message-Id: <20260702013334.140905-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0433.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bcbe2f-d088-4b77-3acc-08ded7da0923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EwA5hKNDgh8C5LK9e5SSihCLQ0K3sfNNnLBVkwQ7+e94x4QpqOUtD/lR7U2WPz0LDQvThBHnptl85NwmECmzccPecM4njBds9gRxJwlVUBY+bc30TbsZythRpgqRVyYCYAznGZF2WavjExpBVXMy7Sy1eIIrFffs4tRn3jYGDurP7/MvYY8UuMqBZVqgPPGo7jOguDNvJddXIXTcbZ3vuoiV0j74I6z1AGckp3Sn3gjsCiLm56THWgm8/e92bnbUcUROxUXcY1FbjSaiZ7yq2RRQvXh54jaYJ91BQ4SE9J5otG2uGdW8FcNaDljmCYiQ2iN8S8YULLkuwc2U9hgheQqHGqvvp09xYkNq/oEiZJWqy2gjHxoVnZOhD0iXSFr49Cm5m58Nw3VAWU6uXFzk71eRq8Ge9+mJkJ5prbbt4N+RMgN33XaP0xHJJyVdzborIEN2lO1j4TwBUlPTGw6CzXVC8Et0plTBbirJkVowT6vFvs4Tg4LAg6VpdirCYFhkhNe5Of+9sLtVsC6WkXNLG5K1UgMRhYI3gcB6lGEd4p88tKxxuGsKsLIH1oX30imEGzmIyLwXx4op+DY9iL+Hu3kEdJLmEj9zuJZZVLIxHh25m2LkJ9xzNilPpuovuYk0I4uf7XU/HswIInYpZsOvntX/IS4zWxTJJCKsRW8M2FE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ywxf3qCapzlL9AsvwwUXR7qjR1bgbB9x9qggnqeK/D3QPBvCT//I6sLnV+dZ?=
 =?us-ascii?Q?V4bd87+fxJxYLL4Wig71RLUuLkT2E3Wo9YYgJuMt4wVOD8qlAXzmmMZJy3FH?=
 =?us-ascii?Q?spTYV/OlzB3TE4XefZ3I6CVyEwroJ6KL9w0cJvQ3CD0XB09+V+9gD16Mgu8d?=
 =?us-ascii?Q?i+h+GzbCY0KLqKBVidSmmck78ZWRCyW0NF/fSGAGiOFPEehpvKrv9udUlSxo?=
 =?us-ascii?Q?ZfLRVrUIV8DV5/ceheWsqRmZzPITQG0pM58ndbu2Fb5LuO4mQ4PDHIExn9wK?=
 =?us-ascii?Q?Hdeos7iWQTZWr/vwQqYLq5yr4kHs+D0V1rq2TQEbaa4kazj+IWpLJ3HwL/w3?=
 =?us-ascii?Q?3+KGs4SXe87+eYsUkEE2JuHlbSyo7H0RpDuZX9DCppoyOqkcnOmN8NF7L3+A?=
 =?us-ascii?Q?GXogbTbz+EouB4hM9HMsomf6D8mX7AFfteN7p6BuVGxlIvauWsJi709RyO5O?=
 =?us-ascii?Q?1xqRu25Hf1r9lyiuqQVwRyhHgt1H+v1ScmgPh2v8ikZxyzctBPS6semSOlmI?=
 =?us-ascii?Q?lZEALxbj/Yd+5fgt2zQevCSZ+MRKFF69BC4VtXjGw6M0AdQT/GjlMw5QKBuB?=
 =?us-ascii?Q?TrQfnwZ527QNIwBhgIJm38+k/ro9SnCL4zEc8cWIhU56qjj4ZQ5ZRboP0b7l?=
 =?us-ascii?Q?HNrH1Nlv1dCQHg8Wv/6lB8+g56ST7OSi3ckT+6S1cJyqQneXeVVcruXsqs+A?=
 =?us-ascii?Q?JPURp0BxgGH/cyL+aPxhPXhuDW8kakxajdYR9w9CpDWFoUb7XDYhi7qV32JF?=
 =?us-ascii?Q?+G9T5Edn/HjGDydn9HnobIB1cGOnuftMvCNbiQm1+Ddq5AT7jUwzrDBHdH84?=
 =?us-ascii?Q?iL6jITS+ZOERuJkR9JnmQtHDolUenhcdpKP8J7lVShW7jIy2KilK//saons8?=
 =?us-ascii?Q?eWQ0SOSZ+0Cmakje6B7eHN6EX4sggbgElU+sBZs9qqZysJgIU3+Dn7FvKjzV?=
 =?us-ascii?Q?gWWxU66k2T44XPJPR//zBQZYycG8NlrzTtqhUENIbrr/Pmv3bZOaiik/qyPG?=
 =?us-ascii?Q?nFqjPjxPICOCann6uyTUcznWpVkLmNwKBguS/OyHg2prCCe2WQjN/CmggGOc?=
 =?us-ascii?Q?CCrufRta5iCKrP96h5+N8JuS58gqxxBQZJfVJp1kmSRXM9IYEhotQ0j9VTAA?=
 =?us-ascii?Q?1Uw1Qt0huddqCVdfL8adPySLoaAAt8DyM/AGVymLuqev95YMvslt2jcRIrnC?=
 =?us-ascii?Q?gewkJOeHsUTAwRWu3vwnCyKiVfofxKU2apj1ry+ECC1WC415EiYOOEQB7vQc?=
 =?us-ascii?Q?BTyTHn2SrujVNoteJfMXweFHdl6ZmU8Rbu78gL+rwqDf0pnOkJLX4U9l4zT2?=
 =?us-ascii?Q?Ml2BKhswM35N9fEODjITJgOQJPHY5aW9m1buiq7urUpMdqp/dbJqsV0xdVUY?=
 =?us-ascii?Q?2w+L2k9X3HUpak4kkDfk1PHMC9w8aKXvAhUYHwsWOCoSNTxb6CNBS0PXLVXm?=
 =?us-ascii?Q?YIv9pdjAQspGGuhPlAVnCl/yW3ziGOCwg02wBpvd34UTk3VdyE25o5upZOHE?=
 =?us-ascii?Q?rNflAxnV/BP9V8A5xKi2xvzNKr6dgiQwoDLJ21lJpytqjl4US+tax5annicA?=
 =?us-ascii?Q?+6IPEGWhBT8RccQFkQEoWPMsnb6wUrWhC6PWNY16eHlTcAXVHpcUlF5rU5m1?=
 =?us-ascii?Q?Y5HjuH1ZqFrzqqau/MCJ0fkoadT1OVmxI8Q9Umyx1twNfIi2Ae6Tu5I8NxDv?=
 =?us-ascii?Q?A+omS/B5bZyEUktcf4pJ+IdotOR22w4QpkT17jsCPfyQuFMXB0vfNKn9NGuX?=
 =?us-ascii?Q?3w3LGOnGjVPKnD0DnMiIatbEq/a1uF8=3D?=
X-Exchange-RoutingPolicyChecked:
	rtvCeMh9v6ULAE92p/ZWpjxV0TEQ42J+gDnmGTmOVS5ATDiaDCI5mpvNn1f0EifJD3KoYE6yguJe5wRUvLDnwPqzbywJEOGql3XR8sZakeCnu+JemwD7P5XIMwsCTAkAlsr/z5vMPM5LhAxmySZss8CQbrj7/UAtllOv84q3lLNpoMZkU61SuF1FF3Spc9cg92jOcOTEVJCxhFF2cH9fHZqcYZmzR9b0X3zyRE9FWCVJOPDK5RHqUAsAskBfoO1flQAiHtvvHpDx6+nZKiN0wYBlD6jNd/lpw7JqPB8ysfzs09rckRAD27I+fBnMBU+oi4K33qHAy+heoK8or2XoMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J/Gu+FskuRw0gDf5hYecQX8b0X0u+P4wlTYiCVdIm3sg+enHkXX2w8itHhKcIoq9u8mgWpmOMOmzniZczEiOMnpzBi+BPDVD9vNcGC/mCXOw9h2gjO81mOTxyVHgpAjpaF5GXlUfPuaoviye4bug498C45hXPd2v0LO28cM5sVAWxCqB2l49ugqcdY7GcLAuWwpcDryMs2WI94w11WaknYQHkq1usgHmrWHtOSpaqXhTHyDNylTO0ComxhtP4XKrNXcIi2T60g0tR8lGJbJ0an54pVa1NWc1qF9HSgqNN0/s+Gd+3WZLLOIg+vnbmPUG4RbnnegFdBaWbxaKxz4Xtf80wncGhcZQgXwzLYz4XDCzbG8O5lfKGyH4m3wK24xVtM1bO/AX85VvjsAlsceOGJ8+bEFEEh8Glh/sLVfhxcnPAKptVApEPq6d1LmuWym5IPG2bhadfqpWEUnKm7ob6bRXZMoQbR3RrvFh7tpC/SUVbcjuJ2shxAU8XyAMDM9hM5JceCUOx2Vi0IJ45O+kIqcwv7Sx8G8O7iOzUxM/8cD9z/6i97CLq8LaUKh/OnrQ3cTk2YhIM7LS6ZeiGkSuqXLsvRlP158lHurzp7aAvyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bcbe2f-d088-4b77-3acc-08ded7da0923
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:19.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJjAjusnMs2LCnsaxaiHYfIXecqKEFUWs+SfkeXjlsaR2fmh7o5edmwRd4CKpiZa7QyrL9Jg3WXKs7R7SmVFMjz+kU3r7OPiar+wxUTnKZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: AeKqviypOJNzwKYMacH-d5gt-VoMuJ84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXwnKQtMC5hW2w
 P6hLSybh4uC5C8pfJ3CTEDcH6hyX5Mixkhgd6NU2kEgqSEj7FAbGwhkxc8fFr/l0aYAdbyqdgrg
 rakbBAJpgSBkinpoW3+KG4J1uPCgODyIWltpH5vKjsQ5YMW40kWGMTaTV37nCDkKpWPXDv6JU26
 vemy2tr9lV2ZGClFAzT2sEHFznKYClfz/JhdPruUcAqHUEN2mQPlIieAq7kF1SN9qzQIUxl823n
 NYw38wIBuh9j+6Qk3tronqbJWpQFlA1gHvbs/EDNeqRKbp7oNEnqKKsv2YluxaOGKR8k9urxVq9
 YCsLuc83+/+ciCpck9dTHo/KHl2VUcbxHfYpv/5ivUTl1DXYgt0ZUukQBbSL1winT1V6MMSDexa
 yiCyak1jkjgj86dNm29ABk2ArtVcpb0NTYyoGY253Ja9vmaVEGtyyEI1asLwLVspbv9kzSvi9Vi
 tMiy38378OFfjInhncSXkbnstDxKjxuuURZb0JqU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX7HI2iGB+E+5s
 KcI4AdIxVNXj3HMufdbooO0WPvuss2t97tR95Lgj4oTtKNQtPyhf6ZSs1pSK3lHuUbPLBJtefDa
 jiAlLKYBOMQrO1Ig8SAC3wWAuD/as+8DgIIwqLvlEtSpYdi3SAzd
X-Proofpoint-GUID: AeKqviypOJNzwKYMacH-d5gt-VoMuJ84
X-Authority-Analysis: v=2.4 cv=XrbK/1F9 c=1 sm=1 tr=0 ts=6a45c020 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 6a4e47d2db35..553b6b0e0258 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4b882bf19018602c10816c52f8b4ae280adc887b
+// 79c1f4acb5774376ceed559843d5d9ed1348df99
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.43.7

