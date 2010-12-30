Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:38150 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0L3ECy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2010 23:02:54 -0500
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id oBU42rBL023399
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:53 -0800
Received: from pvg12 (pvg12.prod.google.com [10.241.210.140])
	by wpaz29.hot.corp.google.com with ESMTP id oBU42prY003115
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:52 -0800
Received: by pvg12 with SMTP id 12so3717925pvg.40
        for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:51 -0800 (PST)
Date: Wed, 29 Dec 2010 20:02:49 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: [patch 6/8] init: rename CONFIG_EMBEDDED to CONFIG_EXPERT
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.00.1012292001250.27241@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101230040249.1VGgM562Fun_2HTWs6QKRvesOK628L-HFmBd8n6RzSo@z>

CONFIG_EMBEDDED has been renamed to CONFIG_EXPERT, so fix it in the net/
directory.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 net/mac80211/Kconfig |    6 +++---
 net/rfkill/Kconfig   |    4 ++--
 net/wireless/Kconfig |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -19,7 +19,7 @@ config MAC80211_HAS_RC
 	def_bool n
 
 config MAC80211_RC_PID
-	bool "PID controller based rate control algorithm" if EMBEDDED
+	bool "PID controller based rate control algorithm" if EXPERT
 	select MAC80211_HAS_RC
 	---help---
 	  This option enables a TX rate control algorithm for
@@ -27,14 +27,14 @@ config MAC80211_RC_PID
 	  rate.
 
 config MAC80211_RC_MINSTREL
-	bool "Minstrel" if EMBEDDED
+	bool "Minstrel" if EXPERT
 	select MAC80211_HAS_RC
 	default y
 	---help---
 	  This option enables the 'minstrel' TX rate control algorithm
 
 config MAC80211_RC_MINSTREL_HT
-	bool "Minstrel 802.11n support" if EMBEDDED
+	bool "Minstrel 802.11n support" if EXPERT
 	depends on MAC80211_RC_MINSTREL
 	default y
 	---help---
diff --git a/net/rfkill/Kconfig b/net/rfkill/Kconfig
--- a/net/rfkill/Kconfig
+++ b/net/rfkill/Kconfig
@@ -18,7 +18,7 @@ config RFKILL_LEDS
 	default y
 
 config RFKILL_INPUT
-	bool "RF switch input support" if EMBEDDED
+	bool "RF switch input support" if EXPERT
 	depends on RFKILL
 	depends on INPUT = y || RFKILL = INPUT
-	default y if !EMBEDDED
+	default y if !EXPERT
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -95,7 +95,7 @@ config CFG80211_DEBUGFS
 	  If unsure, say N.
 
 config CFG80211_INTERNAL_REGDB
-	bool "use statically compiled regulatory rules database" if EMBEDDED
+	bool "use statically compiled regulatory rules database" if EXPERT
 	default n
 	depends on CFG80211
 	---help---
