Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail29.messagelabs.com ([216.82.249.147]:25506 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751237AbYBYN0y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2008 08:26:54 -0500
Date: Mon, 25 Feb 2008 14:26:48 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
Message-ID: <20080225132648.GA13791@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org

Hello,

I see the following:

	/ # for i in 1 2 3; do grep PageTables /proc/meminfo; done
	PageTables:          4 kB
	PageTables:   4294967292 kB
	PageTables:   4294967284 kB

and I bisected it down to 2f569af (CONFIG_HIGHPTE vs. sub-page page
tables.)  This still happens in 2.6.25-rc3.

I have not investigated further, so I cannot tell if it's only the
output in meminfo that is broken.

This is on ARCH=arm, on a Digi cc9p9360 with ns9xxx_defconfig.

Best regards
Uwe

-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
