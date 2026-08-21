Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021140.outbound.protection.outlook.com [52.101.65.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E44C9557;
	Fri, 21 Aug 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325506; cv=fail; b=O4BhG+PyqI68zSBdrxclPQRy2OKJKbz88o4diVfEdR2WM5o10TzeNINEHJKW2nadZH/85kHijKX4K1NVkBorOjaNl4VNlpx9JaYs7SpSpCf683kvyk65LkOfQEoP/Li9L7LYNXMNuN/LZt0Rn2A9FM5iHt+aQjkMjs1ej8v3xf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325506; c=relaxed/simple;
	bh=zApENHU6d+7Fl+SzygJ4TF5KoC4NGlBRmpY8i1SFzyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugrkC7raUHfn2hWd/dw3lXpFLFKNiNqwQo9GtF5JnJ0kCfbehphXx2NIgDHyRu5XQN37pwgnTb0csmZwGZG5Cx6qIBacJEXPhcQ+MdxW4u1O2U7LAv1X7FhdvDb/lLzm6F0RIhMqcQX43vrt4tRf1rXFfma0ci5iVL72RUWU/nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=BwD6cDWg; arc=fail smtp.client-ip=52.101.65.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="BwD6cDWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7NMPMZDdB6rsnSrHtvaGZ0pqTedAGpHXrrs4T4F7SH1OqczA+lP2NHxrd3OopkWxRz74nUIijqIkgcWRJuFN2E4kd0livI1yvhjlgTgC6yuzpknn7SeMBUJzPjp7sdimM98R3mqFt8bWAhGyq7CHWVyn434kKjEtuTY+jwyBVeZgUh8dfckmTiSyq7N675H5ubQjsyXUH0+5NRuYO/taUPLY4bWnXEjIuy3stUQhnubQQl6nsSzD84I+g+6MkPyeVKyA5fhm/sIUdvs5+RuvBFCqTlRfao5Qqk6t+E6qTX/KQXKlOhaoJsJRnmr83q/cabbe82xjukgWjp8RQzKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpQn8i3VWcUv3NJhxDN9d6ctE5fkDWt0THzoIl5sSdw=;
 b=PkKTi+e5eAghVDv7URzx8R2T+w2ETk2PkH+DBgdPe7AU/BBUINiQDmbyAdPHNpPqpkf09+qHQLz4asrL1GMIZLw5nSikBMpLsZpufKxn6jhSODld6D+lVdX3Uink8Tt8uRBdnr0ZFUGb8KDJ6O5Yb3XpUYoqZHVnd+bI87/r4vPJR8E5wkUD/82O75P42O8YvqOAokk285MEcVIXBOND+lC38dRRu+Ep9VZd/UINkErY9hYuSgG+gwBWkvkXZgmq4L3lfie6pQkKDMp7A87o0Z1wXbbSG4xbJQm8+rOcm6SYcv3FhMoPwlkzEfIQfxYk0Ve6Xf1ZpGq0BLeCv6Lp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpQn8i3VWcUv3NJhxDN9d6ctE5fkDWt0THzoIl5sSdw=;
 b=BwD6cDWgwusVQZn0kY9AUKna5niSMtxXRb2qCfBN6SmAj52Vc4ZdP0Nre+QwIUgbXteVJImburZ8kAhPZ/bHguGdsrj3yQisyW5kv8loX9zXN22fHZyfWNcsU9BLnuydDqEbAKKOAKUKqrYYpiuyP0rcl+Bhgg1mYG0xSd0UK6CS/T6hD7k7ebn6Dgle0YhzMGmV4iUiZnx7YkGCoEk5qVWYQ+bxUSIRXMoDIH3CWNmpPBAhK3xDOqO4ZOTfu7N72PEz9OMGrnIYMG4PagnYGIS9uqLSW2DJjcNbQd4zxFWaIucnsf2cu032r7ChD1HKiHaCkekfBjicVPtrD59EOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AM9PR04MB8068.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:18:18 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:18:18 +0000
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
Subject: [PATCH v3 5/5] microblaze: preserve the MSR carry flags across signals
Date: Fri, 21 Aug 2026 17:18:09 +0200
Message-ID: <20260821151809.1233057-6-ramin.moussavi@yacoub.de>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|AM9PR04MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2636bc06-90a0-4650-5458-08deff976de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eCafPgkIdilzpZSoGfSrBK+SsRFS1lcy7brbByWO8zHWzwD12EJ5DAU5skvvTqoPDpjcfLI7GfOBHUysEcarfOiDlbz4csGg6M53c3hQ+rjjbm+x1VHDVgMVpaPBbKPc0+mXCuilttjvLGtd0R2LkNnJ9XzOm1I/oBsUGlUiaoTZfXOKsoV8thDx889oinfFxqqFBo5X0NkqMZJchi4qzsuncN0ec9kLlIKV2ESO1QPuSjUU8zx3hzLxrCEalqiUzq4XZzd2UclF3ZcGSbhiW7V+SYN32BG1v3xAthtn+UnuMrfUQYHw5SoHqOZi6cjF8RRt0KmHVACOxuGdYpTkL1wBdrjcdAtoZZDpZ6QIG4ohddjy5TpyEEqogFZ/qm/qUk+ocqSzkYysnOajFNfWl9k1d0dLqtYnZziYDTCqwJOh8c7EzJBT2NxHIMpfssQZg4nt5HCO8xTigmrKJ7ruHhSLtk+QQXQXcs0SvxsvzNZs+5AEYsTIujNHh3TGMlUYL0GFxoP0BjWXRooW5MFwdRrkoBSQ+ltt15CUuUYOsyclwbEoccx/eanmj+uo1np4BslHthFf95wyuZsHYWIMrd1qkq/YRzlP7jSaeFOl43w2boQrXMb0WzLLjrrn7CAj6bBNPPM3D7gop0TiMgwj/wWcReAe1qSDdhSBs30rlFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hnly75ueNEOuHXwtUgNB85h2x9qcXsW1HTzNDPGnb14mwh1paLUAPTcPhscN?=
 =?us-ascii?Q?UXoQ32fu3TQv/Ye3ziKG78wckumbsaFAGsFkMYZ5BduMd9Tc5DBkDoInyI4k?=
 =?us-ascii?Q?F3//CU90weEYUfg4XX3hqrjG37ZXncJovqmes9I8BPLOLnrelPr75gxCXliV?=
 =?us-ascii?Q?qfpDxzHo9FwBUTTJV74uFrmmIA3ElL6j8kMWBcEQwU8CM0nr+TssLFDniDPs?=
 =?us-ascii?Q?vKnvGHyrznuqGNCPQlamCLsxvpCLSglXTIvUKs5df4XEE+lvl7tzDg71+tmB?=
 =?us-ascii?Q?WoyxGowIRzBxbMjEJp2AHWqcqsiiK5CJt5CMtpx2ata39/eaWSp61fm+2VGA?=
 =?us-ascii?Q?tdhVBQnFs5pr0e0yJDuYNV+wcWUe3AwVb+PTWxswTIuUEJuYKNBMkcjjCYxF?=
 =?us-ascii?Q?7iU0D0XMHUYyK9a0yivPJeL5vkx8M3rGv1I7AUlRkd5a7hPeK1EEzUgJ92vm?=
 =?us-ascii?Q?qMXHb8hyUoNfj8EVcLKY9LcztQ6/jcG0b5V0pxrk5xhen51sXNAchkFQUuR/?=
 =?us-ascii?Q?EdBiLvOxIactVH4oe14PAkNKyFVpMsXlOFw8YoY9ruYVmGYfG0S+HRMzcjTa?=
 =?us-ascii?Q?7TQ4bpDgZqZdBEx2nAI+0F/azgtx5P5R4dO4Ki0ci5uFbnCegoysl6eHls6s?=
 =?us-ascii?Q?Nd7KvRILN5SuGtonVGhyPgoZx/r3/APZq8hSqq9X+UAkUaFnd0ldh6GBq7Zf?=
 =?us-ascii?Q?d7jSvEtUSnyq5jdH27+WnXKyyTxDBv+OzBuB+PA6kjaWkaxhU5+8Jk1CXJqG?=
 =?us-ascii?Q?YU7yV9UYYinQVFmYmN5s+4hrRcc7SGFVCqg4TvN8Ml4lTiobjXJE0ONKcli1?=
 =?us-ascii?Q?cInTcZrb/8wgelXS/UYWSNpMV2pgmh9tCOr26VCoH2TYR5EVogBWYUDM+/m9?=
 =?us-ascii?Q?pIMYCTAimYaSu0MyK8r3xfCWTVZpzHgFrV/zbRvL4H5MDgbRO0pRj2WkHSMZ?=
 =?us-ascii?Q?I+vha0BivExwHImcGAsvsCh1WISHSbW0Lb2J23A2hgdHq027XXb9MiE8WuGj?=
 =?us-ascii?Q?RZ7FkPy60pI4HLvDjCuEHrQ5UO/e/NdpFC80zchhmmljtZcn1u0G1yl4f0Wi?=
 =?us-ascii?Q?LonGO7l5ww5b8JIkGwwzcZv6ZQy6sv56Pjuwj7/hMxLstTEm22ryVwPH7rbz?=
 =?us-ascii?Q?m2CaFw7dvULjR1L0lPcxM1jBcEaOJeTheA7jz0MeTnCmeZrKabCsmqkJ1zUZ?=
 =?us-ascii?Q?UQUNWxxVAG40gfIY3Ivc9Aw6zlEmzfP/04VTYrJ5m9ndfAOx/1Kf+/0myUwo?=
 =?us-ascii?Q?tl/yrmH6lNT69FVduGkcQYiPzHnhbjUIWYjLCwFGA+FMt10+E+bfqjKKIFRE?=
 =?us-ascii?Q?dYu0c8B3l96LKlTlKuayA9wxpfp+4UfPZAcfJQuqVAA6j70yQMc/h+CZsIwp?=
 =?us-ascii?Q?AWpuGa5xUBjKgkUk9vq144IQQrrTCJ/A4/DWVnuHgf5SFB9IYfsRkRYOTAJz?=
 =?us-ascii?Q?1xMg4zdJ7sQDcB16oXgmgPmyHAKll3OP/Whj/o1Cly24c+sgMz+K3r58CIAa?=
 =?us-ascii?Q?HuyfOOoY363F9yKu8AXOtALmyhIj3NlT14DTOHBkY91P5BcV624tgEulO+kx?=
 =?us-ascii?Q?/jV2kxCIcb6MpDLEdFSvmxC1kQbP2ujDwx+ORwyaw2xDily03HLSWu+XOWVO?=
 =?us-ascii?Q?3ya9xfnE7EihKoQWxzvTqolszFrJHvyQLLidZQyXUvt5+SH8FjYbf+HF01V4?=
 =?us-ascii?Q?Qygc+TIwF5mCle5JeCdoNbthbvNPQEyWW9zvhIIkNLqdhN7ffe+VIwCgRK0m?=
 =?us-ascii?Q?W6h8cdr46T1wXybVWXSTNTb33hgg18c=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2636bc06-90a0-4650-5458-08deff976de2
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:18:18.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KIa4XUbOWOozrO64zs0KUdY+vORNLv4IzYnRDNJLGHdYan0o7b4TAyk2KQY8uGXL/SbhzMPjqP8W/gv99rIBaF8y32Hn6+bqcBK2ZZJHu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8068

From: Sam Price <thesamprice@gmail.com>

setup_sigcontext() and restore_sigcontext() copy r0-r31, pc, ear, esr and
fsr to and from the signal frame but never touch MSR.  The interrupted
MSR is therefore dropped from the signal context entirely: the handler's
ucontext does not expose it, a handler cannot adjust the resumed
arithmetic flags through uc_mcontext.regs.msr, and -- because
restore_sigcontext() leaves regs->msr as whatever the rt_sigreturn trap
left in it -- the interrupted context resumes with the carry produced by
the syscall entry path (_user_exception does "addi r14, r14, 4", which
writes carry), not with its own.

Other architectures round-trip the user-visible flags through the signal
frame (arm's cpsr, csky's carry, x86's eflags), so a handler can both read
and adjust the resumed flags; purely privileged status registers such as
riscv's sstatus are left out.  MicroBlaze should do the same for the
user-writable bits.

Concretely, MSR[C] (carry) is lost across signal delivery.  Code that
keeps a live carry across a point where a signal can be delivered -- for
example an lwx/swx compare-and-swap retry loop, between the swx and the
carry test -- resumes with the handler's carry and mis-evaluates the
result; the same failure class as the rt_sigreturn r3/r4 clobber, reached
through a different register.  Demonstrated under qemu-system-microblazeel
(machine petalogix-s3adsp1800): a handler that sets MSR_C in
uc_mcontext.regs.msr has no effect before this change (0 of 132 in-window
signals propagated) and takes effect after (130 of 132).

Save MSR in setup_sigcontext() so the handler's ucontext exposes it.  The
signal frame is user-writable, so restore_sigcontext() must not restore it
verbatim: MicroBlaze packs the user-writable carry (MSR_C, MSR_CC) and the
privileged control bits (MSR_UM, MSR_VM, MSR_IE, MSR_EE, ...) into the one
register, and a verbatim restore would let userspace alter privileged
return state -- rtbd derives the resumed mode from MSR_UMS/MSR_VMS.
Restore only MSR_C | MSR_CC from the frame and keep the rest from the
current regs->msr.  This mirrors x86's
restore_sigcontext(), which masks the restored EFLAGS to FIX_EFLAGS for
the same reason; arches whose status register is purely privileged (e.g.
riscv sstatus) simply do not restore it at all.

Comment on the exposed MSR reworded: it is not read-only,
restore_sigcontext() applies MSR_C|MSR_CC from the frame.  Author's
Signed-off-by kept; he agreed to comment and changelog cleanups.

Fixes: 2148daa9c45f ("microblaze_v8: Signal support")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Price <thesamprice@gmail.com>
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/microblaze/kernel/signal.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index 4956014a9937..6bbc16f98d5e 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -33,6 +33,7 @@
 #include <linux/linkage.h>
 #include <linux/resume_user_mode.h>
 #include <asm/entry.h>
+#include <asm/registers.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -81,6 +82,22 @@ static int restore_sigcontext(struct pt_regs *regs,
 	COPY(pc);	COPY(ear);	COPY(esr);	COPY(fsr);
 #undef COPY
 
+	/*
+	 * The frame is user-writable, so restore only the user-writable
+	 * status flags (carry) and keep the kernel-controlled MSR bits
+	 * (UMS/VMS/IE/EE/...) from regs->msr: rtbd derives the resumed mode
+	 * from UMS/VMS, so a verbatim restore would hand userspace the
+	 * privileged return state.  Same idea as x86 masking the restored
+	 * EFLAGS to FIX_EFLAGS.
+	 */
+	{
+		unsigned long msr;
+
+		err |= __get_user(msr, &sc->regs.msr);
+		regs->msr = (regs->msr & ~(MSR_C | MSR_CC)) |
+			    (msr & (MSR_C | MSR_CC));
+	}
+
 	*rval_p = regs->r3;
 
 	return err;
@@ -140,6 +157,7 @@ setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	COPY(r26);	COPY(r27);	COPY(r28);	COPY(r29);
 	COPY(r30);	COPY(r31);
 	COPY(pc);	COPY(ear);	COPY(esr);	COPY(fsr);
+	COPY(msr);	/* restore_sigcontext() accepts only carry state */
 #undef COPY
 
 	err |= __put_user(mask, &sc->oldmask);
-- 
2.53.0

