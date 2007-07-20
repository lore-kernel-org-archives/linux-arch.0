Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18040 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933878AbXGTQUU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jul 2007 12:20:20 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: build fix for x86_64...
Date: Fri, 20 Jul 2007 09:20:15 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01FA46A9@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070720085501.82715036.randy.dunlap@oracle.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>, Andi Kleen <ak@novell.com>
Cc: Arthur Jones <arthur.jones@qlogic.com>, Vasily Tarasov <vtaras@openvz.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Half dozens?

I was imagining having to have "help" messages ... which of course we don't.

> config COMPAT_FOR_U64_ALIGNMENT
> 	bool
> 	default y

Plausible.

Randy suggested:
>	def_bool y

Which is better.  But if we unconditionally set this CONFIG variable, then the
code in fs/quota.c will have to read:

#if defined(CONFIG_COMPAT) && defined(CONFIG_COMPAT_FOR_U64_ALIGNMENT)

We can keep it simpler if the Kconfig file does the conditional for us:

config COMPAT_FOR_U64_ALIGNMENT
	def_bool y
	depends on COMPAT

Then the patch looks like this:

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 36c7b96..36c1582 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -425,6 +425,10 @@ config COMPAT
 	depends on IA32_SUPPORT
 	default y
 
+config COMPAT_FOR_U64_ALIGNMENT
+	def_bool y
+	depends on COMPAT
+
 config IA64_MCA_RECOVERY
 	tristate "MCA recovery from errors other than TLB."
 
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 14bf8ce..c77510b 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -753,6 +753,10 @@ config COMPAT
 	depends on IA32_EMULATION
 	default y
 
+config COMPAT_FOR_U64_ALIGNMENT
+	def_bool y
+	depends on COMPAT
+
 config SYSVIPC_COMPAT
 	bool
 	depends on COMPAT && SYSVIPC
diff --git a/fs/quota.c b/fs/quota.c
index e6577ac..99b24b5 100644
--- a/fs/quota.c
+++ b/fs/quota.c
@@ -387,7 +387,7 @@ asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special, qid_t
 	return ret;
 }
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_IA64)
+#if defined(CONFIG_COMPAT_FOR_U64_ALIGNMENT)
 /*
  * This code works only for 32 bit quota tools over 64 bit OS (x86_64, ia64)
  * and is necessary due to alignment problems.
