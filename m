Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654742D9EFF;
	Thu,  2 Jul 2026 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956081; cv=fail; b=R05bE0DWjIehHgAaWniWh37uWBLenwe0mFJPUQp9bfnGkS7PlmwbxzWL4V3tU8sHCNJwXECGphg4QVXyYJHESPhJNrICYkn1oCp7P0gJ+XdfHR/fYSnaEkzlaUfym6L0a9eTZqx65LCgX3wSDO56iJSvj1Qr+qJwibSZ6rsypI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956081; c=relaxed/simple;
	bh=RSPtQawh9N4YB0zGquqLtaoMfcBKut+TOWqh471SMOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPIBGZzeCO6MvMl7oYKkn0URf+6ig9PKn0RQduWD//SWz5qxpV75ZEEaTTHOxevqoJVi2YsqKbXizw4BTp1XP+pqc9hGKo7xfjvbOmVqByPT9Kz9XwdYnFeLcDB1yZMwoPF4s69caJSOI6b+o2NG4CFYj0QGCy8HPPCtiw2AzBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rwx1I3LN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E759mii3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rwx1I3LN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E759mii3"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EKYc42931940;
	Thu, 2 Jul 2026 01:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6Gfco4bH1sOEnOhotX/AZ1SQrv7/A85oEqnR1pzaVrQ=; b=
	rwx1I3LNSMx6eUHVDOLs/k8NVC/lhoxEz2vZX+HHKYA17CUZuAIEyU00M/grV6fV
	N9I80yfxAcG50Sja/E1QxwlXq/IlwTNdj9hLSLojs+W7fb8ZN2vkEz9+l9Sjlc+4
	KjrmeRsjn8mI8XFJ3rF90mBtdQklYkkzUVtugnxe4n2/SA/TrZXNo6Ix6xI+FElJ
	U+6vlO/3UCdi8zu31Hlpz4Ytg8vJOENTPtOY+pZAw/d2sSaDdQfxRZWoqe6iVCXq
	1nl29DnoxrNS5H5YRf6kGj6BqOink3QrP/TZJhLEnxFIpKc4DdUD3nSrvzuccg70
	sMW54VZO7fipj2kWPuZVwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26kyf6u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621XY5O036168;
	Thu, 2 Jul 2026 01:34:06 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f3u1xpsuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBhB5hVbjUomq61zJw8hGV2PX78N+c9Ao8zsyDH9l9XCi5lKSwVZJNbt8ruYFoJyx+tsR8He29SkVK68dcbYgFQpVnTI0LQELV9PVJz4oO0+oigMhZypYBju26XTskrRBhVIiXGSF2GZpJX3bcRiiZrOFKaDrpN1DWBxUEZ4xsSBBYxEqtQAVjelbDYGgZYPKMfDfqZ3wY+T1FvECm3JxJ4s7wwgzA0sZnXGM6oJ5lUKVblCE63/Z+1/Dv5a0v2cFLGn3LkUtTqG5iE6L2IB+5yN/6Notdwlow4UTY+0jzlvmQP+ZVxdiZ36NyaBFToc1Xzi2VCzbOorMIp/nyY3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gfco4bH1sOEnOhotX/AZ1SQrv7/A85oEqnR1pzaVrQ=;
 b=HiHfig16CTWlfbK8/WuKlE7go7btaChbyvGp43x7Ok99vVFB+3+hlevyDKQph37dcS15MLBI8tdh/SYzamgp956b/AhVjOMgS9t3fIxStBUWNt7CwfsbbUh3T3dkZFOjJzopeGkGOrFSt8dmY3pRrjIFnaK6k5nh+deJELnz6v0Ycfn6MqRPm3/hpUnvfkYn9mu3VdcNh/mcV0DFVFMNipAbl3LBkDkFDsqOcTCv2wMc5ajG5+q6podMQTtJVLE8/4EdyIo5tfJfDfoNDiZXMW3vIBgufk7RC4vcTWXgoL8CtwK054xwwYb3z/zEMjofWNFHY/trcfRK4O/vkMaipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gfco4bH1sOEnOhotX/AZ1SQrv7/A85oEqnR1pzaVrQ=;
 b=E759mii3Uc88F909ryePXXepnSfo3MUuHy/NAGcgksVRw0vHwHeFaN7qVVIopkjw9sWRMFYEZfnhdHd0oDpGenKcf3bPY+JEyQZM3EJT/3lV0oYUmDwwUuCSMirslJAoP4zGLCd3M3kdo8R8208ZJa0H8KYvpr5+Lwat8AOUAWo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 01:34:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:00 +0000
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
Subject: [PATCH v13 05/15] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Wed,  1 Jul 2026 18:33:24 -0700
Message-Id: <20260702013334.140905-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 457a35aa-0534-4677-ba4a-08ded7d9fe18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I+45MhKUdk74Rn6CsvMSZw8Pj1NX+y//3hPaWDJG8Xuq9gzj56cLwnzyytKwU+QH2qEm265rMTYrbZE+8PJmVGDyRjbbeOSDqn0PwzsSOG9W+2KUr6S1vmC63H9KgbTR0JwnDhyhx/wW+kywpIj3ZmVOPNPhljO9UxjiN7WRcYI3Ix9NrKMr5DZsR5sCT52ApVuLifyOMBBS3y9CtG3nmZJhj6eYWh9SlEYtg9Vc4Xb08kSc+LCfFC3Vfqfz+osTVD+XWk7Xb4dXumyrA1DnuMDHl/vsTmJgsPR7SNthdo1R/XbGoJCNm6R0ta5UDc43SG5lnoq+2MS0Av7GaRDKU95hWj37rKNj/oWqxBY7Zsk0NPwF0XGwnzfH+TnA4XqrrmXNlNuY9OrxUQ4ln8CxIuxIRR1mekUNfWDTIbqbsQ9bawAWg7Lkz2llmjGCJRLpwFW4YFDuuwr7p4yv+w/MzxCLdnVYYi3ItGuuKXMWJ2vusqn+fM80nSN8lNK19YN/RJvi3tU8bFpgoM/h/pkJjUSbalcqW4SY1jYjzlMez/uN8Csod/g40ddSr6fBmgh9uIDeZHyM/KDBesDjO61PS2GVRU+Dj2tj3WNI+n2ssaMWK2FsNjY043sBOW08bYhswCB+b9NiwQZ3gTG8uRtPoDgruF0F6EspH1cbm8gzo40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pl08U4ky6VluxRciO0TGusYTHk4Yoi45oh6sALYtCvLnzpmNBVQ0/1kxT8Xl?=
 =?us-ascii?Q?VEtl58uV7yWCSzIv9lhxyN11fJ2pNfYuA4vq3VxTRqSM5Ob40DLAPg3F2bmb?=
 =?us-ascii?Q?h86tMbntBPFCQ75blLkdjisClXqVUsTxHJRW610t9BvOCoMBlYb/mbI0XNGx?=
 =?us-ascii?Q?hSydr+iCcgMxFPaZfxOEUCaHd4oUDuey5N0ZW2ilx8v5eDnzIC2XKt7xSezP?=
 =?us-ascii?Q?kuCm5wbYkmgnjrQTZzSowCGTYfKufYe2yFys+bdxW8NZYtpc/y/MCLsA516P?=
 =?us-ascii?Q?VjqmT02hSjXcBkk7nXIFL5kfqFy95ZFtMmZlwyrW/54R0wmGFfdMtlh5AmeQ?=
 =?us-ascii?Q?nvRpFEH4D7sKOq1qrUir+9QwUNT8CPWZHEDrka4zTqdtDsHjFlZ/pi8dfZgI?=
 =?us-ascii?Q?lbe6nBpjyL1sCNRLvoQd9e3puLWWqtDTUHc0kJAi9WaekrErzYXqtl990UFk?=
 =?us-ascii?Q?BxO+yCmpW1zJVoq7rYr3t95WaHMNOnim4syqTGXoDxSB3R1FpX994WLPKVvw?=
 =?us-ascii?Q?EYCcaMJpHqFk9BfklYvKKOriAxav26wSqMO/4m7iHM5EV+PjyhfCtiOLvzGq?=
 =?us-ascii?Q?26TFtYsxIGgCKpRtkfrkfVEw5FijQIF7182/8XJo+ns+/OtitqnvJ6ElRNIy?=
 =?us-ascii?Q?QH+5vs0t8Cys22DKGTuMXTjlMtrKTfBPcfDqB2W51D10OJJG+0hT4r7OA9AB?=
 =?us-ascii?Q?UBu2b7s8SYBgI16ByIJfcqKvmPFHujrJV2FkyfPgU4rxuz/01u+6TJUw5Zqk?=
 =?us-ascii?Q?wwx47P5jPTdYH8UxefuuVl1D38LY19m9MEycG9em7M5vS3pYfv4YPV4LI/W+?=
 =?us-ascii?Q?s02vJ0ZjV0WojNFek4oDb6+N+a75aIdF1NMjiGI0g+1XsKlIqmmEV9HBsr5j?=
 =?us-ascii?Q?PzsJSkBrZMcA242DC8tH9L6CiiLC2Kj8+y3KToL+OlIy4/jJoQFxBHN+9OJx?=
 =?us-ascii?Q?0ShedgO3k25QDwprxXyebC4uK4APMeApgyNboDaGkNGbpW9VoJqvw2EM6BH2?=
 =?us-ascii?Q?AFCYzaZi6mxhccjIATR1MONpJuk15pzViouCmBa1YFjEAFiXYy53xvn9wmE9?=
 =?us-ascii?Q?YdpjucjgjxPa7Fv+oniAD4dnhVy/aeaNig9+sq4DjQqBAc54bizj+0aWol8w?=
 =?us-ascii?Q?mE3AnZ+/n8FiI/FJxfyqENihUJk9Y5pcfPnltUkJxcJi2GFY+F1ojNRySUTi?=
 =?us-ascii?Q?ofkGqkGMfJ04bPJz5UbATCQBEaaGIw6g1FTRFMdI6Jch8HOaZqkLuPPu194M?=
 =?us-ascii?Q?4COaBFUnW3C0M3zp73TwxmdpM9oTAMs8Cofa+7yGaji3pgOP5jgumpEbXA/W?=
 =?us-ascii?Q?EBjMYDgz7pLxizN0mkW66lbxati3/PsLHGXDszOitDOr46B9bODck/S10gu5?=
 =?us-ascii?Q?58nkyH9v5U9eLq2mb5JUq8WhIXS9bADRtJWYZ2QSwlMZVxTh0JkV5BZ9bUFP?=
 =?us-ascii?Q?vBl3xzXXkBurVMkOF6BmYrZ1qQ2PID3LC+uRprhdpQgcgNl09bq83r2cYwNq?=
 =?us-ascii?Q?iVJ3xYY0CSRR3HJMeSiWIXReY1lQjda/jnv8R6d2MDBcrCis3SKIG9nmkmBz?=
 =?us-ascii?Q?uXDqxNAiWyJwqC0fAb0h1wia89wNyhAPMo3KvEP/PgdW0k61xHKXFgx9rAUb?=
 =?us-ascii?Q?+96wgD4/W+b+Df3KuhbdwYiFIL5A9zCNavMpZuNT37WI3OTAFaEXf2K8Y/cJ?=
 =?us-ascii?Q?zGqc5ZpPBpzFPqUSx3Hzx2cQbttOHy00gUq2Bqup0pjxPbLbhC+1R10cQONf?=
 =?us-ascii?Q?1wGTmpa6Rb6WfcrxIOrHKZdyU4NqJk8=3D?=
X-Exchange-RoutingPolicyChecked:
	DDwV53xYaea2dQVAhjLMkQwrBWPSduzLVjRTfZc4Y2FUFaKhwSQv8AsY0eMHj+J2UeOaBjh1QrgxK3MXrawigSJZ7k3Y2dDXjN51Gjgvff1j0w1nCNcnWCh6PTvDiVGpvp9Mwolmt6Z6uKGqaqksY+qIkpDacJ+gBLzmbA+yP+c5UJ6v1Oye7DDZswrSc67bOVIQtoRVmttOAqk3b0g/zsPcBASwx7PmcYCK4Ena5lk3pqqdNohLvU78kEVhM+/2saAeIHbgtxc4CIHGHMqhUgHkV+iQEqxIo0/i118IXjatcZz+X1KefhrQj+C5JIuBTTL4lAqVYmFOVU4SWWFoiA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQOu1F/rUBJHwYckkbSyIIPtvhqCdFLBAfruxL66lF7qWLLWGUtcJqDeBf9vYHVOR5605unmfsRphDvemVtLQzZZsaLtMG9YcHvZwts8sS4rCn2oqdW8qTNI/1sfKkl2aWMtN5zP4afWJyIOqNZ9jCOwWUVVcPNMqb33P5MIAMH3OpGRaSxdQe4lmUoBGKJOAPK1ReWDyXv51xRM7mOLROnfAkbDjzOfB8l0sAh0sCR2FjIJ0suhyRij2FqCWwTyh8I/h4VXTqzI4PDWCNtlEFIv/Qxxe5SuVVfc+fZsEl20orQX5Br3oiP76jPj2kmow3FIoJUs9zyAkY8d+K113TJeibwu6nO/4sN07lUZUpewbq4MxK5ExQQPtA5ovRo0hWqukH3qodPnKJWLZORqjO3tISybfE3yOsW4X65DnJZeLIoY+vt83vT2XzrmjCHFqZV6aupYDd5BOsyEnjf4K8EZDA0mPX6fG9848MzkF4thJf9nzjZaxB7DuNAs8rfgo5+vrjMjx/jTKP5UV6A7MYFPp1eHo4Y8/tRZsGxVaqni8KsrcAQ+9+keIMw8fzPU0VG2lm1Uo4B04+adC5xG29U5rSUtwtftUwmcBazdYuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a35aa-0534-4677-ba4a-08ded7d9fe18
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:00.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Mhk1M7a6MK8ncknefzZiOMqaohN4GnmYOAH5E/lLk6ek8AW50w8xMwoMSe4hob8uLbVq0w2c5ajh/gwkBarDBSS5zEtApAo/SC2xoHJwHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXybL2c8G8ux5m
 UEH9dL0CEGCnj7EHF65SnO0/ITw8AqlzUIe/V+F5y2ylUYvOnSSf32rFwyCLYbAOzjTcweV8tJy
 78L9P1uEm5Y/4aPoDBumyjujNxmSe3wyCWXCfUrcwNxOSNHcCNqT
X-Proofpoint-ORIG-GUID: 0z5T07MEI8Kjbd2v2wOcmVSQcpYJFqCb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX6QzHm1iZgXmG
 T5u5m0+TlcQUDltIIO/KO5kAsb2NSiSlkGKruVy3SfxFwoszhchW9Avq5KBqbp3ckUfz+kQfNOY
 lPtQVBxfZc/rbyY9cZmpe54sHN7WYD8lrGRBFnYYTFY5MsJGdAs8D1+8AvjInrwdD/WYP61j7Dh
 A1YlF7jyNu8522cQMv7QYjH92/iMLGDraSkGPUfPkXxPuMOd63xrO9uLgpfHPmby5XOSlpTKvsG
 3eG27Z9e68Iq1VXKvh2vUAjN7vnxv6Kp3HTGJxJYLoR+44OrfxAKwdfsfiMxrm3qnAFZwGGjN/z
 QXH67no0liM3AMeWokutE0VIkmfQy8GcabmoIU/8OQKkl5xIWnOGaWhol0HHhimaRcJaH3v5kLz
 44kGsVDxVDPMvOeTSHkTlTLjJrUEDnUGG3ddfgyzdwdszyUfFmx4tDAlL+LRBU31bSfmJ17QXzp
 SP4rh45pb8reBoRqh0birbSTx8FvCt3hzEYm4ArU=
X-Proofpoint-GUID: 0z5T07MEI8Kjbd2v2wOcmVSQcpYJFqCb
X-Authority-Analysis: v=2.4 cv=ROaD2Yi+ c=1 sm=1 tr=0 ts=6a45c00f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=PuvxfXWCAAAA:8 a=wxXpT7fL2LLBmjscUt4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: comments about bisection hole [1][2]. Discussed and acked-by Kumar.

[1] https://lore.kernel.org/all/20260608081935.E42C61F00893@smtp.kernel.org/
[2] https://lore.kernel.org/all/04f6ed5fe4f00805ba2eeb5f5d1b6f6d731cabcd00bd74fe11c060fd828131a9@mail.kernel.org/
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
2.43.7

