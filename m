Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983539;
	b=WkBntvcwp0Rw+M3LatND50yRXDffVxeHYbzmnX7WFQH5aL3J3OxNWxKIQk2yD5R+lm0L
	 n2Zzg1nR5L9ILWFIhxPzfsrPk/Kc5E6U2kS6hBsLvMz2lMINy0k5CnMi5lWG6HiukkAkP
	 lV2gF7bfEw6IbPT9QHuMP5X+cWl7gBAidhMp/ajhHk290T2cmgJkAGThD/vdv61cJIaHh
	 MqaffzRzGL9uMQEfIhbbrgQr+KFfZTSw9LkDeau5TI1HuwzJLXIFXZhohwksaD0Cbrk1R
	 lVosfpL1A5OQJwZx5+ZTli8tnMYKmSqcPwLySn7ztKEsas3gl2hYHRZWURELOI7y/Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983539;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dnfYV+tw4lEIomCrh4siMJclwcG6EGRxw7VMOc0OVwQ=;
	b=FeLTmtpnlUXZzPR1JBLMaZJNBliDsFoeOh30CkaiVjy9+DsH4UHQaEuEbJPwrnxF4+Te
	 aTMeMZDTi3LwgFEkBDr2NZtRQnVRuVsx8NHlCslGHXdNpAu3yYdCwRHJpLHKV/MhGG/hQ
	 0nd6UpwH5FyvR6W1JzaRAW2koMupQ1909UjF4o7bQ+dTlrmGWIg4cySyOkoYQCvYuamHm
	 UWpHZPPazyS5ZEiOS6mWhwD3qCnfoSfE1kAfzzIlgV68aFokaAVa3uT+Gj37zv21L/rbv
	 4cjohWciG42BmUEe8uoV9MDdZEFdUiA06q37l1kqqVzA8M9tQ6BMpJUlksacFrbIi1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.141
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E38606A337;
	Fri,  6 Nov 2026 16:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E38606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs9p+gNgeJyecMaNZBp9wXkxsILiUK8FykdbvuJr51rOOj7O6eW3hEYMkd4anokyOfH9ICCB3WCz/S5bGR4jSYboUDmDwzZuJv7qxNHrKHA1/CxhdVRGA7+XGPd8XTIEh1RVni7tMYV/lvEre1yiXwcHvgCUwVvepyQrhrPrDAkJM118Szp971Z7CSiBx1a/QbcytZdmXBn9f4q5qaKdmdd1CxHpQSn5F+8v1AZJlt+enFwLWNPlgtycd33YIluku3xBxa/y+QrrPu//rerII6sSjCsYHCzOhrkTpeczX4KxxPhN6XsfU4SY3VFfZwpTKW4lT0vV2hJyY9x5gZqj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=dnfYV+tw4lEIomCrh4siMJclwcG6EGRxw7VMOc0OVwQ=;
 b=nnCNJLkcW1ryYwFFm/FGFybR+ChaVzbJutaCN8tB+XIv2/v2njwqp8jqHQLE8XV9ddQqHKdTIEeHCHyYLg4/Puc+OmtoAGQs8IlL9GaDjUdC8ZH0pWyviokDgU6hjV39FIpWX9t/B2Z9zMwe0cFbYwZEuVuJm86hZkctKE6t8kuSmP+kTzcQBjE3ZTGgPEvMDpzmZgoeE9TtrpoYki3zncK4ijpVSfI+XzDEYL4x22txDkdC4o/9l3MdtYy81B1EbcdaZBdP2YtddZb4QaMsCeyI0kQMsUZHcFFGzH8XVj1rInMIGXioqzxS49i09K13mqtFX5znuvra27NAKHQyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB6202.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:45:33 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:45:33 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: jpoimboe@kernel.org,
	arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	mhiramat@kernel.org,
	boqun@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	chjohnst@mail.com,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 2/3] module: Extend module_blacklist parameter to built-in modules
Date: Fri,  6 Nov 2026 11:45:20 -0500
Message-ID: <20261106164521.116168-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106164521.116168-1-atomlin@atomlin.com>
References: <20261106164521.116168-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:208:32a::6) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: a09165c2-b2f2-43d1-cfe0-08df3c256011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|261009221227099003|261102124527099003|261102123227099003|261009223027099003|261021121427099003|261021123027099003|261021130227099003|261022113327099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|5023799004|56012099006|3023799007|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IT4NvQv8+DFHYCb6cVLW+5cH4y7VmbRA4CgM2arei/Fr2887LG9y6hXiLL26W2PX7Zr84AUtaEMKfp4PkLTcLD75H5tyzV/A9Ka3v78Ei+AikL1YojDTpbyFygTpqKKZL/kg9KEk+H/osyfq5SqBhgRS5IfT106hQ9npXO2E1PRht37Ej+0msLK7p6AZTDibHfE1CmRKVLJS1SJO8OL45ULYfyUtmsyCsc1u4w8JxbZspXNfGmLrIwmR7h0nxjvtrjeLTJWMclibkZ2of1KtKNbwkIglf5z1cwC768STPbbwpFO4K7NneiPH7fiNLnNdJqAnUw7Q9uL2Z+/KhFUSdWDWVQR03u9cIPCGziTg/XE9rUkniznlASh2Jtr34fMVZxT/JOpSDBGP2OvYsXSu/r4hxZLJ48KlTDwhCh/uheYGuPA7304uWP29dsuqQj2MovIKeC4Z3uJ47sk53PvqRMelaEL8IKNXPClQ/JMXqfj+aaULCIg34GoJNXlHc6hQB2YkMXb6rfUlsWF24SBe5lyRoGk357LPh0ElMogZGOW7iPkKaAl2mPPzOjTxcszY3a/2Gdlf3wpxOMr2yimzqSTFi1VtSHm2o7HGQoD+YN5ugktnbkc0ZplNN8w3/kgefHnLdiS8MwznehLHGRP5BR7l1TUA7Hbr7FDUhXjrM6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(261009221227099003)(261102124527099003)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(5023799004)(56012099006)(3023799007)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gJYUIPKmY1913R7CvbDz7U2J8p3ugadue96AsEdcEEfa+BBYJP4g8rufbwp?=
 =?us-ascii?Q?lubEWM/RqHjp6eYnIV2zNER4jF3lj0s+kdGJMBkzovLmm0ZvA7+YSwpgPuyp?=
 =?us-ascii?Q?YMobTFRRJhI8TNCyrlcXmqan+IYU/45+0d5mLkBxqp2LlBuBq9kkeBbLPXSl?=
 =?us-ascii?Q?zlB2KrPy0GbH00H9Tsmo2H6BJo4/LLKgWuRWf1CzLhcs1POqmdF0FC6J7d6h?=
 =?us-ascii?Q?jdaJ90dc5syp/L37tsBuLioTRt8y9A4RXhyAzoOZ3R1GEle3vL5pn1VESO/q?=
 =?us-ascii?Q?H+Fe++QYHJUFTOL8UhiQATmev00KEc5lI+JkchW3EAmHtjXYZobOUQ2fMVb4?=
 =?us-ascii?Q?U4L3Ox0mCN1/TwkI0zxlCXjgBBEvknJriMOJwz+aQ7IEc+HrnBI0ljZrFwUd?=
 =?us-ascii?Q?1b9V38PetSmmO4/cFrG6KAu9vtYxvLlhWoRQiRrQ4oWg/xyyUeeXo5ElQvD6?=
 =?us-ascii?Q?XXqzhGiWgFNPJrvo3/jomNNvJaVdqOYsHOCMEKzsWrSl/BjZPQA1UibNrjrE?=
 =?us-ascii?Q?Z+1JuNj0Dx4JZLZzj8IzfE9yRYxBS9GU2OLPe3BmI3VB971TJDh9grK78Txh?=
 =?us-ascii?Q?TW7jKrsBvrWuoJj+/ywWHGR5fzxneiStPgOzzm7BsUcCVop1QYjkOXWwN+Y6?=
 =?us-ascii?Q?lPmVk1+lHdPNCwDBUIgn5dBd7RdwAF3pmh32Cei2iFLmFSlqdtXLEtxf8bwD?=
 =?us-ascii?Q?dQwOjeBSGdiBlAH2jjRi6Hfi54/k68lkZf9geb74KccUOqKVWwTCv1Qh6jYV?=
 =?us-ascii?Q?d6JpVVs472jWU5VXr4Kxf4iX5axTDCW1Q4I28ORBa6Chrs6C9+LuuSr2fMBR?=
 =?us-ascii?Q?8JQI/rwCzJeecC7zktoBMAcaG/eLn5lWJ0fnvFQqpMZ6N8YRpEbaDh84vSyQ?=
 =?us-ascii?Q?cXlJMuUuULIpits5pKPX2hmTBoS4ekm+Z52DVXyrss9qZHgU4MSgL5SfQMLh?=
 =?us-ascii?Q?xXG0aitZMNYpf5b2dj4B3x6oW558wYgFjGJOpOjcl2D1UYcMo6Tky6WVully?=
 =?us-ascii?Q?L/WjMXRYYB+8PV6U96LW5VIpekPweonYv8nern/bsDTWCc0EgpjpjgDziVQU?=
 =?us-ascii?Q?qzxen1hD+djPuxOeqpQyEK1nxIeyo4dVq42ztAIRdGgJ/YVRkPhY7UIj5ydd?=
 =?us-ascii?Q?PD4ZGj8YCFXJpx6ME4jbkhGAkkuwXEmPVByrvVLRk3KyE6rac3ifCNmyRCKv?=
 =?us-ascii?Q?z7zIc1nT8RHeXmQzGpKHMuvhyClGmOyMsAHIVj9I0PMpoHiAkgjpn6OQ2TOD?=
 =?us-ascii?Q?2KNJnwGkoPfZUWGByLtVwvIXMgs3ukeZRN9lYIyT1CGG1gyNds6aWeirt8ts?=
 =?us-ascii?Q?PvoKgj5eKeNvjOVnMuVuRMi/xRDVvMkqxUEXVrNk9d2zVZuGKbj67+NxhS/+?=
 =?us-ascii?Q?vmwZe3ZKcrU0EOdRD+IwjlhYOEu7yuo+ANMRgI1v+G+NjzYC0ACav9xwuF1i?=
 =?us-ascii?Q?LN5O/75HbCrkp8kyY3Y8PqSaU3zXkRDVX5ESyYcyETOCM+j766fZwx08+BMh?=
 =?us-ascii?Q?nl0fVZZRQXICaU8xOoBMBKBAW15RMIXmMCadzzFn8YwQi9TOoI3wdbENYaCQ?=
 =?us-ascii?Q?rA+7MtgosuWo+kr93Zr4llyX9wj5ocS7J2v8tdnNFD8+JjstldHGwTTvkqiM?=
 =?us-ascii?Q?eNFeEaJiS4cFuqfPkBfiPnbgvi194rufyTaO2iJjWqWMoUFnfsYlSB306xLi?=
 =?us-ascii?Q?t5yPyzdlZuPd4jkmH1xpse3ufWUpugYIVZ7sXkFyItR6/pddJYNpjGZK/pAN?=
 =?us-ascii?Q?+t8nifOdIg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09165c2-b2f2-43d1-cfe0-08df3c256011
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:45:33.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFOPjh/9bIAmJ4CGA0h+mzQlRLTo1dC/TNFWWvKXCJhRhrHXkHkk3DeJt/7b9U+aGdOgdHNkuW+AS6rLb0BSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6202

Currently, the "module_blacklist=" command-line parameter only applies
to loadable modules. If a module is built-in, the parameter is silently
ignored. This patch extends the blacklisting functionality to built-in
modules by intercepting their initialisation routines during early boot.

To achieve this, we introduce a new ".initcall.modnames" memory section.
For each built-in module, we use a standard C structure (i.e., struct
initcall_modname) to map its initcall function pointer to its associated
KBUILD_MODNAME string. This mapping is restricted only to files
implementing built-in modules via module_init() to avoid mapping core
kernel subsystems and save memory.

Under CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y and CONFIG_LTO_CLANG=y,
__modname_<fn>.initcall_fn references the __initstub__kmod_* wrapper
symbol, whose name embeds __COUNTER__ and __LINE__. Exclude __modname_
symbols in tools/objtool/klp-diff.c:is_initcall_sym() alongside
__initcall__ and __initstub__ so that __COUNTER__ or __LINE__ shifts in
a patched translation unit do not cause "objtool klp diff" to reject
__modname_<fn> as changed data.

During boot, built-in initcalls are executed sequentially via
do_initcall_level() and do_pre_smp_initcalls(). We introduce a new
wrapper function, do_one_initcall_builtin(), to cross-reference the
initcall function pointer against the ".initcall.modnames" table. If
a match is found and the module is present in the blacklist, the
initcall is skipped.

To make the blacklist functional on monolithic kernels, the command-line
parameter parsing and the module_is_blacklisted() lookup function are
decoupled from the loadable module subsystem and moved to init/main.c.
This enables "module_blacklist=" to intercept built-in modules even on
kernels built with CONFIG_MODULES=n.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +-
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 25 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 54 ++++++++++++++++++-
 kernel/module/main.c                          | 22 +-------
 rust/bindings/bindings_helper.h               |  1 +
 rust/kernel/module.rs                         | 18 +++++++
 rust/macros/module.rs                         | 23 ++++++++
 tools/objtool/klp-diff.c                      |  3 +-
 10 files changed, 130 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..6cdee2dc4193 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4226,8 +4226,9 @@ Kernel parameters
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
-	module_blacklist=  [KNL] Do not load a comma-separated list of
-			modules.  Useful for debugging problem modules.
+	module_blacklist=  [KNL] Do not load or initialize a comma-separated
+			list of loadable or built-in modules.  Useful for
+			debugging problem modules.
 
 	mousedev.tap_time=
 			[MOUSE] Maximum time between finger touching and
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..96559b67293f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -765,7 +765,9 @@
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index 6326c61e2332..08cb8a294375 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -109,6 +109,11 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+struct initcall_modname {
+	initcall_t initcall_fn;
+	const char *modname;
+};
+
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 typedef int initcall_entry_t;
 
@@ -252,6 +257,7 @@ extern struct module __this_module;
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
 #define ____define_initcall(fn, __stub, __name, __sec)		\
 	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
@@ -260,6 +266,7 @@ extern struct module __this_module;
 	    ".previous					\n");	\
 	static_assert(__same_type(initcall_t, &fn));
 #else
+#define __initcall_fn_ptr(fn, __iid, id)	fn
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
@@ -271,7 +278,23 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
+#define ____define_initcall_modname(fn, id, __sec, __iid)		\
+	__unique_initcall(fn, id, __sec, __iid)				\
+	static const char __initstr_##fn[] __used __aligned(1)		\
+		__section(".init.rodata") = KBUILD_MODNAME;		\
+	static const struct initcall_modname __modname_##fn __used	\
+		__section(".initcall.modnames")				\
+		__aligned(__alignof__(struct initcall_modname)) = {	\
+			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
+			.modname = __initstr_##fn			\
+		};
+
+#define __define_initcall_modname(fn, id)				\
+	____define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))
+
+#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
+
+#define ___define_initcall(fn, id, __sec)				\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
diff --git a/include/linux/module.h b/include/linux/module.h
index 76f4f3596477..98196204fe27 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -86,7 +86,7 @@ extern void cleanup_module(void);
  * builtin) or at module insertion time (if a module).  There can only
  * be one per module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(x)	__builtin_module_initcall(x);
 
 /**
  * module_exit() - driver exit entry point
@@ -892,6 +892,8 @@ static inline void add_taint_module(struct module *mod, unsigned flag,
 }
 #endif /* CONFIG_MODULES */
 
+bool module_is_blacklisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index 7b0c8c34e6a9..1302fa71a733 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1406,6 +1406,56 @@ static inline void do_trace_initcall_level(const char *level)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+extern struct initcall_modname __start_initcall_modnames[];
+extern struct initcall_modname __stop_initcall_modnames[];
+
+/* module_blacklist is a comma-separated list of module names */
+static char *module_blacklist;
+bool __init_or_module module_is_blacklisted(const char *module_name)
+{
+	const char *p;
+	size_t len;
+
+	if (!module_blacklist)
+		return false;
+
+	for (p = module_blacklist; *p; p += len) {
+		len = strcspn(p, ",");
+		if (strlen(module_name) == len && parameqn(module_name, p, len))
+			return true;
+		if (p[len] == ',')
+			len++;
+	}
+	return false;
+}
+core_param(module_blacklist, module_blacklist, charp, 0400);
+
+static const char *__init get_builtin_modname(initcall_t fn)
+{
+	struct initcall_modname *p;
+
+	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
+		if (p->initcall_fn == fn)
+			return p->modname;
+	}
+	return NULL;
+}
+
+static void __init do_one_initcall_builtin(initcall_t fn)
+{
+	const char *modname;
+
+	if (module_blacklist) {
+		modname = get_builtin_modname(fn);
+		if (modname && module_is_blacklisted(modname)) {
+			pr_info("Skipping initcall for blacklisted built-in module %s\n",
+				modname);
+			return;
+		}
+	}
+	do_one_initcall(fn);
+}
+
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
@@ -1478,7 +1528,7 @@ static void __init do_initcall_level(int level, char *command_line)
 
 	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -1523,7 +1573,7 @@ static void __init do_pre_smp_initcalls(void)
 
 	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static int run_init_process(const char *init_filename)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6b1604018cc9..1787c8784aa3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2946,26 +2946,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 	return 0;
 }
 
-/* module_blacklist is a comma-separated list of module names */
-static char *module_blacklist;
-static bool blacklisted(const char *module_name)
-{
-	const char *p;
-	size_t len;
-
-	if (!module_blacklist)
-		return false;
-
-	for (p = module_blacklist; *p; p += len) {
-		len = strcspn(p, ",");
-		if (strlen(module_name) == len && parameqn(module_name, p, len))
-			return true;
-		if (p[len] == ',')
-			len++;
-	}
-	return false;
-}
-core_param(module_blacklist, module_blacklist, charp, 0400);
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
@@ -3421,7 +3401,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..d86872912eee 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,7 @@
 #include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
index d71370598447..3f0545c4d7dc 100644
--- a/rust/kernel/module.rs
+++ b/rust/kernel/module.rs
@@ -78,3 +78,21 @@ pub const fn as_ptr(&self) -> *mut crate::bindings::module {
         self.0
     }
 }
+
+/// Newtype to make `bindings::initcall_modname` [`Sync`].
+#[repr(transparent)]
+#[doc(hidden)]
+pub struct InitcallModname(crate::bindings::initcall_modname);
+
+impl InitcallModname {
+    /// Creates a new [`InitcallModname`] wrapper for `.initcall.modnames`.
+    #[doc(hidden)]
+    #[inline]
+    pub const fn new(val: crate::bindings::initcall_modname) -> Self {
+        Self(val)
+    }
+}
+
+// SAFETY: `.initcall.modnames` entries are immutable metadata only read by the
+// C initcall runner during early boot.
+unsafe impl Sync for InitcallModname {}
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 0a7b9e24c960..df1d0eb89c16 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -480,6 +480,8 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     let ident_init = format_ident!("__{ident}_init");
     let ident_exit = format_ident!("__{ident}_exit");
     let ident_initcall = format_ident!("__{ident}_initcall");
+    let ident_modname = format_ident!("__{ident}_modname");
+    let ident_modname_str = format_ident!("__{ident}_modname_str");
     let initcall_section = ".initcall6.init";
 
     let global_asm = format!(
@@ -491,6 +493,9 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     );
 
     let name_cstr = CString::new(name.value()).expect("name contains NUL-terminator");
+    let name_bytes = name_cstr.to_bytes_with_nul();
+    let name_len = name_bytes.len();
+    let name_byte_literal = Literal::byte_string(name_bytes);
 
     Ok(quote! {
         /// The module name.
@@ -591,6 +596,24 @@ pub extern "C" fn cleanup_module() {
                 #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                 ::core::arch::global_asm!(#global_asm);
 
+                #[cfg(not(MODULE))]
+                #[allow(non_upper_case_globals)]
+                #[used(compiler)]
+                #[link_section = ".init.rodata"]
+                static #ident_modname_str: [u8; #name_len] = *#name_byte_literal;
+
+                #[cfg(not(MODULE))]
+                #[allow(non_upper_case_globals)]
+                #[used(compiler)]
+                #[link_section = ".initcall.modnames"]
+                static #ident_modname: ::kernel::module::InitcallModname =
+                    ::kernel::module::InitcallModname::new(
+                        ::kernel::bindings::initcall_modname {
+                            initcall_fn: Some(#ident_init),
+                            modname: #ident_modname_str.as_ptr().cast(),
+                        },
+                    );
+
                 #[cfg(not(MODULE))]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 34da55e45609..bcea6c524d53 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -420,7 +420,8 @@ static bool is_abs_sym(struct symbol *sym)
 static bool is_initcall_sym(struct symbol *sym)
 {
 	return strstarts(sym->name, "__initcall__") ||
-	       strstarts(sym->name, "__initstub__");
+	       strstarts(sym->name, "__initstub__") ||
+	       strstarts(sym->name, "__modname_");
 }
 
 /*
-- 
2.55.0

