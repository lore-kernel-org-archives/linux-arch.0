Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9492773EC;
	Sun,  8 Feb 2026 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770524633; cv=fail; b=EYm7bnkWee20YBrDzMo8xaynCCJn0d+V/JlC3CqDn1hUtWSr/O5CzQk85r3g4wzALePwrfC7GEvI1kBhDRtIPjE2htHhV8URa9nqKJq+Ese8P5GvD/iBmmMw8a2Fqf2LrPo+bPlH1xt5fT1JboEIhvJF7WExoRtzFlAGkWtq1H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770524633; c=relaxed/simple;
	bh=0oL56+5wM0/JiU44e2lQFlxo4mXY194ntEaqUeylg2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWcGJ5x96fWP4RCubD0GMweuGmHNMezXC02zfkXWoEdq+ZkrL/r2iGZ4v3ig4zfbjeCji+r7Zp2T3SaLvQ288LoKzMftzP/hm0CC/kunNpbpifqleEfC4s5MBOBxmaS+U0SY6Zb++gFPEdMmh5DcyBkfY2/vSxVNQ56ANa6ry9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h++/yPNO reason="signature verification failed"; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h++/yPNO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXKYRJpSpeDi5j7pkuc9K76Vm5fmhr1AjTeucXhLDaZGACQofazULASXo83hj0MIj/n7fpBAgwHzpTwRo2NR6rK48Ff9nTSPJ22hdFnaB6bJVNJLoLI3ZR8uldntJQ/5Io1vS67buJNei6lIpdFGKazgwY5o1u4g0CJ9JXn0ffNabslXPj6/ja1OXw0VfueIwYQhAVxZraBnh+E9jePCbmKWJlZ2K74bjyTaNc96xMUQWFmmXvR9m0V21fZP1qlDAgifr38CJRaXZs3BR8j3YLoNwPO5zOxMT+qO2DQkwTcxBByzSd47MwIC17tP6iH298cRml8HvAT+pYLxwKoCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkxNGuIhkN4AKNOtkkPuithEbF0x8EaspeLTcnOBwcg=;
 b=mGJp+uPRgXc2bUHp0SSaswgsTPAX1b9eJcmLRhb2g9APMGFBHLz7S5uB3PxDSrqLZOxG7RGHyrefOq2zP6oh0Ggtu64Evbel0EINsP4wqxtyo394sOLyTfmQS7qBEhXSaml6eI9u0unKEvuOntLd3BxwGYzu/k1fQJPj0So5Bu2oHSjFgo9NMXISjFqAuhj/7U+0ZszoAf8X0Ry0NQdfWAOcc+j/OOMuLRZY4g3nTrYuCD5Ovi4dWBhtEQ/ZMU+adZc3uXuxms330eJciqkP4+5lETPE2RlE/ilAE9cRIu00iIgnc+spe27ESCaoBBMjjSEABpjTNGMBu/bg0XwXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkxNGuIhkN4AKNOtkkPuithEbF0x8EaspeLTcnOBwcg=;
 b=h++/yPNOEuDYCSD3EWyuBWIkx0SB+6U4nUfK0+m2vHegiYmZEf6Th3tTk8wXQNoZUkErapiXabEaSB8X9LeeMExlRpSf+sczjgXsvqQYn4CeX14tmxW0vvvY+MpkE5NfgtyqO3Rn4yG6vL0H/DE31LzPtSRVWSnUcP+xQpO3HOyF0ME6ftc/+NaD4ZXO22izjz0W9ROAd7/DOpk/mtemMNzR0GNAToCgH81CQOR/CUc2aBSn7fCTW56GUPg5w4ey/2doD8v/+nru5+Te0R/gpAVB0OAIjd/4pQX4UVcbfLR3QiR97oFJmuuAGa7kSAqRIp9v+PqwQnfJVsFInPmD8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sun, 8 Feb
 2026 04:23:49 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 04:23:49 +0000
Date: Sat, 7 Feb 2026 23:23:47 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: david.laight.linux@gmail.com, Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 12/14] bits: move the defitions of BIT() and
 BIT_ULL() back to linux/bits.h
Message-ID: <aYgP00w2xzWfbx8l@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-13-david.laight.linux@gmail.com>
 <87cy2gb2ja.ffs@tglx>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy2gb2ja.ffs@tglx>
X-ClientProxiedBy: BN9PR03CA0872.namprd03.prod.outlook.com
 (2603:10b6:408:13c::7) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: e874613a-1d5b-40b2-996d-08de66c9db97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?X5Soro5q9DMNl1UarJ8iTHIWBbmTL62ZydYXdtrYOAKHkFPrLa6bYOv9jR?=
 =?iso-8859-1?Q?gQb+vqqjDQkFPZUD1h38Au90baOCC+vCXXV4V4CUsZww+WNp28uOtinMY/?=
 =?iso-8859-1?Q?ADK8AvzaHuDW+m2oUCMCNcgKfcinwD0HxdoxTDasjEDn0yO8JTfUtK+4m3?=
 =?iso-8859-1?Q?Q75bYynuEDU30ETdiaBJiU6EFCWTsJZp07QmPiIZ45aFrvaNQjSn/7c1KP?=
 =?iso-8859-1?Q?xroXzCS8esc5E98pGbcEG8X/6uZAmDKkZ8cu2usAMRP+48oMP99LzIkwd1?=
 =?iso-8859-1?Q?RuqlXbb7iLbvIaVoeP7LzEUP1lSjW7tfbCluA8N7eM52q6XNdag0lERkS1?=
 =?iso-8859-1?Q?fBrIRMp3uraLTgTBMYRtD4OhuNWh2biQp3YQl2aeKUYo/cPMbui9IQmQqe?=
 =?iso-8859-1?Q?WYYBFXMsFOO5Fzvwo3HcM6wMW+9PiWMRYf4N18Js7yHn125SBifWZULRdp?=
 =?iso-8859-1?Q?mhmjg4VD+zG2TcAWqgGfEc3iGlJ/yKGNqv6hEjDQG4A8DVf0ZncXmxU1ra?=
 =?iso-8859-1?Q?7Yd4em8p5SKhrdiW+LHHOl68YVuESsD3KmZLPDEztRH9B4UmUB04F3WLqT?=
 =?iso-8859-1?Q?IzCDhTQ4wg94ZtXupSV95VHi9AhZIuu2MR6CW7XfhrXUMCJr/tL8iqvBwC?=
 =?iso-8859-1?Q?uHT3EwwqbLGo0Wl2qVhIREVbl7lq9PW7DhZeKGUD4ORvKi/cpQkcG3k9dY?=
 =?iso-8859-1?Q?/ymArJ+83u5lmwPP6PCawT7klI+XiEKXTJci/S/2zLLcfTPPGLoh1Atbdn?=
 =?iso-8859-1?Q?dTOtoxudN0sRndn36ydw3QCP/5JbPaqdf4gk2ddRrcgF4nvusDnyKzYfcp?=
 =?iso-8859-1?Q?ju+EH9FGux6PY43XGUcAtwArwZ8cyj8eb6u7QHKKaEZqWQnEUBfRQ5BdfL?=
 =?iso-8859-1?Q?jjdyoT3N6fcie+VtMkTlkJiKYvB9VXXJOP4JHars2ZXI1KR64OIXyDR5Zx?=
 =?iso-8859-1?Q?My3aK1LEWfbzg95j8+Onwh/zrKAH6LSZS7ONhavU6XngpBikI6ayVczxM+?=
 =?iso-8859-1?Q?ENlR9K4sJRG5kwR+bAyzK3g8FibnM8z42lpENgR2ufsvS7uZU6CUf8CGWQ?=
 =?iso-8859-1?Q?fYDjMdJ3WkNWtPTzTuhyiKELw/ft7dfmu83D1/R03h/1w1hGfp21iB0kAH?=
 =?iso-8859-1?Q?UnO86nuILciPWbb/gomNFt9wjHpN2X26JEtXS6LdhNPfQ0nBlPeHmSA7lK?=
 =?iso-8859-1?Q?zd7jP/Vxj2OnUlxxeiHx2MqT8QeOev3H14u44ysy7sxgjAET2ykY0Vr+r/?=
 =?iso-8859-1?Q?sEa59TiJkYr/nHaR+TMsEkd98ZpRKtQ2Du+M9VdmBUbqyntAOtF6Hf2D+Q?=
 =?iso-8859-1?Q?oITKc6rgOXk44M5Fi84sV56e0aqkqqxcekZdssZy7k2k1AC67CjPSwtTjs?=
 =?iso-8859-1?Q?61AhzhG4+qdDj3soIGvUxaG1W6lZZCddCxRnLcIznlQgzwvX/TZrUJfrJB?=
 =?iso-8859-1?Q?lST+6lf/HbMk4+CSJ4DmIDQ6U0sB2Dq9NqRIFDz7VdSLwq6VAsAN+b1FrJ?=
 =?iso-8859-1?Q?8qj/WUrKW8BH1bRdIw72izuH595cBOMs0k1fgqZCa4G0JyCHsPzBnefrTl?=
 =?iso-8859-1?Q?d11oJ80fhD1S51l/JTQLEBFjvlCHvUwZVgd8PS0HioupdOUSHwWYg7FH8n?=
 =?iso-8859-1?Q?f980q+GesilnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?x2awpo6KvdSTHkBoy21wlrxDNmCrLgO7Y4LuMdMXg9+ES4X4YmULFl7ly2?=
 =?iso-8859-1?Q?qWe2I9rHsdgDly22QPoAkQe5h3yXOJ3MHQm1JiS+L9V7FwzHUruhlpT6+K?=
 =?iso-8859-1?Q?7q3kuZbGLXzIDIcny80MmK0g3PyT3c8VGONr//LyPzRH9Nt7AK2yWSs/Bz?=
 =?iso-8859-1?Q?3tRAdpH5ss/RcYcqqfFqundJ/jhiixLJx/YNReD0IIwRgMx615E1X2bzgm?=
 =?iso-8859-1?Q?1OcMoloyN/8MskFbux0daReBdDFFaKSClYREpLaWOgJHGJIq8iazhP/Wm/?=
 =?iso-8859-1?Q?SOMUbw5iVaoBL1LZO/cTGypERpGNAS3ACL44LiE2yKCiGpqwezte8B/YdG?=
 =?iso-8859-1?Q?leybbAJQmOVn7SY1YV+CaZnK9xjWBuKXijmOjupehuNUXdOIPmKvoz4uOx?=
 =?iso-8859-1?Q?rc3l+adicNnR0sm9n2iRsaaIp9NGniTKL/5KR8Qz5d+hAXpwbZx7wT+wdh?=
 =?iso-8859-1?Q?R/8KRiYOkoW+cOCDSPuYvPGQlqZ0gzoIlNbz8Sx09i3H86+nxd6+UeMgVF?=
 =?iso-8859-1?Q?GcrszlqnEDWOiXBva6P57cQoRZ9UtxyogAvfzjonD/XXV8Yc7Cu1eTvVpm?=
 =?iso-8859-1?Q?a7ni0/G7Qk1Rc730tMsE8catrJIPULp0eUh88gsjlicKYXOnuzaAjJH6Pp?=
 =?iso-8859-1?Q?nZhmI0scOLlcgZCPiGUBxCCclFwZTQDCcKaRr7B1QF+Uy7S8x5Zj3+wlHJ?=
 =?iso-8859-1?Q?1ktsRXxNr55bm+cesU0ZcVpRiYatb8C4f7oiVwaeVM3IFZtbA7hGqKrqr+?=
 =?iso-8859-1?Q?nvNBl7fmVPsO6ONisnJSzQC5lxc+F3AjMpojc0MFW+vADMjRtNrYY2YZ31?=
 =?iso-8859-1?Q?R1JPR44i9Klay+7bP2nYp/bYXjiz0eEBBjI8a4NX4JV4J2BbbTsJAjSPZY?=
 =?iso-8859-1?Q?+M+WYwUnDWjd3egq2WhwKYF+7GKYE050L3+D8LPiFo/Z13mREfaNM1jKYb?=
 =?iso-8859-1?Q?GJx00f3I72sx1luoNkS7HaQvMUhe+5JSelsZG5pEzSYycecFgXCKEbsp95?=
 =?iso-8859-1?Q?RIVimb579F0JISnYlfck9bvPQ5gVIpnTdPj7Bn/PJTAfBEpIk4qhUEk5jS?=
 =?iso-8859-1?Q?BF6X+/qXDme5NVmhCoF1fF+xiH66h/aHX1DTg/cwWTrxbHxaHHTtWfrzud?=
 =?iso-8859-1?Q?WyG72SnBbDbx/nLVnZnG4daB9eRiScgj01QHwVPzhptBJL2jl9xyZ76kKg?=
 =?iso-8859-1?Q?IHQMPE57Vu+Op5ytvVMrdA1o4GK5wWaNdJVV9eBtpXLU5oLSJGCQBRlxue?=
 =?iso-8859-1?Q?xoZ8C/FvlJQhsYx+stAsgbqHyWTUnhzeG6o9+kcfOUG/l89tSiTaITA/7z?=
 =?iso-8859-1?Q?+TtLVeOy1wj3VlR2zC4g/je5Aa6PZL5h7ViK05j6yyxNr4nEO8MdXtm32F?=
 =?iso-8859-1?Q?WtYXt/tVWvnIZYmyX1pOh4NerOi5hEUu7CSQXLBT7Sqq+G4W7ZaqGfLyfB?=
 =?iso-8859-1?Q?gYNw0Ch6sqp1loLulcZp+28NWe0FBxvGRFolm6sWg+tqNl67SS+fSsHK+B?=
 =?iso-8859-1?Q?EkEOO87sNow8rSx2ywKuvy4ZTzZIR09GfN7qSJb9HFQCHGHEwHANIRZPLc?=
 =?iso-8859-1?Q?xgWKT3QIxmQM56qko19AAzuatj2hZsc+R+K9PRzqwxYfOvtnZPP+GV3nRI?=
 =?iso-8859-1?Q?EevC65vJ+rVl8upaO0sjrUBwhRcE9G5StgweuvzBnsejuocN3NbbX/UVFM?=
 =?iso-8859-1?Q?jr0WC9LT7TJ7pAmZWKjTlCECP/ek7ND2BEp+DlVILsy48JAC2M9eD7lSnt?=
 =?iso-8859-1?Q?Um+uLSfxAH5bPXxCAYxIy3zzJSjVTGe+AQjLbNX5EPLoeJMIvRm9c2piYn?=
 =?iso-8859-1?Q?ms4O32ZkJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e874613a-1d5b-40b2-996d-08de66c9db97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 04:23:49.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9l+u2WnBar6q/GanSpUYlZ6mrI+GcEEukBkSEkemZLZwXt7IK8IWaOEthDACvqFaFMS1OZI+uzPbCI0ezyEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

On Sat, Feb 07, 2026 at 11:40:41PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 21 2026 at 14:57, david laight linux wrote:
> 
> TLDR: Not going to happen. Period.
> 
> > Move BIT_ULL() and make code that include both headers use the definition
> > of BIT() from linux/bits.h
> > Add BIT_U128() for completness.
> 
> 1) How is that related to $Subject?
> 
> 2) It's clearly documented that patches should not do different things
>    at once.
> 
> 3) It's also documented that stuff is only added when there is a use
>    case. I can't find one.
> 
> > Note that nothing the the x86-64 build relies on the definition in
> > vdso/bits.h, linux/bits.h is always included.
> 
> Wrong. The x86-64 build includes vdso/bits.h for the VDSO build.
> 
> > @@ -2,7 +2,6 @@
> >  #ifndef __LINUX_BITS_H
> >  #define __LINUX_BITS_H
> >  
> > -#include <vdso/bits.h>
> >  #include <uapi/linux/bits.h>
> >  
> >  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
> > @@ -89,10 +88,16 @@ int BIT_INPUT_CHECK_FAIL(void) __compiletime_error("Bit number out of range");
> >  	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
> >  #endif /* defined(__ASSEMBLY__) */
> >  
> > +/* Prefer this definition of BIT() to the one in vdso/bits.h */
> > +#undef BIT
> 
> That's a horrible sloppy hack.
> 
> > +#define __VDSO_BITS_H
> 
> And this even more so.
> 
> > +#define BIT(nr)		BIT_TYPE(unsigned long, nr)
> > +#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)
> 
> Aside of that you sloppily kept the comment above all of this intact,
> which does not make any sense at all after this change. It says:
> 
> /*
>  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
>  * following examples generate compiler warnings due to -Wshift-count-overflow:
>  *
>  * - BIT_U8(8)
>  * - BIT_U32(-1)
>  * - BIT_U32(40)
>  */
> 
> I have to admit that you are at least consistently sloppy.
> 
> >  #define BIT_U8(nr)	BIT_TYPE(u8, nr)
> >  #define BIT_U16(nr)	BIT_TYPE(u16, nr)
> >  #define BIT_U32(nr)	BIT_TYPE(u32, nr)
> >  #define BIT_U64(nr)	BIT_TYPE(u64, nr)
> > +#define BIT_U128(nr)	BIT_TYPE(u128, nr)
> 
> What's wrong with the obvious solution of moving all this BIT_XX() muck
> into vdso/bit.h?
> 
> Especially as you say in your changelog word salad:

I'm next to that. I'm having hard times struggling through this
wording style. As a non-native English speaker, I used to ground
myself when I feel like I can't understand things. But here it's
clearly not only me.

David, for the next iteration, please reword your commit messages and
comments with a more standard version of English.

Regarding this patch, I agree with everything Thomas Gleixner and
Thomas Weißschuh said. This is an NAK.

> > This lets BIT() pick up the extra compile time checks for W=[1c] builds
> > that detect errors like:
> > 	long foo(void) { int x = 64; return BIT(x); }
> > For which clang (silently) just generates a 'return' instruction.
> 
> Letting the VDSO build have the same checks with a W=1 build would be
> too sensible, right?
> 
> It's not rocket science to achieve that. See below.
> 
> That's admittedly a hack too, but a more palatable hack and I'm just
> including it for illustration.
> 
> Just for the record: I definitely spent less time hacking that up than I
> wasted reviewing and replying to your slop.
> 
> The proper thing to do is to move all the stuff which is neither vdso
> nor kernel specific into a separate include/$BIKESHEDTHENAME/ directory
> and sort out that ever recurring problem of VDSO vs. kernel builds once
> and forever. That's not rocket science either.

I would say, "both vdso and kernel", and I would probably add uapi in
the bucket.

Thanks,
Yury

> That'd be too reasonable and tasteful, but not convoluted and sloppy
> enough, right?
> 
> Thanks,
> 
>         tglx
