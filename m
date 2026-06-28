Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021138.outbound.protection.outlook.com [52.101.95.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563322097;
	Sun, 28 Jun 2026 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687547; cv=fail; b=A4uyh1mRkhY3Lq5qpmDW7ZwfbSGqzx3r1AgEcUECwFOyJxeUU0coQJM4YYfzH/UsqjeB0ppInNMf/DrbLYSD/5shh8M/TxCFhw+KqiCYxXt9NWTq7Cki95f9rYwt/u3gjXrI3avHcRDcJ+q76Hf8mo8nfiH850UWzlQYX+G4lMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687547; c=relaxed/simple;
	bh=izQDibUisFGmOtpBi1by/lg65PLXV9EypW3U7ECffGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q1WzO7uNRHtwLNv+Tl55KIoL632eCiI6YV8eQNYaHRXUYF15nnI6IkezOjObqzh6hotQ75u3aJAznhB7Jc+cft7rzfdTU4Is974SfO6on6mP3rJhwJiJPVXvh0MFpXZfOKQiMH4/iKPA6dB+VKrKmr9ZobFMWc9XkVjxngIDoOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7CnRS2Rbm1gPbtdL/+k5vvw/yls8Qik6hRPgASvQJVLn4XpRAjoc1bKDnC6mYLAZuEInarfYQ6/8lk3NXk1o1ix/dQx+5MS/407Hdwm4n6YaKicM7rFXr8+4X9HmPwLBcfUx9vKZbm/tpfUCwr4UuV7TBsgDO4S+Lrt2lo7PqErpj+ZK9uiqupX2unF3FBBptQMeyJMmKyJUcijGt+tQ/WxpdTjhwYNXXYjmj3S0wQOrKdNtbDFDGvILVoLcNw5L2d6/tJx+lrWw5cBDlSIGtzMK9uBMaa55E75j/I/1TBw5L+xxYJQgdmqHjfCWKB/tRIavUIUiZck/EJq6tVAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=oBB5uKU5doixnsv+Z692gPUFkD3HqWWqRGmUfYyQMWY=;
 b=e2yyWQndvyySWRunlbeDtaTFNSI+0U1nsZpFCflwd7Pc5Nv89jKrniO6VFtj+62eYmM6PdlvDfX7nQ6DX2XBRIpvYM8PXxVeliKD2Zce/7LbVHKLsmDBR3Kvk/jdoRQW99tdAJhLjUiC81fOaCjHVVLBnphUGtrHkUfMkjKyx0k7lpU5q70f6yWTGHFk4O2N+yPxZnWiFVPgW4QkCKyPKe5LmjtYbdmXuDDFW6o5+QxknIme8brA3y5tjePa6MC2gLElWLsAWSpipKz5YOO+SQ41/wZdWfSFVtiSEPZkp4bpqdaFONlEHdBMxFZA/PDs4gGFcpXbw5pQw5XV4NGCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6674.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 22:59:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 22:59:01 +0000
Date: Sun, 28 Jun 2026 18:58:57 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, neelx@suse.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist
 status via debugfs
Message-ID: <zd7aavrfhnsllrlmhfmkwznvvmxeg5bqsoqrwwoogjqo4ezshm@iv2t5y5qbman>
References: <20260510061301.41341-1-atomlin@atomlin.com>
 <20260625165011.63b47ca601b6f871797d98ac@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625165011.63b47ca601b6f871797d98ac@linux-foundation.org>
X-ClientProxiedBy: BN0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:408:e8::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f846c5-8eda-44b6-fbae-08ded568d842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|3023799007|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	npYuJc3sDAoqCNmKRxD60LFWQ0vtO9mj+QDDtTJZQFFZ7hHisoAgdZyjfcF4rrSIwI1sWQXUkTU1suFTrUGGjlIg4aFKRU3NZR9T+prL9NMLcqSh4J1DZ6S8jJ3Ge+eg5ENeRt96EtNBaMnjwDIHhl6HAlvWAn/iM/jHmHYo5SIpMBzgOeXzcyU3DespEq9If9mkIt7gBbqeGTa8EatflidqPGRxBSYn4ygImOcD7ExSJL1RS1pxGXUlXBR64FGvp/6ueu8iUe+BjtUoK78a9JeHssPlSQ/n3VeTDAjDAz4J1kIlp/+xLoLyTk1VG4Gt+EKQr6GyjchMyK7cHvkVzTAZrkmSVZYGhOLIg1CnsTsFqmddlHo7YTmauxb2zzOfz2hn8Lc2YHYQj1kWDYj/VA2elgLXrQGRFDmYnxSD5/6xGhCkwZ+49MNY1fcmbZNr3z2LBBT+Ewnaj8IB+GjJkfmIZ3VAaciYNTJ8ASUyDpDzVxoum9gQnsc9tbPuJu+9AiHLAhGnwVi2QwCaL2W+WAZWyz+jUR7hwPSq5kOulnsZjLAEvJ4q7wzr1XqygnaRCHb8ESpe6kpDZVcTYTTFw7qSWxUvx4T1Qvuyp8dobXgWgHElLG0OJb24UkApWcAdFIjrTOSIEqbwgIbA2uHHNIYjTjT2JFtekWpdZiYtYL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(3023799007)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cSt5b0QzYm5NUDZjcEZzOVF1NVU2R1ZVNHFhdXV3Yk5FaXRocXY1UERKNkt0?=
 =?utf-8?B?ZXk4eHh2Nmk1em55SXJWSTdURGxxeWE4Snlxd3krT01udjh1OTk4ZzNsT0Z5?=
 =?utf-8?B?NElsdzBrSklhMzk4RWRKYnJnTkoyanAyNituSURrazhvTmRlM3RETnJBNFRM?=
 =?utf-8?B?RXY0aFJ5NW1wQW1GcytGemg0WmVsbytPaDU1Q3hBd1lnNEU1RHZhL3pJRkUw?=
 =?utf-8?B?b294eTNIZ1dUWVFjMVdQTC9UbjEvV2kyM0ZnaXEvOFVtakxNblYweDVJYWJ0?=
 =?utf-8?B?ODFLY1hha0RkTEJWemxsWFF3Qno1ZDlHYlZmc0pmdVh3V3hWU3dHR1U0bjc5?=
 =?utf-8?B?MGJtbE1jSGpPRnU1eUt3d01jTWh5RWlpWElYNVZnQUkyc0JLYTJldUd3MjN0?=
 =?utf-8?B?eDl5VUhUNFQyUklEbUdaS1dzQVNvMEt2R25jVVpzN0VPSmJ0b25QZkwwZlU2?=
 =?utf-8?B?UUFpbVh4L2lFbkJvclZlQU15TkYyZ1dlalVSeUFUN1BzMkhaNDIxUWR1Ynhs?=
 =?utf-8?B?R1pBVVc3Vk9LZ24rR3BPRmxoWWpNTm9kOUpXQitlNWFqNE5hakwrcitCc1pD?=
 =?utf-8?B?R3F1ZlNpU2lBUFprYlAxcTRtN2tpZVNTUXZGSERiMFUyTTVZbm1wVUVjWGc4?=
 =?utf-8?B?dElSU2d0aEZHTzlOYzRGQTMyNS92Y2VKNjN5c2dWL0Zzam0rODhkR3lMQlVR?=
 =?utf-8?B?Nm4xOEY2OFB5UkNXTU5xZVhjclRWWGdPVEJlb29VZmhqMm9GZXVJWEprTys4?=
 =?utf-8?B?YWZ5MlVoTE13aWNRUnpnOVdlMHNUSHB6czZIbjdudUlveURZbU1qbFROU3J1?=
 =?utf-8?B?a0x0andBL0RadWhRc01zTFhMRnpsODRmQjRDVTVPY3pzd1ljMDQwc0JDSzZj?=
 =?utf-8?B?Vmg0bjdySkVpUFdETGY3cGRubWxoQzcvWHFoazB2TUFGWTZmWWRwUUVGeTcr?=
 =?utf-8?B?T0NTSjdSbi9pWklDOFQzOWVxQ0NDbkFUTjdSNmhDMmVsaTRzd1F0TVVhazZ6?=
 =?utf-8?B?Kys5Q0dXWTdMNlhwVHRqSkIzMzY3K3V0b2pQQU11ZlZhTjBScUJ2TkdDOFhZ?=
 =?utf-8?B?WE01eWVETFNRaFgyQng0QjU0MFh0ZnJxOUt1QlNEdTAwRnU0MHI0RUpCT08v?=
 =?utf-8?B?U2J3N1d0K1lOZ21LMTFKK3d0cEZ1bEl3OFRmcWJpWjh6TGU4Qy9aTWR6bE56?=
 =?utf-8?B?SGxRQXE4cWhRRlRWcU90VDAxOFVKdnpXdGRNMUlieUJaSzR6ZTNYTTY3UU4x?=
 =?utf-8?B?OUFuZkNZZ2Yvd1U2VFlOMVBYTnc5c3BjZEdNaDNVU1BOUit6WnZwVDgxUVlK?=
 =?utf-8?B?cEhrNkkvN2g0VnR6QVRPdVpOUnNSSmxMTUlISHVYSjBiNlVvaThpcE0vM0ps?=
 =?utf-8?B?cktVTHRPVjNpQTk0SFd5WFRRNmRQRXN3cDhidzBwN1N2QXNUaFhwd21GTkxy?=
 =?utf-8?B?M0xJOGJuL0cxaGgzZzJFVUFrNmdrSFhud3I3eWZBRldnTkZ2cnkwVXhoVWpY?=
 =?utf-8?B?RW5mcVhiVE1iWVFTQU5jNzZ4WFAvRmMvdlJmNDZhOC8xUnpCbjQ1ZTIySHpl?=
 =?utf-8?B?SWdxYVNWbDNYbTJ2YXlVTkdHUEFVK1E0NzRMUThRdHMwN3g1emxEb2FQYldR?=
 =?utf-8?B?ZlZoMUU2dFdXZGs0eURUNzhDSzRZak5ocGtZNkNMNTBMZ28rZDE0TFp5QzMv?=
 =?utf-8?B?Ly95Q0lnRlQrbjFDNkMxQVh0ZFpJbEZRTFowNEgvc0hGRnNpcEpLcUxsNEhY?=
 =?utf-8?B?M3V2WEVybnl6aUNkZGZWNHRJc2lTTzJtWkpQOUdjVTBML0xhNUpObW9RWTM0?=
 =?utf-8?B?ZStXYXNkWnFxemhUY3NyZFVaS3B6VUcxbmxsQzZEWmRGTEhrU2R6VU9iaXk1?=
 =?utf-8?B?ZmlubnB4NG5IM1VsUmQ4d2JPZlB3V0VpRGNpRllTUnpncjFrY2xQbHlHcWlX?=
 =?utf-8?B?aVdzQ2JDRnpnVW5tM08yaSsrNmN0NWthUjNBYlNlU3hHNiswbm9ZOWRaTHhh?=
 =?utf-8?B?Wm1kRk5iMFVWT3FDTXRyVUlKS01PQ2c1RXl0MHZSWkVFczFLVDBIbVJTR2lF?=
 =?utf-8?B?V3JJc1IxRkJIRTFaMGx3Q0tRU2JERlF3a0dlSmpWNDB3Mmd5TlJOT2JkbDhm?=
 =?utf-8?B?UDRqWmdMRDR0RXlyeVh5cGhTRUMvYjhtOGJFUFBTS3ZZQ2RoSDdHVTZRSnVR?=
 =?utf-8?B?c1pWK20vRHlzbDY4bUZXMVVrcFViUTlvaDJxWlJPUzlQek5QWUE5MEg0dUU3?=
 =?utf-8?B?MWdvVFNRVmZlNzBWMUo0RzdFVGhEdng5dE9NRDFVck9RNGY0TlEzSkp3Nnkr?=
 =?utf-8?B?eTlqZHFyVVhnNU8rd21OR3VrNVN0K3F5Ukw0ckVyc3lRYXRwQkg3UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f846c5-8eda-44b6-fbae-08ded568d842
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 22:59:01.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqsKpHoPDx5n9xCLHTur+BLylMJyX78/BsHw8Kilx5ZdTA6ETDWwwCPTvKo2S7PVqrgRQqgDexr2obF5STv7uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6674

On Thu, Jun 25, 2026 at 04:50:11PM -0700, Andrew Morton wrote:
> On Sun, 10 May 2026 02:13:01 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:
> 
> > At present, identifying the correct function name to supply to the
> > "initcall_blacklist=" kernel command-line parameter requires manual
> > inspection of the source code or kernel symbol tables. Furthermore,
> > administrators lack a reliable runtime mechanism to verify whether a
> > specified built-in module has been successfully blacklisted.
> 
> I expect nobody has felt a need for this in their day-to-day work, so
> the interest is low.
> 
> A detailed description of the use-cases would be of benefit - help
> people better understand the value of this to our users.  I suggest you
> add this info and send a v2, if motivated.

Hi Andrew,

Thank you for taking the time to review the patch. I appreciate the
pragmatic feedback.

> > To resolve this, introduce a new debugfs interface at
> > /sys/kernel/debug/modules/builtin_initcalls. This file enumerates all
> > built-in modules alongside their corresponding initialisation callbacks
> > (e.g., those specified by module_init()) in a simple format:
> > "module_name init_callback".
> 
> Isn't this information all available at build time?
> 
> Can we extract it and put it in some file somewhere which becomes part
> of the distributed kernel package?

It is indeed possible to extract this. We currently generate
modules.builtin, but it only lists module paths, not the corresponding
initcall function names. While a userspace application could theoretically
parse System.map to find these relationships, this approach assumes the
presence of Linux kernel packages on the target server. In some
environments, these files are frequently stripped or omitted entirely.

> > If a built-in module has been actively
> > blacklisted, the entry is explicitly appended with a " [blacklisted]"
> > suffix.
> 
> Can this be added to the /proc/modules output in some fashion?  Perhaps
> just add TAINT_BLACKLISTED and we get this info almost for free?

Unfortunately, we cannot append this information to /proc/modules. That
interface iterates over the kernel's modules list, which relies on struct
module metadata. Because built-in modules are statically linked into
vmlinux, they lack this runtime structure entirely and are invisible to
/proc/modules.

Petr Pavlu offered excellent advice — extend module_blacklist to also
cover built-in modules [1] — I do like this idea.


[1]: https://lore.kernel.org/lkml/79ace94f-31d3-4a5e-9a47-3fad69304fe5@suse.com/

Kind regards,
-- 
Aaron Tomlin
