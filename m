Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0527713;
	Fri,  1 May 2026 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594296; cv=fail; b=UXf+9+2CuF/MqdXa4+slq/Jq6OMcjrnFIxY0ZXmJRmjtEeC7Up5kQyiNWuPP6pti9j9XY0Qf/smyB0VSACbGGseRL0PHNRe5ZOzQpnLwwNhAWY7RMx5yhgfD8anuc1feg6M534rMxl3HYKyhFcZ8HWMMxv2HcsveIcbapAf3HxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594296; c=relaxed/simple;
	bh=SifE+Vjo0MYLYC69xMxAmUq0aY0Z/SylqPSTdJecNfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VFk18vXFKrpUYuV4n7zWvwRjXTWYR8aloNVOZwz142f8H4H3i8FWWZd8RcdeS/Re9sT7CLuKHKoKx5F9gTsKIPcn8GT9+dvHOajKMxZFAvZeB9gG+E+ggCatBC6ejRCy9bw/GKTTO+vt7Uy9OmoGJU+33UG34qrH8H2gETmFfFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aRSWtKOB; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aRSWtKOB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRrop/mjagYXwQEltnz7WTf4Ud4rOsCK4fwMfK7XSpxWfSd8iDU+D8cmhIXXq1MsnYVCdtYb3SAd9jpqs7S+pOWW30j83Q+Ho4H+DHY3JruFA5I9R1sIaztOAtly2P3zoEnlN+6A5VfdmmNRn6PyONYhBDSyMDNH9SpwjEQyQXJHxbSjYi1vNHO2Ba54B4dQB9Hxw7AEKpWtls6gqeWmPmihIDjmy41kS79K0b3hnJNyvP/4jDIzXu1MXrbZDC36CldgGbns9GOyBBWmEqK/4M9e/ukca6MWY/pHy/baVS3BCjZVyO6JPLIj6beVIBAnJvPqWMxjcYCAATqQKYjEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EtywL06htFWDsOvro9YDDNv/PGmHTgYq829ZrVdmHc=;
 b=jDOd9pVs+Nb7aT6uCKX7LhYql/emzDKp+Kft9bSupAS1kvHStXdN5hmEo3zpYeZUOTAKSkwnoNX9yavnwE580qc8EqU7YjUcZzPxJ5lhgVaN3z8mDzuWLiaw2KQ1pTMlvp23oKhLu7pnUVJoCFCRl6jDL/F+FTAhltrbBvgYBe5n8ganhdb0pjN4RF1/73RTqnUSf7Z7RTNYQJm9+Vj/owbzmzIi83YU811Q2dYTV8ddG5zbeo6HJbgwx/CyFxReOy0f/rURMbEml4cJWQo4rPCS3P3jiJeVxxLEwRjMisISlCWGIopaGjNkK9z/bMfpVkoRiNtnn+73hrkGkK6dAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EtywL06htFWDsOvro9YDDNv/PGmHTgYq829ZrVdmHc=;
 b=aRSWtKOBn7dPKmiiujh1ikINDX4nWMWpA/gPF3nznm84Lz40EpRB7VRZNdm0xg5qjMQFmmCA+/ZQCfS8VauJRlZ3kCfsRmMt7wgWL/6kh3OV5xSR116DILMcf4NMfmCRvmfP3lbFn47EgZ2AhpMosqAyWayrMZC+X2VYcb2OYAfeau22be95pGRY1RJUUZ0j+Jv8GnItvqcaQfeOw01hNyUtbvHQtOMTI3+Zmin3D3Z1aqJrafnGCXEH1cUUgcvLr9LfGmZM2vAMnhOpSz2w+KQBdoGCaDqvWkNZ0n12fAHaUCMqCc4mhSAud2f8I7TnJJOnWS0EduJlGus2ZuL3qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 00:11:29 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Fri, 1 May 2026
 00:11:28 +0000
Date: Thu, 30 Apr 2026 20:11:26 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] bitops: use correct parameter names in kernel-doc
Message-ID: <afPvrowTHUHGdtle@yury>
References: <20260430233934.2620065-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430233934.2620065-1-rdunlap@infradead.org>
X-ClientProxiedBy: SJ0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:a03:333::22) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b36cb9-3990-41e1-a263-08dea71630f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lRM9k4USiRHrxX/whcv/qoTinsPYDXo41MKU/wXUTB8Cv5oxBWwJMm2D4x9pGZtKqAislbFNGCX3Dvr84PQ+pZU6S8tLcc5keNFyy4WEBK2+GqZ+IffgU8otwuYNcuNevGyTE2bNdYPa07VTtzBUs1hAxfP1F/MJ9WOhha5BlBF73CqrJVn/xw4jjwlr6IGMQ97/DDKvMPMrT+uVFfQDYz5ywIyDgNPiFJMhDAxvA/xj5ILMZc+EriT5YT0nAwELLECeJHNRTMbFa0rywizjbg/9LKLzByplPCQWwyba/Qyo7iaF+25zW4OJSd6zkm34Cv5Pkgdw3Jrqyx6k6ezcv/ys3zVE51MLDj6XfK2qBCPTCmfBe4sUVJM43jkQsuY/9RPGmEW7Qkb/3GWOWZrHJe8LTz0y5ReQAhc/m4+U1jTqPAcQfOme+7VK/pcalLtn61+kAGTA/1UYVxUCxVs2u/JQIozUmLs4yfXZyvwW0q3Z6Tv/WHrzGLBxsQiacCaXs/SeWprGG6pUpJA78+3tffyuM/NW4i3Pj7a05SNi7N08EazTpAhwuVPvPqeCRZALW8Frz3sQ5vMUZPUOwQaIZ9p2z1ybqN7t7sLM88RUcZ9zjVenG3J5CU8jrR9VTwm0smmn6Ri7qKCs6+d0c4TfRYA7SBUCdL80lL7J/lknjW01oEapUCQstGAH76P85spL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sgiqja4pNp8bP2zFiYNHIeDd2NSDPTp0Dg1q/B9ACgT/xyks3O/rcF1va5eD?=
 =?us-ascii?Q?sgZFSn6DQBZbRXlG7mEzxCwXjPWjNqKExm1ZArHTFYuSILRt0HZ0RnRbFwsF?=
 =?us-ascii?Q?TC0jOuUpkbDS+sZY2O3CuAudqlEoHkz0ak680BdRwbtSk2QV8pYU1CsBZMbf?=
 =?us-ascii?Q?7iNYS9x4+vBBgALRQzPyHGYLinEqfLwgvGaf3OSc6IHV/3BfBCx0tWF27YFe?=
 =?us-ascii?Q?dAfuDARxNUPHVDSg47EO1FQ1BjxwCRB5dVfoDRKVrxZvBQu/28iThg6guFze?=
 =?us-ascii?Q?HRiIX8Gk3PXOH+xYqPf3Z+DBc5kf5D70R4eF1AcTR1dKttb4fnMXwmrEiwjk?=
 =?us-ascii?Q?FHF51DX+/3VGWzamHUSazwmjZOqX90cXxxym/IY09i8/UeLMIEPaXf2blOb9?=
 =?us-ascii?Q?wnlwXpqlV1He52n0zHwIauC1Lh24/GbDVbGwJJXT+9dxraDHuZofg9z6PMER?=
 =?us-ascii?Q?FN9OZPDYCMl583ncYzwsyvCQj2SkyCdbBOxS0UVXLsJ4TJR97pgc+Y1zgPsy?=
 =?us-ascii?Q?Pl1aWuEZpt9sd+hlRKkPH3PA1DEALhyyRQqGcrrIjCHGOAVO2ws4pZG3nCap?=
 =?us-ascii?Q?AUGR2az9SgYwugVNrIwT0HF4dvaqtkGmPhNd94b1jX+7fMIbgy36GBxMSG4n?=
 =?us-ascii?Q?o3Dg9/jUM+O03QWNlzR3N6wwTIpStotj1WCXbhHBKAzfDCncwS342U70B0sf?=
 =?us-ascii?Q?25AmmKL+jW6BVNVWL5vMIVfnomjCeGsCT+CdOwyOoxhDugybkmGBd1YiHjXe?=
 =?us-ascii?Q?TmOJg3esr1+uA3WiPqXSEeVOcq2rlswMv3rhtqVn9FLFFzr0O1EQu7pnPlAY?=
 =?us-ascii?Q?9vHcovotays23J+lUcN96q5L1CVZZkwQ9Y26hmc/EUND5+LAch2nEuu7eJtT?=
 =?us-ascii?Q?Ymk+G/wxykqPkAr2u2oEaDzItZHFfnR3zOwInPAlF7Vd16YsjuipULD5Sb6Y?=
 =?us-ascii?Q?evuLRoaPANLRAoIX1lOeY6E3PVSQj/MhKMvpfUYaZA91qfGEWNMKJfYu3BEw?=
 =?us-ascii?Q?fdWb+sCK7pnEJ/Behl75pXLs8N6YkxyHyEfoV9XCsprqFrMisBzcw2heee1k?=
 =?us-ascii?Q?KmT5OCReE5tnOcGlyW9/y8JCKKEoG2aaPQ24EjNAUVBbJkV6P2VFsx+bnApN?=
 =?us-ascii?Q?dFNjglqA3+B/vRrSCfPfr0T2wcl9FHl4c+e+ppfToyJSXS9MiFpRggyL78pb?=
 =?us-ascii?Q?vTqJidYL9lXv7qX3uUDqOqtAj3nnXw9CdJG+5RuNMdaz21Vmyh1qmxAQBvZK?=
 =?us-ascii?Q?QhHIt4uvrKdqN4dFzqslJ1AQ2vrguQIHi9bQ0ga8kyPJ87mtxKhri6lD+8uS?=
 =?us-ascii?Q?u5Oq8Eh6rl3RyOpSgY+qmQzwOC6hp0tfflmYR6nRv3oKCDMjQ0QUTjl+KCRj?=
 =?us-ascii?Q?rijJgTnh5yv1LpOwFcB9lBW0aWl3ixcONNTejLbj7tRHtXn1fz12TAJY+idL?=
 =?us-ascii?Q?w+42sJjmt2mxXSjmFDOvCDDqkqpxbcuzdlSM+rERE3COH6caI+Ce8zyP9Hkk?=
 =?us-ascii?Q?COJgwTGVxi4PqiG6f4DXWum3dhuCJPdQO1EThoPXjp8ZWkXeGHefEMIRPUNS?=
 =?us-ascii?Q?J7wvGEl134beQ7aIbMWuLBVVJvIBVKtiPmKxxDA/C5G5MuVQs8CN5J7B4WhW?=
 =?us-ascii?Q?QWuA6M3NJwKS3z7FdIXBlkI5+Chelo9DY7+yh4Jm+jndYHrWnNHpjf3083hY?=
 =?us-ascii?Q?cjnPZ4UdsP+B99czVvWx2vTamZoynER95akyQXJY60DI3aWF48sG72v8SnwX?=
 =?us-ascii?Q?uAMYmhKi8Rt8a26HsVf15zoX1lHBpzrzGn79yfZGXlN12vCOJRXC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b36cb9-3990-41e1-a263-08dea71630f2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:11:28.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYxcb5VGvuXV4Cicfuq7v4MsGXNrgBDef+DpVASSfzj3+OPuddUodrT+tWAceThvhmsu7jZSO1Ol5hfYr0G+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

On Thu, Apr 30, 2026 at 04:39:34PM -0700, Randy Dunlap wrote:
> Fix the kernel-doc comments to use the correct parameter names to
> avoid kernel-doc warnings:
> 
> Warning: include/asm-generic/bitops/lock.h:19 function parameter 'p'
>  not described in 'arch_test_and_set_bit_lock'
> Warning: include/asm-generic/bitops/lock.h:41 function parameter 'p'
>  not described in 'arch_clear_bit_unlock'
> Warning: include/asm-generic/bitops/lock.h:59 function parameter 'p'
>  not described in 'arch___clear_bit_unlock'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Hi Randy,

Thanks for the patch!

The arches implementing those functions use 'addr', not 'p'. In
generic version originally it was 'addr, but then the functions
were re-implemented in 84c6591103dbe, thus this 'p' appeared. 

Maybe just restore this 'addr' instead of fixing comments?

Thanks,
Yury
