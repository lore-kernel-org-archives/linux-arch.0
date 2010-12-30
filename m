Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9809 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab0L3EC7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2010 23:02:59 -0500
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id oBU42uu0010553
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:57 -0800
Received: from pxi17 (pxi17.prod.google.com [10.243.27.17])
	by wpaz17.hot.corp.google.com with ESMTP id oBU42s9l030999
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:55 -0800
Received: by pxi17 with SMTP id 17so2188892pxi.6
        for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:54 -0800 (PST)
Date: Wed, 29 Dec 2010 20:02:52 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: [patch 7/8] lib: rename CONFIG_EMBEDDED to CONFIG_EXPERT
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.00.1012292001430.27241@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101230040252.-PrtE5IWBJvqminJEIG0SU1FrQJo19Ibcteakbr4akE@z>

CONFIG_EMBEDDED has been renamed to CONFIG_EXPERT, so fix it in the lib/
directory.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 lib/Kconfig.debug |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -656,7 +656,7 @@ config DEBUG_HIGHMEM
 	  Disable for production systems.
 
 config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
+	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
 	depends on BUG
 	depends on ARM || AVR32 || M32R || M68K || SPARC32 || SPARC64 || \
 		   FRV || SUPERH || GENERIC_BUG || BLACKFIN || MN10300
@@ -728,8 +728,8 @@ config DEBUG_WRITECOUNT
 	  If unsure, say N.
 
 config DEBUG_MEMORY_INIT
-	bool "Debug memory initialisation" if EMBEDDED
-	default !EMBEDDED
+	bool "Debug memory initialisation" if EXPERT
+	default !EXPERT
 	help
 	  Enable this for additional checks during memory initialisation.
 	  The sanity checks verify aspects of the VM such as the memory model
