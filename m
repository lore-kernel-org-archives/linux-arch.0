Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9282417D9;
	Mon, 16 Mar 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625071; cv=fail; b=b7+Haop0aCJO/60BXZRe7rWVFZIvbsVtpL6Agwza9k+eyf3j5IUxGCkQ8YGTb+IhyWeHzmzUdb68idLF1+fUcJR/q1pOMXZloUMZYTRAOJXB6QIjzaINUV0+VQA+i3U0B7Cwzc9cg272aH4zFQg2480Nd1pqhNheFJQf2kpquWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625071; c=relaxed/simple;
	bh=VY7YpCkzTrVjZwC31hSC2SfzAEDkVp4LE1eNj3G7Ebc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DyyPZ58fgRkTvOnwLDAXqsVLZ3dKpVvQ85CKJKJw/sMlMO7PbKG8PxTsTmCvptAXza5h6V2zlZaDESOFZ4ha7luMvIyh6to1d8AkqxJHgCfTYxnJnjlYsznJQYIdjWEcCpb0Kp8cFXeezvU0hSgnNwADJwcBDzc+1LHelfzFkIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKJerYHK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lMhXqb3v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKJerYHK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lMhXqb3v"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0Kxlv1338917;
	Mon, 16 Mar 2026 01:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=/TxwOqXaMzZMf0+F
	h3uTwpZyIF9kAYbZ+J7tryuieTs=; b=lKJerYHKFLMrS88gviiP4mzIxXnJnS7g
	gwAzIky+RqWMUbMq+ZdcNEqZaofISmaG76prWLZ/NITSeNhj4g5hqeZ+mcZ+IuqC
	oq80/NywCnx1kraLlEXXDjKrBUMZcKBC/bFhGw79UN/WiCQwt3C1FkHkdQ4y3JkL
	qoxikJy0vxyYi2b39+8tbLvz0fr2R0XyNfKzItNYkqOn/cXyTE7uUGokfW64P/Le
	DNZTN7ZImD2I8QJ0Pazy6Ovwo9pl8mmSVE610SeysYfFegoYcqWhzfmO3092AlZi
	X9p9Nw/XNl3UpIHwtodXaop/DZLmaPUBV+ujc4I0X3QmEvA4pLZ7Tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b1bh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:36:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FMZmu1030614;
	Mon, 16 Mar 2026 01:36:57 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx48043c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARsdK1DyFrD4vN+AtFlUstOkiVjrI4k0BI7h2hOkScR16Rpmjadino3TPjdelSzIudtVJnrq4GzO/crfTODYlDLm2MX9PbYR/jD6UQi76YL0vYK+klQukvIBBZq5tAdcvVx8a4cg1Km2pkXF2rz/+4mxhzD/XA41DDNo7/pX7bCsH9lBso+6/Gl5Mx5As9ZXENMjJwzCOSEW1B1eGzv5jLynpUIvdqjxcWGcjFaEB1GdOtGWB6OrB7TyFJGib3TtjmJr7GpiXr5Sg7W0BLCrYFZqhBcQt9eArBoqlswfrI7qJBXJw5S0/Of+TR4M/pBeygIBS7DLjtbGD0EO+gdZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TxwOqXaMzZMf0+Fh3uTwpZyIF9kAYbZ+J7tryuieTs=;
 b=pd3C1QtGSPuqQi5CPsbsGa+I57nMGoA7QkFH+IUnb10aVGFtSNpWBvEqiXoAi3CRXfxxO5Kt1FAwiJ83BWz1rGxua4WEnTuyrW/zt5MntIVdBw4hreaDDXsRDBW48xlIQ6s7ThqoDMtQubTnGTXnUu70jjriQ2Ocs8H6NHibznQ78nlC5x+uNt0tesZlgarYBRW/K0yx3fwcTUcZtBJKgq0hGouFUxtvT2q+mQMtIJym5C6pCkwZL0KgSLbJ3TaCjbFQyytamSBg/P8wA6sZUO0dgYFor3qkg9zH60jwL9xOo5ka4fsf1XKI7fObMoeARdaXv007vqmYzHN5nI1W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TxwOqXaMzZMf0+Fh3uTwpZyIF9kAYbZ+J7tryuieTs=;
 b=lMhXqb3v5dtxpKnfTNgHKCKudsJ7MqaF265RvNwq3UtxMUI+Z7naIXnLt0rBeLBvos0LBp6A1p10PDbuZkM8/K8GfRRRvnClIiJZNmpnmZC5JwGWpJnY7j7aMVWpiBkxal/DQOk2i194MYaNIUdH6yKVfweSdePcwuTnF6R5HJg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:36:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:36:53 +0000
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
Subject: [PATCH v10 00/12] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Sun, 15 Mar 2026 18:36:39 -0700
Message-Id: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 968ea1c0-eb65-4d3a-6908-08de82fc8069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	zhr3nOqOwq7Nt3gI0mKfEA9r/FaVbT2RhNil3Lu9toBmyRGful411IuGz+zYo3iVYI8ByJ5vlnZIwkygESMuMzHwj2xzgqXfhTRh3GXj3o577YD5kx269o3iQqu3398DKc78LezvmA6iKDwagBoX52zPYKVPLARlNjZYFAcMyc9FCR3T5y2yqsvClXEkps0abo7ZI8qNKigC1MKe+KtuOkuofIqw5FaywUDCdQxrfBP5KY0zUdbC9geXzFMfeKoznZEVlll7k1N0hO1OFdrN7ClGe9/DVIwW70b7lYC12MHB2unXpMCQt7A0JtJubZ/tEG9/GQbEUmcnREKJ4CItk9mCxc8t93atV4fTtPhZUtCxDiCk3kltNuRKmVmHKrPknnZQ0rbwSavmqVioBT05sc0pjmJhLzP8G9942Xe5qb0NWko3h84kyHncfkL+zF1LUMxndbPGC/TWOVAHttQ70/8y31bP5T4o/N3c+Nhft/mCBUANrYX8kBWGOUodg/AycI4RUWxjMSu4AuNXiotEvrOyBX9jVuHe6ca1Yx7EjL+uBBFE8/Tm6wJfyDMcILMlUi6rFP1z6zTGxr83j7OIwowYTlTmEMDTXzQrQJ1uVOtm+w93nAN5bcribG2O7DjCE19Z1Ib82LzKPObLb2+mTkd7mJNb+R0X6srL6S9RDOMR4pKfLj3/HS5dJNyb6rEFirUkRkn+XKoIfvfcvDUXGLrLkcewlRLisU2dz72JhX4VBE+lQKfbRznR7M0M8ft6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AV8ekg4unoaVjk2Svad/3uuEyaZe5lPpvWYo2/yWp5tH+XrF3peL+83AvoLo?=
 =?us-ascii?Q?fYHi7NBExTaIgFg6qi2Nyd6Irbx+HE/cP0wmWCuvzLz6gdPb/KmXw+KBsc4c?=
 =?us-ascii?Q?fF0rNGW2zL61KhkBRq4QWb9UoXkuTPyy4wmpVAWhsjZPmr3tCRt7DdYzYkzR?=
 =?us-ascii?Q?GgiLEAv8LY9GIVt1QIVDqQ6RaYhNurT82nIJUNUvkxIpfuyx8rmPlg0SinC6?=
 =?us-ascii?Q?MKSB9W4P2+XEYaaS4BLv5890C59gFEIfedbAkhEe1HDtuRNlrI/0/Fd4yVdd?=
 =?us-ascii?Q?wxqg0vdwqFkHBeKM6DrkMgvcXuwtO8Em5AKk1+rJpRG90rUnIcmdN6LjataU?=
 =?us-ascii?Q?QQ4tw+y3FCcWpL2MX9FpabKAVYCts9GwENIe9ktBHua22gy78qn78BHUdy2n?=
 =?us-ascii?Q?DJR6byBuyjl+1uVWgfpGRoV0psmx8O045i9WDQj/6R7kuaTI53mkjMO9/zPC?=
 =?us-ascii?Q?JfPvsMXV0//VGdVov0qXvth/iha0L0L0KZTqHsmoUeAVWh7gRYmDqzuTYWo7?=
 =?us-ascii?Q?hEIV4/9QNmtBXYzrKg05HgFyX/+LySSOHCjKwBFGEGnGjxyIXVSiRarTo8ho?=
 =?us-ascii?Q?7MG3jz7M6CsGnjzsNgbgQdzH+FmbKvZw7IkV8XcSpFvBZNV5sHGElKUz5hZ7?=
 =?us-ascii?Q?MNTq+Nu60yNZb9rWUdg/vlONQfNXx+IlLc0KkDkM+zqFVJQMGMBHPjrKjW1v?=
 =?us-ascii?Q?DY80cnp+EIV2x0r5Hrh73Zav6nmpgXrcsk4iTvHMb8gcM9tG9kOCWo1Z0cZD?=
 =?us-ascii?Q?F9TR+pLCCvAgf4c65T2nP+8sKPJzRSL9bcvJGJuytR3sjs1DzKZmUDpflf+W?=
 =?us-ascii?Q?tMjisTc3OA029w0ujTaAxk2uRkqHrxkKyrFZMC9DYn4QJMWP3FlTXeOd8eBx?=
 =?us-ascii?Q?Cqk6/8qi+Ypb9mF5N1Ink8NwCXxSRFwcQEZvZNSZc2FksFoalLeSp1Rrm8NG?=
 =?us-ascii?Q?/zU4QC013U8LGUvnp6pN2bE10Z3lckjsyUpMMmQ3XeEp7a7mFrQams47wAu0?=
 =?us-ascii?Q?EvqCe+kbXHJQiwaEvVF32dlTiRZzhpbVnYwRKV7uZNari9J+HkR5ByJVciPM?=
 =?us-ascii?Q?FZ3v1evdcAStqv4eFb1zr3DiSTDfoxAiWuqEPYP+lUux3Sdj5Y8Spt+u1LWI?=
 =?us-ascii?Q?lwDRt380BE/RTvP2Vaadh0e+QZThEAFr3L4GomEeRq9BOGogmX3MXxJ37IyA?=
 =?us-ascii?Q?lS11nSJvoxaoMkP28dcKjs18dQOjVArhoY3DFtkW10F6at3S03SsUhCIv2xa?=
 =?us-ascii?Q?GOeiLVsNoMncDvhg53pw8dAlabnwILXmENBuE/oDQ9/p7vdwne1S135sFWHZ?=
 =?us-ascii?Q?+/et8I75ulTBMf+lXRJn8U5vxcajYc3VIy4y3KmV1jE96izJ5EvMN0BW+fEr?=
 =?us-ascii?Q?6W5fg78s+1E2oC86ILbCasPyJ1hL1fM5lY64gIFeALbEdKqqDtd9jhvMWrAd?=
 =?us-ascii?Q?m9yERO7FnPZsvizUhg/OxZst4DLbBs3hhww5uvcgS9dPLkTVQoQkLuAQbQo1?=
 =?us-ascii?Q?zMtY0IdV249QjXF0fGa2KHTDdL1qq/o6utZg0RDt1w3WajODn/bY7Yrpk6J2?=
 =?us-ascii?Q?13mamwOa39foZk4AWLKT63mzMN7HfKTEvVSVGVc+jNh9T+BqpyzTqg3xvnFy?=
 =?us-ascii?Q?cUtkGA297TzfLBJlNkQ6uHq03i63OmaHbkQI+2CJb7zz1NqvnR5NOUPKgIcl?=
 =?us-ascii?Q?ct23bL1dYe0mreOsLDZEYLk70vQnoYjjes0fGAEBbXlewQWl9KjORiB1RZrj?=
 =?us-ascii?Q?BV7Ybmo24qUTptHyeIIIyOSX/mAFh8Q=3D?=
X-Exchange-RoutingPolicyChecked:
	OvhA0UL2t/1ye82Ay0J3jw0GDgjiI9z7vPj/aEUTWEO2V4fXxB6CainDrQcTl1Yv8WBj4+xhN2/IfDr16vxCGL99fpu01eMCZuoRFSdXxf6zdR3FCzKUmZLDbNzMFZEfQ4eFYrU3QJF+qLmT5g+GOQQGMvfupKCQ9960wM0xaD8kxtXgZ2RCBusUN+Jvwiwdj9OKuKlSrMpKUenExj+/KP9PD/ytxjG5bKuw/rBYjhe9cFUuANyvaSJV7JqYI/KG9fNQI+viF4TmtiGH9bmszCBNiDZkyyAZZGa0FUHi08UtgNt1oqGY0p2L1WZrGS4dGWatewp73jovv6pbhJJA+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K2eAlNjSs8m6mSM25wG8S1aY/H0TuRgjlWy8M0paKsH0ha5cdiCxjef+fiVJgafT+BWlt1sahTSTiFxG0EtbZvIsgNSB9NnFcZpQerrfYszYyzg6qGT+bjhc23Ulta8rfgFJc3WE/EGc49KM6tzJJkemqzwc3Ewn6tIuCMDcfRaKY0uz6tJdtI+tmefkYwBboH8JgA4LCdheQvoa3CCYKW+GRPLB4Zg0ZpT/aGhiFklmVLB5G8IF4e0NZmXbzn6fzXUlvhBRe+t0scl7XYJUkx7SLzCx5gx3IgERaMBriwX+WYPQoc/VMFRZvFzJj9r5WskHmrefIAUN5T4IL3JOuclasCtdcDQBD4Y8Cl9XqcBkFd8mzN7CcFi4sZVhU9h+9nd2YrZavUO2HM1GDy/Bj0tmog+k3xElYRdMkel7nVaXNDTqG8I8ceHwnGD9GYeZLl5klFAxIO/gSzMoLNFWiRL5rKQTOFyGrBzJyS9mBJmapmw7EQNffpTvmUP4c7mGMAI2cIcYPmfgpj/i9Id0aiOJ1sZPgx0iFjrT2v5HGweVMJijKAKmKpnMx1kgzQ15mLnVtdbkdn2XKYEEh8lOckpG5riTTi4ECdp6gsVQdzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ea1c0-eb65-4d3a-6908-08de82fc8069
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:36:53.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVi6njMXj4kLHdXqezfmRm5kXlQf87+RHO5l1+o4FOocP2kMSKivFxyMDMbLhcoBKil7pkWUQE05jBOgi8gT3Lnn+HE9O+3cK760F7QKxbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Proofpoint-GUID: 3wlmbmakRm-irW1yev2rCREkFV5F_Ars
X-Proofpoint-ORIG-GUID: 3wlmbmakRm-irW1yev2rCREkFV5F_Ars
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX42C/Pufr2GlB
 a6UF4RjcnVmGKB3Gr1kczho0XmNwHPgZEqbASgy1FGlBA39TafulEJlGin6GHQgIr31RpnkIX3C
 t8NAbfiR5yTokIDfQRwGeGrr1iVwZWGoQSRtOSjOpCSrgJkNy9KadgwqFr0dnC1eWTxyd+KVTY1
 pmjoQJehhCcAAsebFaVh4+u9okP6CF9NS3S16EPtGz0S1Pj7HxxIHhWvXm9jtAVcPlEK8LeBYbI
 QYMXtyqfLhltxflwUH4oegojX5EYrp4yByTHGuYlMvSong4PYmKlmOEpHsbT2MX35Dkbv7FO1/s
 MKUcuhluQ+HM3V30Sq1wWYJJ53l8fr8d8SNLPQjrRlN2kccvROicOptz1s6IGyz87e47JqfTg5n
 Ew3DnmJ3w1X+H0k5w0817yN3126IZIg8LfT3/b4L5xAiv4rn+CKOKvwkHVQiAWx66iyqEgG/61i
 8DWShkP2Rcdi8eYHQBg==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b75eba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=StAC9Qp1_Vm3cNwxg3kA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22

Hi,

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

With this version, the main remaining things are:

  - Review by PeterZ of the new interface tif_need_resched_relaxed_wait()
    (patch 11, "sched: add need-resched timed wait interface").

  - Review of the BPF changes. This version simplifies the rqspinlock
    changes by reusing the original error handling path
    (patches 9, 10 "bpf/rqspinlock: switch check_timeout() to a clock
    interface", "bpf/rqspinlock: Use smp_cond_load_acquire_timeout()").

  - Review of WFET handling. (patch 4, "arm64: support WFET in
    smp_cond_load_relaxed_timeout()").

The new interfaces are meant for contexts where you want to wait on a
condition variable for a finite duration. This is easy enough to do with
a loop around cpu_relax(). There are, however, architectures (ex. arm64)
that allow waiting on a cacheline instead.

So, these interfaces handle a mixture of spin/wait with a
smp_cond_load() thrown in. The interfaces are:

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

The parameters, time_expr, timeout determine when to bail out.

Also add tif_need_resched_relaxed_wait() which wraps the pattern used
in poll_idle() and abstracts out details of the interface and those
of the scheduler.

In addition add atomic_cond_read_*_timeout(), atomic64_cond_read_*_timeout(),
and atomic_long wrappers to the interfaces.

Finally update poll_idle() and resilient queued spinlocks to use them.

Changelog:
  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (12):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()

 Documentation/atomic_t.txt           | 14 +++--
 arch/arm64/Kconfig                   |  3 +
 arch/arm64/include/asm/barrier.h     | 23 +++++++
 arch/arm64/include/asm/cmpxchg.h     | 62 +++++++++++++++----
 arch/arm64/include/asm/delay-const.h | 27 +++++++++
 arch/arm64/include/asm/rqspinlock.h  | 85 --------------------------
 arch/arm64/lib/delay.c               | 15 ++---
 drivers/cpuidle/poll_state.c         | 21 +------
 drivers/soc/qcom/rpmh-rsc.c          |  8 +--
 include/asm-generic/barrier.h        | 90 ++++++++++++++++++++++++++++
 include/linux/atomic.h               | 10 ++++
 include/linux/atomic/atomic-long.h   | 18 +++---
 include/linux/sched/idle.h           | 29 +++++++++
 kernel/bpf/rqspinlock.c              | 77 +++++++++++++++---------
 scripts/atomic/gen-atomic-long.sh    | 16 +++--
 15 files changed, 320 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

-- 
2.31.1

