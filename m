Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D31CEAC2;
	Mon,  6 Jul 2026 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313224; cv=fail; b=rv8j6a9g8Q1xm+tAVPY/Te1O+H1mSRPSlLfxkgrWpmyrJd51TanGCj2G5BVabLXo9HCrCUHQ/ou4OCVtfTPQfOW1HouV0gbH6tMj0arOsJYgBeViU4yeVpCZ7nN3kHCmp4vZtIlRnsk6MHkWwOnXUIw2lHHCK7U4IB/f6Enup/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313224; c=relaxed/simple;
	bh=fVktW0V19VNtHzxB5ZWAGQPmOoGCD97axHVgMQb8NTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SmZnsG+d5y9yg4g699ieXI0VCX31S2yg0smhB1sbFYqAiMz64t/Ig5UOCqSo5eAV2kCJ/MhCyGj5jXg8g/SWBTfz3iFBsuYm4iLnzfoAYiLgJ9R/4G/xbaa7lXnjYtWinTtFysnFDn8CE2zQ7prnmrkhnOlT5adY1lEHcvpByVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9bDWzBz3lE4s+eAGDmomeARc7bdnbwVqOdStdMvnZpfH+qQ4Z2ciNXqYmwtnwkxtvsxkREqQlImHzlPK6ExziVSO7N2wwFQQVOhEwoXkf3BNOFGduBzR4PEu2pheLzPyid9ZGaKO/wIgQpfUU0mR3vJXaPZ0Zt2Z8Aan+57OSdub+UVyyTPcEv8KulAE/u44iiUa1HR9+UxKxOpAtJ0QDmz8VSrP/fRDXdbgjep2n6oGiig2TsvlbtlhS9W49YwU9y1YO8NScIqLFxtvaxCU4fFlNvpTYdmSBrb4HAB5p7jb+ABDJLJD+bG2WKM4Xi8Pwn+nY592TtAelswFIjmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AagUMz55erLHK5pUQ12n4sv0pfQUJTnsUWfQxqP0uEc=;
 b=Mnx4qVLsxg6skw+cH7eoSa77Qw/u3OwxrqQ99+9gisEk3hNv8yKC+MbInHIbvpcoeffbQb5T2wSUrBF+T2dLqLUzY/zgvRGRpRLr3H4gdUFSIJpEh+yzc9JXwBJ8CevzMv0WZ2XnLUxWMMF3QRSjJqwhElr6Nmf49pXsbhewEIo7Km0A7X/KgXf2wJUlUGonzSBsKEhvFYwLNudhJRbucn5PmJiwpKbS6uBbQBlFbBAtAxCQ9YUqt2bzNQgN8oNVoelSMy0xKQVDq9qZvtkAtDgb+MsTZ0crJJEi0N0cjRXyNhJHdMdvrq0sMYJqoUZIrzNlQ5DNjZD/oXzogJzTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWYP123MB9058.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:288::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 04:46:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 04:46:58 +0000
Date: Mon, 6 Jul 2026 00:46:54 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org
Cc: mhiramat@kernel.org, neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, 
	chjohnst@mail.com, steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <aaomvpg7n3guyisvwbcjbfyn6ck6xsue2uqpnrfoofviq2we2j@6lkr7r6zhutm>
References: <20260622140259.2974-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622140259.2974-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWYP123MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: d6538463-abbf-4bdc-46ed-08dedb199cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NRyepOOUXx/U8zg2ykd/GDtllC2ucNhB0DEvoJA76yVxGrBmZQAnimbh6hZWUJjF/OvzAa1jTHfmfXQJl3V1qMEUPdlbP0Mro0v08z3OesXqMeuscPX2yUZUQUZRIiHqRcT/sS2fg+VunnHFpbD/mf5TqufFizzHWo/YWAIa4hY/Cl8wrQclRZGdHihpiNEKl9HoUA7tWonLSDIbNPrMsZyEVRy0nP+GAMy3YRYt474s21736B+h+OAX0Pax26mL3vloQP6NiavxLWU2xyDpGTalYHs96X+MUVKOc5RVskOHN/Nh0pz2XTU9w1ex1jcsmOMp9iPOj5iDq/eT5EwlfS62ZwEA9ERBTvJxy/ky8P/EGmXZoCg1u7jtMPwx8ifIWe15Py5AvqJCHIZGMrdtSZpWuGjIn9svYO0DRaKYNtfRyhnqlJ7Rq5Da7viz/mLyHELlt87HdAsxb5D31f4Pd+P4g2s4GfsHy6WdHmqG6ffoY8LhlVTkDV93r8MHeCLWFsPXdQtbOE9UiEPE8YoIi/XnzbDTIMNiQYzr12cnn6B5o9k/OeZUvW/4ZffORnZZWHuXH7XeVsSgzoy+rtnJphqAsm+ruXiUQeOINrrT0os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUV1UmNicjFwK3VIOUpQenNqUHBLSDlYUjYvWnNKd1dZTmlxMlpSNXpzZjJq?=
 =?utf-8?B?bFMyVUlLWW5TZFJyaEdrZkdndkRYZ0FsVkxxQndOcXAxMERZdWoyQVNRQVNY?=
 =?utf-8?B?WS9SWHYxSGZYU1VjbTczR1RDVG5LNjUxNlZldk5uY2VGN3VSL2h2NTNKUVgw?=
 =?utf-8?B?M0ppbEpiL0J3c2J2R2lyL0tBR0wvYXA4aEdBUHBRSlN6Z3JnTEd3TFE1Nlhr?=
 =?utf-8?B?MTdlWmVmV1EzTS9aVStsSU45SEpvUytjZnBvNmgwQTVxclBHbkVqRGQ4bVlv?=
 =?utf-8?B?VkhtdDNqYllqNUhqUDYyZUNob0tFMTNKN2E3K3hSYmVkNDArb0J1dXBmano5?=
 =?utf-8?B?TFMxNDZHaHIwNDRaZi9idjM2TVB0YnpjRExDUXg4d2gxbkRwYVQvU2Jwei9z?=
 =?utf-8?B?R2llTjN1U3pSUkQwbjBaU3RzWFd2WGFjTnAyUXpFM0hDbTVjSU5yVkIraDZN?=
 =?utf-8?B?eTMwVUozRHNsTVNwKzdxcUo4bkpVL1lWOXRRVjR3bE5vQkgzRnY2Y3cyMStF?=
 =?utf-8?B?eEluWHNhdTZKM2ZJWCtROWhvdmVEeTRIRWRtUWN0Y3Bqd0laU1ZCWjY3eXpU?=
 =?utf-8?B?NDgrdzZ5VmtCVHR2blZuZmVhY2JKaENQY3l5eGlRcXdmRkJlL0hHNDU0dEtv?=
 =?utf-8?B?S1ZyTmhKWis1SzA5eUNoU1lRYndxaTA0QUc2bnJob1Q3Z3AyV3pUbU80OWla?=
 =?utf-8?B?bE5ocG5MWDVzSmRMYXgvLzFNRXN0Y2k0SCtkelNPU3dxSGpSbHJKM3BORVpY?=
 =?utf-8?B?T2VyVWJIOEthVWtGRnIwWExSZllpTkRGWWNCcndRMldZeS96Szk5OVorRnd5?=
 =?utf-8?B?WXJhcCtFR3RDaDlXRFlqbnNyc3VRZFZ5TWgweWNhNk41b2xRb3RGdVBVcUQ3?=
 =?utf-8?B?Vm9ZV2lCSmlNOW5HOVR6eFVlbjdnZzNoZWxWOG4xWmtLNm1VZUVXSHlFMHJ4?=
 =?utf-8?B?NlRITHptT3A0SlY2aHRKRm1YS1pGeEFnUzN3dVBWalFlUWNpWEFidVpqYSsv?=
 =?utf-8?B?OFZlSUZRZWR1NnE1dUdxNnIra29nSWNqMnAzUHpCNThMNU1yV3hhMUhKeG5i?=
 =?utf-8?B?ajQ2RTYrWWdvWkkvSTh0TGdQVnRwK2oxMDlRQWozSWIydHZlNWRuRDI2MFQw?=
 =?utf-8?B?SU5CNW4vU1kxUVFGVWJhc3Z3akxmN2sxRWxtMTBYZmNQbVJOYytjNTZrSnFU?=
 =?utf-8?B?V2FCRURrODB0eXN3SkZyMDNHUVYrRWN6UkoxNFJHSUgzd0xSMGZGUGhqcHJE?=
 =?utf-8?B?RWk4ZTZmVmNhakl3aFREOFRwK3loMEtOSzlnY1pYS29BdDlydTVTcGNycHpt?=
 =?utf-8?B?ZXI1SGNqcXlkMHlKaVo2b3pmS1VkSkRBZFJUVVNjeFlOaFhod1ZZSmhrd1R5?=
 =?utf-8?B?dzNuT3ZuRVZvNjJ0dEtrdVRuaEJzWFo3ME9lOE5Rc3QxZGNNU1NNblZvSmxX?=
 =?utf-8?B?eHU5UlRiR1BCWG01cnI5S1dOWW9VbmF4YmtVR1R1enErbElTMXVKYitkS0h1?=
 =?utf-8?B?c2hUUlBhVXhIM3BwY0VQSjhxSXJEemhOVS9IclFPV05Fb1o3akI3SUxDMGFr?=
 =?utf-8?B?eDFHdXp5K1oxMnNWNW83QS8vWDdGWHEwbXRManFvWkREd0VVa3pvOHFhcnQy?=
 =?utf-8?B?b3cvUEhJWmdCS2lCMXlPTWFodGhBZ2FtRGpXUm8vSnNNaXl4TjZYK3M4WGEz?=
 =?utf-8?B?NWlZWURmUmNtb2N3N2YzaVc0VkRJMXlIME9wbTdNY20zNGVWbEhxUW4xemhW?=
 =?utf-8?B?SFh2SWlJSThkVUFNS2Y4Z1FDb0g5YnVnTzZRVFNROXllaTVHK1ZzcWVrVnI4?=
 =?utf-8?B?bzMvL1lRSXpXZThCOW4wM1BMOVZ6SVJxbE9JTVhOb1dZcVdOVmNKbkpZVUlk?=
 =?utf-8?B?V25HMFNwSEg2RzdoTUZkSVRnVlBnejd3dDJSNTRGTHpUbGUyTnZibzY3Y1RM?=
 =?utf-8?B?d3FFTEMzbE4xUjlKUlFuN3dRV3I5NkFLb3U1dGZGRzRlaUFyZ0xkb1R5aHFu?=
 =?utf-8?B?QWZhSW50c3NtZS9XazcxWE9rdmtsdGVVMmZEamVyS2tQZmtiVDJxeTQydTlS?=
 =?utf-8?B?NjNBdjJlaTBBUlI1d1B4NmhxV2t6WGJ2UEtwZEJFakZuTEpRWlZLQjRBQ0ox?=
 =?utf-8?B?RjhVMlNMMW1McW1oQ1pQd1kyWlZaQWZIWW53RXhzbU1wY2FRbVMxbkp6emx6?=
 =?utf-8?B?eFhncHhIZzcyRkJvSndKWDBheUs2VmN3UVM0cTZUQmhsZ0c1cTJaUDFITkhr?=
 =?utf-8?B?UWVjbHpUM05aMnJXZ2hsZkdXdzB5dGY4YjVIajFDUnk5Yk9VenFlRmxWb1ZU?=
 =?utf-8?B?RUc2dHdJRUVXM1BlS2IwRUN4N1k1dDQvZTNKTTlTSTVHbFdMNXgrZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6538463-abbf-4bdc-46ed-08dedb199cd4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 04:46:58.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pkIEzCoA2Jr91xf3jUT4DbrJqyfWxurfkkzggk4HX8JR2yw3/IMc+gq4z4qBdcNSvgyTL0o+aBBBADmosIElQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP123MB9058

On Mon, Jun 22, 2026 at 10:02:59AM -0400, Aaron Tomlin wrote:
> Currently, the module_blacklist= parameter only prevents
> the dynamic loading of external modules. It possesses no mechanism to
> intercept or prevent the initialisation of built-in modules, as their
> associated initcalls are invoked unconditionally during system boot.
> 
> This patch extends the blacklisting behaviour to encompass built-in
> modules. It introduces a dedicated ".initcall.modnames" section into
> the linker script, systematically mapping each initcall to its
> originating module name. During the boot sequence, do_one_initcall()
> interrogates this mapping; should the executing initcall belong to a
> blacklisted module, its execution is explicitly bypassed.

Hi Arnd, Luis, Petr, Daniel, Sami,

Sashiko [1] correctly reported issues with this version. Consequently,
in the next iteration, I will implement the following changes:

    1.  Abandon the raw assembly approach in favour of using standard C
        structures (i.e., struct initcall_modname). While this sacrifices
        the PREL32 relative offset optimisation for this specific table, it
        guarantees architectural safety and ensures native compiler support
        for both LTO and CFI.

    2.  Wrap the module_is_blacklisted declaration in the necessary #ifdef
        CONFIG_MODULES guards to prevent undefined reference errors when
        loadable module support is disabled.

    3.  Iterating over .initcall.modnames within the shared
        do_one_initcall() path introduces a severe UAF vulnerability when
        loadable modules are initialised post-boot. To rectify this, I will
        introduce a strict, read-only flag (initmem_freed) to explicitly
        bypass the built-in lookup once free_initmem() has reclaimed the
        .init sections. Furthermore, to maintain a clean separation of
        concerns, the blacklist check for loadable modules will be migrated
        directly into the module loader path (do_init_module()).

[1]: https://sashiko.dev/#/patchset/20260622140259.2974-1-atomlin%40atomlin.com


Kind regards,
-- 
Aaron Tomlin
