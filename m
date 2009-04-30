From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/9] more non-ABI asm-generic headers
Date: Thu, 30 Apr 2009 20:56:28 +0200
Message-ID: <20090430185628.866082445@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58140 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbZD3TC4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2009 15:02:56 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>

I reviewed my patches again after input from David Miller and
others, hopefully I have found a way to send out patches again.
This series is much smaller now, I consolidated some patches
according to logic grouping, and left out the microblaze
stuff, which is probably just boring everyone except Michal.

This should fix the broken From: and Date: headers in the
mail, which caused problems, while the contents are unchanged
from my earlier submission.

	Arnd <><
