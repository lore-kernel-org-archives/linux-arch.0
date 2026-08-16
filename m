Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40563D9041;
	Sun, 16 Aug 2026 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863252; cv=pass; b=evV3KMW35MXH/BHBrHC3GG7yRWptfrjCSh3c3BqKhcYpzKYR56qLMAauUchgc/1UVdQ4+QgDYcYtA3fWXhlsO8EVGlunCtLxrOfSWcWoOiYKKlTFCuyIRUoNrOSNZRY3jQbd0q3umgZxxh3d57vpqDDh/DIVVIxK1dZAh8RNUaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863252; c=relaxed/simple;
	bh=WjQThJ8gO8sfpYNGwMrkXYvCSFd28jCE4/k69wyOZxQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=fWswOD/dqfpJS0PEVDbUwrppLsruBhqbQnMB3F84iQdM0RnOJR0h3RkViRPqIsbDFPjixsqTubycYF+RKxv7LSQiPrnL1WW4GFxnW3OqneMx8w5a34iDk39MnEkse9EwWHX4lbwsJtnbft04I3unlEtJm2OSl9nQYr51Ypyfdn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=mQLGrlf5; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="mQLGrlf5"
ARC-Seal: i=1; a=rsa-sha256; t=1786863183; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Z0754RyPsl1uwvByj6XxD7TbetUmIZ6nGRRjmaiY0nsFZm0MILBQXKtfRlEOTxkL5T+ICDUzBgIPXpS+gee5j6Tpce9fqwFdfbmf+ORUAMTte47iohLpxTIDewkQTA+6gYbg2sq64bm4sOstm4Yxd9zLTzD1Vcwr0EqEFfh3USA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786863183; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1ztlF1tuaa5ZuP5+7XgtiHwhXw4SaAn02SAHAWNxcos=; 
	b=SZ89XaIXkwAOWGy+9uHkjyLUC5aGsvbiEhrtCMmsVP67nGxY0hiMSIitIkvuq6nmVbm+6ONDE8Mo+2xACTZD8NPLeFj/CtQoEJVPhKTLnyKs+8Usd9V4DiRFksoj9Agf3GDkfkoDgas3D122iKnu9b0ra0hB7SkfdeOqE/59qR0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786863183;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1ztlF1tuaa5ZuP5+7XgtiHwhXw4SaAn02SAHAWNxcos=;
	b=mQLGrlf5cbMMolRcqWviszHFF8YVFsz77oypG+mT3YP0vxZrFZBQu9bCS4IvraAJ
	eiOGfMTBuoMLSRC5ku5tZrCi63bAQj1rLNCRLZiCJ5tjZK2rPsFwnDdK74EYrMqZk4g
	RZswQ2+kSXLIU75MbwUo25jvRZwVP5RlYNnsdjcs=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1786863177930130.25535363176027; Sun, 16 Aug 2026 12:22:57 +0530 (IST)
Received: from  [152.57.162.68] by mail.zoho.in
	with HTTP;Sun, 16 Aug 2026 12:22:57 +0530 (IST)
Date: Sun, 16 Aug 2026 12:22:57 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "linux-arch" <linux-arch@vger.kernel.org>, "x86" <x86@kernel.org>,
	"tglx" <tglx@linutronix.de>, "mingo" <mingo@redhat.com>,
	"bp" <bp@alien8.de>, "davehansen" <dave.hansen@linux.intel.com>,
	"hpa" <hpa@zytor.com>
Message-ID: <1a0095850a2.420baa24109407.6360488265274002002@zohomail.in>
Subject: [PATCH] x86/mtrr/centaur: Fix MTRR validation for Winchip2 CPUs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From 7a4c00674c687e74e526d659fe864df2ff108719 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sun, 16 Aug 2026 06:50:03 +0000
Subject: [PATCH] x86/mtrr/centaur: Fix MTRR validation for Winchip2 CPUs

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 arch/x86/kernel/cpu/mtrr/centaur.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index 6f6c3ae92943..b82055d4e906 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -6,6 +6,7 @@
 #include <asm/msr.h>
 
 #include "mtrr.h"
+#include <linux/compiler.h>  /* for __maybe_unused */
 
 static struct {
 	unsigned long high;
@@ -45,7 +46,7 @@ centaur_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 	return -ENOSPC;
 }
 
-static void
+static void __maybe_unused
 centaur_get_mcr(unsigned int reg, unsigned long *base,
 		unsigned long *size, mtrr_type * type)
 {
@@ -61,7 +62,7 @@ centaur_get_mcr(unsigned int reg, unsigned long *base,
 		*type = MTRR_TYPE_WRBACK;
 }
 
-static void
+static void __maybe_unused
 centaur_set_mcr(unsigned int reg, unsigned long base,
 		unsigned long size, mtrr_type type)
 {
@@ -87,21 +88,26 @@ centaur_set_mcr(unsigned int reg, unsigned long base,
 	wrmsr(MSR_IDT_MCR0 + reg, low, high);
 }
 
-static int
+static int __maybe_unused
 centaur_validate_add_page(unsigned long base, unsigned long size, unsigned int type)
 {
-	/*
-	 * FIXME: Winchip2 supports uncached
-	 */
-	if (type != MTRR_TYPE_WRCOMB &&
-	    (centaur_mcr_type == 0 || type != MTRR_TYPE_UNCACHABLE)) {
-		pr_warn("mtrr: only write-combining%s supported\n",
-			   centaur_mcr_type ? " and uncacheable are" : " is");
-		return -EINVAL;
+	if (centaur_mcr_type == 0) {
+		/* Winchip2: supports both Write-Combining and Uncached */
+		if (type != MTRR_TYPE_WRCOMB && type != MTRR_TYPE_UNCACHABLE) {
+			pr_warn("mtrr: only write-combining and uncacheable supported\n");
+			return -EINVAL;
+		}
+	} else {
+		/* Other Centaur: only Write-Combining */
+		if (type != MTRR_TYPE_WRCOMB) {
+			pr_warn("mtrr: only write-combining supported\n");
+			return -EINVAL;
+		}
 	}
 	return 0;
 }
 
+/* The ops structure is used externally, so the compiler won't complain */
 const struct mtrr_ops centaur_mtrr_ops = {
 	.var_regs          = 8,
 	.set               = centaur_set_mcr,
-- 
2.42.0



