From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/10] sparc64: fix build breakage introduced by percpu-convert-most
 patchset
Date: Wed, 24 Jun 2009 17:03:50 +0900
Message-ID: <4A41DDE6.1090209@kernel.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59515 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbZFXIEZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Jun 2009 04:04:25 -0400
In-Reply-To: <1245825924-30412-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org

Commit e74e396204bfcb67570ba4517b08f5918e69afea incorrectly added
added HAVE_LEGACY_PER_CPU_AREA to sparc64 although it already has been
converted to dynamic percpu allocator.  Drop both
HAVE_{LEGACY|DYNAMIC}_PER_CPU_AREA.

[ Impact: fix build breakage ]

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Miller <davem@davemloft.net>
---
This patch fixes build breakage caused by changed patch apply order.
Thanks.

 arch/sparc/Kconfig |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7a8698b..4f6ed0f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -92,15 +92,9 @@ config AUDIT_ARCH
 	bool
 	default y
 
-config HAVE_LEGACY_PER_CPU_AREA
-	def_bool y if SPARC64
-
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y if SPARC64
 
-config HAVE_DYNAMIC_PER_CPU_AREA
-	def_bool y if SPARC64
-
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	bool
 	def_bool y if SPARC64
-- 
1.6.0.2
