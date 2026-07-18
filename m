Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FA2CCB9;
	Sat, 18 Jul 2026 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784351639; cv=fail; b=XFvNhIy4TqZM6YAo28Il9KlegVDVl2mZbPkdKJ/3F9Lh3dj+b7GSDZFc0cyFmo1RyZ88oLiYJkifOAyIi2TyAtPuNwi2xHoUrQtoDuc8bNYg2mneb0UwUJ408jFhpIjJE+ibIl50FsKqIgR2mf442EYHgoS/maZmyfr31FCo+Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784351639; c=relaxed/simple;
	bh=rA8/S7bYY8wAUK7mjkpSvVWfgM+AzrLNM/3SiLXUByg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hn/GGQF4RpMRotXPTcvmLLWs2KNaPGC+n5FWDWxBVPLNoY59o/VhXb5OXCX33ZGG24DpN9yiW9aWlJxitbwf8tGoHDVWFd1c94GebrCscIj5rxMnaC8HuQo7WHO5MNpam5DRIMG1LKyScqtRt1v+CzCIPWk+jaQ9nuAOOgfIWXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMBoQ+znIeCdW++Zb8b5q+n118MZlwvcue0J4TaXZmWd5Cek5A25JmlMQkQffMcsgjTpj1W38RIgkx0NerRBuh0qV7Mp+mX53lSwORZZLyo4EF2WuvWeouh+qve4RHO4hRi6/qjfVbax5uHDdqMsERoQtqBXGFt/Od6EDsi3XkHy2COBV3EhjPSwi0UMlCKffl7QuqQDEQKjrA4BjOibFbMlixH+IVH3tJbE07rk2xatri6f4m+cuO83gN0cMrhI6lTTZdHCcLFfJqKKUAyuF0yBiv7wCfnQtvzeXqRj82nlqkH10PTpjkrMNNiLI54hsyAyv9g8zUfga6rkC2qg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vi7BCpeX3wWsCK6zdTpsFe6wia3ibj/QjFVZXgWyr6U=;
 b=HENRtXGC3iCXWsvQ2ihnN9m5dS5S0FFgtD7MTDrwj3KH/OvAkhD8mkDXFf3bYDx9Dvgkpzw54FzI5R7YODE3FUg2xeqQ0O3VZTDlurXIhMmHeq4VC+XQ2Pq1gyIZHa1xMHqy6ftyJqAc8hZ6TrCLyG0Eyi3h9ic6gUATWTv1R32B8KR5IiBVXLz7U36ROg4MgNmf55vQ8PGkFDUFaboq2MhRAoZTMZ3Y2yd6hcdkoAgHzuHdAMDuxHuCi01Tc7j8iMD5cWiV+CHp8ovbdMVdDs3kloqDFTNy6gFtFw4ZhNfWsl3gkj3iUpwQU4VAvDQXneBuC04sNVAHu2Qd+/jQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7540.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 05:13:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 05:13:54 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org
Cc: akpm@linux-foundation.org,
	mhiramat@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	chjohnst@mail.com,
	steve@abita.co,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] module: Extend blacklist parameter to support built-in modules
Date: Sat, 18 Jul 2026 01:13:48 -0400
Message-ID: <20260718051350.344772-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1a1545-a71b-45dd-7723-08dee48b5c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	bbxjU+CMKu1O2zDOCpihqr0Ex+7/eodg2G+Aoa6KtcLC8siYYGl/3WX3f5b67qzGAZqKCwV6H0QH34Z5LkMQw6VuexcYiZOKD72AbopQ+UsOGM5zh7Gdaer4MXQxUYbvesq3uQuUOBBqPIL1pToMlQmgh4u6pWUS6GfVQF68ffKRNHYna15XkGxU/5nRAKJfPFxmeg9V7gCl2eW44GMhFFUqqNr5iP4zmlu0Xf9oILxHDIQAjCCPgjJfOAv1SEZPCwWYeXOrRu6+d6hi+aQnoPDsSSirDg1uwehEqOgfN0GAT/RY8f6g+9EAKq4hzNcavUikhjV54toAUa1XGNOzcgvxOHpaGvV/SFVR4g7hJ1auPHOE9T5AWdt9fMpCU6IVHTKLXl/7XzMhrrpF64JvnUJRJ7Drs/mUdC/U92eoecs8fK5o3P53f8p8K8T64cxxET34Ob8glenisN3oWWWlKKjiuF0WMk/MFgDW093rk+sSreGiOugRsNCmKRyLYAxM5b9a64VvSjF4b6jL/aHhzl0SaBF+PpkqFsv3HDpphozY7H/jHrQwuG2m4SiPNOYVZETzMgKzPZvks7fRN7/Af8xsa19JA9sVy98X68BE+o6mTn5d8WrDugqLQnTmS9s+jvoYPdStpnoDWNilMXz7SmmYDi9N0NLadtJ3u2+n8gE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBwlhOhhDMXWisR9j4vjSr6aixD+pMDuqpdAMrsnHLw1LMYUoPsTGV3aKW4q?=
 =?us-ascii?Q?Sm6l3fzx3ikqD+/Q3135kwD1AOtueNYPX9i1PJGOl67ZrQPI601PRYwyzaGD?=
 =?us-ascii?Q?sYF06R/FUzlDRCvxwzaUBFFO1+gwvS+g24i+aInUZg+2jMKIWZiRk5koqkAN?=
 =?us-ascii?Q?uqVppQSG4rN0v/RjxdvU8FxCBxV2ZHAo57CBUFt6Jc7kA+nDLje55PN2Eltw?=
 =?us-ascii?Q?Ym2dnx4/TcPLTVxiJ6/A8kGMaSMMin7Rzpzkxu/udaY6HkaluR+b752blJvG?=
 =?us-ascii?Q?pNOHG9uPzhqZk8bDChY8XqRPvTwnAFPjkMs+uQ6vdD/vPtYphdBsl9z0IfXm?=
 =?us-ascii?Q?hATjCOBDbOFeYPPr6faruychBdACX5GgEVQqiIdrrZ/gjRioTujEGxkUg74R?=
 =?us-ascii?Q?oDtCQno1b5sHNAdp8yZ0t9OEPCrBJ6z5SGxZsL5lsk1JNt1fY9Hd7LtX2tgx?=
 =?us-ascii?Q?aiTirq7pt1qQC3aNns2FF5pwL3NAlAjDIDaWg/cWQuB6DsXDqc/VC0B8q3eO?=
 =?us-ascii?Q?ibGXqEWCd+9/wveVcli0hboIg+Ae7KxoM+XfmyWPLjq89FlwqpgpgBDawMyw?=
 =?us-ascii?Q?Qbo/9fubqRPl1mRaY+68iK1nJlBafaMaEO7doROUpvWL6G/6SsUBL9rxHz1l?=
 =?us-ascii?Q?eloz0fdrxbgi2CeavSR2S4FkypUiwLcd9WL3+4zf3Sh3jTFxg+jpLpAPw15H?=
 =?us-ascii?Q?hYwj8L+vNkX9B/InO25CiogFaGEqK+eK17X1VGrCYDqINblC7Hji2iHqML6o?=
 =?us-ascii?Q?/gaaVWIwei+K934SH54NKFpMbRjLjbt8xt7u3w3ykpiWhyJ/WEfa33d7E1yo?=
 =?us-ascii?Q?BDhDeyLVrJ5pV46UAW7teCu7nXIMr7sG31LPGj9mbHzCRLl759hxekvkvNIR?=
 =?us-ascii?Q?RJyt/fX3EY2GT6lt48tW0Xr2mA4nQi0V/AbMDq0exikWi1Gk3X/0jfR7fseL?=
 =?us-ascii?Q?m+MCr1FI1gqlmmVKCPL8DTjVuqrKdD2aivz5sHpOxl8jQZgCTzeB5J5V2q5w?=
 =?us-ascii?Q?5jwBPwDOoUYUhPmlYpoP//QZLQ8ky0PHuVSePpCHo9PTpNS7jZvV9CfKSoFk?=
 =?us-ascii?Q?OXxrO0pZ/6B4gwK2oFyaO2IZOw9W81aohgY0UC2IOlV6zWsqni7RRcYvwQKf?=
 =?us-ascii?Q?+HjQYRa6oop3Fkgy4cKM7YHST6hH1njrGPXNHLwrIIGrso5t6YAW99sb6yte?=
 =?us-ascii?Q?ne9U1h5laDAlZagN1MC6dzzrsgTi+CXexhcaRDh0urTFxADw7O1W4ck7jOBS?=
 =?us-ascii?Q?/6v/cZkqeTYEhyx/LcJUHu2UQSsRbQjlGnxCm/50SZPI8zmXZy9Lqdw+5lkn?=
 =?us-ascii?Q?HfthBxi7aOJIRFaX6Wk4nwK/0GYO+S0laeQcgwiM7S8ftfZUrquq5CDRhbt+?=
 =?us-ascii?Q?Ilzr98R9aOLOAhTE0fuInggoL3/FhrE6dtMh5ZSt1Dlvvz5b/Zq+qfuScfsQ?=
 =?us-ascii?Q?gwNN0uUtzKMlDKm5Az4c19diWmwO8wo5Pu0q2c7mHN8wz2DZSLNqJy7AD2sp?=
 =?us-ascii?Q?nyXR5dJNdsAfdjjFtFNLWFgjoOYqL9mYtwwtn2JO4ZNMnnQsBPL0NtYpYfj3?=
 =?us-ascii?Q?CvYFltSCUKpeF/N3WTnOoD+OR+MGnSteyvatcqRh4d69R5G9XVt1OKfncgfC?=
 =?us-ascii?Q?3zwCQjEDp+qrcGTvsTfi0crfhJ1s+2FzlsC4woVtnirL2O/rKw1n9Zx4F3Pr?=
 =?us-ascii?Q?fsQ0j0Yn53bpGKSRi6+EQ21YhqgyR/XOWnxf1ZD4DJDIp72mEY9jZAzIuykN?=
 =?us-ascii?Q?Ck7g5PAtgg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1a1545-a71b-45dd-7723-08dee48b5c8c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 05:13:53.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G1inzu9azeZZ1ShjUYfmmGg38XK3Cg0jwAB3WB8Pih884SlvbPY+SlFmpNTaO24Evdp0rlvibbsl5c5Nc01dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7540

Currently, the "module_blacklist=" command-line parameter only applies to
loadable modules. If a module is built-in, the parameter is silently
ignored. This patch series extends the blacklisting functionality to
built-in modules by intercepting their initialisation routines during early
boot.

Following review feedback, the implementation has been split into two
separate changes to decouple the introduction of the new feature from the
terminology renaming:

    1.  The first patch extends the "module_blacklist=" parameter to
        built-in modules using the original blacklist terminology. It
        introduces the ".initcall.modnames" section to map initcall
        function pointers to their associated KBUILD_MODNAME strings
        (restricted only to module_init() invocations to save memory and
        avoid matching core kernel subsystems). It also implements temporal
        boundary checks to prevent use-after-free (UAF) risks when loading
        dynamic modules, and a fast-path check to eliminate lookup overhead
        during boot when the parameter is not in use

    2.  The second patch renames the variables and helper functions to
        adopt the preferred "module_denylist=" and module_is_denylisted()
        terminology in the codebase. To preserve the existing user-space
        ABI, "module_blacklist=" is kept as a legacy alias pointing to the
        same module_denylist variable


Aaron Tomlin (2):
  module: Extend module_blacklist parameter to built-in modules
  module: Rename module_blacklist to module_denylist

 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 24 +++++++++++++++-
 include/linux/module.h            |  5 +++-
 init/main.c                       | 47 +++++++++++++++++++++++++++++++
 kernel/module/main.c              | 24 ++--------------
 5 files changed, 79 insertions(+), 25 deletions(-)

-- 
2.54.0

