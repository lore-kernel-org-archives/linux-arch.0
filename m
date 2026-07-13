Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCD3382F1;
	Mon, 13 Jul 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960707; cv=fail; b=SEN+TMTuWmgFiOHldsYNpv9VXdfoIpsKXs8GcQxgJ/KKi8jFDg88M5Huk0DnalePpeDokxpFKfJdBRgx9Pa4EfLzB5znpKn7s4Btu9z/3IQ89qXNfc00oy4Yxb5aoKA3+kPSm8jiEUmC6/BNKGwu/BCjCOq7FpUz3+QLakllm7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960707; c=relaxed/simple;
	bh=6pA1x4hy1S5BrvbPcwsR+HBw0/UjS/cu+7r2SyMOzUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAtIHD3FcOadyvb9vBWqmo0PT9b9cNoKbtIRjh9829swGPD3QcCbaZCt+cgWa/me7cdY0iri7lgf16oFCYn8PsSvk+OhKIt0Q5pD4VU6nr2LX2aewrLU3VdFwCAKOf6P3ww+XJyHHf1gneU7a4cAJ3VCgcZFCs55Aoy53ygDYeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LuGZfSNU; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LuGZfSNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1vAhvMXrgynBDXhdK/ais5Fuv2poCf9VRLlj1vTR7cCnzEBVptR5KWLCjICtQDzloDI/A7FmAk487xYzbrL9YuoCU1gpURzoQa541VHQUGIuOV0EBSSwNRJb9eRLe5HqedaI5aYn+gEgKQmIAGKTe8SclOjmdUh6P4MU4KH65f3GIBBAiz6WYh+qzbF7YvgXv0/a6nr1EAYy+92Q7r4WWRwwhasklzOeCPjToIY1iHhqWslVBq9oL/P+uay40pMg1e73JprDLg7IPdM6EHmv+cs5PgyaqHJTIn7RQ8vvvgL1nlgu5ZQG0g/uCrdd1kXf2Op3OPFbsfRhVyMIpAyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/en/7ckSEXraxMygO/NvLcwDhwUznwW94J4pPpTUg=;
 b=wfxoQUKxAkjByu0ozScrsGLM/+gHDIuTmIaJIGGL3Nn/NfqVwarU0Mtkykp6imIFPmUT73iulE+D/w/dxl5HW+qkgx8KA4CjSifEprAsA1CWzXxyOn2kleZxdgCBtR5mGrYpjNObe6kHmrCqyVKILeIXkdsW/zlMENOdVNahe/0qrqrKW5BICJMIZblnpGY3XmsejTiM2srkgQDbQA5U5bMTvWEhWKJHS1uSLFArVSMtJUEU9XkgRrdOdhtRy7PM3nA2DIIO+CczgRrN7DY3nN5bezg7xkuZi1rCkTzvwSWdszXG1aKDG2wyQO/yBsiFD+zpkbZ5KdEu0nNVn/ZaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/en/7ckSEXraxMygO/NvLcwDhwUznwW94J4pPpTUg=;
 b=LuGZfSNUJy5XLgbmujn9u4bUQjiM6AG5cZI9jniQJahtYkQvPFvV8XiiirokaNu4appEjHstbFSYRvy1cxipcoLx3EdtZ/xGLUUN4Mtm968luXe6kqX3LjCIb/kneqGl5DQEYt5cz6Qy2Qn+KO5kLFmvxENUHyqIMcc1nIPkFLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:38:17 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:38:17 +0000
Message-ID: <02ccf4e3-8193-4ba7-931a-e5bf2dde3f12@amd.com>
Date: Mon, 13 Jul 2026 22:08:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
To: Shubham Patil <shubhamsanjay.patil@amd.com>, git@amd.com,
 michal.simek@amd.com, alexandre.belloni@bootlin.com, Frank.Li@nxp.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, pgaj@cadence.com,
 wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
 arnd@arndb.de, quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
 sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com, kees@kernel.org,
 gustavoars@kernel.org, jarkko.nikula@linux.intel.com,
 jorge.marques@analog.com, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
 shubhrajyoti.datta@amd.com,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
References: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
 <20260709064233.1451482-2-shubhamsanjay.patil@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260709064233.1451482-2-shubhamsanjay.patil@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3201d55b-5b6b-45d1-4784-08dee0fd2424
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|11063799006|56012099006|4143699003|3023799007|9063799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	HZ7Btc9nUGa9GKHJ4yYgntoiWddF6EtX+4MA8PZP7KXmAyhEo/XYfOTD9LYm+22EV1YB935DOe805n7sAhvG+wKnDFh+xVjl2b+B8eUEdBohmaWIPgPF4OJxbx9jCPdteC6WH2W8ED7rIVKbhotVY7KFH0o2UWQW2ZGC+YGHQl8/PLT7wm4wEVWHqNmyWwW5yh1QCHOvlLlMq1HGkxznl5xrNIjwOX0DTn7L3fVy9RjKWf5atqLXXzytLVHE36taoeyppFKxvRMw1A6FXBQENOXqE2ksnU05XAF6B39cyJ8NOa1tLfloPQGd8OWQNG3f1HQ9LGy1GpfGmOooJDzUYxOl9CTqn/FU6hn9Ye7T6ofZumg2lSKTRpxBQCbWVIz4dPr4L9npCJy/bJlqLNSoepE0nLEXy82Mnf/OQUpIPAGl8Z7E2pBEmxjUt8gRfYN85bkLqYir3NYxEKDlZPeVfv56hhZv1Pq15eobQiOH18rN/iTrSw3bMATzSPTLSh2d1cUTHM51nqN5HYl7HBcdnGbjs4j2gfqxfqcbaFhegBxy6Pzqf6FvpgXnLvN14bLNunjOnBdumTN28U3BfXbKQwIpFJCPrjT5OcyNkMqIKN1SSnoNvn7mWa+iuBkegjs9ofWYmDa++uL1G4RUsjEJcn2LHKhhq3GyrmCqludDre8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(11063799006)(56012099006)(4143699003)(3023799007)(9063799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkpKS2VodEprWGJRT2krVjhFOTZwdE1wb0dJOTZBVTcxOW9CZ2RvOTFjZXJi?=
 =?utf-8?B?UVNvNUxsTm1FVmErdklES2V6VEVCSWFKdTdQYUY5V1ZsbXBHMFFHWkVTdVVB?=
 =?utf-8?B?ZnZ3eEViTlY0SzVpS2RjbWtVUjlLdmhRKzZ3Q3B5cjFGa0JDSEZGU3ZjOFp1?=
 =?utf-8?B?bW84eG5aQ1F4R3dISVdVM3ZLL2UvcU4yem9GMW1sbjdjTTZzTEc4c2d0amR2?=
 =?utf-8?B?R0VkVGNXSWNSM2lDa2pjek9WbFk2WUR6TkZIZDMzTU4wOSt0VERTQTEwelJQ?=
 =?utf-8?B?Qkx5RmhWK0ZFTmJjM2QxOWFkNkNHMnFGWXJ5bEVaWFg2NjlBNVJKNHJiRVo3?=
 =?utf-8?B?QmJJZXBmL0FJeUptOFFleWZ6ZmFsWDNzRnhFc09wZGEybVBwWTYrWlFnd2lx?=
 =?utf-8?B?aFJkK1hjZ3ZnZHRYNTN1L3VONnRBSkU0YnE5bnlOZzJ3QlFiRldxV3pIUzVw?=
 =?utf-8?B?TGZibzZDUXcrckxWV2pmNitLWkR3R25QanBiQTI4YVlUN3phRnVpL2hXbE8r?=
 =?utf-8?B?aXBteFZpMHpOTHd4ZGNjS0NZWVZLblFmeWJaTHVVYUYyZUx2QmhYdjBXdWZi?=
 =?utf-8?B?Y21BSm16NjFUYXVUajNaN3ZLR2hzM1A5a3NibW9xaFozR24yY240NDlvTHEy?=
 =?utf-8?B?bk56OTRxaXY2eXVCbTVKbWlkL05adUJ6M3lxbE8yb05CZ2FFZVkzMUhneCt4?=
 =?utf-8?B?Y0Jkc01BZnhTWjlRVmJTaDYweTB6dlEwTW9WUTEzZ0hvY05WQnVUaTNvYW8w?=
 =?utf-8?B?QXZWTkNBR0J6cWFxVmJOTFplM1pkbkNBNWZsRWFUSXFHek5YaDluZ25MZlVY?=
 =?utf-8?B?WVVtZldWUC92bXpsU2MyZnlkRjJzbGNKL2VrZ3dHWGdlYXRlUGRHRjB5UnpK?=
 =?utf-8?B?NUhYOWIrSUpRU1VYVCtnNXdVT0VEMUtPL0p1dnNCZ3YrV3QyTnFZUTZFRlFh?=
 =?utf-8?B?dHovdE5CK2V4bFVzZXhBemRmaGptRkMyZ3YzNmJCVkU4RVVFdEhYYzFVWjZO?=
 =?utf-8?B?VHUzd0Rsai93amUwSkl4RTNJUjl5Nzl6TkRvWlYydzhRUVpjUnI2ZGlkb3Jq?=
 =?utf-8?B?TlAzRTlpZ2lpcVI2ZHFmVEZEVGtIcWZTaDU5cWxDV3J5L2lrZEFxWUF2QWxu?=
 =?utf-8?B?akNFTHowTVJLeFNEK3FrTjhqUWRER01hc09lMSsvKzlLdTNOUm5yOG1EV0Zr?=
 =?utf-8?B?Z04rMUtVR1VFdzl6V3JidWVOcGoyb296RGFiN1lvMmZUT2tzRWJsUisvVlFt?=
 =?utf-8?B?VVBzSUdKbDdxWlBQRTJrdEs2Y1owamp3RVQvYzJhVkllbldXRlVsU1FRTmwy?=
 =?utf-8?B?RnZCeE1DekZCQksxN3RMTk9lemlmd3ZUd1BCZ3czQkpvbUNjYldZdVoxNDM4?=
 =?utf-8?B?NDRtYXlRRlBkdm8wUVpDdFhJdkprNHI2aDNBUEdqcUxnYUpTWjZLVU5QU2tK?=
 =?utf-8?B?dTVLUVd6NS8zcWkvSmVlWDExL3JLZ0pSQm1wSHB1cUhyM3BUZHhCTXFSb0l2?=
 =?utf-8?B?OUdCRVBBMXVOOUpYejVuUXRMMjdYTWRIT3haL1MrRzAzTEVnT0ZmQ3F4aXJu?=
 =?utf-8?B?N3cwdWNka25rUDhZZHlFZ1NvTlQ0UVlDS2ZuM2JWN1BBNTduVmhHOSttQ09Y?=
 =?utf-8?B?bU9KVXM2ak1OaGpNSlBnbUVGdEJQdzBJMU5NTW02dkdwejB4Y2tscFU5enRX?=
 =?utf-8?B?NXhjdkhEaEZscW1HYTFubXNzSExJNTg3WWErb0RtOVo5YXhybmtaVExpOFh3?=
 =?utf-8?B?K0F3WHFKN2I2TXY2VXZxS3BKNCtuTU5jRVcxNGZJNHpQSGt1UTlOczUrSm5n?=
 =?utf-8?B?cCtBOEU1R2dhK3dTNnB5eGtWb0VOWSt6eFhNaXFrN0QyS3ROY1BZc2F5WGtt?=
 =?utf-8?B?R0lYN0hDd3FxM2xNNldObDRiOE1LY1VjbXNaeHhYS0g0M0s5MmswODZNMXpz?=
 =?utf-8?B?TEZkM0E5ZFdmQVphTFZOQVlDZ3VWY2t4TnhocE1xdEExc211YjNnKzhDa05k?=
 =?utf-8?B?MlBBUHp1bGswUUM2Y1JRaWo0NGgwUVZMV2ZDZkJrUXVocncyakJaV2JQSEpM?=
 =?utf-8?B?YThNZlRtVEpVOEM4UUc1R0Q0anJPc2NWZm5GZWgwdGl2dWZ3UTV4VGRTR29u?=
 =?utf-8?B?NXNHZlo0T3pNekdWVTQ5am9QSnEyQ28xZVBHb2cxVFRpYi9tcUc4LzJEMloy?=
 =?utf-8?B?VHMvelN0ZTh0TkJiZnk2c2NBbituL0Fxa09xU1VOZjVsRGppSUxhRk4vekJw?=
 =?utf-8?B?bEV1Q3h0SHdPVFlzL2JoN3Mzai9SYzFzbUUwTUtJY1B4cmorcXVFaGJrcXBk?=
 =?utf-8?B?c2N4clpkMXAwRzZmZk5ZcFpEL0hMOWl4OUpDckRPTHJRRkE4ejV0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3201d55b-5b6b-45d1-4784-08dee0fd2424
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:38:17.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnOq/4vGdOlFSspQXgidxq8DNcMXTZn5xAnEJK+6bIjeGMefRqeYlWEywRrymV4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532

> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> 
> Add device tree binding documentation for the AMD I3C master controller
> version 1.0.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Co-developed-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
v10 changes looks fine to me.

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> Changes for V10:
> Use symbolic interrupt macros and include arm-gic.h.
> Added Shubham Patil as Co-developed-by / Signed-off-by on the binding.
> 
> Changes for V9:
> Updated the MAINTAINER section.
> 
> Changes for V8:
> None.
> 
> Changes for V7:
> Added i3c controller version details to commit description.
> 
> Changes for V6:
> Corrected the file name for $id in yaml to fix the dtschema warning.
> 
> Changes for V5:
> Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.
> 
> Changes for V4:
> Added h/w documentation details.
> 
> Changes for V3:
> Updated commit description.
> Corrected the order of properties and removed resets property.
> Added compatible to required list.
> Added interrupts to example.
> 
> Changes for V2:
> Updated commit subject and description.
> Moved allOf to after required.
> Removed xlnx,num-targets property.
> ---
>   .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 58 +++++++++++++++++++
>   1 file changed, 58 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
> new file mode 100644
> index 000000000000..2caa245a8656
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c-1.0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD I3C master
> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +  - Shubham Patil <shubhamsanjay.patil@amd.com>
> +
> +description:
> +  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
> +  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
> +  buffers that implement open collector drivers for the SDA and SCL signals.
> +  External pull-up resistors are required to properly hold the bus at a Logic-1
> +  level when the drivers are released.
> +
> +  For more details, please see https://docs.amd.com/r/en-US/pg439-axi-i3c
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-i3c-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    i3c@80000000 {
> +        compatible = "xlnx,axi-i3c-1.0";
> +        reg = <0x80000000 0x10000>;
> +        clocks = <&zynqmp_clk 71>;
> +        interrupt-parent = <&imux>;
> +        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +    };
> +...

