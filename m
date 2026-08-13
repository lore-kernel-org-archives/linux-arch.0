Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89564463B60;
	Thu, 13 Aug 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614345; cv=fail; b=ebZH/Mn1Aim768QplQiZorrwewFLVM3LsfkImqKiC7Fkh41yssaYvpFe8TVQYwdu24YBBIIXg9SSaH+gGJXpdMhAXXrTapi4ym4CN1weVWn0schQFSVZcpK5VnWXg/oyQFcHvYrD/arYH717ZWNoum8WRhjXyhfOUHWdWjaQfpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614345; c=relaxed/simple;
	bh=zyUCfib5H7t0TFlPw+6vYgWnEiByWoxFb9KAI5BuAGg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGp1ohGx2P/T3Ab/GN/oDtLFhElv/LhDA94GP45qbZ22mMvsEY675/2JZeuFlc/dNcF9Butv/lL/bLHBLxtRhALwuwLamQuLqmR0A5bxCPgWshUpgwM0G86/6dfk6oHygP/fM3FfqHZ+MyU8l4ESdKlfzxtpqKFfTaYiSsOFgdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oADrTD3F; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oADrTD3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786614343; x=1818150343;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zyUCfib5H7t0TFlPw+6vYgWnEiByWoxFb9KAI5BuAGg=;
  b=oADrTD3F5sVywdxEXhXiq0r75R+HImqfhofcHBAVHi+wRUIH3Keb26tJ
   ZvjAETr0eU7slBmerXeyXMU07JJePmhpCDX33BrEbepVZx/hJQidPru+k
   E38TR58fI3g6Av1mJp6awAonuJC5oBR7PBnz36BVJOboY0O4hhYacJtmB
   PcnLR2bLUHEHhleFXCUlkiI/CIXT0gso54f830QmgWGmIlKK+CflrKvGH
   XFrH8Gb6d4bb6ra2rOZykxmKEpJssK09qCxfxHcfT+yWbEACjLep6Kt04
   gmAal3FEXltbjZSUoahJ85ZuH6a61LUxTDGebEFdbO302PDCjzwQtU1c/
   g==;
X-CSE-ConnectionGUID: W7OhkxXYQvCUZwydDI0+iA==
X-CSE-MsgGUID: cZgcThGYSty8HSu7Mb25NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87400433"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87400433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:45:42 -0700
X-CSE-ConnectionGUID: js0rIgBxQjiXgWCB+elx0A==
X-CSE-MsgGUID: 7JHMps46QqmIvK/pVRAREw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="260083765"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:45:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 02:45:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 02:45:41 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 02:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpafGUopLY0h5YA1HvcIcgqbHPRwkZDsA7m7m4YOGnNmW8nKnzoyeqp45A7Ve4pC9MsdTVlyb82yfm+9/JGOe9J2jWmLS39rMpk6gT4N43yNQagbA5QMMg4guOgCs6IGx+GojoXuHZZnv6j0ZPwTt7T5+zzwRktwpo1QgChx0U0TVQu2C3hvYfCsoVWhsZhl0xudIf9oLu3oifiWGAFHfdjKW8jfmoxtFgwL0uUbh6honnHSoCxfbRvOclR3fiwRz8igrh45TxuV2tlNWmutHiTZBrR8G8yr6qxKpC40EPeVRF9cFYK7UiCDOVSdYx6w6tpg4MzhR50WJcxQgyBdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+grBthL/Wp8oJe9EjvJgU/pvWExeBep5WerK6Sy3lU=;
 b=mIwIZpFCDqxGrlqJgNerJ0XspU6OmE6AAp8XKuigtr89sQYSnq5iGtN9dMiMNXDpRi2xB3TNPF5A6zgl9ReaMe8sqqioHsw7Kz/Mw0trYzmUo9xesKSvJ2oyQLw3jgwP6jqxuLPdODZy5l8L+3GjOlXX8oorrj9BKlW49VYf171Y7dTpVp+BBiIC6XJNRk32SmtCcVMOHK2HK/Vk3dnnhAUXx+o7oIIj5zCNstaTREiho/tVYYxO+jo6MfT/f430mD2+S2AlRyPNXJoCAV506shwRyDC0Wye9iyeIFlJpR/+6L6rH3ZBUjSgPBtqUwe0Jl8vKrWbIjTUOu5e+Z1ZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB277314.namprd11.prod.outlook.com (2603:10b6:610:34a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:45:37 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 09:45:37 +0000
Message-ID: <f1eb7f06-ac71-4aa3-8b36-05ca86850553@intel.com>
Date: Thu, 13 Aug 2026 12:45:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] i3c: master: Add driver for AMD AXI I3C master
 controller
To: Shubham Patil <shubhamsanjay.patil@amd.com>, <git@amd.com>,
	<michal.simek@amd.com>, <alexandre.belloni@bootlin.com>, <Frank.Li@nxp.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<pgaj@cadence.com>, <wsa+renesas@sang-engineering.com>,
	<tommaso.merciai.xr@bp.renesas.com>, <arnd@arndb.de>,
	<quic_msavaliy@quicinc.com>, <Shyam-sundar.S-k@amd.com>,
	<sakari.ailus@linux.intel.com>, <billy_tsai@aspeedtech.com>,
	<kees@kernel.org>, <gustavoars@kernel.org>, <jorge.marques@analog.com>,
	<linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Adrian Ng Ho Yin
	<adrian.ho.yin.ng@altera.com>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
References: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
 <20260709064233.1451482-3-shubhamsanjay.patil@amd.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260709064233.1451482-3-shubhamsanjay.patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0137.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB277314:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adb8dad-6cd8-4adb-f325-08def91fa093
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: zm+fM/+UMYdQXxqZxCqjorBbrlP+hUEFDYyN5wVrPmiiwrd85VeCmXnowh+5QtCZlBM7rXas7USAckT4QXf4Mcv7zE8/YLZpGOWlqpaJRdyXNNT9tXMCH+u9bISOZRm0zykZNWo3eOkXoUD9LuTRZoLC5ylD7BY+6q77I1DLg9xGi1QgndoAZ80U8glUQi87nn4aZNoQyECBpEE7I1Q/jMqpAA8TyIFbV0HlbcLv8YKPCbSK93AfYejf61x6WvVKDTXhSNS+U6teT7CvRS6hv4Lamu/bOLEog7b/HSHclaf07VqVPVhnvCYolzQVpwAx/Ukg8oh/tvA4x+e+7LrFJmObJGnWDODsLf5n4NsS35Gb055oByugOeYg6vllZwyfetGRFdgDfXnlSbIYCs4VA0ZDi0HRTaYsB5K45ADRHc3fkxzkuVk4W9UWmUNe6q9HNfd51olr7dA4RqSYS5DEOuRVMSQrA6w7pEQZ865jfa/psvxD64nInY8e32g5sJLUQqupes9siRNbXY6MIccEbuBHk//1qwgUW42oe3OblAG9JDBm6YHexh5M+a9miyH2luIwsWFLyrL0fyPJHVz1XKBeVHizNk1h5xVbWaJZA5DgyzQJ04ZYijwdjMCOe1Xhg5fek/J62LYIcnZ9kzm4V6QBPX9FtuNxIyeGdq/Ko4P1bVyzZEjzhgfYbhdgJe6O7ebeAbX82v7/8d3ehhOR7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBtQWRiZVFkTFFZU0w0UkoyNFFBVWg1ZVJNRGlwUkREYUdvUjUxRjJMQzZx?=
 =?utf-8?B?amZPL0xOVGlxWEZDNTI4bzhNMktCK1hHRElzRzJrSlZiL3BHWEk1NlpaazJD?=
 =?utf-8?B?TDBGZ0U0aVZyUjl0eE9oeUlRU0FrL05lMlU1L1kyb05oTXhkZGE1MmtzVXN1?=
 =?utf-8?B?N0wyUCs5Smt5RlcyemNPbFk1QUswTk9sTG5TN1FMeENvcHdCa2ZudXllM2hI?=
 =?utf-8?B?eHJsay92VEoxMHRndDludmFvb0hidEt4Y0xWdlY1UVZxRHp5WFIveldURWFJ?=
 =?utf-8?B?TUFtbktvN1ZZQVdlaXVWZmZieG91b3h2SjJ1N0lVanlrc2UyV0FsejBtNXFy?=
 =?utf-8?B?U3d4ODVla08zcVhCR1ptMXVQREtrVnplcTN0MnVIMVNndEIyVURnT01zU2JU?=
 =?utf-8?B?QW5YUmZJN1paZC9Vc3BYWTRmcWMveW9sSlByOWczRlZhUENxVHJJcUt4M1Fx?=
 =?utf-8?B?QldyRSt2ZlVCNTN1TmpmUnl3cEFBYW5iZ1NycDFRcGJ5NWdFb2MwNjJZZndN?=
 =?utf-8?B?NXVmcFd6MHUyOXRDOTJlWXhxTFFvRVRpSnMyZWthQUxMU3U4UHpXQ0ZSb3R3?=
 =?utf-8?B?OHZLSncyRTk5TnFXbDFEUTh3OEg4aWlaeVR3RUMybmlnT0V3SW51RjFNZ2RZ?=
 =?utf-8?B?RUg2aWlDRlgxUnZMTy9nV2pmN25FczI2UmR3UWxOVXI1UmVpUzdhREloMjVi?=
 =?utf-8?B?ZkJMRlB4azBtSGE3WkN5b3QrV1h3dmNlUHhoekhoL3pJdHpuSGxJNFBiRnE2?=
 =?utf-8?B?eHJOQkJTaFBmUFVEU1ROU2tsYmhIT0o2aDcyQ3RKTDIwc3hDM3ZGc2ZFRG0y?=
 =?utf-8?B?ZHZ5T0NZNTRrWGpScWVQMEJsNjc1cCtWNjZ2aWJVNDh4Q1FKT2d3OHFEOFVv?=
 =?utf-8?B?YlNhZlE0aENmT003Mlp0RHQ1VHJKait4SGpXRHhnM3l1bjNpOGo3UXNWdFJl?=
 =?utf-8?B?aEswMnZoeVNtVUNCMlR5RXJuMFREVlVjWERQL0FkT1p6c2xycXVPRVB2RlNr?=
 =?utf-8?B?OVVPUnA0NndYTFVwMkgwMmErSXVnR2dZWGEwUEw4R0Z2c0F5SUF4V1E4L0cr?=
 =?utf-8?B?NWV2aEh2K1ozYy8rT1EyTkZlOWZUOFRhZHZHL2dUQ2tZSTVZYlNqbXJoVWJv?=
 =?utf-8?B?ZnR6K3E4NkQ3ZnJmWTM1STFvQVlMSmo3KzNEZXlTYWN2cXZoSmtiL2FuQ0NM?=
 =?utf-8?B?d3lVbG9qd3BmdzVDZ1lJRnZUVjVZZHRmdkVpUjAzYWxMbWVBTUpZbDY4cVVh?=
 =?utf-8?B?SW1pczVRRURFY08xSU1YYm5yZzZQZnMxNjNMMCtIRGtEaEJNZ1NHblc2UUoy?=
 =?utf-8?B?blJFTUs0VVBreUVabDRCT0o5U2dBQ1ZhOHV2UmxKeHorQnpTYm5vTm4rUlBE?=
 =?utf-8?B?a3RtYW5QUFdGL3FlQ2pKR2Y1emNjR0UwdmNLWjRCNFFWYmtmZEdJV2tIMFVK?=
 =?utf-8?B?UkxPL1EwUldrZFA0ZExhNFhXQm04dWdmMEFYMk1QaElRd25MY1duZCsrMTZ1?=
 =?utf-8?B?RXA5Wm9aTzRCdTJxOUtFMm9vaEV6RndUWUJNNVVZbVhsUnF6eVFQcXFDUGRU?=
 =?utf-8?B?RHMycjBHVVJyY1B3M2N1M0VSZVF4NmJoZlJFL1RUL2tock1Na1dpYjF1SVpa?=
 =?utf-8?B?UVkxWC9nZXNQYzluUjkzQ0hnLzRyY2V2bk1qbm8xSHUyK2JqdzZRTUcrbFI2?=
 =?utf-8?B?cm5hMHZoVHR3L1NXdERzRXhOVmZXMG9UNStYMWNva202cnlqV0k2NXRIbEdk?=
 =?utf-8?B?a3FzaEtZcjBmcU9xR0ZDRTFUUG1KZXNhV3BJNDB3VGtIcW9PY01ITlUrRzZj?=
 =?utf-8?B?c2hETHEvRGY4QVBIWFEwbHM3YjFHcU82QURoNG90Rm42RVNsN3ZSNjI5MEJp?=
 =?utf-8?B?M1RNRHpOZVF0ajZLcmNQcll5aURWcmY1MVlKc2thWlpiaXl3bW1IYXFySGRT?=
 =?utf-8?B?dFo5S2NCVGZpcXhaY0tobUkwUXhFRk1SZ1dTTDdQeHowQkZFdVlLcTNucEtP?=
 =?utf-8?B?YVRVVm9XcmVoRmYzVE42NmRYaUFoOTgrRXMvQnhzVndzU3FZcjhYSkFhWDZl?=
 =?utf-8?B?bkFZd3VvdUdFalBXV2g0OXFIMkVUcERZamIrTmdYY2QybEp2Q3NxdEMwQVdX?=
 =?utf-8?B?bEVIZHJ3T1dlTGFkWGQvRUJEc2ZUOEZiaFBzeHlkYTRGd04rY1p1QU9FbG4v?=
 =?utf-8?B?N1RZWDRZS2huMkZMZ21DZExERnJqeWUwWXh6OER1TlFUaG1wZC9NVVkwbklG?=
 =?utf-8?B?RVd0cEpIRVRTb0NZU2t1R0pBY0ZBRzMwSWt0RDJJRWpuSzBhRXJwd3dHeEg5?=
 =?utf-8?B?TEZqd1I2WFpqQlNDaU1PMVZxUjhnWU82V0VBakZBVVQ5NUx3anR1TUJQVFAz?=
 =?utf-8?Q?3mP3z+TOJLm5aa84=3D?=
X-Exchange-RoutingPolicyChecked: ARzq81ZMyAulIE8xXUD17m7WzfZJUCya2MG220IWavJLuiUy/JzbK0RttI0wtXQWHG202GnVcZ9lW68yR534SGJgQCLwSVZ1KbE4XzekXzQ7rWCym8zynFk3R5U4LMnGMTOnw9M/RUXsOD10VqNFMBLTGE1JXo2epVwUMR7ZVKroDkLKC2JjY+GYIJaYjJTFM+qr767NE6Q4wTnxVjLm3d+DKC7M42C5it0nUlaFU7FVwSCZbAW9tBL+fNgOnCL9Y4ONpWolFOo5Yr8ietvPGSdETO3EqjNcv/X9PMP7J6iPcSjCxazpchJ4qvJxZluxG/+/jwutu/irqn7fBVWhOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adb8dad-6cd8-4adb-f325-08def91fa093
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:45:36.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSDy9+dFS38xDrbrodlYqSjBy4TV66YTIiY7t/2/nxWm0S/XKoChj7A3xC38FlmmsoXKi3t4wvJza2nAdOH1Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB277314
X-OriginatorOrg: intel.com

On 09/07/2026 09:42, Shubham Patil wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> 
> Add an I3C master driver and maintainers fragment for the AMD I3C bus
> controller.
> 
> The driver currently supports the I3C bus operating in SDR mode,
> with features including Dynamic Address Assignment, private data
> transfers, and CCC transfers in both broadcast and direct modes. It
> also supports operation in I2C mode.
> 
> The controller's data FIFOs are accessed big-endian; the driver performs
> this conversion locally using ioread32be()/iowrite32be() with the
> helpers, so it does not depend on any core FIFO-endianness helpers.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Co-developed-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> ---

...

> +static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	struct xi3c_xfer *xfer __free(kfree) = NULL;
> +	struct xi3c_cmd *cmd;
> +	int ret;
> +
> +	if (ccc->dests[0].payload.len > XI3C_MAXDATA_LENGTH)
> +		return -EINVAL;
> +
> +	xfer = xi3c_master_alloc_xfer(2);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	/* Broadcasted message */
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = I3C_BROADCAST_ADDR;
> +	cmd->rnw = false;
> +	cmd->tx_buf = &ccc->id;
> +	cmd->tx_len = 1;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = true;
> +
> +	/* Directed message */
> +	cmd = &xfer->cmds[1];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	if (cmd->rnw) {
> +		cmd->rx_buf = ccc->dests[0].payload.data;
> +		cmd->rx_len = ccc->dests[0].payload.len;
> +	} else {
> +		cmd->tx_buf = ccc->dests[0].payload.data;
> +		cmd->tx_len = ccc->dests[0].payload.len;
> +	}
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +
> +	/*
> +	 * Report broadcast error if any, else the directed one, so either
> +	 * NACK reaches the caller
> +	 */
> +	ccc->err = xfer->cmds[0].err ? xfer->cmds[0].err : xfer->cmds[1].err;
> +
> +	/* Report actual byte count so the core sees the right length on short reads */
> +	if (!ret && ccc->rnw)
> +		ccc->dests[0].payload.len = min(xfer->cmds[1].rx_actual,
> +						ccc->dests[0].payload.len);

Looks like this missed the conversion to using payload.actual_len.

