Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C7238D27;
	Tue,  7 Jul 2026 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453110; cv=fail; b=gp9Rgau+ut1pur7i52q2E5jtKRIKNx7zer1/2zstqyVR24UtjdTv3nrJVepga6pzVvaa+IoKqi1NTExDp9JV8+dKQSvm13oEAqyadX8LSF6cjydiOd7iXGEFEZZrWFKHGD0tRKCrvOzoGFj5A0TqJn7la6LzZzUQuacPWG75mCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453110; c=relaxed/simple;
	bh=XQeRVv1Ibq69Wf+ozO1unieMgXT1M9zhNuCQp/Ayo08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X4B6jtKKYd6S86vG7PXu+oOSnxuAbSb52ZuNccYHumeR9+MDZQ/nc7+HkDGcwobh/Lm/GRnwkqxmZM+CztsUa0LijN3cvOE2fBx8JVPOoIIQh3bLLmBSwU6OIDnjytO/6rRa89srdI5IYeabjjZfRaF/VDqydxS4oZWNZedbit4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pqa82mVA5EW8RiNLNmWItT+UKW4E/IyOv7NYBgUUKJiF+wWFUWW1T/UrPF1CdPXcvbsOiM85qN6GIQC00ZOSSAh2TF8hOVCrS0P6Mhqj9Aur05BXNWqLuQV5sAKXmep+L9XuAHejjvL64Cj+TAz0qxTbtJDkT+lR0FbU6fZESMVty04jPJN9dHeQRW045+KOBdK+YZ2j+uJ994PCBhi0v1YPrgnP39Bks+ZCjYF8g1H8g56YlXsAm1zPC+/lxHdCE22l8WQiZSEhagNgwd6EPyHiRp90tH4yZMHTHm4WOSZt9lYyL8Duwn0AScPY52+ySB0RBZRW1Ke53C6g/Efs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Pa/tmdmJGV/LLXbXVagxlYcY+0hdhxVRqgHmUPCbPIg=;
 b=jttoAF/b3jLgMWPGSLtsco6vdUs6JFoeam+I9dfOBOvu4nLh8q7mhis2ox8WaGzIDHXtxyjlx8Epe/SH8WHx7f9Z5LVfY/5GI99xlKkj2HyI29AMhy9EvykHucKwuCJP39E18cedzxKSXKIhwEGkfJ0XviKmE6JJ6pvJ/T1PqyWyuSsuE6npKxLTl5UxZvGwq5OXDO5EVqLX4Pemuq7EbHukRdeOOz7SQ+7dXY0V8es+VIbfWPuDfXFgM6CmyKYPSCON1m/ZskUGpyq8K+L6ShkEwPfx2s6bIdUTDDq5dn9Zvy9to1PW5t3QrjFQUjATduohP6+3g8O7I2XWW2+pSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB8002.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 19:38:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 19:38:25 +0000
Date: Tue, 7 Jul 2026 15:38:20 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, neelx@suse.com, 
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co, 
	mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <amnaa4wr7kmx5abcixwbfldexlhbn5spzfritjn3gxmutnvbdm@kqeaw6fu7c4l>
References: <20260706050337.7613-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706050337.7613-1-atomlin@atomlin.com>
X-ClientProxiedBy: IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f2d970-2a98-42e1-d35e-08dedc5f4f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oXgTM6QiT8t0QVpszfXH9GTVmWNQSNepniSs00TKKHbGYiwYJKbs/TukDIrZAn3hvZwzvBfXCNMlS+e9wyBYRUuGDC8uM6RHnCNiXQsQrI75yzqPg9Du7HW79lcZ1d8b4kCOPHbAIH1DmGerUI1/MFCbzlU294roEadg7OxUusGDdmnlLTDngKuPiCK1LX4X0OWkRdrxcOkklr1h2ZmO/g8TX7R2819M8VE5zqvr31dKgzg+7z1mh9WiB4kVy4QhS9jxjLplSI+QQJQyUjTSFBe8gp4B1M5jT8GlyVVn0CTINZMtg4GLqujKSiQtFy20Ne9Q5KAzfYzZ1uac9fy7C7Hy3TtShmDxkRy04iP5tMRrT33XT8peI4mb5uN5iydYm69RBCPY/J0brv89+PYuA6G6DSTCTX+DNaeiT+w4CY68fikgoeMuEPlwBPaXBijkXEf20zTgUFo6uuY3lvvuARvO40gN2pSe6HZI4ELqmipmlKVWzh+d133vBzQwGszbeVYopCfgzNq/RVUY4W73xe6Fnx5Uyt7kdjqGCq+okUA6Hrc6LQZVf7piVt+A659hwbL9fy36eb3c30+EgwFk4sM4jbjetLwUrEnwUiK3gnM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2EvbTJ4eWJWQ1llVTYzTm51eVgyQ1JVT0s1eWZpcjB6L09MbmNKbUFwaWdr?=
 =?utf-8?B?ZzJPY3Ftelgxa3dNcmNTNTRXUVA3c1VHZHVjTUxPdUhaSUlpQmQzVlZyTjl1?=
 =?utf-8?B?Tkc2cENDNUw2d1I5RW5YY3YyN0U3NUFTYlUvK0RiZ085VDJNaGxwTGlqR0Yz?=
 =?utf-8?B?a1dvOGYvejNLeTk3TlByMXI1NnhYbkFacmRsa2oyb0E4NGpvUVQ5bnJrU3pH?=
 =?utf-8?B?bzduN2xlMnczQ0VYcHdPdDBZdk9jQ3FOZ20zbVBHZlJWa2FJMDNIU2V2NUx6?=
 =?utf-8?B?ZXFIQlFvam0rY3ZSRXM2WFNEM2lETWxxWVo2OS9TbW12OElCZ1RhZ1ZheWxE?=
 =?utf-8?B?azl2OFNGWXNkR0ZxQlFmVDRlVHJkREl4amRBYkQxZS90NHlyTDlUcFUvdi9w?=
 =?utf-8?B?MXVUZjYxR1RBWnZRK253T3FXT0hDTmIzY1F1eGk5OFMzMy9aN1NmS3hhUUlD?=
 =?utf-8?B?OXY4Sld2MUl3UWFSN1BkVkpsYitMc0lwcStCMUJzam93QjdkcXovZDJOVTNu?=
 =?utf-8?B?ckkyZTBuaTVmdEV4MWZRK09GUDhFYWlVaEhPeDZFQ3lTTnQ3TkcwY1ZUZzNh?=
 =?utf-8?B?Zk5wZkVmckhGWXRIbVRtMmVjUEN2R2NQWFZzMmJ3YndHQnBwckRuNEV3RWkz?=
 =?utf-8?B?ZjFTRk9OaE13Y2lZeGhsOXVWenR1VDhJSFhycUZmdzJycXRTam05Q3J2ZkxQ?=
 =?utf-8?B?M0MvOUR2TnZ0VFRrd0RzSG9pNjN6MjJZd3JaNmtNOERoMTNIcW9hSE5SMjdw?=
 =?utf-8?B?ZGVFRytYQmdadkpxNE56U2FNYjMyYnUydlg0aWZkV1ViUFNRWFdoMFhUQnFh?=
 =?utf-8?B?ZXVLemtlditObjZjNDBVaUZlekxMeHZKYXViTDljM3paa0ZYc0pYNFdPUnA3?=
 =?utf-8?B?MlJpTnAvdFYvT2dEZm82YkhLcE5FQXBmWW1OanJIRUs0WWU2MmtNUHNlcGFx?=
 =?utf-8?B?bFg5OFJzeExHcTF0Yko2cld2WTZyd0dLZmtxSU9HYUx5Uk44NGRNTW40Nkp1?=
 =?utf-8?B?MzIzOE9TaXIybjRCMElOd3pWNUR5bDNrSUVlcW9aTWlkdzJsQVlXVndSSVlo?=
 =?utf-8?B?UWFvbHAwdG1LSkptbVBTRk9PekRwNEd3SWgxSEtBa0NRSXc0dmpBTElrSmZn?=
 =?utf-8?B?eWo0dTVFK0krc0pvSGdaVXRpaENxZWVSSUtxNERTT2h2Y0NSd1pmVlVnbjZl?=
 =?utf-8?B?dHlsMHVNYWx2Ty83KzJhU29iRk9yWTlDalRoTklEU0J3b0xZMFJRclRFVytu?=
 =?utf-8?B?NUN3bjFJREp6NjVPbmpnWUR1Z2ZIcHF1WGdhU3VYSlZCL1czOFlwUGtrZnNR?=
 =?utf-8?B?T2V2OVAwZ1dpbjU0KzZjUlRBTkE0UlBia01LWnhsNWUvYThwWk5QTHBqSmkx?=
 =?utf-8?B?cGkyQUd2SHYybWxWbnlXb28yZStHell0TDNabkNvQ2VQc29MVWtQZHNmVk5T?=
 =?utf-8?B?Zm5vQWxac0xVbFRubEhVM3pjUnkxazk3azk3YVNDTHdBQkR1cDhuUk9kclVu?=
 =?utf-8?B?OHhFQ0kySjlDa1YrZlFldjFSWC8zL2plVDIvWTRkZHJmODBKL2paNnJzektw?=
 =?utf-8?B?YTQ0WWZFTTVwSFI0aVVTQkUyVk1DWFBic2V5VU9jRVVRbGF5aUsrWTQ3d0to?=
 =?utf-8?B?bEFUZ0lHa2lnUEhlYUtCdEFvcHpYNVlETWUzeDdNUGs4a1BqdHFtQ255RTVE?=
 =?utf-8?B?Kzl1NUFGT0RkeGV0NXlvTzNSTzlTU2xuL0JocUVrQUIyQjRyeUdOd3BlTzFH?=
 =?utf-8?B?Y0dxcGozTFJWYSttby9IMGgyUThGWHFRVjhMZ3htZGRUbkZwZy84ZmlyY2dr?=
 =?utf-8?B?U1NVeFFEYlFZRTFVZjNNVlJUM2dTZjl3VHVsTkRRYmJtaFJOMlQ2cXZaUHRR?=
 =?utf-8?B?SzRacDNIUng5WUk2SU5FRzhQRTk0ZHY0TWg0cFR6OTl5SGZSdmRpTmp4WGMr?=
 =?utf-8?B?QnNXdEtPSGhJdDk5THRJNmh3UmhabURNOHd6U0Y2bUYvc0VnYlBXcWJuZFVU?=
 =?utf-8?B?QTdXSkRzMEhvWU5Neno5eTE1QjlCTnpOLzVERkVWTHpKbmxLRkIrYnJhRjBn?=
 =?utf-8?B?MENjOTZpb3VKTUkyQ2xlcUN5TExTZHYwUHArNk5iZXJQbTAxUXowdlJIa2FP?=
 =?utf-8?B?N2FEZmJZMGJhbDNJdTV3YXB5WXliQllEUHhOZkVOUS8wcTQzSW53RmVlc3Fj?=
 =?utf-8?B?a2dyZmVPK3hFbkIrbm9ZTVNKUlkxbDNIVmY2azdsWEFBVGg0TU0vZS8wbVo2?=
 =?utf-8?B?OGNhQUU1VkZIZHN4RVo1SnAzNldEdjhXMkQ2cXBTL3FmMnFidmRJQ29EN25o?=
 =?utf-8?B?WEY1ZThMZWNiWk5Md3JHaXgrNHFDeGJOc2JJdFgxYnl5TjNFL3Nsdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f2d970-2a98-42e1-d35e-08dedc5f4f85
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:38:24.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjLJBmJi3tLDR2RuLk2uLpC1dn6qxtDSDj5LbzZ0Y34shs3C4H8R9ldgPLHhKYemaaZZLEy3wr6OGuxR2Ze58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB8002

On Mon, Jul 06, 2026 at 01:03:37AM -0400, Aaron Tomlin wrote:
> Currently, the "module_blacklist=" command-line parameter only applies to
> loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch extends the blacklisting functionality to built-in
> modules by intercepting their initialization routines during early boot.
> 
> To achieve this, we introduce a new ".initcall.modnames" memory section.
> For each built-in module, we use a standard C structure (i.e., struct
> initcall_modname) to map its initcall function pointer to its associated
> KBUILD_MODNAME string.
> 
> During boot, do_one_initcall() cross-references the initcall function
> pointer against this table. If a match is found and the module is
> present in the blacklist, the initcall is skipped.

Hi Arnd, Luis, Petr, Daniel, Sami,

Please ignore. I will send a v4.

Sashiko [1] correctly reported further issues (e.g., CONFIG_MODULES=n)
which have been addressed as follows:

 - Decoupled the module_blacklist parameter parsing and the
   module_is_blacklisted() function from CONFIG_MODULES, moving the
   logic to init/main.c. This ensures the blacklist works for built-in
   modules even on monolithic kernels built without loadable module
   support (CONFIG_MODULES=n)

 - Removed the conditional stub implementation of
   module_is_blacklisted() in module.h and replaced it with a single,
   unconditional declaration outside of the #ifdef CONFIG_MODULES block.
   This prevents compiler warnings about missing prototypes and ensures
   visibility under a monolithic configuration

 - Replaced the initmem_freed state variable and its synchronisation
   logic in kernel_init() with race-free spatial boundary checks using
   is_kernel_text() and is_kernel_inittext() in initcall_get_modname() .

 - Aligned the .initcall_modnames table with relocations by assigning
   .initcall_fn using the __initcall_stub() helper in
   ___define_initcall(). This ensures the lookup matches the actual stub
   pointer passed to do_one_initcall() when
   CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is enabled

 - Updated initcall_get_modname() in main.c to resolve the function
   pointer fn using dereference_function_descriptor(fn) prior to
   checking the .text and .init.text boundaries

[1]: https://sashiko.dev/#/patchset/20260706050337.7613-1-atomlin%40atomlin.com
-- 
Aaron Tomlin
