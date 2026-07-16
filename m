Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17031E824;
	Thu, 16 Jul 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185329; cv=fail; b=jc6EqjMOY0ugjn7Hh2Br6SFT/MDLor7GqWPX/+rS3BnJLwziZYT1C6QbBjTa9rYg56yENPMZ1R2CzHqeT4WJ4qLSeVAMcXztbWOM+SePAED8OjxEnwXeq8uSMf0kmCy2b+iOesg3W5bmb95YcYTxrVqoGZDTB6x59Y2JET1yyw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185329; c=relaxed/simple;
	bh=EIOGlzgiZ1537R88isb0pxkzF0A7xXU6eFlL3QRXv7Y=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=NDGtVERP1jEO9CY2u2COlhY22rTd3ln6yQu7rjgvXjoXbvcdOnwp6kntqQaHCCA8MvLWT/M0eXDxnQxRzNrHEvj9Lzx5gZjo/A/SdG32bI/RtUll5wFGnzniCgEZ+56UfM6SeRlF9o/XaDl5QQXqwdo1iiGeDFlmLwZ7KJ1+LnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fD8VPK1L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CF6RE4PE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fD8VPK1L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CF6RE4PE"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKN6A83848726;
	Thu, 16 Jul 2026 07:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pNLS94VjtMCEEn4vHS
	v+sk60S+f5LkeVbX1u37sizo4=; b=fD8VPK1LkCXH6VSYwu7YQzHEdPx2+8cOW/
	Pj+wmVRvTzs18nLLGTHN1xJi6BxPGYhUWvdeD7WeKutF2Ff4xPQIL8QZzAR3ETKJ
	Ssy8pkjrCrq59NG0r/c/7DfVNR0/EdbhbwIN13d06j+4KMzb4qTNr3tDQQ4v345N
	6MCG3JQ33KxQ2frNLCWEehF52ONug5ehkCx6mqlQZLrKpAQlnVfH73u4dRAkAe/Q
	Pse+IegtdS63mjkWxiiyupya+x/RU+1hnOjal90oAJqgRC4rlnZ6dxUHnePU5/IH
	xEyGwZH0+QY45XYXe6uA0j8StylJsqKBM0vOp4/8O+VtKG6idVPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fdhn0cgqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 07:01:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66G6wVCa017727;
	Thu, 16 Jul 2026 07:01:27 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fdmhbq6g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 07:01:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA55tDLTmC3/X1OV4j02IFx0sDdtLMsBtqVpjpZnJyCq0oFtohAx/79RfJGImRmYrV/LhWnlT4nRz6gZMfoh4vnr7daKT55ebywfOrm/kJazhwAYjoOxjdtgyOxImHSe0nIaXpsROOrm7paSNwpxgHxde60rN2e+DmVlCM8voBACIfP4necPZZU/etWPI6IIBlVM2fR7luHDsUecvX86WilBayB5+fkWF0ajLuP6YSAzvfnv21CEcBjbulFVXH4Fz/O2sqsnokIAUtcNnKJRlYYijwB8x5PaUiZQFXqPWOmKIjOu4j9H1kBexGttk2a/gZKeXCOY6d0wAEz5B1+I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNLS94VjtMCEEn4vHSv+sk60S+f5LkeVbX1u37sizo4=;
 b=xpqCBi1tmHYIk3cZSX9K6/slOTgcVE2w3dKUPvRcezQkfu1uOfDiPZPGGJxsxeotVzluMCPYqyYobrwLdxER7GHVYziDyjagXRJwVzyk/3ulFhtERoGNsL+nB3+WRSXboVm+CVo0FawHEacZpMPXTBTeQuYQUVb14A65S2afKWBghludV+ENYqfiPEN4K/NakJOBkTKm9OXwhLaYEN9hN4AOoHzNH1q2PMNkhVFGUT6zkAa2eCx/5szu+o+IM056GWLMLo19U6Iw/8UWRxF52GFNk6iuH7HkucFZ152NWje5z4TVspMFgouZHOoU8EgU9ERNG0Frob+J19wEll5VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNLS94VjtMCEEn4vHSv+sk60S+f5LkeVbX1u37sizo4=;
 b=CF6RE4PEVQ/UWs02yQZr4ZWVpRsyCYewqhVERimna9HfNFxDRSPbVE3j/PzMxI+TsZKgEyhTQx2npTL1SUrGq2yayaCLc5epRF5AMS2zuw8L42WEuanDWkCmPvAyQzTd3TBhozJRknKNzFbd4kdltaV+e0V7tPbp4LAhT+58cg4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 07:01:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:01:05 +0000
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v14 00/15] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Date: Thu, 16 Jul 2026 00:01:02 -0700
Message-ID: <87bjc78lld.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: d7302fdc-9bcb-4dc2-1596-08dee30800c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|13003099007|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V5eIN57BDnefIJNRnTnaf6OeEhgY2xf0tZujhlFf625JRX5M0OBL8lXDDyDvn7FU5G8f94RPzWX+1O5bXzqGXuWsONtWl9W7EBHzdhISPe6WW/i1KjRl7rTl3AMfpyxe96XQrOvSdCuMI+PTHQFTIpuTp3udvKntJoi+6bHleTMaqiMdSDNZRD5chT7mTcfjksKTUzUx5gBILl/O8QXUgmXtioXXWb0s08r/UrcXFZUdtEmcDHdC/NFLtlv3EY+rWytBGIWrEoLySvbtPnmyZNHMC2cgMm6PK7fPurK/SPLBnyfqx28KeVzus/S0BoKhIGJ2u+BJ6tr15LMwsA/ZbysqjownSTnfn8xgoW9LwLtaFKCq1a6JsxOLNEPn+hJJitmvmAtIiHKsV+aStX/s7PK/TAQGmFru37xhqvVJqmZMd4pAxiL26uJb636wQNV9Oyxz2KocHbFyyqPvZuTknj6kgdbSrdxIPoLARfVVz4AS264fTR9qiNcOCa6MfCRb4Ajo5ESpEuRuzTyn0PmJs1hXrvRawj+9G295Qx+Jv9pqZmrNuqOzJWCBwRYlLoa2rwdCdAhMv2Fqju/YW3esv6/B77Gjg1dIXTXIY/GotruDYmOjdKG7Fhb2hu0NIFJrj0165p/cNcrAKszxlE88vvnjjATey7DDDnxJOXQKDL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(13003099007)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8U04EU/Eqq2A6O0Z27Milq5xa2vOHreNuxBF/BvOkt48lNCdKjlaR46aSjPQ?=
 =?us-ascii?Q?Dhaa95DwqUzdXYFLveyidGOqXXCbG3SZER8l8QUmULhI8m8pBy0IDrKYZyUn?=
 =?us-ascii?Q?a32191L/Xhkh4BicWhxe/PfsOSi0F4eZ9K5SkiLiswRBHtX84V65E5Uzi2lc?=
 =?us-ascii?Q?Wd2aRbFgUyForOlodd5ICQ9QPn3A0a0ql5wytp0sS7QHE3pkEeiLHrgJv1nY?=
 =?us-ascii?Q?vSRXv56uiNJKKBJFsmt1Sqe4yLoY6g8CrA2UCZyolzCWiUBVvXdfCNNW4Jgi?=
 =?us-ascii?Q?GAHKtgLVY5PbYNq/euSvNjy0sC6OT8UR2nm1ZfaTZ36TnpUQTVxl1o0wbK0I?=
 =?us-ascii?Q?RzyZgH1pnkJfIOlB5r9AMqAyE0YJ31Y/TuQKT2XMzgpJ8oOc173Gngo7be8E?=
 =?us-ascii?Q?SNsTPGLPb9ktq1j7B/NUXz7lPfClUziaURecEhwFyoozTvbkKJI8kLpeK7Wi?=
 =?us-ascii?Q?RMU6SNZ8Nckb5EBMj6P7Ndw5OjZZ8dgu0aSHom0IruKhN7xrQ6LnwoVtfVSJ?=
 =?us-ascii?Q?8qdDV22bdpraz4TESYYxWwe75Jl12Trw1NAlmteHWXDMyBMY+PgQbJkSnFW2?=
 =?us-ascii?Q?z9UTqM23y/NeG6wd6YKsETuCzd8dazj/obL6oKo+bsNObh7h2GN5RIKfHVSu?=
 =?us-ascii?Q?qXOEBbYb+76zD2DVaP62IZMzanqzIXoIfPNbf2cE5BQV8L63MRBt0T2robem?=
 =?us-ascii?Q?TMyH5eslxek6YTj0RentEP2yrCdu3VG2WOwHUVreGwnKVOg1FwMSgkEBlUGK?=
 =?us-ascii?Q?PqKpnt/BGpW7mK75sbkH5cXvh7F4atqRwZjBqr6aUk7zqMIIhJ32x4heTVKj?=
 =?us-ascii?Q?nU0/oz2BmeGmY1DJa7B4OBNwlDb0jdteEMahCynqx1uQI9PWz9qTUys11T+l?=
 =?us-ascii?Q?C7nDO3MARDK2kKT/0jUJrPFY1CN/0OHFHWoN2IINBwqL/F/lJJPWEqNNWpjf?=
 =?us-ascii?Q?G92MhNpyB0Y1LcZ/tDAADnuVIAxddHWneREWWJnQK3vwNPzQBubjKkENjCF5?=
 =?us-ascii?Q?FAJKBt44ZqCJHm42AOM+uEIkeeoqAeaKxaXAzEcnNnYY2bgCqTmU9M1G/swA?=
 =?us-ascii?Q?SLOiMsTEa5Oz0m6lS/8vjWRDmNZTaFt3b8JVOTc6AvqWnP941LwuqAcpxn+T?=
 =?us-ascii?Q?O1xI39NeaP44/NQg8J1mh7sFGKB1wHngMHQNEUijyX2um7wS635uH02suWIz?=
 =?us-ascii?Q?REdoXVezqrubLUKBzANS+pk2/rW3xxszdMYdRyQ9F2pNZnFEbaFd+QUddhTn?=
 =?us-ascii?Q?6SENqnY96wxrYdz6valoU1AmFLr/PtGRgf5mUAMKsI3YaS/eyNlHVBwUZZP2?=
 =?us-ascii?Q?e9IvNX53B6//9EEpg5JfDbWxGMOGyyxEpUELtkbMvba9DfhaOX3WqOQQfkwd?=
 =?us-ascii?Q?8s+aG3m2zhsbK0RNZGakOx1zpYcLI8oeuNLUWY/tyroPA3k4ZIrLyfJmZmA0?=
 =?us-ascii?Q?/NFhxrHne2y5APTve3JOBjcCLkAOrYH9O6Vjc0yEnS1u13qTsSoleyk8qBr7?=
 =?us-ascii?Q?ZkvzEtUA9WW5D1Ec/+ddFetbor/j/A7v+90CL+p01ZBl+dOVJ2RHabijlhD8?=
 =?us-ascii?Q?1nanYrcV4u0jRWr0yCEtA4n/Yt5oFjSA8nYZgH4to+ULhTlnHB9fqoQCKoIP?=
 =?us-ascii?Q?14Qy29j0o3+M9du/0+lFiYprMz45Un6S/DYbYI/okE082YkUWHjHDmttdbU4?=
 =?us-ascii?Q?LmSgA/CvtaN+CX5/26TP4YypZpZHTcB8h7uWF9m6tQqU/Kn4D8yvCcje0vaQ?=
 =?us-ascii?Q?jHuDLSwrP1b5NiwHXH/vWcqK0s4swqI=3D?=
X-Exchange-RoutingPolicyChecked:
	Kqlb54nolicBVbXn4cBCFgQXKyyN77RM4ghwvyuuIl5TTikZqTwX0MN9UB9c8+JbgfcCT9ctnWX4Nn7ICGL/BocW572s/eQofZ4zE7WupSy06g+AMmLD9efY5bHXQgsgDmoaqldqY7mg91EfMGBJr3WrEaU8X69BIkOvqgtwEAWP5oVApVaTFawaJGaiVHTp6FN40SLu6I0IdT8FDtxDvmIpasQQ0DLrKswjzWxVVfJn68/WbpJ3gQImmrbmzqfk0Gep74gaUrowV7ooakqpbWk6oF7Sw20ME8o9rCle9J9bT21czgu+IZRS30Ob1a7yqy7sbvF2kYzvJW+a5X8xTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z4LaV7XLbwTHnQ+YszbxF3S4+4sAujOud/WJVoSMO4IXauWlpMphe3MHXKr+zG7jnyXbcViJHHLZCmUIap/JtBeoE3B0RrL0r2HITuy0m4mhZC/kkFl0fHCq+7BkqtPijX4ZUgkwHs0OHw6hwI1cGKHZzZHWd1sVf+fiDtZtYXseBMrlrDCQ6Azc0KPk6LZj2lfHhsh2WKmUvpDATNN+3EI3I48SWKvGNnnFD36xMVyxvXMh3PCis8000ldv78fuoqaAWAJIbET+Nazs/ruXnmG6n0accsT911BmAAX8B3gbWYTu2qbBvZ/0jttQTDh54HvGGEfBWXIscDH8kLmDmrrL3LGJPrWEx45R99J1kH74sU3RrB2FKfZaI+y0ULlbolRGv95KiT09OcXUw/jT1GWDf632Z1EvUKzihvdnNK+NXwL3eB6NbD/mFzzn6EQnBvjqnKdRaG8tjbXZdJujkYe68Eqyjruda6Fg+N5jiklcLL9XwU/cmruaRkY535dKGNXOr4h2T/DkKVXx3SCtgOkAEqi3o9u79irUl4zVYwpWTwQ6UYngQOx+dsuvQGPNh0XvE7Lb3cvUjxJsy8bBCPCtrwJ6CEJLKBnQpbBAJ+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7302fdc-9bcb-4dc2-1596-08dee30800c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:01:05.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXLib46ZGztv6LZCcEwQecQDkK2MhBqcGO8AW/HGC9oPQ2YVOcojwb3U62ywoxUlfbvFxeCNU+kk/sFUbP2JuFZavQ6Ud6jEkuEukupX/rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607160070
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA3MCBTYWx0ZWRfX7BdD3nI6AL+7
 I03PYqE1R8STFbE+sywVeZPedxvZ0muuVAHmgELLnFPzUs/4k4UopiQCm3pcuCcBAqCC7BT7E+o
 gXnNGM3uqmzy0cpMYNivVZD1RvLEgtRZp72XnnJ2eDFseIOr8Jcl
X-Proofpoint-GUID: kh1JkYYIGZ2_syMPNmVPHq_RQ-BnGYjo
X-Authority-Analysis: v=2.4 cv=ddewG3Xe c=1 sm=1 tr=0 ts=6a5881c8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=iZDFlVA-Fd3C0jwnJWAA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA3MCBTYWx0ZWRfX1tOZndK41ASk
 21uxxO92Ebk90Gnqxj6Y7lYqVXqy2H3V7G+hIV18nTouu0OAwC1i7cQ0uibNu99SsQXwvIz4jI+
 jdxCagaVuKv4yRPH/WwHStCW8eRGPslon1H7x0rsd0LhQUSaIfrqZu8fiRZmrzcSwzAK1tiN1f1
 Amo6+PB/UlC/SGwA78dXp0wmD7UDLBCCKXg0kXDOBd4o2DPmjSOuUpf09BZ7WelIzrnPUaK1UWY
 3crU6fHil1c3bj4lmN0PeQnTTsrJF4lo3bEcPlpRwJa8lWau6IZE6UnY+e2kyzr5fqbmTgk9U3D
 SJsFK/r83InBN1hATULXiwPBMDGEFS2tNq7eESzHKAyXMFLYVhRVEHNt55lepTw4VwSXfU/8AKB
 At2QItAsaYZo/swZ1XXsrFaibSRAN8ijPHjiP75ZesycjEgklmn5NXIjmUcv0LoIT5vijqaiLjC
 sa0AzDiBrCHN/knpRAshp5Y5LDfIM0vqNYvZx64Q=
X-Proofpoint-ORIG-GUID: kh1JkYYIGZ2_syMPNmVPHq_RQ-BnGYjo


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Hi,
>
> Changes in this version:
>
>     - rename kconfig entry for the barrier kunit test to follow
>       the kunit style guide
>       (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)
>
>     - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
>       is not enabled.
>
>     Both comments from Julian Braha.
>
> (There were also comments from the sashiko and bpf-bot which I've
> commented on in prior versions of this series and which don't
> make sense to address.)

Sashiko/bpf-bot review comments so far are a repeat of earlier
ones. There are a few new typos that got flagged. Will address
those if I end up sending another version out because of more
substantive comments.

Thanks
Ankur

> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
> on condition variables with architectural primitives used to avoid
> hammering the relevant cachelines.
>
> (This primitive can vary greatly across architectures: on x86 it's a
> cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
> which waits for a cacheline to change state in a time limited fashion.)
>
> Regardless of architectural details, typical smp_cond_load*() usage
> does not allow for termination until the condition change occurs.
>
> Beyond the core kernel, there are cases where it is useful to additionally
> terminate on a timeout. Two cases:
>
>   - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
>     duration expires.
>
>   - rqspinlock: nested qspinlock acquisition that terminates on timeout
>     or deadlock.
>
> Accordingly add two interfaces (with their generic and arm64 specific
> implementations):
>
>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>
> Also add tif_need_resched_relaxed_wait() which wraps the polling
> pattern and its scheduler specific details in poll_idle().
> In addition add atomic_cond_read_*_timeout(),
> atomic64_cond_read_*_timeout(), and atomic_long wrappers.
>
> Structurally, both the smp_cond_load_*_timeout() interfaces are similar
> to smp_cond_load*(), with the addition of a rate-limited time-check.
>
> Usage
> ==
>
> These interfaces drop straight-forwardly into the rqspinlock logic
> since qspinlock already uses smp_cond_load*(), and the time-check
> extension can now be used for timeout and deadlock handling.
>
> Using tif_need_resched_relaxed_wait() in poll_idle() removes any
> architectural details allowing arm64 to straight-forwardly support
> that path.
> (However, for efficiency reasons cpuidle/poll_state.c continues to
> depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
> with an optimized architectural primitive.)
>
>
> Performance
> ==
>
> Apart from simplifications due to this change, supporting polling in
> cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
> patches):
>
>
>   # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
>   perf bench sched pipe -l 1000000 -c 4
>
>   # No haltpoll (and, no TIF_POLLING_NRFLAG):
>
>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
>     45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
>     26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
>                  0      sched:sched_wake_idle_without_ipi #    0.000 /sec
>
>        12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )
>
>
>   # Haltpoll:
>
>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
>     34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
>     20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
>          1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )
>
>         7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )
>
>   We get improved latency because we don't switch in and out of a
>   deeper sleep state or from the hypervisor. This also causes us to
>   execute ~20% fewer instructions.
>
>
> Haris Okanovic also saw improvement in real workloads due to the
> cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
> mysql, and postgresql under certain loads. Other applications likely
> benefit too." [12]
>
>
> Changelog:
>
>   v13 [15] (as listed above):
>     - rename kconfig entry for the barrier kunit test to follow
>       the kunit style guide
>       (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)
>
>     - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
>       is not enabled.
>
>     Both comments from Julian Braha.
>
>   v12 [14]:
>     - smp_cond_load_acquire_timeout() now only has acquire semantics in
>       the success (non-timeout) case.
>
>     - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
>       defining TIF_POLLING_NRFLAG, in some cases we end up with a
>       degenerate version of poll_idle().
>
>     - kunit: removed the test case for timeout=-1 (not supported)
>       Also add test cases for timeout=0, timeout=1.
>
>     (All of these address review comments from sashiko/bpf-bot.)
>
>   v11 [13]:
>     - addressed some review comments from sashiko (see commit notes)
>       - The one notable change is to the implementation of
>         smp_cond_load_acquire_timeout() where there was a missed
>         control dependency in the timeout case.
>       All the others are minor.
>     - fixed a low probability race in the kunit test added in v11.
>     - added a bunch of kunit tests validating the implementation's
>       use of the clock.
>
>   v10 [10]:
>    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>      be using architectural primitives that don't support MMIO.
>      (David Laight, Catalin Marinas)
>    - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
>      Morton.)
>
>   v9 [9]:
>    - s/@cond/@cond_expr/ (Randy Dunlap)
>    - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
>      addresses. (David Laight)
>    - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
>      (Catalin Marinas).
>    - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
>      in the cmpwait path instead of using arch_timer_read_counter().
>      (Catalin Marinas)
>
>   v8 [0]:
>    - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>       (comment from Alexei Starovoitov).
>
>    - Mention that cpu_poll_relax() is better than raw CPU polling
>      only where ARCH_HAS_CPU_RELAX is defined.
>      - also define ARCH_HAS_CPU_RELAX for arm64.
>       (Came out of a discussion with Will Deacon.)
>
>    - Split out WFET and WFE handling. I was doing both of these
>      in a common handler.
>      (From Will Deacon and in an earlier revision by Catalin Marinas.)
>
>    - Add mentions of atomic_cond_read_{relaxed,acquire}(),
>      atomic_cond_read_{relaxed,acquire}_timeout() in
>      Documentation/atomic_t.txt.
>
>    - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().
>
>    - Cleanup unnecessary assignments, casts etc in poll_idle().
>      (From Rafael Wysocki.)
>
>    - Fixup warnings from kernel build robot
>
>
>   v7 [1]:
>    - change the interface to separately provide the timeout. This is
>      useful for supporting WFET and similar primitives which can do
>      timed waiting (suggested by Arnd Bergmann).
>
>    - Adapting rqspinlock code to this changed interface also
>      necessitated allowing time_expr to fail.
>    - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().
>
>    - add WFET support (suggested by Arnd Bergmann).
>    - add support for atomic-long wrappers.
>    - add a new scheduler interface tif_need_resched_relaxed_wait() which
>      encapsulates the polling logic used by poll_idle().
>      - interface suggested by (Rafael J. Wysocki).
>
>
>   v6 [2]:
>    - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
>    - remove a race between setting of TIF_NEED_RESCHED and the call to
>      smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
>      would be set even if we hadn't spent any time waiting.
>      (The original check compared against local_clock(), which would have been
>      fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
>    (Both from meta-CI bot)
>
>
>   v5 [3]:
>    - use cpu_poll_relax() instead of cpu_relax().
>    - instead of defining an arm64 specific
>      smp_cond_load_relaxed_timeout(), just define the appropriate
>      cpu_poll_relax().
>    - re-read the target pointer when we exit due to the time-check.
>    - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
>    (Suggested by Will Deacon)
>
>    - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
>      interfaces.
>    - rqspinlock: use atomic_cond_read_acquire_timeout().
>    - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
>    (Suggested by Catalin Marinas)
>
>    - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64
>
>
>   v4 [4]:
>     - naming change 's/timewait/timeout/'
>     - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
>       and fixup use of RES_CHECK_TIMEOUT().
>     (Both suggested by Catalin Marinas)
>
>   v3 [5]:
>     - further interface simplifications (suggested by Catalin Marinas)
>
>   v2 [6]:
>     - simplified the interface (suggested by Catalin Marinas)
>        - get rid of wait_policy, and a multitude of constants
>        - adds a slack parameter
>       This helped remove a fair amount of duplicated code duplication and in
>       hindsight unnecessary constants.
>
>   v1 [7]:
>      - add wait_policy (coarse and fine)
>      - derive spin-count etc at runtime instead of using arbitrary
>        constants.
>
> Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]
>
> Comments appreciated!
>
> Thanks
> Ankur
>
>  [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
>  [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
>  [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
>  [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>  [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>  [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>  [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
>  [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
>  [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
>  [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
>  [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
>  [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
>  [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
>  [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
>
> Ankur Arora (15):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>   arm64: barrier: Support smp_cond_load_relaxed_timeout()
>   arm64/delay: move some constants out to a separate header
>   arm64: support WFET in smp_cond_load_relaxed_timeout()
>   arm64: rqspinlock: Remove private copy of
>     smp_cond_load_acquire_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>   atomic: Add atomic_cond_read_*_timeout()
>   locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
>   bpf/rqspinlock: switch check_timeout() to a clock interface
>   bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
>   sched: add need-resched timed wait interface
>   cpuidle/poll_state: Wait for need-resched via
>     tif_need_resched_relaxed_wait()
>   arm64/delay: enable testing smp_cond_load_relaxed_timeout()
>   barrier: add tests for smp_cond_load_*_timeout()
>   barrier: add clock tests for smp_cond_load_relaxed_timeout()
>
>  Documentation/atomic_t.txt           |  14 +-
>  arch/arm64/include/asm/barrier.h     |  23 ++++
>  arch/arm64/include/asm/cmpxchg.h     |  62 +++++++--
>  arch/arm64/include/asm/delay-const.h |  28 ++++
>  arch/arm64/include/asm/rqspinlock.h  |  85 ------------
>  arch/arm64/lib/delay.c               |  17 +--
>  drivers/clocksource/arm_arch_timer.c |   2 +
>  drivers/cpuidle/poll_state.c         |  21 +--
>  drivers/soc/qcom/rpmh-rsc.c          |   8 +-
>  include/asm-generic/barrier.h        | 119 +++++++++++++++++
>  include/linux/atomic.h               |  10 ++
>  include/linux/atomic/atomic-long.h   |  18 ++-
>  include/linux/sched/idle.h           |  29 +++++
>  kernel/bpf/rqspinlock.c              |  77 +++++++----
>  lib/Kconfig.debug                    |  10 ++
>  lib/tests/Makefile                   |   1 +
>  lib/tests/barrier-timeout-test.c     | 186 +++++++++++++++++++++++++++
>  scripts/atomic/gen-atomic-long.sh    |  16 ++-
>  18 files changed, 548 insertions(+), 178 deletions(-)
>  create mode 100644 arch/arm64/include/asm/delay-const.h
>  create mode 100644 lib/tests/barrier-timeout-test.c


--
ankur
