Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1KuC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Aug 2019 06:50:02 -0400
Date: Wed, 28 Aug 2019 12:49:51 +0200
From: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v3 06/11] export: allow definition default namespaces in
 Makefiles or sources
Message-ID: <20190828104951.GC25048@linux-8ccs>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-7-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821114955.12788-7-maennich@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthias Maennich <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@android.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20190828104951.qLQJ6VeUSNy_1tuArUbcugaQNtFTN3L-cMaPS1_04pw@z>

+++ Matthias Maennich [21/08/19 12:49 +0100]:
>To avoid excessive usage of EXPORT_SYMBOL_NS(sym, MY_NAMESPACE), where
>MY_NAMESPACE will always be the namespace we are exporting to, allow
>exporting all definitions of EXPORT_SYMBOL() and friends by defining
>DEFAULT_SYMBOL_NAMESPACE.
>
>For example, to export all symbols defined in usb-common into the
>namespace USB_COMMON, add a line like this to drivers/usb/common/Makefile:
>
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
>
>That is equivalent to changing all EXPORT_SYMBOL(sym) definitions to
>EXPORT_SYMBOL_NS(sym, USB_COMMON). Subsequently all symbol namespaces
>functionality will apply.
>
>Another way of making use of this feature is to define the namespace
>within source or header files similar to how TRACE_SYSTEM defines are
>used:
>  #undef DEFAULT_SYMBOL_NAMESPACE
>  #define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
>
>Please note that, as opposed to TRACE_SYSTEM, DEFAULT_SYMBOL_NAMESPACE
>has to be defined before including include/linux/export.h.
>
>If DEFAULT_SYMBOL_NAMESPACE is defined, a symbol can still be exported
>to another namespace by using EXPORT_SYMBOL_NS() and friends with
>explicitly specifying the namespace.

This changelog provides a good summary of how to use
DEFAULT_SYMBOL_NAMESPACE, I wonder if we should explicitly document
its proper usage somewhere? (along with EXPORT_SYMBOL_NS*)
The EXPORT_SYMBOL API is briefly documented in
Documentation/kernel-hacking/hacking.rst - it might be slightly dated,
but perhaps it'd fit there best?

>Suggested-by: Arnd Bergmann <arnd@arndb.de>
>Reviewed-by: Martijn Coenen <maco@android.com>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Matthias Maennich <maennich@google.com>
>---
> include/linux/export.h | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 8e12e05444d1..1fb243abdbc4 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -166,6 +166,12 @@ struct kernel_symbol {
> #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
> #endif
>
>+#ifdef DEFAULT_SYMBOL_NAMESPACE
>+#undef __EXPORT_SYMBOL
>+#define __EXPORT_SYMBOL(sym, sec)				\
>+	__EXPORT_SYMBOL_NS(sym, sec, DEFAULT_SYMBOL_NAMESPACE)
>+#endif
>+
> #define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
> #define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
> #define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
>-- 
>2.23.0.rc1.153.gdeed80330f-goog
>
