Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021074.outbound.protection.outlook.com [52.101.70.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5A4D2EE1;
	Fri, 21 Aug 2026 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325510; cv=fail; b=UDpbRlD/3D6kCaZhghzU3V5jsSsHXOzdeNd9QqHAkgaaFtucjWz7TrgZtmsqiNkgvzhlP+AK+pSbgzZE5xCvF7CblHQCESRDE5JFPeBwIPm/5a0u+XBrPK+LvabEOdmoxvnQX/ATMaQoUsIbMgSW7MioNsapahFlbz4lNthpBCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325510; c=relaxed/simple;
	bh=mAMllYFGV+hYCBLYZQH2ES2mqidbjatT1jCtaDl5WDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJMvMG74tiIvlibZqNbgtdJc1ITX6SRfSqMZqZO6dOCzwKkj1Tm/LINH9fhnW5HWGD9I9VwGkgYK7ePHpYxeshogAFIPmuW2WUOd4e+Kn0/3r+aP4LbM3oNy8k2rDGCWmAb5Z0fOUU8i4THNk09aqMeph4SVYvckteBg+xR/eGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=LNLR1d4C; arc=fail smtp.client-ip=52.101.70.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="LNLR1d4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLRBcoJIBfJ/WfgP9Ne9qwWnxl5spzxy4oafCPJ4fDnEJKsAjWnari1xYnYD/m4OcljrmTV4Nd5utxgoHwbmLl7XPggCl/At9XUN+qnXrc/GhsyVoIjn+MDulCpM21Ki1jhNrM0Jh8b3EUYrxd57xkmB8kHpcebvku1c+tlKpzYx2np6jgvc59j+Zv3hkNBpz4fUCMGNKhdAM+FcJ0OKJzTc9VRbp9HF25nkMfp2YHrpoO7ZX/iOF2awBiFPfA8piZD0Y8fV45znBVtQClKg/lgmK8MNuFzbJWuP/BWVpnjyizIx4UCY6yi2+UmT8Jy6Objc/XnvqlHeVmvB7V1n2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZNhoNtM4fhDzHo/E7OOBCGYQSH/NriUzPBgPloFxNc=;
 b=w+Pesrj8HHn1ZXWI2ClP/EhUzySD392tYMxr3aPmKJPvl8/JXjEOib9Jg67PGG2pXV7oPzno0kTrcA7pUC+DOo1zoOqZHJZ9DUxufuOLV4AdAPxDSuzK8HcLDgoS4DcJi8TkDlvjTABZSNLK6+F9uMr1SaRA32YYz0Scw/nkaOrCTTm2O0dEPUQHFMtYk0OZfRpUbSJZs51amu/TkvQqdA37DAL9cAHpn2DBFHoB8o2nH71jzgAzWjJASuOm0bFVW7LKvVIi5Je80AvzOoZYUeXptaN5Vt5Xu/DXk6HKIvPQYwkRr4VRay/SrXIizhXGIhFl9CLNhacVZWZh3GrA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZNhoNtM4fhDzHo/E7OOBCGYQSH/NriUzPBgPloFxNc=;
 b=LNLR1d4CzAFXHWuFoH3SMv7u6EnL6K38DPkUeov7tYfKEpF4bCC7e33xo5Zg7rP62nReot99I+Cm8U3x5qR9mcESD+P6qx8TW5B0yiVI3EkpaOkcAf3sKwUh2A92obZKsBj363CG+SllDroZSz/oEIAynZoUEa4fRuvWWP9dmONo1rIrA1dkzL0TdhTYjw1G5Gq5Oln5qPzqBPi6qsdWAbfWcpSZtiDGGJlpp8KHEkeuoD4+LzoBSnUmu1x/+YwhVkXIX1i7gcaVYoTetlPP1ufwqtfEuRx5UyOetoJ0iIt3chYXcFM69VcCijU6bRAZcjZJ9b5rwp8jlr+TBGd9pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:18:17 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:18:17 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Sam Price <thesamprice@gmail.com>,
	Neal Frager <neal.frager@amd.com>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Michael Eager <eager@eagercon.com>
Subject: [PATCH v3 3/5] microblaze: don't clobber r3/r4 restored by rt_sigreturn
Date: Fri, 21 Aug 2026 17:18:07 +0200
Message-ID: <20260821151809.1233057-4-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e89866-f011-4d3f-1695-08deff976d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kjlZxESBwW8eDe0JrNCizwI5pAX/elZWVithh4tdFwrH7U5O7/12xm1ba4JaWWAhs1gZbykdASZkqv7A9mo6zkKv4HUNu34W5Bf+oc+KMUvfmcFDMXMQHqEP1PZIgO5FUrYkoN6MbAt8Fz4E82efNyOl13lxFOmxgtXPOx+d4dlzk1DgzEHzZFvJBpodV1jOgWekMWxrq+M/zJr/48EJ46acu6synAE4o2luh9pHNzbZEiy3FoDTFn7sY6e3cS91HZP6BX87INZ1rr+jcnzeXGbhhmmPwPD5au1sfR3Gs13p4YZE3GiTOJpvsMnk1cIMQ1Z1k2Ty5jqmbR2eBHNH8Sk6dQ2XfSzxAQcgzKZGNaEQSzu91JCNp/xtqEE47j1/vsuUAg+dAUpEcQ9nmEgrQDE+bJkk2uqEIVMSAQzeqgsPkWaQ817T0YBk7fPnsXRh8xzJjhnFlxrKseWjimGzbrxFBqmwZ5P6qJvpGWi+8/R6jvj1zFn5VNrIN0ocHaX0wp5X787EgpdmVYusmvv5W2HQSXXoo1qIjkcedcfdVxKOzTB+ERwMXV2tg/8g5Xw4aeMMPkuHU/d0aAbl/nqb1GnVaNqsOohuuEIwrGmOD2WIYsBVU68xMNeXQHYYLzV0D/3RCddVL/OwAuXK49xJxbee9Qc+stOHPKQ0iL+0sMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2XPaQZVidC4MM/LVWCRd1qOprEwIyZW8lSezSZkaLsNidFxerCgksTwJ49fw?=
 =?us-ascii?Q?bQ+kh4UuXVqHWeRbfwX1/Y7C8096bQnDtQRZCTwdTzT8a4QAyjFRBF7wKkG3?=
 =?us-ascii?Q?ilMpXAYkB/QssX9O836ehcG3zWAihJHV1O8Hjw6/FAsI+ddi3/2sUUy5BFIR?=
 =?us-ascii?Q?aDJAQVAXOxNnhN/XQgpGXAmSus/4PXyyIGXxykBbs1a3d+ROKvibBa2lKKF+?=
 =?us-ascii?Q?CsIPE1SnEVmG89eW+SQ4hDbYG/awIZJr3hExgeWYyvk5CWQa7ZKblvz8Zd9Y?=
 =?us-ascii?Q?whTHYvyFPaSOiAV6e0j5XfycHie3VLUzNNqdAMr2nCHgXvdYknM74oCXzw3O?=
 =?us-ascii?Q?Om+6RwzyLU1nGL8rq1aXsfqf1p02KquJTJoIQjJ4x1iUxlOsUWbuj82buuS4?=
 =?us-ascii?Q?Q+LJnwuZ4RT1LVsiDtWPQxlV+NgZcxzOT1MtcdXY1GbxV/jK2meF2jjkedrl?=
 =?us-ascii?Q?P7QgeTWcni/KdwuDMw7jzeVcwzo/kvthIDRLk04mgI7NGPeOvwJyepip+h+o?=
 =?us-ascii?Q?+1wGvk/3lt0caTxHEIgCZPKge/vK1PbgeArS2S/0mtL0sVDkS6HYYcMEpF5D?=
 =?us-ascii?Q?ddvBZFI6fZJPxQfeAYjMjRxOHokIxPB+NBByaLvfhumvi8F6aYL/fzIFrM4U?=
 =?us-ascii?Q?Li1XxKBgQRZA7VQ5sTls58VrkjcxJRK1YBu0qfeBr16+//cYySoQ/gu3/YSr?=
 =?us-ascii?Q?EZo6718UasRfvm2CAURxENCvX2LILPNE/iRFaAEkLzewBpK7I9bM3IdfBN6n?=
 =?us-ascii?Q?Psi9+cz32U0zU3BdKGK9E0d6t0fePV+/0zWw747XFdTOBZgyGkBo55qMxa+G?=
 =?us-ascii?Q?euYsrMO1YWNGT76pLtI4Dnk2dC09T2/4hZqlbRtLLdQywiO8erjMvd1o3Jrj?=
 =?us-ascii?Q?bmL65LaIdVHB/YAhqc1b3E7/2IOuFGJx/yX+gxoKUL4dJ695++ZtG2tyk/GE?=
 =?us-ascii?Q?YKqCf9ASY1Qu95pm3FGbSLntlPfSwxPvYFRMOee+M7faV4Tw9O7XObH+s1oL?=
 =?us-ascii?Q?tIHL94CwgP+8GrieTwXyGhPG5qVvBS99jRmGqbbNtYpWA/n4e9i+durkho9/?=
 =?us-ascii?Q?TQV9OxKtY1KcCLCAwJkt0ELrLDmwARJ3E9ZDBh1IcERGdmFO/SuRKYQo8a0a?=
 =?us-ascii?Q?nauUAIKEYpvhyVaBCju373ZYCAoSaZL2PgNxp/nhwdkjT0pmLgo/9UNXYWSM?=
 =?us-ascii?Q?d4oJGisnFb24EMSPgpn/IpxYot96nXPTgNnlFCthQHLP5rT0i32P2LkbLm3V?=
 =?us-ascii?Q?3OW3CLSdt6H6838+WHEmTbU+fHpBPEI4NKuUmRckgbaEdtY12CZe4Dr8QaI/?=
 =?us-ascii?Q?Z2bIYCNivM8s/asXJ121Ug2VOjxEY6rs0N99qBOiFtGbojdCBSOtiYUOuU9q?=
 =?us-ascii?Q?g/S72VRTrBMvcv/tERavkFy4nUdyiNLgNhoZKgo3aEdg8gsPdPPA0GjgAPIx?=
 =?us-ascii?Q?AAEFaEw1BGMt/2O3maaeXUcsLvDNlcH00eAxxfwyLCnoHFAA3vPRI6TtOVFU?=
 =?us-ascii?Q?ULaVziMCs4jM/pNph7ebNTr9RFX7S6lZe1B13nKiDEDabAm/33tjhSj59FNT?=
 =?us-ascii?Q?dose1FqPuPtQJFN/K0aciUBY6LpqeX37kmqU6vzJG8iZfl/8L4faMfvOKnUE?=
 =?us-ascii?Q?vufzpEhL04vIu6Rycu7xwWl+DXiP8xN+wxDO+CKUd0/XIsc0EjocAwRFW6Iy?=
 =?us-ascii?Q?sfBSzOv/4t9PMOE3KBSim4HLjlfhtdjBvM7acJzDHB9dslatGoCVem6ixWf5?=
 =?us-ascii?Q?ARAvNvM1gw=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e89866-f011-4d3f-1695-08deff976d45
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:18:17.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+DNoQcbIObPK9AmBL7y4e0wOM4ZmlLX8458tiV4npeUgKh92/eqZFe+djFn24OrhxtGigKt8aML/z61E9PXfA1be2MgFhTmjl1lpP7BR4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963

ret_from_trap begins by storing the system call return values r3 and r4
back into the saved user pt_regs.  That is right for an ordinary system
call, but sys_rt_sigreturn() returns through the same path and has to be
transparent: restore_sigcontext() has just filled pt_regs from the signal
frame, and every register must reach userspace exactly as saved.  The two
stores overwrite the restored r3/r4 with whatever the C function left in
those registers.

Only r4 is actually lost, and that follows from how sigreturn is written
everywhere rather than from chance.  Architectures have sys_rt_sigreturn()
return the restored return-value register precisely so that this writeback
stores the restored value -- arm returns regs->ARM_r0, riscv and csky
regs->a0, arc regs->r0 -- and microblaze does the same through
*rval_p = regs->r3 in restore_sigcontext().  But the entry macros treat r3
and r4 as a pair, so ret_from_trap writes back two registers while a C
function has only one return value; nothing carries the restored r4.

Commit 791d0a169b91 ("microblaze: Fix sys_rt_sigreturn_wrapper") introduced
this in v2.6.37.  The old wrapper saved r3/r4 before the call and reloaded
them from pt_regs afterwards; switching brlid to brid removed the only
point where they were reloaded, and the stores have been overwriting them
ever since.

Fix it the way the sibling paths already behave: ret_from_irq and
ret_from_exc restore the full register set and do not perform these stores
at all.  Label the instruction after the stores ret_from_trap_no_rval and
enter there, biasing r15 by -8 so that the ABI return "rtsd r15, 8" lands
on it; naming the entry rather than computing ret_from_trap + 8 keeps it
correct if the number of stores ever changes.  Restoring the old
save/reload would work too, but costs four memory accesses and a branch to
undo damage that is better not done.

Any value the compiler keeps in r4 across a signal is lost.  The tightest
windows are the lwx/swx compare-and-swap retry loops gcc emits for atomics:
in uClibc-ng's libc.so alone, 50 of 364 such loops hold the address in r4.
This is not specific to one libc -- musl passes the address as "r"(p), and
glibc has no microblaze atomic-machine.h and so uses gcc's __atomic
builtins, which expand the same way.  Triggering it needs threads plus a
signal storm, which is why it survived 15 years.

Reproduced on qemu-system-microblazeel (petalogix-s3adsp1800) by running
the uClibc-ng NPTL test tst-eintr1 40 times against an unchanged userspace:
on v7.2 built with gcc 16.2.0, 23 of 40 iterations died with SIGSEGV
without this patch and 0 of 40 with it; on v7.0 built with gcc 12.5.0 the
same comparison gave 6 of 40 against 0 of 40.  The register dump of a
failing iteration shows the signature: a zero r4 and a fault at address 0,
while r3 came back intact.

Fixes: 791d0a169b91 ("microblaze: Fix sys_rt_sigreturn_wrapper")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/microblaze/kernel/entry.S | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 582d7256d815..fea235f139d7 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -434,7 +434,13 @@ C_ENTRY(_user_exception):
 C_ENTRY(ret_from_trap):
 	swi	r3, r1, PT_R3
 	swi	r4, r1, PT_R4
-
+/*
+ * Entry point for returns that must not store r3/r4 back into pt_regs,
+ * i.e. rt_sigreturn, which has already restored them from the signal
+ * context.  Reached as "rtsd r15, 8" with r15 set to this label minus 8,
+ * so it stays correct if the number of stores above ever changes.
+ */
+ret_from_trap_no_rval:
 	lwi	r11, r1, PT_MODE;
 /* See if returning to kernel mode, if so, skip resched &c.  */
 	bnei	r11, 2f;
@@ -518,6 +524,15 @@ C_ENTRY(ret_from_kernel_thread):
 
 C_ENTRY(sys_rt_sigreturn_wrapper):
 	addik	r30, r0, 0		/* no restarts */
+	/*
+	 * rt_sigreturn restores the full register set from the signal
+	 * context, so it must skip the r3/r4 syscall-return stores at the
+	 * head of ret_from_trap which would otherwise overwrite the
+	 * just-restored r3/r4.  Every C function returns with "rtsd r15, 8"
+	 * -- the ABI return, where the 8 skips the caller's branch and its
+	 * delay slot -- so bias r15 by -8 to land on ret_from_trap_no_rval.
+	 */
+	addik	r15, r0, ret_from_trap_no_rval - 8
 	brid	sys_rt_sigreturn	/* Do real work */
 	addik	r5, r1, 0;		/* add user context as 1st arg */
 
-- 
2.53.0

