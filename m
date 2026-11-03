Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793742157;
	b=oRrjWY2HedDaFf/8BSBqdj/0IPLybsLjNDm/341RXCtAYygVol6FT4pgvAijOL7Y7cI9
	 /KNDzO8hdyNtHiOwLQEQ5MCUUx8CAG4LxSSZnF/eBYEXyFYMNnDhA+HeUW/a2mihr+zDy
	 HlT3mk4W8uFLsby/A13P97Yer/tL8m9LA9IENHFcXre8du85pL9NW7Hf5SzUfFsg6u4wY
	 icY4UElO4rlCRNvAi0S1WYAFemmAr+kYSI6UYrQmoFZHiL8YJBQOq4bqiHGsOZqd3jiKc
	 7KLa8LD9b1C24GG43Hz/SIajWxNAHnEMg9NpD7aqKVPvMYTlUs/NmGPAF1uC/yUzUwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742157;
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
	bh=RHF82mENK8Sm5WiTvqi28GKk5i9P/yRU1iP4yc4ZUbw=;
	b=LdF23vl9LjotZO62znPcCPvNbP/tGjQf1sa6vOVMWNd/w/PmJBalHWAooxMeQkPjqUKF
	 dXBn8skIVjwWVK6CgOFdOJsqIqSwA2kn7e7xYpWODXjkOh/5TUC59wKB58P/jGvanYAX7
	 RRdjd/v8A7lvTHSZw4OXBYy2cIm+KmizhbGuuN/S9/lbMbTLxUTuLCmcG8ygORvBGTow1
	 wzyOkW5tiOFB6G68ngOh5B1XCU8TQjkFg85AOYgJb3kBNPRPtMnjgXCPEzaDR98NIstw6
	 TSw+se0uK1FZuU9iHk0KmamBVXcD51CeKH3AU0IBgVYj7AdKHTe2HZLWAA393kVQuWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.120
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501D606A334;
	Tue,  3 Nov 2026 21:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A501D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aItcYKYpnbsi0otD6ct1PQQkLswNVgJKwHtFGHgYsrHuqu3Z7BOREgBfgCHjo488slVLmsmI5i7iFzuJ8pC2K7LHN87n5CG44gjwgago7rEPCy9KA1JyA10SSgWNr9C+/VkNmShSFI+ya316IR5KtOqq4H88cN/HjKMI+o1pYCRg3yPvbt/BSTCqC144rhTg8hCVGO86s71yYihX8SsW0Wi/kOqm4drWPMsaD5jNkLB6BgMkYWELq4tQuHwORCuYoYNSHQppXQLz9WWh/p7iu+hYi08wFok3cER5gsIcymmsow8WPMeXL/Hyyt4wfc82zLN7F5VYPnRjQdEYhJqjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RHF82mENK8Sm5WiTvqi28GKk5i9P/yRU1iP4yc4ZUbw=;
 b=miZ8njvMcAxJLKNqQMyTGxCTp5DJv4JMl/lKzmfvP5a8ql1fZbcAGeYwt8ap4fky3nGzBZjCE1gCsso5qz4CcP53WWCF6JKs0g+3PTd2SHNd/7XIFOSpZcFvqUza+A7xc8Wvk/Z4gNXeuD43imTasKsVYN1zKzqZcLEWZdtTMfJKMLqSnlTMq8rKdr+oecueZnz1WdqQsmwJGNrUsBRvZr4ZqabC25Ev7BvPyAr/4OVF7hE4gzpO06GGakdc0JlmAoAiSlIJrfvTKuv4Q6LRtS4P7+hkC77W4xdxFYk35ALBPJKVUDKqoBRN1Zch3StyVKs1XfxeOexbayIPxR6M5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO7P123MB015864.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:604::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:42:34 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:42:34 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
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
Subject: [PATCH v12 2/3] module: Extend module_blacklist parameter to built-in modules
Date: Tue,  3 Nov 2026 16:42:22 -0500
Message-ID: <20261103214223.32598-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103214223.32598-1-atomlin@atomlin.com>
References: <20261103214223.32598-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO7P123MB015864:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a774f5a-9678-4585-da98-08df39f35f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|5023799004|261022113327099003|56012099006|261009221227099003|261021123027099003|261009223027099003|261021130227099003|261022105027099003|261102123227099003|261021121427099003|261022115727099003|261022075727099003|261028144727099003|261102124527099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	whU3DSyRpxBo4oARomQhSLauT9MAvKDMVg81Hi3g09n09IxqiPEP78W/dzkhDYKqAqbRHq+D5Gy0qS/rDkUKGslRWw90iKXj3W7YVcZn3Gcumkb8KNIYeriCnRosYjmGTx9hHTZpbO/QhjJdxTmKufb0dxLLRr8j4F4n6ansTSCuxYp3zZsz9BhyHQwZaGHP9H4aK89Ovk4yxugrbw+A2cc77AMeXkkghIG1x0GGG23sUEjjhgAfm9CClGC3/tFC4q/VkYBu36idBq4av2+kfD9YeSg+A6IgEqGjsdgYVUAFrTMN6QFPxT49Japxhtz0uL601nzxMSEoM5ossFwvbb/XZ/hxXVLB746CeLdhON5mPrlfXSWZGF5FmAh5cIQ2iw/1VoEZlu2wGcRZwzIGxjMBdu+p69o2ma1REGcsZ/9R06Tp/D7ka3yVQ0ypFGtZpTJ18WCno+Pok9MUPtbHcqKfRyUKafMOSSohur15onB50c4am0TBsQQ5arzUpE80htaf+pSCt9G/4LjZWO0Fgjfr48wXWItXKcICG9oQbKzC7aDk2rkH8dlVwUG1rJqU8YyRPN1My+z8vgxxUwDP3mDOTglZQe6JXKyv7siYLP6a9+Z0Ixw+JaQ94DdiZBmN+VK976Zr6Dx2rJEd3pqCYFK/witjaeNSI2HMoOewDjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(5023799004)(261022113327099003)(56012099006)(261009221227099003)(261021123027099003)(261009223027099003)(261021130227099003)(261022105027099003)(261102123227099003)(261021121427099003)(261022115727099003)(261022075727099003)(261028144727099003)(261102124527099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7a8j4J6yWWBnU3NKbof5e2XBazyoNmdqEOinq1mGygiRQwhekiEsRe/DIJw?=
 =?us-ascii?Q?MaRGFb+dvW3zFn6mBmwRVbuIX7gFk2RSxcnO1YR4zjAp/opOd/WxgVICNPgD?=
 =?us-ascii?Q?cdeOFAbbZtgcS99ZZaDy2NdXR1sDKHrPaJHfH5eEIGUitgI98kPr11zLHnDt?=
 =?us-ascii?Q?LiFHnmDYUhOu9SsTgHOlzAV5ULSz5FFa2bHQTCKZzckhz22Y5aAi2L+CeGoU?=
 =?us-ascii?Q?baA70FOVvOGmgBqZ+MT3KJT0DMw4alRsfif4hgArXCchd1MzeoViJqtggTU5?=
 =?us-ascii?Q?baw2kOph3ybKn0sDKVBGNYgLwDng/DzZoewwOQgjarY0BSkMElQmCONo8vNa?=
 =?us-ascii?Q?n2W2AMlmMyZG24dcRyxjtZF1/dopsjxLBWBOisKhdToyQ+qf0VxJebQWCcO2?=
 =?us-ascii?Q?mZnhp32o6hgOXOxS4Nwhpkf0sdYzulik+qO0YeVy/fE2ntUR390D9kKe7tFR?=
 =?us-ascii?Q?gerr0gfAN+zoHFf8CbBASQrSbag4aqyV3+/Uy7VqGV0h0x7lPRBp7bMIfjTf?=
 =?us-ascii?Q?UCI3zhLtr5LCmfTgIoqPYb9XHYp922lqoI0dB143PoqnWKYXMTWdLBuK3aC8?=
 =?us-ascii?Q?uigw/NsLFbdp9BwbDLwEttPFsxcb7ZTP5s+QxNr5kIz0M5GBAZHylb15iWZn?=
 =?us-ascii?Q?3CD+S7dWegyz1ZQZL7KxiM8IJCqDF6j1UrAiVqPb5kl5unDveKIoHE5FZ+ic?=
 =?us-ascii?Q?0mSXuf+pnSk0E0hHcTvxg+cbFviU7h0OIdovnNrRBz3KZy6oabbsfIANBmeH?=
 =?us-ascii?Q?SiUhfDej+5ZkcoiIxzVnzp2zFVJBYFCkU6jGdJU4xw9kIENnAE3tpBiwAaB9?=
 =?us-ascii?Q?1cOAJAioDr2+I/sXbKnNb4td4ei5DNV3SMG2QuWfvwI+RsGaVt15Sql/U9NK?=
 =?us-ascii?Q?qGj/hDn0S4ZZESf2gkCVryhLqXdtEnNJlpuP/U8mzxewEl3TS0SpHwBJoxdE?=
 =?us-ascii?Q?1a3WAgUGDcJWAuGt7sChcuQnvD62JZpWPlVcyoGPyu2imMH6PE7k5hjAH+el?=
 =?us-ascii?Q?cLWP2z6S3DJsONYztNnw71mLi/hrQibNf/3KQfthq7X52Lc4pqwEdfC4DYT9?=
 =?us-ascii?Q?iHTOAJc0BGdJkFhyhlV0CyPgjDQrHMQ4NSRDG4fGTXPprdGgbNDU4Jlj7i+0?=
 =?us-ascii?Q?IVShfah/2ov3XHIe0gxDVN8hzwjLVTSgVDFQbAyVTRanEaEzdRwR3swEgnjl?=
 =?us-ascii?Q?ZeUdXVdWv8SXeRtuiemvKvZbeZ4f3TgVYZAjDDZF413k2Jb7UfhIpdbshxzh?=
 =?us-ascii?Q?tvfgLYiEcihERsns4DmZQwbzEXp9PdJtVH1q8/kF56uPAS1BkmX3/wNvUpDg?=
 =?us-ascii?Q?fEw5YsV7NM4R5DbPnmw8LH5+masDHHDY7XrIuPq4I09dtmYjtCWqYi5OBNPu?=
 =?us-ascii?Q?l6RSNBYovxMDjJYA8AuZ7svI5IKjPIChabSGgR93xeRF/3mdSiFF8liO8UIi?=
 =?us-ascii?Q?gGugJJLWbwncTZxnXmi3nYfRAokMWN9H0gojR1Z9UbPI1EYAGyVXu6HuPPbN?=
 =?us-ascii?Q?geWeihK4gTpHsuAogrYIXRDSQBsdrMeXRE0be3e1DWMvqMGulci47N1lV0gc?=
 =?us-ascii?Q?8J0vF/HXHcj53uKErt+EWKXJWepmesdVtPVpqlLN8whLtAWk2YE3VBNRQcYQ?=
 =?us-ascii?Q?PlybgXi9VLNich3J6mDFiaoLkhcK7jv40LPaV4g4USeIkNRyv426y1Vzrtqu?=
 =?us-ascii?Q?DXl0UiK88xJL8aheCsPSsWrzJoDFDzZSTmr+tHndZb7hXJe2X01thfaVGPrP?=
 =?us-ascii?Q?Lxmjve0MvQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a774f5a-9678-4585-da98-08df39f35f11
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:42:34.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEAa87IyZEHqSFxjYYvwgH+hJpbWbO3k2LUfQxFmLOvAt3u4dWHWTCH9cJgiltYGeFz9aoNLUJBexs4TNfMboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB015864

Currently, the "module_blacklist=" command-line parameter only applies
to loadable modules. If a module is built-in, the parameter is silently
ignored. This patch extends the blacklisting functionality to built-in
modules by intercepting their initialisation routines during early boot.

To achieve this, we introduce a new ".initcall.modnames" memory section.
For each built-in module, we use a standard C structure (i.e., struct
initcall_modname) to map its initcall function pointer to its associated
KBUILD_MODNAME string. This mapping is restricted only to files implementing
built-in modules via module_init() to avoid mapping core kernel subsystems
and save memory.

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
 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 25 +++++++++++++-
 include/linux/module.h            |  4 ++-
 init/main.c                       | 54 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 22 +------------
 rust/bindings/bindings_helper.h   |  1 +
 rust/kernel/module.rs             | 18 +++++++++++
 rust/macros/module.rs             | 23 +++++++++++++
 8 files changed, 125 insertions(+), 26 deletions(-)

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
-- 
2.55.0

