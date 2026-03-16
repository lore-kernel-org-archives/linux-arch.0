Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823023EAA5;
	Mon, 16 Mar 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625071; cv=fail; b=nDHWtDG2uJ074kacI5X/LRikDMoQ0S8PmToJq4xea1f4KCxfv7RfjhR1XhpU2SdT1wLiCLw+COevY7za1FZ++sNYBwTtQBvbmkEzG0dZUZ9zWE4KVt6JryzUA0oKRXSqPoKe1b7RsG7n+tUkSVbFdE9/ss2NbnFlKPWQ+jbPxlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625071; c=relaxed/simple;
	bh=fLzo2MKS3zcjLUWyddaAdPyIlMm7AdzWYGTGhHuTrXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PL04qfWRvJqIVO+5pN3jWhS9n+Y+aztWBExMQiTvWOMrYunfCucFMu24vfylnBTULlXVV1W5Of9ylvv/UDY5SdgqMI1K5Xr/+1oIC6KTaSDR/1vmokjLZtoRPKqQVMxfypoD91Df5W2nBYcP79uwDpfnDFpYMz7UufR/YdHj8K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qAYdQ7TZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqXSao8g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qAYdQ7TZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqXSao8g"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FJtHr91061276;
	Mon, 16 Mar 2026 01:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=; b=
	qAYdQ7TZDtMFcvHmL/vHA8Aj9Ekt4mg7uJkpP+rc+jCfjyCnomkj6c4lUr3sFRg0
	AIDJDufGoJ39VluaAjvwPRSI9MKWUDRxsHMm7pF4bw57EXnNML4SZmOwS7DXK8aU
	zhnqhK5kbAjxgwHSfKks3abcIIF2E7kcHfRm7uqKkhLuhMN1NAWX4PuxauL8rcwY
	2zHYe9d22Ci5P7OUhTOLfSEfjK5OADQ2sPSH5wNCe8LO0tu9O+WWQIKSnZumkOT9
	aKbwaSSi2f2bTxEmZpN8lcVkR4+/5/M3xi2/idUO8ezioUsqGJtD0xJeNCiO8MpS
	OcGhe3fkMkvnF0N6I+5SYw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rsatv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLlQHY002861;
	Mon, 16 Mar 2026 01:37:08 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4j84md-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6PJwOAXLngTKBqM+N4dDIDrzmsypbTvIw5SO9MmSTTmodgyGOAbeO0kYOuRJaDIW5P3JhEx+h4LEWTB18fUc4+tOA/qj/PI8aFzsHXth6922Y7zZZgJjfP8UoimPfTLkjBblrLk5FDxgp5RmJ0TCzKSRFla/WrLiDwGkLMcLc/ypSsP1bieCQPORmpFQ+KsFnoUU9cwk+6UkWTDQG9+cwIn8wnZhXrU0qoD47CUq6uPu+pkMhsM1//yk9tfsZq6+u7qDmUS5LM30+uUKrZLUu2bIquL3LZI+2rgkko1SufvLJFbUm1jb66nwEYBL2FUiF7qfW7BJv3LKLzcPt5/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=;
 b=vdqhfN9iYuzaFXGvOm1dpDYlSCfaijYi5OGIwlZ9x334Z/Kcw2mSemxg6ZT3g10fQLlhXRQXZVV0xqaAvWj9IntUdsidBxEKElv8JdLjN3A1HE+bXNC18Y7kqRZPN0fSGmncb+QnV9EprTwe0SInHX4OD3dQAZylBh24sV7woOAIIUEDkNj9OFe27ve/I/fkNv0+zDPuSI69746OeP7sxn4kJWQg5nl5WiqHhMlTh/rS+VaopV8bRIA+vqraAZ4jFldF5DTU1orhzbmXMOfOg1233hDAajgklb6Hp+KvQ9WAMFPhIufXZ5hv6yLApcnJzVyveLdXY5AwkG0zT4ig7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=;
 b=rqXSao8gRMtqYBNiG7cZbMR/ubGQw6TQbDlIPwmHjUjTPGdOwXFe8s/vkJ33T/24DliGoIczQMhTYvZ4wk799W1ALltX9snS0aGdF48cKPkvqNM2ES2d7+jsZGcZC5LdpU5lsq3VdQB3L0fnrJuOzbP3FKNDacNJyv5Y4y5FcM8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:04 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v10 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Sun, 15 Mar 2026 18:36:44 -0700
Message-Id: <20260316013651.3225328-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 7987322f-03d8-4c77-9901-08de82fc8716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7R3z2zUZMsa2VQvmI17DRPRz3ydicBDG3hWbj0UF3qaD35+f9EJ94Qn3Su5Mh8Y2zxbkuWcR0459QEfHygC5N3Nk1B2Y/ohkU/DiLljd1BwPtoaQB15VSJNh3s0QjsIg6aJVCgHclhOqH11us7os0ZV1npVZd3D/+fJRyf3/aBLt4aJIn+7MWl7nxlI59+gPpoV/EIuvJJgMx1GKsZJuwagzaLn5j7p2okoPw+h8JfH9Q++0sQ2r9TUNZU4R6IbnlO4VRFsqVXeyiQLu9uTYv8JxPjiT8/28nf7mvTGQ7xnxrgrpAgSJqYfJUdAUTiLG60W/LURpxEFPPrSK2uNRRgovg1Z1CUApgeeqlvJDmja5Bmg9W8UyQwl8WbSCYvHMN4HpzFWe4YGo7uGIrNWoo6vbXEavDdib4gzq1EjN/wTlKnE/7ySBaVEdNwz0wWNALM/Uv3gQ9LnJ50CHJkgkVr/3Z05rl9eTU6OrL71ydYAzj3H9rbp48qIOqkM+VK8xkJpKtNvBUdIr4MfZlUAcxhT1RK1g3DL/Nny6fG3wLdcOB7kK1fmgL4Mkx0+pq7c0E82gn91DtL7ksTioTNZZhmzbGz3DHoXVBfsM0T+lUdLanrgUZffgiUgKQ6Mfc2OzIVHdGPwKKYy5iCYBkIaqJZsrTie5LgGX4Qmkuc9nSo5Xyujf/AnxU6Gt4hI+mWiNjhE34S3q66eY17OVCzIwTpgNT3qZ6JVS0ocMFLaky/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dCUqnHhHiyQ8+KvdE+I8B5AFWFh7xRvI473xDskIP6mfdHRAnmjYqxeFpPEa?=
 =?us-ascii?Q?mOeWoju2apLyuWk/Lt5wEXM7H/L+aAa6IP+8zjuMQvqScclxnDAAq62CZekf?=
 =?us-ascii?Q?HnmCxF10fcEK4Qqh/nWSUrmmURAtkJCY6SCjrO2rPnLCbUxETDPVSCIhc439?=
 =?us-ascii?Q?bzlAlAVPTveSGNtQ3qf9ZiLE0U2eLoAyYmUYFxeAY/rHez0fL//JTONy3hSg?=
 =?us-ascii?Q?tHtI2Fnne8AYgdjga8Lp9ltlt8d4/7kVT4g2GLyDS+R9eU1xzPmSGDqAT2O0?=
 =?us-ascii?Q?a26iDDHVTliQfvUY0+IyRNYan0UaxZdA90TCHpo0mfPqj7zcnPLvdY4jJOXY?=
 =?us-ascii?Q?PU4UmHyU1NdJzH52XJ4zMrZYI3O5nqhgl/3uEgUpT+HBbGxXWYu6puqdmxzF?=
 =?us-ascii?Q?A+lJYN4NsHWIXFs7IGeU5KjCQ1gIUbQovJUsBVVBugoPKbZXh/BHt2OX4vvt?=
 =?us-ascii?Q?f1Yg7kyHZnBgncljdFXTkk0613rfZ4OPVpJgr6+ZaDj4H8VuuxPTiB5jitKC?=
 =?us-ascii?Q?X9LQM0sn3A3lW5VOr8+zSLJEjPh+q+myChgHcJqb9fKrw8BoKBtgcQrzR+DW?=
 =?us-ascii?Q?wCqv16wBt76xQASzp7/DYew1L0FpjWw0pfBVkK02k0kNB7S9gwRpPISqK01e?=
 =?us-ascii?Q?iBcv30YXOR5vNc8JzviwDOrraqppjzzL5rpEwfKUOzjoSAAxn04hDhpQ7sfW?=
 =?us-ascii?Q?QR726MjvUln1/CsIK5+W/WonujHTWlSrgvjvqSj8XSWo3kn1qOxfXWAvoYzv?=
 =?us-ascii?Q?bzkx8QSx2UgthZoX82BLS7drQDLNLaAmY9AqTL9MX2CcTVgE4/hxckWxKgtu?=
 =?us-ascii?Q?AV/UzBuzt1/9YuDRRvn7xnf9EPU8LXo920yy7sX4lUGHuAdJEY3BNTRLsTZL?=
 =?us-ascii?Q?AvHGi5rcxYxOvSwjLT4Ghq234ydJlYXUsE/SyHtwVK/Q7NMcjYmFeu64QnlW?=
 =?us-ascii?Q?U7BdF62WZORymKUqcrt4L3wAsL/K6bJr4c+zdHOUH1PSNhCR+4cay2i53TFO?=
 =?us-ascii?Q?3VTJWWDKfhhTww3gsjY5+Xhqcf1NRsG6B6DA4x+M0UM06oEs0bO2g7HgMtPH?=
 =?us-ascii?Q?ebtXIbIBGTGoh86vL/N8/HwiV5c9YWCbWqgpnYYeydmlLF8qYJiK4iKiqQgS?=
 =?us-ascii?Q?Ugg8yHIhk2AIIgEnEATcj0WeGR4+xWbjDUtrPv+YDxotn6OmdbMKX7LX3MrR?=
 =?us-ascii?Q?c8tincNNrujXezbTif6SriTJnBiqyFPmfAuQlG6JNu2RESE6SZoE0p67OGwv?=
 =?us-ascii?Q?18hDgvt5eG+GYOB8AVf2N6k8oMtBH0MLT9pSyt3F7X4uDCFZvvGQ59cT0xxu?=
 =?us-ascii?Q?T3iTr3/XUZop+3pSFbo87NUum9qjrSRaCt74CkEktCwHVZ8HVoylo8BtqjZl?=
 =?us-ascii?Q?1wGugi1PaSXE3cTXsi6nqDZtTVjE5YtYW1vZRLHBYxYcF06WVAjJ+1nT31q9?=
 =?us-ascii?Q?cAk+GDBsFrWukJ+B7eVxGr6TCtTvD9SJNOUbffNGQ3zfZTAVexe2xifdW0nb?=
 =?us-ascii?Q?cazoRSOMCo1Fo0XaRXOh9qoJnHog9EQCh5Uiz4gh6EgwXQmBLeKjvWGW/75X?=
 =?us-ascii?Q?uPkYkx4hY99kgkjA0/wiKuX9AB0geE4Wll+ARkq3ABNSzc2UYhfPLbpuSJf1?=
 =?us-ascii?Q?zCUv9qHlsGc7T2vG9ja1waSZrpIwtMZL8ysm/snYwZ784Sd1iHSiYohzdXwO?=
 =?us-ascii?Q?cTkjZLgCUJMgRWjYXGY49LiNCXLB0ajqUuJpHKqU7C7ogdz77S1JpSwu/r+c?=
 =?us-ascii?Q?6EoJZsslmq8le9MhkjrLUpIVRAA9AiU=3D?=
X-Exchange-RoutingPolicyChecked:
	g9v5C8WkQFLRM3UXGDWR2iDkFMQny1maryrlzz2ClArAfU9kwj+TlD/T5vYrI4kPaLdcHLXb97MDExDND3ngDKfoUZiwuTNipTdaYU9r2q6VneDuTq+G2OeWFPwgYUHft0BexjbI+sZoweE3KOjN13VrXgqhQU5YD13uw+k+4B3RUxl3lFPMlUwkYoW3M62v6vPJH6m6aVwvR4hlExuy/1gnzvDk3PqC8x2iyqAPBO/3JPvjfeHPDULI9ScKjlCriF6+nX/uERdVnMkB831sf5een8scmZM9R0dr2Vo7/MQah8nzGDscF5FAH5Fojw18TtO9GSxbOuYu7EDJZNeCjQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NYn4O0kLN1ZUtvpxoTiDi5zTLH1zL2LTY9X5UO3r4nFWG6ppfgEAbuBa4PdaaczFd+aw8j74ubp8vOQKOw03e5tm0iPicwlw2oY2a1XosQlEDYPOPU9/jd3oOOJSoSH0iWEcjAHanQ3myM5dCWnqYkKrq1qWo61lGjBLvDzSDVrM25XofMM6pnK22ByX27l3RRoEwmca3GpO142JZBYh/YDbVb1r+zylT2PSb6W38q9OK/+tWv+7t+3f50Uwaq6VXAZ3Tj8emeADJPRWxOouxL9dyI5quMj9exxR9HRjWPJZOc8xC+gvF+Hs0HeEYRMFOdsKurxrhXi2icFz1Mrou4/9Dy4Ezb+h32ruJzH5eNOSRXaqLXldygy1vGup6ySt8m4BsILmIvRcf+VVkYJBwFTVEHOFvH/xwf5lfHXMdzSYA1N1ZqkuDnvR8LFLs1jqQAR6Hm3GnDg+wy/mB5LC9XdJ4RlICLyilHtPa4vbWrJafXW7lqvBRPuXnAEZfHr7Ww/qkA3vZ+r+7GiJIqjiDkSwAHmlxT1xrw85YmegKuTgNHmYGbkB5RgqpHVg8VuqbkHHd/bOGGFRpBLpq7WS398uSFDMRV3pxOzN9yP21cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7987322f-03d8-4c77-9901-08de82fc8716
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:04.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nk5U9loWZyuYf1+mtEKQ/bRBEDGdcgEARRrenOHAGdNwNho/JsKNTmBgfXJWgqueOBp2Wq3ybX/Qo1S17WvTytleorPBlVEI+wzYgpc1m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b75ec5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12271
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX3GOVXqrg2Av3
 euoFfvLoqjTWxU0V4+Ol8MwA2HwRblT5xsvNYOcZI5ryAnbfawRziyKddTLz2qc61NkUcQH9AQI
 zDnGkTxkj7z7nxbFHXgWCF1P7wEdbY3DKQzV4+PlMFheeLaEsAkR3AM92Q6UgJ6UBmaiX90NEp7
 DVOECqsFdwRihoeP0DR49kdhhaAYnY6QqTH9DpxxCeGuC8edcS9GMDlUk3ydh+rWY7SKspXSvV3
 lM9sgGfGZBCcCiQzyxe1oNgr/1fFyiFC0zZu/tWcJ8S3KmECdRuFuMkILRCrQZCTskcpX59PuBH
 en2ZgAigOpc2qUh7dVozaChozJkQPVSxpqnC5Z0MMDb0mog70TdGf1Zc+Iy/KjfYxU8FxRA7XeF
 JUkf6aDuzQiZzDCh6xn0YWLDzf9oKugd+qonp9Xf9+bgueCAkW94Z6KGaYRgovwWwaqKPV4Xtw/
 DOwdKABZUa8jNQ10U9YBy4hwKs2Nl5M0MUtUH+kw=
X-Proofpoint-GUID: o_80DHZlJHMMuNq34HeeE25kJVLoNkwe
X-Proofpoint-ORIG-GUID: o_80DHZlJHMMuNq34HeeE25kJVLoNkwe

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
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

