From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 02/13] EXPORT_SYMBOL() for asm
Date: Wed, 10 Feb 2016 17:15:07 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1602101659470.17825@knanqh.ubzr>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
 <1454534445-16759-2-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:24910 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcBJWPJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 17:15:09 -0500
In-reply-to: <1454534445-16759-2-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Feb 2016, Al Viro wrote:

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Add asm-usable variants of EXPORT_SYMBOL/EXPORT_SYMBOL_GPL.  This
> commit just adds the default implementation; most of the architectures
> can simply add export.h to asm/Kbuild and start using <asm/export.h>
> from assembler.  The rest needs to have their <asm/export.h> define
> everal macros and then explicitly include <asm-generic/export.h>
[...]

FYI, here's the needed changes to make it work with my autoksyms series. 
This is the asm/export.h version of http://lkml.org/lkml/2016/2/10/5.

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 03b51ac4cc..b450da9d68 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -59,8 +59,24 @@ KSYM(__kcrctab_\name):
 #endif
 .endm
 #undef __put
-#define EXPORT_SYMBOL(name) __EXPORT_SYMBOL name,KSYM_FUNC(KSYM(name))
-#define EXPORT_SYMBOL_GPL(name) __EXPORT_SYMBOL name,KSYM_FUNC(KSYM(name)),_gpl
-#define EXPORT_DATA_SYMBOL(name) __EXPORT_SYMBOL name,KSYM(name)
-#define EXPORT_DATA_SYMBOL_GPL(name) __EXPORT_SYMBOL name,KSYM(name),_gpl
+
+#ifdef CONFIG_TRIM_UNUSED_KSYMS
+#include <linux/kconfig.h>
+#include <generated/autoksyms.h>
+#define ___EXPORT_SYMBOL(name, val, sec) \
+	__cond_export_sym(name, val, sec, config_enabled(__KSYM_##name))
+#define __cond_export_sym(name, val, sec, conf) \
+	___cond_export_sym(name, val, sec, conf)
+#define ___cond_export_sym(name, val, sec, enabled) \
+	__cond_export_sym_##enabled(name, val, sec)
+#define __cond_export_sym_1(name, val, sec) __EXPORT_SYMBOL name, val, sec
+#define __cond_export_sym_0(name, val, sec) /* nothing */
+#else
+#define ___EXPORT_SYMBOL(name, val, sec) __EXPORT_SYMBOL name, val, sec
+#endif
+
+#define EXPORT_SYMBOL(name) ___EXPORT_SYMBOL(name,KSYM_FUNC(KSYM(name)),())
+#define EXPORT_SYMBOL_GPL(name) ___EXPORT_SYMBOL(name,KSYM_FUNC(KSYM(name)),_gpl)
+#define EXPORT_DATA_SYMBOL(name) ___EXPORT_SYMBOL(name,KSYM(name),())
+#define EXPORT_DATA_SYMBOL_GPL(name) ___EXPORT_SYMBOL(name,KSYM(name),_gpl)
 #endif
