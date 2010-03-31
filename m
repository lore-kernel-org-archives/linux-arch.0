From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 25/33] x86, lmb: turn off ARCH_LMB_FIND_AREA
Date: Tue, 30 Mar 2010 19:17:10 -0700
Message-ID: <1270001838-15857-26-git-send-email-yinghai@kernel.org>
References: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

32bit now can use generic __find_lmb_area now. So we can turn arch one off

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1aa53ae..ce097ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -584,7 +584,7 @@ config PARAVIRT_DEBUG
 	  a paravirt_op is missing when it is called.
 
 config ARCH_LMB_FIND_AREA
-	default y
+	default n
 	bool "Use x86 own lmb_find_area()"
 	---help---
 	  Use lmb_find_area() version instead of generic version, it get free
-- 
1.6.4.2
