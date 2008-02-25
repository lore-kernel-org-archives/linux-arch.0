Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:63510 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753557AbYBYPpc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2008 10:45:32 -0500
Date: Mon, 25 Feb 2008 16:45:03 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: let __dec_zone_page_state use __dec_zone_state
Message-ID: <20080225154503.GA16223@digi.com>
References: <20080225132648.GA13791@digi.com> <20080225133846.GA9945@flint.arm.linux.org.uk> <20080225153208.GA15734@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080225153208.GA15734@digi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Christoph Lameter <clameter@sgi.com>

This removes code duplication and makes __dec_zone_page_state look like
__inc_zone_page_state.

Signed-off-by: Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
Cc: Christoph Lameter <clameter@sgi.com>
---
> IMHO the last hunk is worth to make it into mainstream.
So here comes the patch ...

Best regards
Uwe

 include/linux/vmstat.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 75370ec..9f1b4b4 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -246,8 +246,7 @@ static inline void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 static inline void __dec_zone_page_state(struct page *page,
 			enum zone_stat_item item)
 {
-	atomic_long_dec(&page_zone(page)->vm_stat[item]);
-	atomic_long_dec(&vm_stat[item]);
+	__dec_zone_state(page_zone(page), item);
 }
 
 /*
-- 
1.5.4.3

-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
