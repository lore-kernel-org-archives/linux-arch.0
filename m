Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3A3C9422;
	Fri, 17 Apr 2026 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454093; cv=fail; b=UEpJAGtw1ok/Q5llxlheuPdVKsSvEojcPD8yHrA2p89ub8L/3oo1eo5STTXxW2SLZkZm3LvzSp4J4at34omOuf/txZu6kva6K3433ZThn5d5XC644f6aZGjAPwM+Rmtw7Hy9We+vLC2E8beExmKOY3d64rMldys4dn1bFOhQvW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454093; c=relaxed/simple;
	bh=N6Joxmu43xfLH00eP81zusnj+5f9bJk8P9hCy9TSztE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gLuEKgt5Pcruc9MG3PIN8jXEMIcol/9kUY8XfCpESdDfbQVd6gpggBChElLDIZ8Ya1CR0qcbGzxBRxluibaWuj4MQe5wl0cO97Prv5IfRRpRhRDlXOluVsoHQ0Xvo1gdpSIOk8LksjcaBl/t4xHZlXRqeWDiA3CJJ2H/ZjvR10Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7Hg5Q1o; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7Hg5Q1o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhCXc1Z21EwA7LqlKxgUqxykptr4W/wJv8J1dggHtSDdautjK7AV4J5DSalWTw8LQ8s7kILPl0lk2k7FHJKvibdHRAKdWM6Ad7TPUGi6XOwVpb19vdzYsHiF6kgFXmL4YHROFzPFSHMfN2dXojfNBf94gv6qQ6T6vP/hC2oXCbF50QnfOWaRsLPcW9fQRmrkrmrdVKLRSXJpMW/Uom9dixhGA8TZHKWxKu7CjO5tcJHCQw2kYx31lrFC6nufp7xxz1tS7HtJ2ZovD+0dkTOvngaXzSFadn88MigcLPnMy7MDq5ojPJgjKB42IEEL9M6ev/D0MZ0Wp4ey8UVg4ODBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3L9V3oBsJuxcICYRpZMpHGL9EUe38e50ToNlZ6Vc60=;
 b=poqZDEMGur10yjwH0W98xg6GIIsRhDb+/MR14Cn8AwXoEC/igTE4Sd/TdIBBt8AMB/cgkHhYcTqj2Tv9iYP/jsDZf1D0iSKjZOapNZWUP67jv2ZqoZM6izN+mJ1EKoGc0jUov9jqtGB1xWfJu6kI40u1OwXmFPsbPoZNtTFY/JlKFpBYGrTq/76RQldBFXh02BaCDwVWIhBXl+a/tTKnWkF38Tld90TwFdl8qwmh4CGlICwm5dmuj/NvpLisXjmaN5+rn3c8pV09pOi9/mPWDz0ltK4X3EnPkcOjvx4QYIPF1wDhqVsWKyGJpN5Fy+etn0KfV3eddiFjn4H3r+5wfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3L9V3oBsJuxcICYRpZMpHGL9EUe38e50ToNlZ6Vc60=;
 b=W7Hg5Q1osaddz8x2vDknlh34FNyw/Ho7+Ona2lNi8ijYzk5nTY2gifVm06exv/mRMHCgUP0FwR+AFbE1qgQ82o3B30Vd3w4jSWNQY3sTYqDiOo77+MF3wEgRdWotMOQKDtj5jm0WKk24KrmMcZ1o0Sip1DT1fl2rDHxtb6j8zNJugrK4hcV5n1vTrw6be28+VaBnn4hlEWiYKG1U9kGZbcqBiBzUGHgRQKoyNCt5qi/RP4yrsmqqACa7tEU/tYC5a78RFz6KFcOAsvhC53rxXZ9cueHwNkc8Xp/q/ZEJtIVkDE49DkM8zrMludNYc8uLwpulrwDKdHNGSWlUZg3mzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 19:27:59 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 19:27:59 +0000
Date: Fri, 17 Apr 2026 15:27:57 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, yury.norov@gmail.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux@rasmusvillemoes.dk, arnd@arndb.de,
	cp0613@linux.alibaba.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
Message-ID: <aeKJvVaKeI0AiY09@yury>
References: <20260415093827.2776328-1-ruanjinjie@huawei.com>
 <20260415093827.2776328-3-ruanjinjie@huawei.com>
 <20260416231441.GA12905@ax162>
 <aeF5Q2XauRKBDssy@yury>
 <20260417032917.GA4041922@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417032917.GA4041922@ax162>
X-ClientProxiedBy: BN9PR03CA0538.namprd03.prod.outlook.com
 (2603:10b6:408:131::33) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 733d65b0-4471-428a-ca93-08de9cb76f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tlnWSIzp+tym/lTDWJcI/k94Nwr3KYE2wKT+V7MPUYoZApGe8R9AnRmxrjwxAq5fV//qEk3Upbl0/aCa/TfYOnVMsDPnwhSdNzF5plC9e1V+pXk8auKWOC1RuhR1MDUMfXOIFTskTe4HcRhAr2a2Z6HHzDf9QrHT5qG6YfN5Apz97QoKTUtPP4vrVdGIhITQspEkfyAbQLb91VPN/2GGAXnAopzUBlo60mEsd9wNBrYf+GxCb3olrW8w21AZVcqDvpVBsNWpOTzfCJhVTbpDgK2wKEaf0DL52mpCzEr4lQa6S1N9YWRyh1dWnN/4JhYcZRAwpCam6ca96w7xGMN7Q/cBK8r2Gq9YK3oHhKP8iffFUPDKATsVvc0xx1OCqq7gRToQm/2cuTB2yTm+4HDAWh1fURY/2IwDsdwGLUnDcK8tn5G8lW784VXwctntEO0RORaLosPchJ7cYVNq/MOLRGA54gGkaUg4vIAX4pQc87MlOK4mZeqb25SZvnNJ8PG5ps2YDfdFAqQsn5uwLspj/Agv+zVVwXtH2d5JKE4hV1L7CgVem3DO/gL/dI9dhzsdAb2Vj9Yj9b635/4aZUS4EFGOZOJ76ncMrp8vMnPxNYVlonnTUnyuNnjXxMyVr8QMTe7AFyzFdhsCELxxNWZgoKooCwxXk1sBMMFd3xfsEEa2uWxTZGENNdWt/n8+JCuhU2JqC1dSnABuBMX3iGKwkPfJ+kil++bX4P6M7v1DmkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rp3ZG4Mliys3tnI1b3OjKd+OGidMtRSi+ekPnz1RAy+pIAxWFSDjCzNNoIwB?=
 =?us-ascii?Q?2H1VaoBeObqk/xu/uePE377KnB22g+fJTAO+S2Wq3LKPIykyWoqNXF5yJqKe?=
 =?us-ascii?Q?ecaJZN8UHXNLyaDydEPNEG2mCa45r6tqUxCrmYBB0X7NE0FEgYux63fVHaLP?=
 =?us-ascii?Q?R/Ayzv0E1/MbHdTBhRkH2eaNVxIrc1iCB2HicijZjgDeH0O6PoL0Z0ZisVHK?=
 =?us-ascii?Q?7VLLWv/waPIF0Dd68/rPvnx2xWk0euJQG1021KUthVvB1zSGrWeGjA6wPct7?=
 =?us-ascii?Q?4M5bLzD1Qej1GmHwCt73dJrCRp8bhYBPljlXF7P2y/IN02HInUSQ6/2ecBKa?=
 =?us-ascii?Q?XYqXNxNx+Tpp2Ub2fmOjLXxb5wav6kbHk3HdFr7l2E2mJQKnymO287eTFV+H?=
 =?us-ascii?Q?BJMG6bG3sTYTDe5JnL4KmKfdbqVV1KxtBdpvpGYKGyAVjZToGmQU9cXpdpso?=
 =?us-ascii?Q?Vv6bC8kA2wMOOa5F+I4xEXFtlZz83vGXh/Sad0Ob9ezbSTM+iOcgIP1OW/ib?=
 =?us-ascii?Q?D7mRPpXxzQ4bH6RY+jlNEygtXsWEpX1dTtv6j8zmlxiIbBegNz2SV6THcCpy?=
 =?us-ascii?Q?s7qN9zXerHiosjWv+2KRG6Kxp9Sc0cilFnU7d4OMthYD9BYME1wrc2BYHnPr?=
 =?us-ascii?Q?Z3/nvRrZCmh4NiqLLQ0iNAylFFbO7ORperTILZTPNL8JYp4hKHVMV0M4Pru6?=
 =?us-ascii?Q?p77Vq+4p2H8ZzVQ5PfOavLsB/uwuJiGRQpsMzevztyp+XFYqiWuvMx/GNct8?=
 =?us-ascii?Q?McaIwpst5In6qbHnoiyYRNS13Oxw+r9DkRnT6d800D9LZOZFWkmoWgKdZpY4?=
 =?us-ascii?Q?YuCgyOUXg7RMU7Xq6lpZA+oD+xdgLiskWNDjUh/96y/wJShP/3EDD6YPNPa+?=
 =?us-ascii?Q?l4p7Xer7TD3Ph994IIahBWywaVfpApYOiyeWg0Ec2bYlrxnsqwUbaY7fNdh8?=
 =?us-ascii?Q?KpugM5TWnwC8RlbcCOZ7RbkXzq/ogNEzZCvZEe5YtlLCGt4tKCvJCDHhD3k+?=
 =?us-ascii?Q?EIQvyegxTOjGxBG//luMBWtKHf61cQjyLkxf5AeWjc4XE9Y7FYTqUh6r1xNa?=
 =?us-ascii?Q?R1zGbcDWhMME8rq6YWQt/cd2FFprgj7Cx1+SyePPD41buRnWTbni+Tf5obC1?=
 =?us-ascii?Q?SWxTdVVLUeIphn9904enYiijtBL1XT1KivuZrAeyJHiY+Dn22SdFvViXB8y3?=
 =?us-ascii?Q?IUv6NAZfUcDfhaR7PfboW1Oh0jKawDZFW3zrxCz7RvYx38Go0dEpsBF0jKR/?=
 =?us-ascii?Q?0KUqwXOoUnf5IuHnWwKs016YOPX/KsWxxnvdek+I4GTcBlpth3EEoACgOpUb?=
 =?us-ascii?Q?nPTQLWVGGqNB/doYP5gJCffmeLGc4596JLhU4Yo38sCDX8X+bhR+D1AIQUnb?=
 =?us-ascii?Q?RqbTlNfgTr0cPdQNPlIUb7LPDWjHjEjuOwLfqpx7BjBRS8g5n0NmgpZz04ZG?=
 =?us-ascii?Q?VUhHE9fN64MDd71Gzp4aHiDhChwKSsFQJYF1Jj2CS9o+Rv0xtepsLn0grx5G?=
 =?us-ascii?Q?5P6N31jxpiQqUsUARu5VkpzpaAfSl9GQFiFXsJQVLWuTbi36JmAQNI0IDrer?=
 =?us-ascii?Q?0Hz04E5uiQlILxUrBvpCiPHubduNGCd6/frfjNA2tndDJ471BIcyugY8cOhO?=
 =?us-ascii?Q?HWE9S9ygDBmy7hLkeWyxplv+xrP/8mFuxrao/y8dYaCfovvR2Xl30dTO8drv?=
 =?us-ascii?Q?MGAu6Khv0wM4XjyyqaCRjBgnyA1H7fpBuJEaOOynB7BCJ792DFcFZg+f/id6?=
 =?us-ascii?Q?uvSPhPsGN5BIXv8Sm/9EOYDJ3YJu0CTKGSKd+Kn5ThF6DdlK4pr9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d65b0-4471-428a-ca93-08de9cb76f36
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 19:27:59.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmXGXKLYGrl9E7UsL9zSYk/VqzMhobVj13CJEffubt+7KPZ9+gMMv46XMv+KTrmzjBATVheE771D6auJzkyYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050

On Thu, Apr 16, 2026 at 08:29:17PM -0700, Nathan Chancellor wrote:
> On Thu, Apr 16, 2026 at 08:34:28PM -0400, Yury Norov wrote:
> > On Thu, Apr 16, 2026 at 04:14:41PM -0700, Nathan Chancellor wrote:
> > > Yury, are you intending to send this series to Linus in the 7.1 merge
> > > window?
> > 
> > No, I'm already done with this merge window. This is the material for
> > the next one, if ever.
> > 
> > Just as said, I added this one for testing. I am so far have no feedback
> > from robots. But your report is enough to drop it.
> 
> The lore.kernel.org link came from KernelCI but it does not look like
> they do bisecting to identify the commit and notify the authors. It was
> just sent to the linux-next mailing list.
> 
> > > If not, it shouldn't be in -next at this point.
> > 
> > What for do we need -next, if not for early testing?
> 
> It is just for the two weeks of the merge window to ensure the tree
> actually stabilizes. This is how it has always been.
> 
>   https://lore.kernel.org/linux-next/aeDrt2FkMD6ZWaVS@sirena.org.uk/
>   https://lore.kernel.org/linux-next/ad9r3jEtJJNv0IiA@sirena.org.uk/
> 
> I think Mark meant to say 7.2 but still. Not trying to sound like a cop
> or anything but the more problems there are in the tree, the harder it
> is to triage new failures and perform additional testing.

OK, roger. The material is removed already.
