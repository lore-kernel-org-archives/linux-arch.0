Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD424E4A8;
	Mon, 16 Mar 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625076; cv=fail; b=m6kHKHtup+30ibLvUgpuF/EQdmSBsKQpMUgVopNmshh+6vfv2E8NcBjOUR/CQnyLKgKufDA8njnIZg+V5HT5p4afGW6t9rEzzoJo2TwTJBlAnUonBX3IVZIEsKYoYyt4H/WorPVEWIVduV3d4XxbrbMRmRC/3oLDHKn5TOCLIPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625076; c=relaxed/simple;
	bh=GTBs032lC3T/gMgBRYV/zuY14CId3AKcpVhFMw93giM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9efFoIFsbIuYHDReCUwzBtejVyYfuq/2luiLemmkVjHjvPAPLGeKrxLB2PUxjV5qjXPX3luQaaKrvU2KpfVD2yQUZEgocYtRKKEs5s+6baSu42HnQQw+0gPaJnzZTnhW4wqnUI6RgTIfUr74MKxZacWN8gPtaN3mGALdPz3oSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qtNSoA1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tc+pEj3r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qtNSoA1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tc+pEj3r"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0Tx0v1498676;
	Mon, 16 Mar 2026 01:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v1pV2YkoSakXfwsfUB1eT6ng4hrJo5uHjLa9kkD7diI=; b=
	qtNSoA1MztKScNe0DyS4HKuwP+kPIh9gHWtkkaW7ZW28wAZOginrWosXnxAqjxew
	r9mkzJ7B5E9Yqk6cAmLfLR9ItHkUUhllLmn1Bzci028bAEI5fWFhF+20Fu6cuA4t
	YinR0ePSnAsPPSRUUvNcDa1K79ldlF33FW4Qgd5TCey7HUr1fZdqd2/V03vHD59L
	/ZKN/LFQ3P/pfR3lnMeZnE7LzD2/psHj8pX3ul3eHoXSXVvqiOT8exmm+EPIg8Zm
	YMZwVjusI4LupJZX1xHW7kUGNq4lVOpj6UrtsSCfGg3G2WUIK3TGKiJ7+Goe9DXg
	S97ZoC1R7YxoZzgGaPgHhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rsats-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLlQHW002861;
	Mon, 16 Mar 2026 01:37:06 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4j84md-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfzvd5J/Yqn4zkV5OnGPx5ACqpGrB2XYoaYse458XkvtdelolGuQ6j8NzXlnZlGuZWhY/8DN1EJ6metYHkb6C2jC7ErEHHXgolA9stLHS3kL4Lt+zFMHtbXuNel0gkLazZqJ93lLqytP04Aoq7Lqp/UjsIt8f52HPqXOJkLziVod4ol2janUOOZZhIn7BLG50M51qV8ABS13CsK4nDbSYNy5WiimQjjZnYCSjv8Bmu2MsPMS6AYQbDKEUWAXbacP+chZR2wrVEFfBT4WqOby/7Mr0QNdyOyZU95ZVvUoP50xVItZtnJBdSn7GuvZDnlHm0JwP2C+ZYFt0iMIeWmtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1pV2YkoSakXfwsfUB1eT6ng4hrJo5uHjLa9kkD7diI=;
 b=Mp+YAUQEdrEyOo1wBDPRkCv+RSykTqSMTnEMX3Ku/Q2I//VK2PGWyIr8KJ6G3eH/6C+O0D2fap4tXyo2/DiE/eaTMKqB8Fi9YrQgBA+/kUuNc0FNNKQeJxAIrjnBZjUapce+/h2wTL8PwsqgUaQRPizMnzyeesE2hrI20ZQmhqX2as9kR4BZEYcoYXbTC6cB+986YZhvQ4sQH4CFGgVgnPHCEuMoMoJjaarxeCsKY0Pg1rFJ/S1yOV1aNY1bMAnZON/Teo/ldF/Kis54PRIhoihW9K9db6AU7KsuqXLPut1jEr1HastAkR1paW16biyjtrxMi4VVtwvipjm54nQ8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1pV2YkoSakXfwsfUB1eT6ng4hrJo5uHjLa9kkD7diI=;
 b=tc+pEj3rfHakTtmjg3Gbrfjpqa8v1oVck5gGdn8it57k9I2leFCUzJ3bKcRr11uR0XPpLDDIiA5Ov6Lig54sq8UU0MAtWLguarJvKT+K66GqJXsQeFZr3qciMuFE7Hkqn+LYAm2GoeXDr60qEV+9ON+GF8dD12qSmn7aqpJF5J4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:01 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v10 03/12] arm64/delay: move some constants out to a separate header
Date: Sun, 15 Mar 2026 18:36:42 -0700
Message-Id: <20260316013651.3225328-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 11276a92-30af-4b6a-9bac-08de82fc8570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ngAfXw1OtLYZ9Q1Jngawe/IMYG64Ao4y/V142YlPyRWU/THavrmTZsbBknToQebEI/om7jf+HiFGU+sLR3wW/gFRZL8ZA3LJvex0vMiqz1AYwD8e+8OOb3cOBGZEiaoYtPjnvH66alrWmrWogf33MloU2FBDgm90u25xjJ01AVIjZZtrRYK3ANF4IeIWDTduuWgcY+1Gt38eIAthA/srbFxPPUPesifeBeciwhrd9Rd6lYMueEe5Kxrxh/o8Yq0ojSgzi1zsbf227cRYjPy8qpBUC2Nyuty6tkBy/Mtli73+g8sIB4dWCJ/9zvA11z+vUMn8AflUBM+tktk+le1/ZkudPcaUD2/yFXeRFvQ1EL0nJr6k9a5UiCcBBNS7jwLa2XaBBaQZoUbWoDHvKUF47+YsDAkoRRZefKDLoDcykJ9/lpJztIilqilhRzN7iW1c24DzDPAuV9MtyiYClBlj7M/uOHmeBcWDEDv22rcCqamhdaDoUdPUyVCnl5P6pjqMWclKWmQ91YbfJwUg0N0nllgcqp0FXKewhIU75w7UMZXab6d7CPJ3TgYLLebX+bv/BVs3Rdzmfq26MNvBdPRkdYobuIk9p8gdqgLwvpa1WQZdvVgbP2oQvW/tK2htCFLSJTVY19w8P67j/KNRISFvGskJDOLqEulVDXk9t0aGBJ7Cq+1R8MNk0hcWOrl3AnoVT774IoYM28VO1KgAFGzj6zSReVXkw4ZcLXKKyCOWYIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7O/GoUVoHGi5To8D6tEvS3ntk1U2yJjE9J/0rS1zT0lyTt6aUZjqynA5R1O?=
 =?us-ascii?Q?67b1GSJiHtjb8Ksj+1JPj4p4zCpkHINjO2fbBH3FbmW+DA6brALrRNzTWrH1?=
 =?us-ascii?Q?vQoN6tbwMS+XHCkwbqG+NqIKRhDreH4SluRTsqCnnvG1yqWpo6I6j/koUg+n?=
 =?us-ascii?Q?Qze82evVL65hKSXK0otMXjsH8pmasp4Tx39lcsrWvu/BDY2jLCLJETH8U6U0?=
 =?us-ascii?Q?KNn4V58ZhdQEstPvprac2nTu9oMQ2L0NEibpWavRPM8Z1Dl7ql1Jjj7ABjv8?=
 =?us-ascii?Q?t1zrpxqtclQD84prjCEuIutEPxeKddYism3FT3NuYIyoSEaiUSI0zrdXseri?=
 =?us-ascii?Q?xc+rG0CB1wSBpfXcXYTkfRki0QIi3jOu3Bp6C07liN7E9NIR9U98D7Fu/8XE?=
 =?us-ascii?Q?YhN4P320nHI9DlbgvI/6gDdqaZ+YkuFXGBDc6gMQVH8JLeCqQAT0WxzhTWE7?=
 =?us-ascii?Q?dLDLxVcPIWh5zt1dgpAZ6q6C4lw+TPZzrIMq4FmvE4a0YvzHKsZhVDNVLPnj?=
 =?us-ascii?Q?2KdGcJjIDe6LyehmTWF/Z1GSnXFDvtz0FDMyXecGTxlUOxmJ7TBcnVZztOxQ?=
 =?us-ascii?Q?lkTK+fKIGAmr5BVK031UpAo+r9YGYZumfkUSDszUgHDCdxVOhHISZos7qBWu?=
 =?us-ascii?Q?5ctgbuxJHItBPqzjyu3N5XHZzv9Z/OXcoHszrUPAC6lvHwJPnSydIlxGS/sf?=
 =?us-ascii?Q?EnGsvKX/gd8cM/WzD8jY+juMjjlzTboKZNdrZtGuBRBvKzGvu8ijebUEyDTk?=
 =?us-ascii?Q?yj+ySiQWAA2ZQM4sZXV9UGzm4H3v9vCcb3AVCBu0Z9GXU4X8Z+fkWe/jH1OU?=
 =?us-ascii?Q?NvR757kZGKdar5w0SGJUPT5Cu69caEJkzDBFHmu1D2xAkDX760SdxJJTyknr?=
 =?us-ascii?Q?rF8k65qxmlMKyr86btqEsYvPOzIDsrXXNc30S4BTVqFzfzq78fqa1S6aApaR?=
 =?us-ascii?Q?6LDzDkO9Ehj4QIB+w34FUQo1xZFKX4dYwx2w3+S/eVVDlKcMX2QQNzBG5rEj?=
 =?us-ascii?Q?Nxik1Bnoy92+XXBatH457kTjJSE3+ejhpbc226/sX81K+/yjSqP/G5RE0QsQ?=
 =?us-ascii?Q?zMyki2c8t9Wj9oTKj72j6texWFv7+vYcMLzQlzfFPHyUOjO5t1roZIOk59bT?=
 =?us-ascii?Q?1NC0iBf2+uT6L36IxE6YKYU7Muymtz0pjSpgE1y436OLh2sy+Yqy7ZQRdBn2?=
 =?us-ascii?Q?HWU/9kmG44Q9/5p9oE2atwnrmajLzn5M6RMebeXmBfvKAbSPiVrbrVRzbWGC?=
 =?us-ascii?Q?FmjyJ2+jjw97FXDApKOPJ2OR13AxCDQL+H7MgcAIo0WpCtCGW49wkdJb6OJN?=
 =?us-ascii?Q?uqhZGurXFAa5KgvBw62FqX3l/avcrXohB+x7+BrLLGM5jcozoWSi7B5o/vd1?=
 =?us-ascii?Q?+EPVU0SSlcCHwA+5rAA1MV5Kmw/vX8VfUN1CHFDMEk8PHNwQR2yoY2mno67C?=
 =?us-ascii?Q?T9xHoWCENlGtVNON3t8S5mstBYNNGGj0E4efqKfWTqSYsRRC8MTtJDsC/tiP?=
 =?us-ascii?Q?5j9O/Y6VrDhf1DEF4sEuBj+O4DzhO+MzydAnL2rQNJc1WxcZ+Ejgm2c7LHR5?=
 =?us-ascii?Q?mT55/aEATRwJ49hN+OUsqgOb8VRJn8eVpC74+IXHbIlsFwbh+yMEsrDJATYh?=
 =?us-ascii?Q?8vfbSno3iqAik7Zm5lVgzWudQom1R9fuexNyXyhukzkm/1asSAYdUa4AcCBU?=
 =?us-ascii?Q?qmr+nxQmPwGYj0I/I12k6XFFgWOivnDfChFouht/vdzaDpmQ1oRiBUYvk2nF?=
 =?us-ascii?Q?Os/HYKwtqLZW71o93UdPPvIeAzCcwYU=3D?=
X-Exchange-RoutingPolicyChecked:
	BJtFk/Ql6kZZlsuEeuIWARsyAge0VURCtsrmcOGNKqZn9iTrwQ/QevfAxE7lIGeJC6FtEt4SX9ukbbTvVH7gUfEKaVcpbGVyNxAMlAaOaFSEV+lXEmHwiYe8yGkXGPvSakJMGbtTyAFLWU6GtkiL24v5y0Tq4jSi/0CMjxF2mrIb8V3IOuiBtB22JK0+aiMowh30Vq/rijUFCh4sZBM68eo5Eu3P2J7jxMLu3pyJ9d1jKOU0Fd9eojnStcQ4PtuTd/LHdRjOY12oNBX/bveeHMmA5D44MoLYsb9z069HL3rsKWZMOyInPWnfWPNo8ptwGQcZL40SzEMCF1qVpMO9qA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w6rwHOLx29niYun2nHaKVjtp04ElJVCL8qlYFeDJ7lE6NnaIzxjHEbFDQtz6XZvONKBJIgx+66s4c2VzMmd53UhIplvpom8LukjcdZir5h6jrBgpLw/omfeRBv+fc+CGen0wgkrQ7j3WERA/neRche8uLU1Oya6hnZALjh4Ed45nTYqDS3MRpLYObsr24eChb1hwelP2FQ96ABBlPkKgeKx7LeARTxiSQLjXCVCtcjWjYsWm9vy/zc8HXv9+d0b8fStE1CspxL60jyJRkeiu4WMbtAuqzP+XA4hksq+sidoftmvPLwmTFNz/ExNccSOoiiTTWPhJsCKqhdeeJTtyz52QNd5YAPrch1ABRIhP4jJp5E8u4dlvb5rCBm6w0t0I90KaNaFquwrFaus/bOYCssdAfd2KkAFhJt8dkuha+MuLP9qhAJX7L4SnMuSf2c/5HYTrfMnPWyrR6drO4QbZjKPdlmWLUBr3VX4ZEpSFH0U4WUbcpVxTwwMiRJ/QJQpk2J6TJpfPrZza7HuYtPe8E+zTIcsFTlX05yl/wgG2H3at4MSTDYVfLv9+HZvHXYuIOGpH97GaTG0GEaY4pp9xou0SwTCmMSOyvA5ZlDzLzm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11276a92-30af-4b6a-9bac-08de82fc8570
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:01.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+lPFDiMlNkwZl2++hVITem1GCJq/Lj+reaXHQk30rOEH/NYerjHVxNOiLEjKo/zx4maP4LfASydJenvjm9qQH7jX7exmRqAZ0sWH4i5eYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69b75ec3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=gQgDrPkycQ706KZxoKkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
 cc=ntf awl=host:12271
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfXw9NdCs/MCJNx
 9B1q3lEO8krKWJKuk+UkySYI4LJbfONAv7lshdqZfw9/wF75VK4ywcfsoFGfv33yTjI/Nfbm13J
 8EQJvPt84w0jkCXEnk3SuuMqiaFTYxhTiXIt0r2J/4CkGyJEgf4R9ek28rMaTTmL5mEBdcYf1Rg
 jA6OBGEqQvymn7yZAt233i0/DwNv+h0xGFhblEmOJ2HtmINgUOAP7ZdTLLyUNLzAaFoPGIQu7e2
 EOo0QDcOwsCszW3/ERhk1Vd0/ERmNZaWKeQ4QO608M/Goemz6Sl6MkGTdz6of+RwtJGtu4xAmtw
 1xIBI/B1/iPi8ETrxbEmeHT+SCFbPBiH2tMJvoFCbmsvPfik1Gc/+2BwqWMMbsZjiOCbKdutEZr
 CXuEsjclQwp44vpvHO3gBszT5i5I2DVPrZksgZD34yEAc0980MMeyVl408t47CLW2gaCyV6xp9W
 JTHMow9qM2EysElCfaBVJsCYkCOW5E75XdvP1Dsw=
X-Proofpoint-GUID: 12qvfdV1Q-2MWEH8uI1PBBsdPe2XhlPL
X-Proofpoint-ORIG-GUID: 12qvfdV1Q-2MWEH8uI1PBBsdPe2XhlPL

Moves some constants and functions related to xloops, cycles computation
out to a new header. Also make __delay_cycles() available outside of
arch/arm64/lib/delay.c.

Rename some macros in qcom/rpmh-rsc.c which were occupying the same
namespace.

No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Note:
  - Makes __delay_cycles() available outside arch/arm64/lib/delay.c
    and changes the return type from cycles_to to u64.

 arch/arm64/include/asm/delay-const.h | 27 +++++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 15 ++++-----------
 drivers/soc/qcom/rpmh-rsc.c          |  8 ++++----
 3 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..cb3988ff4e41
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <asm/param.h>	/* For HZ */
+
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
+
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+extern unsigned long loops_per_jiffy;
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
+#define USECS_TO_CYCLES(time_usecs) \
+	xloops_to_cycles((time_usecs) * __usecs_to_xloops_mult)
+
+#define NSECS_TO_CYCLES(time_nsecs) \
+	xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult)
+
+u64 notrace __delay_cycles(void);
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index e278e060e78a..c660a7ea26dd 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,17 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 /*
  * Force the use of CNTVCT_EL0 in order to have the same base as WFxT.
  * This avoids some annoying issues when CNTVOFF_EL2 is not reset 0 on a
@@ -32,7 +25,7 @@ static inline unsigned long xloops_to_cycles(unsigned long xloops)
  * Note that userspace cannot change the offset behind our back either,
  * as the vcpu mutex is held as long as KVM_RUN is in progress.
  */
-static cycles_t notrace __delay_cycles(void)
+u64 notrace __delay_cycles(void)
 {
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
@@ -73,12 +66,12 @@ EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * __usecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * __nsecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__ndelay);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c493..ad5ec5c0de0a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -146,10 +146,10 @@ enum {
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
+#define RPMH_USECS_TO_CYCLES(time_usecs)		\
+	rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL)
 
-static inline unsigned long xloops_to_cycles(u64 xloops)
+static inline unsigned long rpmh_xloops_to_cycles(u64 xloops)
 {
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
@@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
 	wakeup_us = ktime_to_us(wakeup);
 
 	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles = RPMH_USECS_TO_CYCLES(wakeup_us);
 	wakeup_cycles += arch_timer_read_counter();
 
 exit:
-- 
2.31.1

