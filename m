Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:37559 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755569AbXHBVxI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 17:53:08 -0400
Date: Thu, 2 Aug 2007 14:46:24 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Get rid of CONFIG_EXPERIMENTAL?
Message-ID: <20070802214624.GA31868@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I started down the route of (one patch at a time) removing the
EXPERIMENTAL dependency from some useful, not-so-new and
apparently-working things --- however, there are a lot of them.


I'd like to suggest we just kill CONFIG_EXPERIMENTAL completely?


I might argue:

  * if you're not sure what you're doing in the first place, you
    probably should be using a kernel from a distribution

  * so many useful things depend on EXPERIMENTAL already, I suspect
    pretty much everyone turns it on anyhow

  * many things marked EXPERIMENTAL probably shouldn't be

  * some things NOT marked EXPERIMENTAL probably deserve to be marked
    this way that many things that are not


So how about we do something like the patch below then over time we
can cleanup the Kconfig files so as not to be overly disruptive?


diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
diff --git a/init/Kconfig b/init/Kconfig
index 96b5459..f5d2009 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -10,35 +10,8 @@ config DEFCONFIG_LIST
 menu "General setup"
 
 config EXPERIMENTAL
-	bool "Prompt for development and/or incomplete code/drivers"
-	---help---
-	  Some of the various things that Linux supports (such as network
-	  drivers, file systems, network protocols, etc.) can be in a state
-	  of development where the functionality, stability, or the level of
-	  testing is not yet high enough for general use. This is usually
-	  known as the "alpha-test" phase among developers. If a feature is
-	  currently in alpha-test, then the developers usually discourage
-	  uninformed widespread use of this feature by the general public to
-	  avoid "Why doesn't this work?" type mail messages. However, active
-	  testing and use of these systems is welcomed. Just be aware that it
-	  may not meet the normal level of reliability or it may fail to work
-	  in some special cases. Detailed bug reports from people familiar
-	  with the kernel internals are usually welcomed by the developers
-	  (before submitting bug reports, please read the documents
-	  <file:README>, <file:MAINTAINERS>, <file:REPORTING-BUGS>,
-	  <file:Documentation/BUG-HUNTING>, and
-	  <file:Documentation/oops-tracing.txt> in the kernel source).
-
-	  This option will also make obsoleted drivers available. These are
-	  drivers that have been replaced by something else, and/or are
-	  scheduled to be removed in a future kernel release.
-
-	  Unless you intend to help test and develop a feature or driver that
-	  falls into this category, or you have a situation that requires
-	  using these features, you should probably say N here, which will
-	  cause the configurator to present you with fewer choices. If
-	  you say Y here, you will be offered the choice of using features or
-	  drivers that are currently considered to be in the alpha-test phase.
+	bool
+	default y
 
 config BROKEN
 	bool
