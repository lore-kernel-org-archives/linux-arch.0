Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAF4BC018;
	Wed,  6 May 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089959; cv=fail; b=I3zLooB1m/VnECmfH4DrZmFvbTW9e9TmyyVRCeH4PIy4miu/qk+WPVPo2o4WHXKJlChIgWnelB6hRbA/KkhbI2cd9d0RGz6HGx0VftP5bBlyUxPTxTBtDRu/h4RQGHup9A5HQf2IGlfgiNJzIC9cVGMteRxG1b7sVqBsiqL1gGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089959; c=relaxed/simple;
	bh=9hvJ+ifL16fb5fYVk5kpCC31cUVtzOXhQpsBYeCs+ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKg7lqKJlh4YQw+gPWGe5pCFmpeXObWFXilJ+7jUj5iqRfAriHeX4L/5hxkawPFCqYEj+2td56Maa0PWAlyTCgaYoMUh8nhOI0uOG/tfaQJg6W5a982Y9VwH4B4gMZgal1V7f9PBRbJzNddYuybnYl4hEH8SWP4K78xSWMZ8k9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AB6X7R1M; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AB6X7R1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZqquAiTdG8L8m7gOH9NCrkZPEo1+4yZ47icWmwhRe2JmzFjlZINvf8K8K3X59hcoAL0segHR92tMZZbA5jKc5zoVF9AdpKhZWaEYaleNmmj5NBtdxep+qsmqbJBOfqy9XEdkGZzEJzG1A/niMKynDBn3o/wbxCI/CYmeYt9MF0ovsyd/Z2VEl6qdxhz4AxwqtUsa6aUme4l8269+YXLMwx+fWp8x5lzS39EQSbot5/FLmKK/d1nF3KhpOWap+EJrGF8Ue1CdfO+kNraSr7gUoZtfmo+R76c/bcV/dsc2FijSIR65Xxb+PTi5B2/7rX+jxmFI82mC51iTvGxa4AVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmVeCYx0noKqdS1osGNtIT1fw0oGHFd80gGlj9CdVBU=;
 b=Mi6D4n04I+NWWFoZsZY5y5uCPmY+YmJNK7TZF29d/KHtcpalsdRnQoJgh+cyOQwsW6OJ9iptJ85NLyvypyB33fStWr4E3bUprYfhbJOQUSmy+Ya4Cr6EFd83s89q9f12mtqCt2tytSG8LaYrXnRXQFFEpZQuWSiJW/CeH8xiw+i4day7/0SyLHyjCREuYz31ghByHtooVNXFWaeNviuwNEpJlLU32emBHJpA9q2pyUfjgcC9YNanTteFEEaGjwj+jpj11vj1NGQv9DTUpAGtpvnkwdBzZ2Hd9FML3kazMru7ZsxTX0Z20iIPHFVIroHiN1KszZK5hjvj/XPVOHdLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmVeCYx0noKqdS1osGNtIT1fw0oGHFd80gGlj9CdVBU=;
 b=AB6X7R1Me3OEK73YvbcBmDTugrjUHCw+JQBY/wIqhEiVV40nE3HpXPV7gpTav4mJ0531LAhOrCdBZrVHl7PUc85BcWAkDG5abwpNsWOzJ1WcBQHlzP8R7AD1LUzy8guLbIf+nVQwFzPz7NZNTR/dkpQVEM0GYY3mG6LEgDeyhFNTPesvwDQx4FaOMZ0JPNBZ085R5lunAzs0c7BhniNhYdkxqiEUqpmnBKZbmIpPtc7SJilt7Lr48SdkEqoF2aGTGDEfOYIVpKYzShFXz6nQ2AG31pFt8gls0XzJ1r25mBIZZd2LP5hpe9+5waV2EGJ+j0055yiWo4YTgzGGar5MFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:52:13 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 17:52:12 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 1/5] arch: select HAVE_ARCH_BITREVERSE conditionally on BITREVERSE
Date: Wed,  6 May 2026 13:52:02 -0400
Message-ID: <20260506175207.110893-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506175207.110893-1-ynorov@nvidia.com>
References: <20260506175207.110893-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdde94b-8d0e-42b2-6312-08deab9833d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ehX8UnS8dsYHZAUE3LAjDwYQ3QwmVnc1HN6/L1vNpCMJZtpJVcXj6MsaEohXAWsMl/QebvIActxd6jRckBrMEdWNOm/LxNbOqqY8N3NrtuZMFhpop/Ei3ciWnf2MLCSyv1i1hMZ5uytzrqUGvdj2bkj//Yroxz+r1SlfjSriagStXCZ4I0/3JT1vSc2uY5q+9l6/uH60rrd/BEf0L9ec/jZnuI1Jm9nKl6ubS9bPcsBPSfSw/9nvn2Ktm93JAz0iHFcDHUVBqLnTpEf5teBSxUASyiCJT4TfwPUJxUC9OHtmJZoYriYDDConzBJG8DdrEWIDL1Vsl+Xe6sIdMqZXSW/x2av7U+N+KwvWmTFqG19wPwkJB1F9nhzNUJaO+vyIdSuljQ+KZvjAERJQVY3hrFb28n7rWTUawzfjYG5n+weYdtvTa0wLYcH4zKBG5MTDgw3rjrUehDzZWbZRAlDvKcnQVU83W7hbdZZhrs6Kgp6SXXDJVDo/lqRHEJ9HkzPN4QT/oSOKoi497829wB/rEZFVsCkEyODj57qwIGQ+C4QTptbNf6994QfuF2H1FeAJA/4R7rW9fw7tQAHpbktrgNgDM6G+HjtHEuTEPHvPJDRRzUJv/WojjmPfPqQtyNmy3MtiaPFdaXcKX/v1LB0alG8D9pbGcj3QU3UCTnaaYbeRncuTCd1pv9DKJeOcuHGgCV23AO0C5TxIhVJPYS52cTu7c815ksIfsKuuKJJmbrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWSvSEvX0B9YkYq7MDrBjCpxDCbP2ed770ExK0w5lF17jA4JJtDcqEG6m9/o?=
 =?us-ascii?Q?mBESH8cw6Dk/aCZpHdMoPHowj0DYJaSjdU+c6H4tbhIIV4qbeCBc6EdYlY3Y?=
 =?us-ascii?Q?NibjmppadNChssfakD/wLCDvbfwxHWXiMzhe8pQ8BaUZ2mIzjr9ORCsmnFjB?=
 =?us-ascii?Q?XIM2NJQJix9mY80Apxim5g1/nEeaWIulkOSZemN7ZZIrsngcZsQlnitbS5Wm?=
 =?us-ascii?Q?3KlUSSrJA1hXw9jLiHCqBbFP/XYHv9wVrMaN3PNmiFfK53OkxRaH7W8Vso87?=
 =?us-ascii?Q?qspQ4alx+vyIYL0YRJ8XFWDjsaCABGoNlu3ivWXOKOn+wK2OeKhSbdqTJE0O?=
 =?us-ascii?Q?YvrosN76FKDPCFzmLk9wa1aKIgBGrNBGL5gqMh20hdOGML/W9wo9BC2VUNVh?=
 =?us-ascii?Q?kTLdRVp8GfZ6txYjAaX8EdbPmMiAD2TutqTnYWuAcpr9tpb3QGO8Pl1/Tt5t?=
 =?us-ascii?Q?j8aa8AuNTAJoesalHihsQTNATyfggL5ct/spg3bgGWGgBtzg3k4Wrw/gFSvl?=
 =?us-ascii?Q?DxMB4ay0irxhsszK86PfDEQZvcW0a4kEcC7mGh76le0Wlo85cpSSr5j7kcu8?=
 =?us-ascii?Q?eE6fyhJQbsAyGtoub7gOTxlnug/GWoNNFY1pHLnGjGBB1XaU0rz58gBas4Th?=
 =?us-ascii?Q?pwBqP+dZybzwuhU8z/DgQoi47lCh7bs6aXX218pongfxXytdIYERvM/Moewp?=
 =?us-ascii?Q?0ykJ7S7v2WEPBGn0C5yEQ6eWUsOuH6+M1Caks35uBS27CoE5fGDtHFQ0SBqA?=
 =?us-ascii?Q?h6FwDhrL7ib81p3pGb96H1m0Sl0r8pL9ckKyT3dp4zHGYm7vJJs/F75pUKyK?=
 =?us-ascii?Q?qjWn/CC0oAgbO0W+HIr5eIe8uN0RR/BkAdvKuAXk4PDOhcr2o/L2SHgIEs6V?=
 =?us-ascii?Q?PAX2gM5h4PRCiRaRy9LKtCsRQn8NZg9XNmtpG96m4oj56uX6Lyw1DrDqn+mc?=
 =?us-ascii?Q?rLR1kr7VtlmcpZcS/IHryEI2cyVTjsxPa0XD7z3PtB0JvlAIwf80Xzx0w7hA?=
 =?us-ascii?Q?GTZQunCEUgtXdblPi3F3IQVk01nvR6ByM97+Ig5dOJqGZkCj3sXgab1drnqx?=
 =?us-ascii?Q?EXJ23JoJ7vSMEwEUDpscdr1IVDUEtI8jx6dzPODgljbG3/Urfip72vaYdD7j?=
 =?us-ascii?Q?zWJeT6mIOiymfttZ4dR7KJ4kH9KxLl1500776Oknr2iKkudbmKkZrs0Qd9rm?=
 =?us-ascii?Q?vyOIHFQ81BC8PAAFrTeGwlSE94W2aqH8wXt+L81+wLhcxb4+q2SiS3Dm5pIP?=
 =?us-ascii?Q?ezCzDMRCgV0soipM02j0ulea46Vp75dbwohKpdxHbOGF11evGV0qITVWCCCx?=
 =?us-ascii?Q?khuaiybsZo5Sn+/l8lLI3ffaX9f3O3Nq/4c2jdWPEsa9/haJyPznQo7lcxoM?=
 =?us-ascii?Q?ec4HVagaEKrZmUu932rTUNSv2U359oCEq1bYM++YSsvBP+nb3iqyIgyPiObr?=
 =?us-ascii?Q?lLSmudRmwaHCEftWR0ONnXQVVAbHENaucWOSV0h7GFa9FeV9gbKVJat1O+qI?=
 =?us-ascii?Q?dYeOeSn8A5c50Y2nbxQARlAOVZfSxGdj6e5cAulEfxn7F/HU7v9FyM+zi3fh?=
 =?us-ascii?Q?pvFf4qBpFeXcFgTnWwnmYCD18T9Nz/XlIWz0rcc+ToZ9jyRMN3NPg6vNd6y9?=
 =?us-ascii?Q?UFNFhX4Iz+EXD8g/hY4Qgd0YR5et44GVowSuzTsVueateeqsqO6hFureETmF?=
 =?us-ascii?Q?ZnsXcZQ+KYtUz27duDRYK+I0Ilg0AgnqBBk/3avdmW7lF04o9KUm8Fcld4P7?=
 =?us-ascii?Q?76C3/Gjk2iHWFNQ3oLV7Oo2a/2K8AK+iLh5mT4vLY2ehIxDopbPc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdde94b-8d0e-42b2-6312-08deab9833d4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:52:12.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4HaCZJ8EWrxbcxcc5GSNIp2y0zu28BwvzKkKbUu63bZe5ejvnhaB+er4XWmJ9nTeZVOdkJQGU+lUAgOsEvS1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

Architectures may have bit reversal instructions, but if the API not
needed, the corresponding option should not be selected because it may
lead to generating the unneeded code.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/arm/Kconfig       | 2 +-
 arch/arm64/Kconfig     | 2 +-
 arch/loongarch/Kconfig | 2 +-
 arch/mips/Kconfig      | 2 +-
 lib/Kconfig            | 1 +
 5 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71fc5dd4123f..0e963e54fe06 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,7 +83,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
-	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
+	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6 && BITREVERSE
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..f5bb62c2ba9c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -150,7 +150,7 @@ config ARM64
 	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_BITREVERSE if BITREVERSE
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_HUGE_VMALLOC
 	select HAVE_ARCH_HUGE_VMAP
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3b042dbb2c41..6c3444e31c0e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -115,7 +115,7 @@ config LOONGARCH
 	select HAS_IOPORT
 	select HAVE_ALIGNED_STRUCT_PAGE if 64BIT
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_BITREVERSE if 64BIT
+	select HAVE_ARCH_BITREVERSE if 64BIT && BITREVERSE
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if 64BIT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4364f3dba688..7e1494e0dbfa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2026,7 +2026,7 @@ config CPU_MIPSR6
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
 	select CPU_HAS_RIXI
 	select CPU_HAS_DIEI if !CPU_DIEI_BROKEN
-	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_BITREVERSE if BITREVERSE
 	select MIPS_ASID_BITS_VARIABLE
 	select MIPS_SPRAM
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..d8e7e89ae320 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -58,6 +58,7 @@ config BITREVERSE
 config HAVE_ARCH_BITREVERSE
 	bool
 	default n
+	depends on BITREVERSE
 	help
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
-- 
2.51.0

