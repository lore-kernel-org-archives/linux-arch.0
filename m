Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021138.outbound.protection.outlook.com [52.101.95.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50938E12B;
	Sat, 18 Jul 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384806; cv=fail; b=KmWw0FGwEg6xXvDMSvFGj2RYTasgcPY2uRJ9iRrFvVmRSPLsrhw4mv+JogYZpyyr+zDeuH9IPAl7UeWZh+V+r3zA5r6MAqk006D+wSN0F+J5T0I6wxxbGpVZupaZ4oa79onv+Z44wfTZTp6Zn6XFa0Q/MKv27HWdkzq7L56Vdm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384806; c=relaxed/simple;
	bh=C6PRU5+CLeBvJlWrbMNXzeONjExB7dT/0o7leNQFv7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qoYFF6xXiXJT9TAichjrYU41rQ5FLT4q5HCIXBO5Hgktl+i4n+obnvcShYHSGty3mLwjpDL37zrkfxPRLIMWaptpvoEQIPB243unk2q8nF7JoInPWoB+cP5+goQoWOBysAPEFKu/nngrNq8g90MUDoiHKuy5rLSuLcmbyqsW3pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcDOiuzKOXFbqMhDYCDn67mcmZnKx9bW5F3eg7vAI1e9rcYNsZ0BEWrriNRbZElRv/Ux+1riQ+ypwoXeIsCnlnRbNxHWV8fxPN9nbq7GYc8VdlsOBu3zmrmR+eMq8WSZFbqc5tm/B2Wib+GmZG0XTvSU3rNPp2xHlszpRw8Gk2aKRek1UFKAZrYwf9NaFNX9EAAvLfTmrdTlKbffs+Z6jJzBllBXYdtbdgF3M15GnFefYgUAFA+EZOcHUc5EBZZ2/N4Tcq9QiwvATSctDQYqGXYnf7nqF/m34B3sRuFMxLtnjaEBREPUtjmTORJnVbthb/zTwybcrPeV55NqHe/v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cuXi2IC/8fZ9Vss9818+0g6d+v9BriWYp4CYjIuzTuA=;
 b=STcbSEXutZRpYcVuEpsh38fqGwnM5XDDH5921WTJxGBMoofaQMY0mtE1zYTpLw34TeIsddBngA30iyCSTIJ+NmSDPLuYvn+HvEj7KETNuT2W3m2iO5+KCV0jIZf8dyyhhueE9kWVTfcU/RHC/gbCddSVJ6Csjd4rVRjGXsKr9lodPD5vfDbCb1WbNOUKmAGazz4rs3QwrtQ03nXLIWSsCZsgPS6Ay8GiSBdJ/yPBodhXsDq1ySKZAMvtli5tm9j1bPqdpjEEqwslLvasWAn8RY/b7s47D1GPsbhrhWgkoDvow2kKgJTU6OINqjyd5J1cK7BDIn/SetvrQEueCouk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8184.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:264::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 14:26:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 14:26:39 +0000
Date: Sat, 18 Jul 2026 10:26:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <ufr2bdr2fudw6c6bv27ohmvk52ibvo4lerw7xblkhciaptwq3u@ajj3wrmpwmyu>
References: <20260718051350.344772-1-atomlin@atomlin.com>
 <20260718051350.344772-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718051350.344772-2-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0904.namprd03.prod.outlook.com
 (2603:10b6:408:107::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6fc210-5fe0-4720-1f5b-08dee4d89482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|5023799004|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gtIOCjbUuCUkVLGZX1OS2/fDE2hnhw51Z9bn0oe4XoyD36W8TVV8xWHltgNkKFBCEAv/S/5zTU3eoNVFSFmXgFkE5ZMPsTB6UFrrV9HYHyLU04ku/2blHGKnMsChtG1UxT9urWoq7lJIl4GhTpu5Bdom/ETa+gpPAOqg2dk9E4L0HCVDruycPs7LDMyLff4MBNVmyBaF1Pf+XeE3+JYGIi73SJ0AjfGu+tXv24AjttTyhm3mJFOlGvOD+HK3cnPcUU31H/matybGqWUZ68o3zFiBVNb5l9MkjkSpR75M96b2IgjbeDmftAfR4Alt2U6E5301Fh1KinE7X9Nqyynow11K29mXqJZkJTnELK0/8FVP4jYqttmS5vB3KY6apghiQsWEpyhdgPlmBj2sfeNkej4FBD8gbWTYRn/SvuY/tGuLj91yu/GkL9SCgcqIcsWd/CNGrM34dIBvu/fGJnYXUBJigb2omu4qKDwXh07fFTVpGSDHmrtQ3gnB9WX3AWWr7BCrhSilXsx1D4eEC1DGv5cgrdNN2ZHxA5sUNwuihksmCdUckMXeDkZSOH1OE9QhzJYzjQaDH3pnSmN7AigctJgyz3iTY/D/ZTYcBqoe0OQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTczcGdPR1lWWXZTV0VNN1czZlk0UnBvSGtsMFNwUDFtaCtVNFNEMmhKSDdE?=
 =?utf-8?B?NGVwR29PRms3d2xTekhGK1UxSFQ0YXl0THpDSzRSVHFxUlZRTE5RaXd0eGM1?=
 =?utf-8?B?d0ozL05YaVZUQkV0T0huek9qRHhQT042ZkdGaUEwSVBoNU45TVVlMVM0QmUw?=
 =?utf-8?B?NktFS2gzR0dsaUwwdzlOelY3UkRkTlloRjhzNURoRUlGRWtvbUxJakdvbUY1?=
 =?utf-8?B?RXVsU3VvOTFScURRWXRGcW4zUlF1a1NaVkw0NzJBSUlmQWtWaGkzRElMdnVx?=
 =?utf-8?B?eU9TWEdYNDJ1amVsL3M0TTkxS2dlRWtlQjJmOW8zQWVYNkdjVnBNQTdIVXhs?=
 =?utf-8?B?Z0RFeXZ6alo1MU9wckZTUHEzR3JlRkRMY2NRLzN2SDJRUDdPOHpWZzZKMStv?=
 =?utf-8?B?Q2s0YXZ2VWFzY2ZQdEg5NVMyV2hyVWlhcStaOThxSVIweGdGOEUvS0lFbllD?=
 =?utf-8?B?K1BzZ21zRkozQ0p0S1BOb1YwczlNWkppN3VJSU42U1Z4SHFaZUlicHJMSGFj?=
 =?utf-8?B?TktWR1QybFZvSW1wcm9OQkZRcm05K1FONzRtaERzK1pGTGJ5SkZZT1N4UDhj?=
 =?utf-8?B?M2JXNGk4Z1pWcVMwRTJSYnNCTGVEMXNzOWJuRVlHTWJLTHZNckltKzJoaUFZ?=
 =?utf-8?B?SDZUZmltMFJnOUUzY1UwNFd2Z3BRZE00Y3U1V1dXeWh0V2l0N1QxVW8waE5D?=
 =?utf-8?B?c3JHN1RydXprNW51QkFJSXVIaDZ2US9QTmlndzcwWldXcGozRkVaNE16WHc0?=
 =?utf-8?B?TGRiUU5EM2JNVVp1dFFpeGJ5NFo0V29vK2l0bzA1cnRlekJIT1EyUll6WGto?=
 =?utf-8?B?dFBNNURPNkE3REk3WHFOVi9aQXNaQXRWMFNoOXUyWXZsaHczcUF6Q2VYdVgv?=
 =?utf-8?B?bXdNaHpaZTQ5NEhSaU9rd1NwQlk3a21QdWx6M1Rzc0pJOW80NllkbDJQUFRT?=
 =?utf-8?B?U3NFNENBY3I3K0ZQT1ZEWXRCMTg2TWJ1K0pFN3MyNk5XMS8yOURmQmg5K09j?=
 =?utf-8?B?Vy8zMTVLUjJoWW5wK3Y2cTVGYWp6VmpEdlF2T044b0dobHJ6ZTBjY1pGbWpG?=
 =?utf-8?B?QzVIUmNDa1JGWFVDY3E4dHRmNFBaSnRVR2RLalF1dWk1bzNqeG9SL09GSnZX?=
 =?utf-8?B?dmlHNVRzTkoyMllPM1kwbFpORTZOVGhkRlJFY25jM3hUWk54Y0gwZzRtRXBO?=
 =?utf-8?B?N2FGdGFDbVlMdEU2U3RGWnYvRFJycTNHZy9NNWdnTXMzWmhmZFdVczdaNXpG?=
 =?utf-8?B?V0l5QzBsTGNqdFB4dWpJdkx6bnowRUhaVTQvNXZBd1pOYlY5VCt0UERFSm5k?=
 =?utf-8?B?VjF3VUg2TTB2ekY2Q0hlZU52U3Y1Z3h2OTJ1NnRNdnRvbzBIYU1BMkZrYUVa?=
 =?utf-8?B?RWdBMlZ5TWNKVU1iOVcwM1hJcVNiSTI4WERsTWhuZTB1OVE1cmwrWk1KbHNH?=
 =?utf-8?B?TEZ0ZnNvN3pKTUQwdTVKTi81WTNXYmNqRzRRL0hjRFNEeU12UGRzMjE1dXo1?=
 =?utf-8?B?VlVJR3dmU1pFRm50SEt4NXN1Zkhxd3dpUlJxNTVuT3UyMCtrMjF6djRDeVFa?=
 =?utf-8?B?Sm5uRGUyRm9hNEl6T0tGNW5raFhKNWwxRXZoNXB3clh0aFlyd2JZNzNIQVM2?=
 =?utf-8?B?eDFSRDdrQW9JS3Q4RFc2bjF3T09QdU5tRWJlY01uQndOUUVyQ1NkaTRIeWVK?=
 =?utf-8?B?OUErYlJpTlh0VytTMmg2NklhVDNFazZrQ0k1blc0Vy9wQ3g2K2xMeVd0d05l?=
 =?utf-8?B?OGUrM28yTE1pVkZtc0oxcVdIbmV2SzJ3dGtpaDlqUmhYVzB6MEpHangrbG5u?=
 =?utf-8?B?bWtqRGR4b25NUUFxL1hKbVFEME4wL213M2s2M0dwWmh1WkFFdkkvMjdhdFhH?=
 =?utf-8?B?SC8rS1psRDJ0bFN4eEk2blMzWUp1dzNFalRKeDZDMEJhM0VkajFQMWd3ajBF?=
 =?utf-8?B?UHovYnUwZ1FaYVA5bzRRNHBTeDhYckpMcTU0UzllWlNwTzBIeWhieXFUK2JN?=
 =?utf-8?B?Y0hCUVJvK1Rkb080VUtVRUFkdVFhdDBnRWxML3M0eDIrRDM4VWV4cDB5b3lI?=
 =?utf-8?B?dzFzYXhneGUwRmFSL0F4bmxkWStzdDY5QVRObHFveTdqRTJIN3VlcFdRQlZK?=
 =?utf-8?B?bFN3eWVYU1U5NEJnaUpBVUk2V3V3emM2clk4Q1VxSEtVSlIzK3U2dEM4L3Zi?=
 =?utf-8?B?Q202eFZtcklHSGMrcmlOQjBsQzRMbU5IY2s3dmUwc0VXUExESnplUkl6VCs5?=
 =?utf-8?B?ZFFHd21QL3cySHcxU2FWSTlPSVNBV2pWZ2dyQjRTblNIeFRUdTcyc0FUOTh4?=
 =?utf-8?B?K2NueTdiUlBxMERWRlcvTDJYaWxvYkdmUjZZeXpLaUNzMmt4QVhUZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6fc210-5fe0-4720-1f5b-08dee4d89482
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:26:39.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35V537nyEVwPDuL4ycYTMUf8k7s5CVQVNyLZgNBIZLVD7L24V9G0b9KQd8J5alZ+bGALxiRVMv6b5mjiws//iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8184

On Sat, Jul 18, 2026 at 01:13:49AM -0400, Aaron Tomlin wrote:
> Currently, the "module_blacklist=" command-line parameter only applies
> to loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch extends the blacklisting functionality to built-in
> modules by intercepting their initialisation routines during early boot.
> 
> To achieve this, we introduce a new ".initcall.modnames" memory section.
> For each built-in module, we use a standard C structure (i.e., struct
> initcall_modname) to map its initcall function pointer to its associated
> KBUILD_MODNAME string. This mapping is restricted only to files implementing
> built-in modules via module_init() to avoid mapping core kernel subsystems
> and save memory.
> 
> During boot, do_one_initcall() cross-references the initcall function
> pointer against this table. If a match is found and the module is
> present in the blacklist, the initcall is skipped.
> 
> To make the blacklist functional on monolithic kernels, the command-line
> parameter parsing and the module_is_blacklisted() lookup function are
> decoupled from the loadable module subsystem and moved to init/main.c.
> This enables "module_blacklist=" to intercept built-in modules even on
> kernels built with CONFIG_MODULES=n.

Hi Arnd, Luis, Petr, Daniel, Sami,

Please ignore this iteration.

I forgot to update Documentation/admin-guide/kernel-parameters.txt to
properly document the new "module_denylist=" parameter while marking
"module_blacklist=" as deprecated. Furthermore, I will rename
module_blacklist to module_denylist in init/main.c, provide a legacy
parameter alias, and update the log message to say "denylisted".

Finally, to address the race condition and runtime
vulnerability reported by Sashiko [1], I will remove the temporal check
entirely and embed the boot-time blacklist check inside the a new
do_one_initcall_builtin() __init wrapper function. This should ensure the
metadata lookup logic is exclusively invoked during early boot.
Consequently, since this wrapper is freed post-boot, it is physically
impossible for loadable modules or userspace actors to execute it,
completely closing the vulnerability and race conditions.


[1]: https://sashiko.dev/#/patchset/20260718051350.344772-1-atomlin%40atomlin.com

Kind regards,
-- 
Aaron Tomlin
