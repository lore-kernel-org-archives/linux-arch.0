Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021074.outbound.protection.outlook.com [52.101.70.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFC43C7B9;
	Fri, 21 Aug 2026 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325514; cv=fail; b=GIFop0bgwBC6S55XJHPBOUVGzu8e75vLLUcSvMBxKlw+Bt9A19mKQ8jgGXDJ9P12yGuMDDXPFk4JFqdNKe+OlxhQBaUtlsmkSlk8cJmxOZCOzXmUAO80OyBcI/8qOH1QbvKhKtfoI111eb64sNV/CsWSB9ZUhAKw9NmoNeop1dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325514; c=relaxed/simple;
	bh=UkhpzA581tfmqu/7JerQCWjcupuF2Xa13yOGB6DY9os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7pII2I7n3WiAArCv2dCt+HWd3t6+pfw4P+KV6MMlYwtZD0WsgGOuqQjEJKSmf9yF1t3nC80qtWL4vKXR88e16244pLxsXaYyyebL/sH3j3MGv5c21SXf62ZEUtE+1wDTY2JaOb4ZTvtuHODaD830tIQ63CHimXA0Pm1tVWR5KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=k+Qv17AB; arc=fail smtp.client-ip=52.101.70.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="k+Qv17AB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKZNr6clToeHNPvxcTIxmpFS5qERK55EN3hdEQ+nRW4ZGtVruSC9MKE+3OEECjw+1LnUiARjUPpN1JUNlkUY+w7jn7qAv1ovU23XAJTYMK6RcjXah6ajVOhhW6E4kxHBXfRR2UgT8VPvQlGgGeZqA5rDizx5J2loG71eQEaRgCMSifFrc6HK7bgtMcjWps+OqeTSHtpS1sGuJwQzDUT7eRRM7ni/H9rCzFOBZwuHbcAJq0Zl+XuqYRXtFj/HvcWo5gXJsNniDNkS2HLwOHKF5aSpgDyMCZLm4/Cri/9haT1sPH46AG7q0RvFNqyzEl8+ElzSYMQxvVbysss4yXbsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqSydulCCnKytUwxLm2X25zQvimqY9O2KFuKA9EQrE4=;
 b=qeGYHkZuiU2NRuX3mct1TaGneF/EKgGAZ+7B9RwgW32r+HQh/Eh0rQcHcnNwhmmyoOy1WdCChjFT/Aa6Dnule6Kjjw/YxYrKUJKjTKzuUIetdthBc3J3aJC5pf8902OWnXdSavygeljvpUNVO4fAf9lt85Yy9JBArZnZLfE0x12Oll1JI/bLrWNV0bMtXAqm6KsC8sJmwjKatLzZcVtdHbHLmMxad9tGVvo9X8IR4yfeP5JBywPOZY3aLIHkMZRX2HJwr3tvEibsz5wnmXWXI/EhWmvGaL+y6PwcodLbEKMzgXlMofU10vAYCdDwfI9WA7lhM1TghucwmnP+5e9uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqSydulCCnKytUwxLm2X25zQvimqY9O2KFuKA9EQrE4=;
 b=k+Qv17ABvgicKL497N/McLJypZz6NkkC0s3+4yipCJ6mI5k4k9KGn2mzD5IyncPwVZIuLcHro5vL+gJaYVwPH2dNQQoH8/ZrWoYw44Vx/gUV0MOKZ5KV/8B9/TZns7R2Bx1BcuzKVFiH/0ZSwHvnl7vsFBFSDv0ybThF7cjYQ4R49eOx4axvpNox5jp5gCJNqkr3HAp5P/7FpyYt5MyKRdUhd/n4MoMPNVs/g/b40D1qHOIz6LjweQG8IfobL/ntjixiKmMlSUMFKi6LJAc8NkdMVXyLGDlUqgwugYCggom4ALJmRPio1exeGWUx8+lNTALoajkZVLpGasig91Azog==
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
Subject: [PATCH v3 4/5] microblaze: restore the ABI argument home area below pt_regs (PTO)
Date: Fri, 21 Aug 2026 17:18:08 +0200
Message-ID: <20260821151809.1233057-5-ramin.moussavi@yacoub.de>
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
X-MS-Office365-Filtering-Correlation-Id: 9c39d3a9-9d9d-45eb-60e3-08deff976d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1KgT1FjwL1urEa0XqNVSilMapZTlTcc5WqP4l/Z8I0mkUQuaz3MsQQkhyVnKZ+TD8+Tsk51aCPKU9q8jKFsH3u2hWFPkL/E8q47Ugr05R4cXIJi01y63GRTkoqQVQEIFTFvv6/ZXVu4UOQABeJCKtqHkX80ZFESkbjrNO/cQLS1gk2yE9B7BNoEx9fMowYdKReDOYVeYycem7lhbf+s6uOLOf/xhvfjLPnxj+dTOvtjoCPB72H+wk0L3XmDMGOIw33uco3oEjd5IMQk0hCJbo9Kw8WhORpqsdviexq/d21HjnbAxGcwl5yHOWQLAZTv17R42Ym0mcfBH29qCzMqUTJd41qBy13qZG1fAJjujEUF9lTKMLaTRCUIqZ8iKkHEQpK/0dNMLzsopaBIeC6PXk7Stykdjzb+Pp2jFBSVXKytTcN/MkK2yuCUi8WEjriw1Sj4m2JpewDizck0M66gLZgZeqaA8v1wsJN3npzU2hW0fm1dssKLHrNZfPlQkAUNtVMjSNRBmkXJsNQJLiU9yR4+pTpI1/R4BQg/HdQIbav9vhbjQnzLOW2GGRx9XmUXPqGFNtr5b+H4Ll6fWYcSReuR3WnkfzDIiqDb2wf0dcekQLUS07LyRv68v1qw0rozWkETCFzpr597c8Qla1PHaEDhOWn8SMvct+B94a1CsFeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQCw9sNZ5XRG+Dw1cNjtnMIFxQ2FrHKrxcPCeStd2U9x1oB9/b++YLtdA8f1?=
 =?us-ascii?Q?ftpAPyKsCoNRTSGNfXduCJHOJ7ZZEZ5vcwUEiIhIK6Np/Rk+p20iOFurn/Vl?=
 =?us-ascii?Q?3b8J0OttemSM5o+4BvjzQic6kUaS9S4wZwAXUQBK0aVaqLXTzlyeS34bYIau?=
 =?us-ascii?Q?hV5NAZEVkhzU/ShNfBRMaNtHcL1Zk9CMJgr60+CG9KHZVj4zgM8AzOJffPra?=
 =?us-ascii?Q?HXVaHJGGb5h64qbq/9Jh5Ajutys05G0U8taLEYZCTDtuFNamMNiUK8QPMjAJ?=
 =?us-ascii?Q?T4/JQ212mv/ddJGinO8rsWywAuW4hSKculUBG8UVTVF8zxuLksJZQ9QxiXfb?=
 =?us-ascii?Q?rmHH9GoRefwjAaYF5m54HQV8i0Hv1lJDRizhxWnh7dNQUE9a/OT+k/XSxvni?=
 =?us-ascii?Q?VLeCPwKK/za0XXq1Hjzmmm5yXDaNLgokKfxCGxSEBjJuevYAjF0rbd/6hzBM?=
 =?us-ascii?Q?rF8DviIdwjaODurjKui+AXwWTLEq4yLH3gWouRZYBUpF8cUyTIXCCFV6jZ/O?=
 =?us-ascii?Q?zKLvgEjTrL9TGHlGoHZqJ1OED3CiXO7S0nTGIKcjpxr1UMy5ZdX2kasKhQU+?=
 =?us-ascii?Q?54d7jPkBxVLjMT6Yh9ZJDIepm0uWlR/CNQ3zfinihSTzrjioNnRvb3SvLq2f?=
 =?us-ascii?Q?z8eIKJOMUfWvhr6gqV2PuTTnJNQawJYC8tprwxoxZqGuYkkrw5iKbhiozdeq?=
 =?us-ascii?Q?6YMSpf7vx90uGD1N8iQKB324YgnRDqJoadj7suzTl7OUcWcuN3adz9DPO5Wf?=
 =?us-ascii?Q?ZmaCHjSIJvDwPxzcmU5xIG5z/iXxUhmEXBtIrMzDEOjbxwUqQIrDx30BWE/B?=
 =?us-ascii?Q?8bwk6aydnVfra1iE9b0lK3VE7p5dOsQsDZeOvHsGIusCcR2isnmgtdxi2gY6?=
 =?us-ascii?Q?PE3IKkH6m9X1XgI5lujH239LhuZAx++k+jhEUzmx94Q+7Z/iy2eezUI003D6?=
 =?us-ascii?Q?COHx+Ddbgb7KfCqihrCDeSDRjzhthW6e8+vlEnvL3wTyDF0SMBxkKe1EVGFQ?=
 =?us-ascii?Q?F7m39QbxcP9AgcCsWokA+KhGYWXPusYe0mNMZ4j60z3clAUQD3T59xK52PZL?=
 =?us-ascii?Q?xBG+Wtp5FE2ssRiEHV+JSh1+ganU2Zinj6N9RAhH0B1kwscfwjTzEl9S8N8p?=
 =?us-ascii?Q?TvTpRTsme13HyDERgiF53NFKJAGW8sJn9PyGpl/6R0Cim4bBVuW02wCVhwo+?=
 =?us-ascii?Q?S9hgrMe9ugpHGMeyNfE0TkL/ufSmV5dBQd2RaXGxtafSYxqAFZBL429IrT8+?=
 =?us-ascii?Q?8tMnMonWrhI1RNW6U6eVi0S8sfPryHsgDuLmkotJTuo6UFQUbR2/8j2QskgO?=
 =?us-ascii?Q?cxnonKsmmp1R/nnS2llS9fW28toWnEhmQzZOPm8+nL55Sg05DKBIjHzBRUhJ?=
 =?us-ascii?Q?G7Q7yhpOLL88oumC/UUfaHP0isKC0xk7nvHiJmA2hZsnTs7JDwtBv/sX1PDC?=
 =?us-ascii?Q?nA2KXoh4478uULHjyCLqmXENfe/O6kelXqyr5rLLGVx7qehUzutMdVqjdW2x?=
 =?us-ascii?Q?8+muXocUyDRA3Z6SnSKexTySvXboAm/DsWFPrGG+s5DYoy7NWA9+/9WsD8Km?=
 =?us-ascii?Q?oClFvdGJiakgiKo8Jeyu3P5ps3lXIOjwxFuRNBgWe3lwCMzsWBpox+OfLjpJ?=
 =?us-ascii?Q?34w7uqTOOBT171i0V2R5gMmAIXdDQD60QMsEIh3RgFYw2TaWH6BIauVGWCAB?=
 =?us-ascii?Q?QrKtZ+yC3tLNKqO5JJZuekWTJ+jJW5XpDKas7ddpEuP3meftb8izSgLsuYSi?=
 =?us-ascii?Q?dPv2+tTZq4J8M/OUR4HaH73gxqP0LIM=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c39d3a9-9d9d-45eb-60e3-08deff976d95
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:18:17.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Fzv2//r2Lqum3MECnZiQim5jZ81YXvrdxr2aBI0B7i33PXW0TCorkJAo9zYCTOvshYJO+h1L0c2Asly46nujhIYRZQ26w5A/aencj7qwZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963

The MicroBlaze ABI has the caller reserve stack space for the arguments
it passes in registers: REG_PARM_STACK_SPACE is 24 and
OUTGOING_REG_PARM_STACK_SPACE is 1 in the gcc backend, so a callee may
write to [caller_sp + 4, caller_sp + 28).  The kernel calls C functions
from entry.S with r1 pointing at pt_regs, handing the callee license to
spill its incoming arguments over the saved registers -- the syscall
dispatch is the worst case, where the first argument slot is PT_R1, the
saved user stack pointer.

This was latent until GCC 15: since 3b9b8d6cfdf5 ("ira: Scale
save/restore costs of callee save registers with block frequency") the
allocator prefers spilling incoming arguments over copying them into
callee-saved registers, and a kernel built with gcc >= 15 (without the
TARGET_CALLEE_SAVE_COST workaround some distributions carry) corrupts
PT_R1 on the first syscall: init takes SIGSEGV and the kernel panics.

The kernel had exactly this reservation until 2011:
commit 6e83557c38b4 ("microblaze: Remove r0_ram pointer and PTO alignment")
removed STATE_SAVE_ARG_SPACE and with it the PTO offset, as part of
cleaning up what was thought to be copied-from-v850 leftovers.  Restore
it: the frame is STATE_SAVE_SIZE = PT_SIZE + PTO, r1 stays at the frame
base through every asm-to-C call, and the saved registers are reached
at r1 + PTO + PT_*.  PTO is 28 rather than the historic 24, which was
one word short: FIRST_PARM_OFFSET is 4 and REG_PARM_STACK_SPACE is 24,
so the area spans [sp+4, sp+28) and needs 28 bytes.  With 24 the last
argument slot overlapped pt_regs' r0 -- harmless only because r0 is the
constant-zero register.  STACK_BOUNDARY is 32 bits, so 28 needs no
further rounding.

Two places deliberately keep their mainline addressing.
hw_exception_handler.S needs no offset change: its real-mode handler
saves into the standalone pt_pool_space buffer rather than a stack
frame, and _unaligned_data_exception works through a pointer to pt_regs
in r7, where plain PT_* offsets are already right.  And the user-SP
reload after popping the frame keeps PT_R1 - PT_SIZE because PTO
cancels there: (PTO + PT_R1) - (PT_SIZE + PTO) = PT_R1 - PT_SIZE.  Both
are exactly as the pre-2011 code had them.

The instruction count is unchanged -- the same instructions with
different immediates, no per-call reservation and no trampolines.  The
cost is 28 bytes more kernel stack per saved frame.

Fixes: 6e83557c38b4 ("microblaze: Remove r0_ram pointer and PTO alignment")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/microblaze/include/asm/entry.h           |  13 +
 arch/microblaze/include/asm/processor.h       |   2 +-
 arch/microblaze/kernel/entry.S                | 329 +++++++++---------
 arch/microblaze/kernel/hw_exception_handler.S |   5 +
 arch/microblaze/kernel/process.c              |   5 +-
 5 files changed, 189 insertions(+), 165 deletions(-)

diff --git a/arch/microblaze/include/asm/entry.h b/arch/microblaze/include/asm/entry.h
index 9efadf12397c..05acf4d7bc4b 100644
--- a/arch/microblaze/include/asm/entry.h
+++ b/arch/microblaze/include/asm/entry.h
@@ -21,6 +21,19 @@
 
 #define PER_CPU(var) var
 
+/*
+ * The MicroBlaze ABI has the caller reserve an argument home area:
+ * REG_PARM_STACK_SPACE is 24 and OUTGOING_REG_PARM_STACK_SPACE is 1, so a
+ * callee may write to [caller_sp + 4, caller_sp + 28).  The kernel calls C
+ * with r1 at the frame base, so reserve that area below pt_regs and reach
+ * the saved registers through PTO.  This restores what 6e83557c38b4
+ * ("microblaze: Remove r0_ram pointer and PTO alignment") removed; the old
+ * value of 24 was one word short and left the last argument slot
+ * overlapping pt_regs' r0.
+ */
+#define PTO			28
+#define STATE_SAVE_SIZE		(PT_SIZE + PTO)
+
 # ifndef __ASSEMBLER__
 DECLARE_PER_CPU(unsigned int, KSP); /* Saved kernel stack pointer */
 DECLARE_PER_CPU(unsigned int, KM); /* Kernel/user mode */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index d59bdfffca7c..595c24db2728 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -73,7 +73,7 @@ unsigned long __get_wchan(struct task_struct *p);
 #  define task_regs(task) ((struct pt_regs *)task_tos(task) - 1)
 
 #  define task_pt_regs_plus_args(tsk) \
-	((void *)task_pt_regs(tsk))
+	(((void *)task_pt_regs(tsk)) - PTO)
 
 #  define task_sp(task)	(task_regs(task)->r1)
 #  define task_pc(task)	(task_regs(task)->pc)
diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index fea235f139d7..dfca6ce2d628 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -177,78 +177,78 @@ syscall_debug_table:
 1:
 
 #define SAVE_REGS \
-	swi	r2, r1, PT_R2;	/* Save SDA */			\
-	swi	r3, r1, PT_R3;					\
-	swi	r4, r1, PT_R4;					\
-	swi	r5, r1, PT_R5;					\
-	swi	r6, r1, PT_R6;					\
-	swi	r7, r1, PT_R7;					\
-	swi	r8, r1, PT_R8;					\
-	swi	r9, r1, PT_R9;					\
-	swi	r10, r1, PT_R10;					\
-	swi	r11, r1, PT_R11;	/* save clobbered regs after rval */\
-	swi	r12, r1, PT_R12;					\
-	swi	r13, r1, PT_R13;	/* Save SDA2 */			\
-	swi	r14, r1, PT_PC;	/* PC, before IRQ/trap */	\
-	swi	r15, r1, PT_R15;	/* Save LP */			\
-	swi	r16, r1, PT_R16;					\
-	swi	r17, r1, PT_R17;					\
-	swi	r18, r1, PT_R18;	/* Save asm scratch reg */	\
-	swi	r19, r1, PT_R19;					\
-	swi	r20, r1, PT_R20;					\
-	swi	r21, r1, PT_R21;					\
-	swi	r22, r1, PT_R22;					\
-	swi	r23, r1, PT_R23;					\
-	swi	r24, r1, PT_R24;					\
-	swi	r25, r1, PT_R25;					\
-	swi	r26, r1, PT_R26;					\
-	swi	r27, r1, PT_R27;					\
-	swi	r28, r1, PT_R28;					\
-	swi	r29, r1, PT_R29;					\
-	swi	r30, r1, PT_R30;					\
-	swi	r31, r1, PT_R31;	/* Save current task reg */	\
+	swi	r2, r1, PTO+PT_R2;	/* Save SDA */			\
+	swi	r3, r1, PTO+PT_R3;					\
+	swi	r4, r1, PTO+PT_R4;					\
+	swi	r5, r1, PTO+PT_R5;					\
+	swi	r6, r1, PTO+PT_R6;					\
+	swi	r7, r1, PTO+PT_R7;					\
+	swi	r8, r1, PTO+PT_R8;					\
+	swi	r9, r1, PTO+PT_R9;					\
+	swi	r10, r1, PTO+PT_R10;					\
+	swi	r11, r1, PTO+PT_R11;	/* save clobbered regs after rval */\
+	swi	r12, r1, PTO+PT_R12;					\
+	swi	r13, r1, PTO+PT_R13;	/* Save SDA2 */			\
+	swi	r14, r1, PTO+PT_PC;	/* PC, before IRQ/trap */	\
+	swi	r15, r1, PTO+PT_R15;	/* Save LP */			\
+	swi	r16, r1, PTO+PT_R16;					\
+	swi	r17, r1, PTO+PT_R17;					\
+	swi	r18, r1, PTO+PT_R18;	/* Save asm scratch reg */	\
+	swi	r19, r1, PTO+PT_R19;					\
+	swi	r20, r1, PTO+PT_R20;					\
+	swi	r21, r1, PTO+PT_R21;					\
+	swi	r22, r1, PTO+PT_R22;					\
+	swi	r23, r1, PTO+PT_R23;					\
+	swi	r24, r1, PTO+PT_R24;					\
+	swi	r25, r1, PTO+PT_R25;					\
+	swi	r26, r1, PTO+PT_R26;					\
+	swi	r27, r1, PTO+PT_R27;					\
+	swi	r28, r1, PTO+PT_R28;					\
+	swi	r29, r1, PTO+PT_R29;					\
+	swi	r30, r1, PTO+PT_R30;					\
+	swi	r31, r1, PTO+PT_R31;	/* Save current task reg */	\
 	mfs	r11, rmsr;		/* save MSR */			\
-	swi	r11, r1, PT_MSR;
+	swi	r11, r1, PTO+PT_MSR;
 
 #define RESTORE_REGS_GP \
-	lwi	r2, r1, PT_R2;	/* restore SDA */		\
-	lwi	r3, r1, PT_R3;					\
-	lwi	r4, r1, PT_R4;					\
-	lwi	r5, r1, PT_R5;					\
-	lwi	r6, r1, PT_R6;					\
-	lwi	r7, r1, PT_R7;					\
-	lwi	r8, r1, PT_R8;					\
-	lwi	r9, r1, PT_R9;					\
-	lwi	r10, r1, PT_R10;					\
-	lwi	r11, r1, PT_R11;	/* restore clobbered regs after rval */\
-	lwi	r12, r1, PT_R12;					\
-	lwi	r13, r1, PT_R13;	/* restore SDA2 */		\
-	lwi	r14, r1, PT_PC;	/* RESTORE_LINK PC, before IRQ/trap */\
-	lwi	r15, r1, PT_R15;	/* restore LP */		\
-	lwi	r16, r1, PT_R16;					\
-	lwi	r17, r1, PT_R17;					\
-	lwi	r18, r1, PT_R18;	/* restore asm scratch reg */	\
-	lwi	r19, r1, PT_R19;					\
-	lwi	r20, r1, PT_R20;					\
-	lwi	r21, r1, PT_R21;					\
-	lwi	r22, r1, PT_R22;					\
-	lwi	r23, r1, PT_R23;					\
-	lwi	r24, r1, PT_R24;					\
-	lwi	r25, r1, PT_R25;					\
-	lwi	r26, r1, PT_R26;					\
-	lwi	r27, r1, PT_R27;					\
-	lwi	r28, r1, PT_R28;					\
-	lwi	r29, r1, PT_R29;					\
-	lwi	r30, r1, PT_R30;					\
-	lwi	r31, r1, PT_R31;	/* Restore cur task reg */
+	lwi	r2, r1, PTO+PT_R2;	/* restore SDA */		\
+	lwi	r3, r1, PTO+PT_R3;					\
+	lwi	r4, r1, PTO+PT_R4;					\
+	lwi	r5, r1, PTO+PT_R5;					\
+	lwi	r6, r1, PTO+PT_R6;					\
+	lwi	r7, r1, PTO+PT_R7;					\
+	lwi	r8, r1, PTO+PT_R8;					\
+	lwi	r9, r1, PTO+PT_R9;					\
+	lwi	r10, r1, PTO+PT_R10;					\
+	lwi	r11, r1, PTO+PT_R11;	/* restore clobbered regs after rval */\
+	lwi	r12, r1, PTO+PT_R12;					\
+	lwi	r13, r1, PTO+PT_R13;	/* restore SDA2 */		\
+	lwi	r14, r1, PTO+PT_PC;	/* RESTORE_LINK PC, before IRQ/trap */\
+	lwi	r15, r1, PTO+PT_R15;	/* restore LP */		\
+	lwi	r16, r1, PTO+PT_R16;					\
+	lwi	r17, r1, PTO+PT_R17;					\
+	lwi	r18, r1, PTO+PT_R18;	/* restore asm scratch reg */	\
+	lwi	r19, r1, PTO+PT_R19;					\
+	lwi	r20, r1, PTO+PT_R20;					\
+	lwi	r21, r1, PTO+PT_R21;					\
+	lwi	r22, r1, PTO+PT_R22;					\
+	lwi	r23, r1, PTO+PT_R23;					\
+	lwi	r24, r1, PTO+PT_R24;					\
+	lwi	r25, r1, PTO+PT_R25;					\
+	lwi	r26, r1, PTO+PT_R26;					\
+	lwi	r27, r1, PTO+PT_R27;					\
+	lwi	r28, r1, PTO+PT_R28;					\
+	lwi	r29, r1, PTO+PT_R29;					\
+	lwi	r30, r1, PTO+PT_R30;					\
+	lwi	r31, r1, PTO+PT_R31;	/* Restore cur task reg */
 
 #define RESTORE_REGS \
-	lwi	r11, r1, PT_MSR;					\
+	lwi	r11, r1, PTO+PT_MSR;					\
 	mts	rmsr , r11;						\
 	RESTORE_REGS_GP
 
 #define RESTORE_REGS_RTBD \
-	lwi	r11, r1, PT_MSR;					\
+	lwi	r11, r1, PTO+PT_MSR;					\
 	andni	r11, r11, MSR_EIP;          /* clear EIP */             \
 	ori	r11, r11, MSR_EE | MSR_BIP; /* set EE and BIP */        \
 	mts	rmsr , r11;						\
@@ -265,11 +265,11 @@ syscall_debug_table:
 	lwi	r1, r0, TOPHYS(PER_CPU(ENTRY_SP));			\
 	/* FIXME: I can add these two lines to one */			\
 	/* tophys(r1,r1); */						\
-	/* addik	r1, r1, -PT_SIZE; */				\
-	addik	r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - PT_SIZE; \
+	/* addik	r1, r1, -STATE_SAVE_SIZE; */				\
+	addik	r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - STATE_SAVE_SIZE; \
 	SAVE_REGS							\
 	brid	2f;							\
-	swi	r1, r1, PT_MODE; 	 				\
+	swi	r1, r1, PTO+PT_MODE; 	 				\
 1:	/* User-mode state save.  */					\
 	lwi	r1, r0, TOPHYS(PER_CPU(CURRENT_SAVE)); /* get saved current */\
 	tophys(r1,r1);							\
@@ -277,12 +277,13 @@ syscall_debug_table:
 	/* MS these three instructions can be added to one */		\
 	/* addik	r1, r1, THREAD_SIZE; */				\
 	/* tophys(r1,r1); */						\
-	/* addik	r1, r1, -PT_SIZE; */			\
-	addik r1, r1, THREAD_SIZE + CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - PT_SIZE; \
+	/* addik	r1, r1, -STATE_SAVE_SIZE; */			\
+	addik r1, r1, THREAD_SIZE + CONFIG_KERNEL_BASE_ADDR		\
+		- CONFIG_KERNEL_START - STATE_SAVE_SIZE;		\
 	SAVE_REGS							\
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));			\
-	swi	r11, r1, PT_R1; /* Store user SP.  */		\
-	swi	r0, r1, PT_MODE; /* Was in user-mode.  */		\
+	swi	r11, r1, PTO+PT_R1; /* Store user SP.  */		\
+	swi	r0, r1, PTO+PT_MODE; /* Was in user-mode.  */		\
 	/* MS: I am clearing UMS even in case when I come from kernel space */ \
 	clear_ums; 							\
 2:	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
@@ -292,7 +293,7 @@ syscall_debug_table:
 .extern cpuinfo
 
 C_ENTRY(mb_flush_dcache):
-	addik	r1, r1, -PT_SIZE
+	addik	r1, r1, -STATE_SAVE_SIZE
 	SAVE_REGS
 
 	addik	r3, r0, cpuinfo
@@ -305,12 +306,12 @@ C_ENTRY(mb_flush_dcache):
 	addk	r9, r9, r8
 
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE
+	addik	r1, r1, STATE_SAVE_SIZE
 	rtsd	r15, 8
 	nop
 
 C_ENTRY(mb_invalidate_icache):
-	addik	r1, r1, -PT_SIZE
+	addik	r1, r1, -STATE_SAVE_SIZE
 	SAVE_REGS
 
 	addik	r3, r0, cpuinfo
@@ -323,7 +324,7 @@ C_ENTRY(mb_invalidate_icache):
 	addk	r9, r9, r8
 
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE
+	addik	r1, r1, STATE_SAVE_SIZE
 	rtsd	r15, 8
 	nop
 
@@ -350,18 +351,18 @@ C_ENTRY(_user_exception):
 	addik	r1, r1, THREAD_SIZE;
 	tophys(r1,r1);
 
-	addik	r1, r1, -PT_SIZE; /* Make room on the stack.  */
+	addik	r1, r1, -STATE_SAVE_SIZE; /* Make room on the stack.  */
 	SAVE_REGS
-	swi	r0, r1, PT_R3
-	swi	r0, r1, PT_R4
+	swi	r0, r1, PTO+PT_R3
+	swi	r0, r1, PTO+PT_R4
 
-	swi	r0, r1, PT_MODE;			/* Was in user-mode. */
+	swi	r0, r1, PTO+PT_MODE;			/* Was in user-mode. */
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
-	swi	r11, r1, PT_R1;		/* Store user SP.  */
+	swi	r11, r1, PTO+PT_R1;		/* Store user SP.  */
 	clear_ums;
 2:	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
 	/* Save away the syscall number.  */
-	swi	r12, r1, PT_R0;
+	swi	r12, r1, PTO+PT_R0;
 	tovirt(r1,r1)
 
 /* where the trap should return need -8 to adjust for rtsd r15, 8*/
@@ -380,18 +381,18 @@ C_ENTRY(_user_exception):
 	beqi	r11, 4f
 
 	addik	r3, r0, -ENOSYS
-	swi	r3, r1, PT_R3
+	swi	r3, r1, PTO+PT_R3
 	brlid	r15, do_syscall_trace_enter
-	addik	r5, r1, PT_R0
+	addik	r5, r1, PTO+PT_R0
 
 	# do_syscall_trace_enter returns the new syscall nr.
 	addk	r12, r0, r3
-	lwi	r5, r1, PT_R5;
-	lwi	r6, r1, PT_R6;
-	lwi	r7, r1, PT_R7;
-	lwi	r8, r1, PT_R8;
-	lwi	r9, r1, PT_R9;
-	lwi	r10, r1, PT_R10;
+	lwi	r5, r1, PTO+PT_R5;
+	lwi	r6, r1, PTO+PT_R6;
+	lwi	r7, r1, PTO+PT_R7;
+	lwi	r8, r1, PTO+PT_R8;
+	lwi	r9, r1, PTO+PT_R9;
+	lwi	r10, r1, PTO+PT_R10;
 4:
 /* Jump to the appropriate function for the system call number in r12
  * (r12 is not preserved), or return an error if r12 is not valid.
@@ -432,8 +433,8 @@ C_ENTRY(_user_exception):
 /* Entry point used to return from a syscall/trap */
 /* We re-enable BIP bit before state restore */
 C_ENTRY(ret_from_trap):
-	swi	r3, r1, PT_R3
-	swi	r4, r1, PT_R4
+	swi	r3, r1, PTO+PT_R3
+	swi	r4, r1, PTO+PT_R4
 /*
  * Entry point for returns that must not store r3/r4 back into pt_regs,
  * i.e. rt_sigreturn, which has already restored them from the signal
@@ -441,7 +442,7 @@ C_ENTRY(ret_from_trap):
  * so it stays correct if the number of stores above ever changes.
  */
 ret_from_trap_no_rval:
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 /* See if returning to kernel mode, if so, skip resched &c.  */
 	bnei	r11, 2f;
 	/* We're returning to user mode, so check for various conditions that
@@ -453,7 +454,7 @@ ret_from_trap_no_rval:
 	beqi	r11, 1f
 
 	brlid	r15, do_syscall_trace_leave
-	addik	r5, r1, PT_R0
+	addik	r5, r1, PTO+PT_R0
 1:
 	/* We're returning to user mode, so check for various conditions that
 	 * trigger rescheduling. */
@@ -472,7 +473,7 @@ ret_from_trap_no_rval:
 	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	add	r6, r30, r0;		/* Arg 2: int in_syscall */
 	add	r30, r0, r0		/* no more restarts */
@@ -484,7 +485,11 @@ ret_from_trap_no_rval:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
+	/*
+	 * Deliberately PT_SIZE, not STATE_SAVE_SIZE: r1 is back at the stack
+	 * top, so PTO cancels and the saved SP sits at PT_R1 - PT_SIZE.
+	 */
 	lwi	r1, r1, PT_R1 - PT_SIZE;/* Restore user stack pointer. */
 	bri	6f;
 
@@ -493,7 +498,7 @@ ret_from_trap_no_rval:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 	tovirt(r1,r1);
 6:
 TRAP_return:		/* Make global symbol for debugging */
@@ -534,7 +539,7 @@ C_ENTRY(sys_rt_sigreturn_wrapper):
 	 */
 	addik	r15, r0, ret_from_trap_no_rval - 8
 	brid	sys_rt_sigreturn	/* Do real work */
-	addik	r5, r1, 0;		/* add user context as 1st arg */
+	addik	r5, r1, PTO;		/* add user context as 1st arg */
 
 /*
  * HW EXCEPTION rutine start
@@ -545,7 +550,7 @@ C_ENTRY(full_exception_trap):
 	addik	r17, r17, -4
 	SAVE_STATE /* Save registers */
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* FIXME this can be store directly in PT_ESR reg.
 	 * I tested it but there is a fault */
@@ -555,7 +560,7 @@ C_ENTRY(full_exception_trap):
 	mfs	r7, rfsr;		/* save FSR */
 	mts	rfsr, r0;	/* Clear sticky fsr */
 	rted	r0, full_exception
-	addik	r5, r1, 0		 /* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		 /* parameter struct pt_regs * regs */
 
 /*
  * Unaligned data trap.
@@ -581,14 +586,14 @@ C_ENTRY(unaligned_data_trap):
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
 	SAVE_STATE		/* Save registers.*/
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* where the trap should return need -8 to adjust for rtsd r15, 8 */
 	addik	r15, r0, ret_from_exc-8
 	mfs	r3, resr		/* ESR */
 	mfs	r4, rear		/* EAR */
 	rtbd	r0, _unaligned_data_exception
-	addik	r7, r1, 0		/* parameter struct pt_regs * regs */
+	addik	r7, r1, PTO		/* parameter struct pt_regs * regs */
 
 /*
  * Page fault traps.
@@ -611,30 +616,30 @@ C_ENTRY(unaligned_data_trap):
 C_ENTRY(page_fault_data_trap):
 	SAVE_STATE		/* Save registers.*/
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* where the trap should return need -8 to adjust for rtsd r15, 8 */
 	addik	r15, r0, ret_from_exc-8
 	mfs	r6, rear		/* parameter unsigned long address */
 	mfs	r7, resr		/* parameter unsigned long error_code */
 	rted	r0, do_page_fault
-	addik	r5, r1, 0		/* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		/* parameter struct pt_regs * regs */
 
 C_ENTRY(page_fault_instr_trap):
 	SAVE_STATE		/* Save registers.*/
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* where the trap should return need -8 to adjust for rtsd r15, 8 */
 	addik	r15, r0, ret_from_exc-8
 	mfs	r6, rear		/* parameter unsigned long address */
 	ori	r7, r0, 0		/* parameter unsigned long error_code */
 	rted	r0, do_page_fault
-	addik	r5, r1, 0		/* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		/* parameter struct pt_regs * regs */
 
 /* Entry point used to return from an exception.  */
 C_ENTRY(ret_from_exc):
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;		/* See if returning to kernel mode, */
 					/* ... if so, skip resched &c.  */
 
@@ -666,7 +671,7 @@ C_ENTRY(ret_from_exc):
 	 * complete register state.  Here we save anything not saved by
 	 * the normal entry sequence, so that it may be safely restored
 	 * (in a possibly modified form) after do_notify_resume returns. */
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi	r6, r0, 0;		/* Arg 2: int in_syscall */
 	bri	1b
@@ -678,7 +683,7 @@ C_ENTRY(ret_from_exc):
 	tophys(r1,r1);
 
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 
 	lwi	r1, r1, PT_R1 - PT_SIZE; /* Restore user stack pointer. */
 	bri	6f;
@@ -687,7 +692,7 @@ C_ENTRY(ret_from_exc):
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 
 	tovirt(r1,r1);
 6:
@@ -720,10 +725,10 @@ C_ENTRY(_interrupt):
 	tophys(r1,r1); /* MS: I have in r1 physical address where stack is */
 	/* save registers */
 /* MS: Make room on the stack -> activation record */
-	addik	r1, r1, -PT_SIZE;
+	addik	r1, r1, -STATE_SAVE_SIZE;
 	SAVE_REGS
 	brid	2f;
-	swi	r1, r1, PT_MODE; /* 0 - user mode, 1 - kernel mode */
+	swi	r1, r1, PTO+PT_MODE; /* 0 - user mode, 1 - kernel mode */
 1:
 /* User-mode state save. */
  /* MS: get the saved current */
@@ -733,23 +738,23 @@ C_ENTRY(_interrupt):
 	addik	r1, r1, THREAD_SIZE;
 	tophys(r1,r1);
 	/* save registers */
-	addik	r1, r1, -PT_SIZE;
+	addik	r1, r1, -STATE_SAVE_SIZE;
 	SAVE_REGS
 	/* calculate mode */
-	swi	r0, r1, PT_MODE;
+	swi	r0, r1, PTO+PT_MODE;
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
-	swi	r11, r1, PT_R1;
+	swi	r11, r1, PTO+PT_R1;
 	clear_ums;
 2:
 	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
 	tovirt(r1,r1)
 	addik	r15, r0, irq_call;
 irq_call:rtbd	r0, do_IRQ;
-	addik	r5, r1, 0;
+	addik	r5, r1, PTO;
 
 /* MS: we are in virtual mode */
 ret_from_irq:
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;
 
 1:
@@ -765,7 +770,7 @@ ret_from_irq:
 5:	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqid	r11, no_intr_resched
 /* Handle a signal return; Pending signals should be in r18. */
-	addik	r5, r1, 0; /* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO; /* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi	r6, r0, 0; /* Arg 2: int in_syscall */
 	bri	1b
@@ -778,7 +783,7 @@ no_intr_resched:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE /* MS: Clean up stack space. */
+	addik	r1, r1, STATE_SAVE_SIZE /* MS: Clean up stack space. */
 	lwi	r1, r1, PT_R1 - PT_SIZE;
 	bri	6f;
 /* MS: Return to kernel state. */
@@ -801,7 +806,7 @@ restore:
 	VM_OFF /* MS: turn off MMU */
 	tophys(r1,r1)
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE	/* MS: Clean up stack space. */
+	addik	r1, r1, STATE_SAVE_SIZE	/* MS: Clean up stack space. */
 	tovirt(r1,r1);
 6:
 IRQ_return: /* MS: Make global symbol for debugging */
@@ -820,29 +825,29 @@ C_ENTRY(_xtmr_manager_reset):
 	lwi	r1, r0, xmb_manager_stackpointer
 
 	/* Restore MSR */
-	lwi	r2, r1, PT_MSR
+	lwi	r2, r1, PTO+PT_MSR
 	mts	rmsr, r2
 	bri	4
 
 	/* restore Special purpose registers */
-	lwi	r2, r1, PT_PID
+	lwi	r2, r1, PTO+PT_PID
 	mts	rpid, r2
 
-	lwi	r2, r1, PT_TLBI
+	lwi	r2, r1, PTO+PT_TLBI
 	mts	rtlbx, r2
 
-	lwi	r2, r1, PT_ZPR
+	lwi	r2, r1, PTO+PT_ZPR
 	mts	rzpr, r2
 
 #if CONFIG_XILINX_MICROBLAZE0_USE_FPU
-	lwi	r2, r1, PT_FSR
+	lwi	r2, r1, PTO+PT_FSR
 	mts	rfsr, r2
 #endif
 
 	/* restore all the tlb's */
 	addik	r3, r0, TOPHYS(tlb_skip)
-	addik	r6, r0, PT_TLBL0
-	addik	r7, r0, PT_TLBH0
+	addik	r6, r0, PTO+PT_TLBL0
+	addik	r7, r0, PTO+PT_TLBH0
 restore_tlb:
 	add	r6, r6, r1
 	add	r7, r7, r1
@@ -868,9 +873,9 @@ ret_from_reset:
 	VM_OFF
 	/* MS: Restore all regs */
 	RESTORE_REGS
-	lwi	r14, r1, PT_R14
-	lwi	r16, r1, PT_PC
-	addik	r1, r1, PT_SIZE + 36
+	lwi	r14, r1, PTO+PT_R14
+	lwi	r16, r1, PTO+PT_PC
+	addik	r1, r1, STATE_SAVE_SIZE + 36
 	rtbd	r16, 0
 	nop
 
@@ -885,11 +890,11 @@ C_ENTRY(_xmb_manager_break):
 	 * Reserve memory in the stack for context store/restore
 	 * (which includes memory for storing tlbs (max two tlbs))
 	 */
-	addik	r1, r1, -PT_SIZE - 36
+	addik	r1, r1, -STATE_SAVE_SIZE - 36
 	swi	r1, r0, xmb_manager_stackpointer
 	SAVE_REGS
-	swi	r14, r1, PT_R14	/* rewrite saved R14 value */
-	swi	r16, r1, PT_PC; /* PC and r16 are the same */
+	swi	r14, r1, PTO+PT_R14	/* rewrite saved R14 value */
+	swi	r16, r1, PTO+PT_PC; /* PC and r16 are the same */
 
 	lwi	r6, r0, TOPHYS(xmb_manager_baseaddr)
 	lwi	r7, r0, TOPHYS(xmb_manager_crval)
@@ -903,25 +908,25 @@ C_ENTRY(_xmb_manager_break):
 
 	/* Save the special purpose registers  */
 	mfs	r2, rpid
-	swi	r2, r1, PT_PID
+	swi	r2, r1, PTO+PT_PID
 
 	mfs	r2, rtlbx
-	swi	r2, r1, PT_TLBI
+	swi	r2, r1, PTO+PT_TLBI
 
 	mfs	r2, rzpr
-	swi	r2, r1, PT_ZPR
+	swi	r2, r1, PTO+PT_ZPR
 
 #if CONFIG_XILINX_MICROBLAZE0_USE_FPU
 	mfs	r2, rfsr
-	swi	r2, r1, PT_FSR
+	swi	r2, r1, PTO+PT_FSR
 #endif
 	mfs	r2, rmsr
-	swi	r2, r1, PT_MSR
+	swi	r2, r1, PTO+PT_MSR
 
 	/* Save all the tlb's */
 	addik	r3, r0, TOPHYS(tlb_skip)
-	addik	r6, r0, PT_TLBL0
-	addik	r7, r0, PT_TLBH0
+	addik	r6, r0, PTO+PT_TLBL0
+	addik	r7, r0, PTO+PT_TLBH0
 save_tlb:
 	add	r6, r6, r1
 	add	r7, r7, r1
@@ -978,28 +983,28 @@ C_ENTRY(_debug_exception):
 	lwi	r1, r0, TOPHYS(PER_CPU(ENTRY_SP)); /* Reload kernel stack-ptr*/
 
 	/* BIP bit is set on entry, no interrupts can occur */
-	addik   r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - PT_SIZE;
+	addik   r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - STATE_SAVE_SIZE;
 	SAVE_REGS;
 	/* save all regs to pt_reg structure */
-	swi	r0, r1, PT_R0;	/* R0 must be saved too */
-	swi	r14, r1, PT_R14	/* rewrite saved R14 value */
-	swi	r16, r1, PT_PC; /* PC and r16 are the same */
+	swi	r0, r1, PTO+PT_R0;	/* R0 must be saved too */
+	swi	r14, r1, PTO+PT_R14	/* rewrite saved R14 value */
+	swi	r16, r1, PTO+PT_PC; /* PC and r16 are the same */
 	/* save special purpose registers to pt_regs */
 	mfs	r11, rear;
-	swi	r11, r1, PT_EAR;
+	swi	r11, r1, PTO+PT_EAR;
 	mfs	r11, resr;
-	swi	r11, r1, PT_ESR;
+	swi	r11, r1, PTO+PT_ESR;
 	mfs	r11, rfsr;
-	swi	r11, r1, PT_FSR;
+	swi	r11, r1, PTO+PT_FSR;
 
 	/* stack pointer is in physical address at it is decrease
-	 * by PT_SIZE but we need to get correct R1 value */
-	addik   r11, r1, CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR + PT_SIZE;
-	swi	r11, r1, PT_R1
+	 * by STATE_SAVE_SIZE but we need to get correct R1 value */
+	addik   r11, r1, CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR + STATE_SAVE_SIZE;
+	swi	r11, r1, PTO+PT_R1
 	/* MS: r31 - current pointer isn't changed */
 	tovirt(r1,r1)
 #ifdef CONFIG_KGDB
-	addi	r5, r1, 0 /* pass pt_reg address as the first arg */
+	addi	r5, r1, PTO /* pass pt_reg address as the first arg */
 	addik	r15, r0, dbtrap_call; /* return address */
 	rtbd	r0, microblaze_kgdb_break
 	nop;
@@ -1015,16 +1020,16 @@ C_ENTRY(_debug_exception):
 	addik	r1, r1, THREAD_SIZE;	/* calculate kernel stack pointer */
 	tophys(r1,r1);
 
-	addik	r1, r1, -PT_SIZE; /* Make room on the stack.  */
+	addik	r1, r1, -STATE_SAVE_SIZE; /* Make room on the stack.  */
 	SAVE_REGS;
-	swi	r16, r1, PT_PC;	/* Save LP */
-	swi	r0, r1, PT_MODE; /* Was in user-mode.  */
+	swi	r16, r1, PTO+PT_PC;	/* Save LP */
+	swi	r0, r1, PTO+PT_MODE; /* Was in user-mode.  */
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
-	swi	r11, r1, PT_R1; /* Store user SP.  */
+	swi	r11, r1, PTO+PT_R1; /* Store user SP.  */
 	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
 	tovirt(r1,r1)
 	set_vms;
-	addik	r5, r1, 0;
+	addik	r5, r1, PTO;
 	addik	r15, r0, dbtrap_call;
 dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 	rtbd	r0, sw_exception
@@ -1032,7 +1037,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 
 	/* MS: The first instruction for the second part of the gdb/kgdb */
 	set_bip; /* Ints masked for state restore */
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;
 /* MS: Return to user space - gdb */
 1:
@@ -1051,7 +1056,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 5:	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi  r6, r0, 0;	/* Arg 2: int in_syscall */
 	bri	1b
@@ -1062,7 +1067,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 	tophys(r1,r1);
 	/* MS: Restore all regs */
 	RESTORE_REGS_RTBD
-	addik	r1, r1, PT_SIZE	 /* Clean up stack space */
+	addik	r1, r1, STATE_SAVE_SIZE	 /* Clean up stack space */
 	lwi	r1, r1, PT_R1 - PT_SIZE; /* Restore user stack pointer */
 DBTRAP_return_user: /* MS: Make global symbol for debugging */
 	rtbd	r16, 0; /* MS: Instructions to return from a debug trap */
@@ -1073,9 +1078,9 @@ DBTRAP_return_user: /* MS: Make global symbol for debugging */
 	tophys(r1,r1);
 	/* MS: Restore all regs */
 	RESTORE_REGS_RTBD
-	lwi	r14, r1, PT_R14;
-	lwi	r16, r1, PT_PC;
-	addik	r1, r1, PT_SIZE; /* MS: Clean up stack space */
+	lwi	r14, r1, PTO+PT_R14;
+	lwi	r16, r1, PTO+PT_PC;
+	addik	r1, r1, STATE_SAVE_SIZE; /* MS: Clean up stack space */
 	tovirt(r1,r1);
 DBTRAP_return_kernel: /* MS: Make global symbol for debugging */
 	rtbd	r16, 0; /* MS: Instructions to return from a debug trap */
@@ -1173,7 +1178,7 @@ ENTRY(_switch_to)
 .ent xmb_inject_err
 .type xmb_inject_err, @function
 xmb_inject_err:
-	addik	r1, r1, -PT_SIZE
+	addik	r1, r1, -STATE_SAVE_SIZE
 	SAVE_REGS
 
 	/* Switch to real mode */
@@ -1197,7 +1202,7 @@ xmb_inject_err:
 	nop;
 1:
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE
+	addik	r1, r1, STATE_SAVE_SIZE
 	rtsd	r15, 8;
 	nop;
 .end xmb_inject_err
diff --git a/arch/microblaze/kernel/hw_exception_handler.S b/arch/microblaze/kernel/hw_exception_handler.S
index 07ea23965f81..4693916be526 100644
--- a/arch/microblaze/kernel/hw_exception_handler.S
+++ b/arch/microblaze/kernel/hw_exception_handler.S
@@ -313,6 +313,11 @@ _MB_HW_ExceptionVectorTable:
 .align 4
 .ent _hw_exception_handler
 _hw_exception_handler:
+	/*
+	 * This handler saves into the static pt_pool_space buffer, not into a
+	 * stack frame, so the plain PT_* offsets are right here -- do not add
+	 * the PTO of entry.S's frames.
+	 */
 	swi	r1, r0, TOPHYS(pt_pool_space + PT_R1); /* GET_SP */
 	/* Save date to kernel memory. Here is the problem
 	 * when you came from user space */
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 6cbf642d7b80..090e1697ea7a 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/ptrace.h>
 #include <asm/cacheflush.h>
+#include <asm/entry.h>
 
 void show_regs(struct pt_regs *regs)
 {
@@ -65,7 +66,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
 		memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
-		ti->cpu_context.r1  = (unsigned long)childregs;
+		ti->cpu_context.r1  = (unsigned long)childregs - PTO;
 		ti->cpu_context.r20 = (unsigned long)args->fn;
 		ti->cpu_context.r19 = (unsigned long)args->fn_arg;
 		childregs->pt_mode = 1;
@@ -79,7 +80,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->r1 = usp;
 
 	memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
-	ti->cpu_context.r1 = (unsigned long)childregs;
+	ti->cpu_context.r1 = (unsigned long)childregs - PTO;
 	childregs->msr |= MSR_UMS;
 
 	/* we should consider the fact that childregs is a copy of the parent
-- 
2.53.0

