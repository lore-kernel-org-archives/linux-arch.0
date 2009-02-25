From: arnd@arndb.de
Subject: [patch 0/7] Use strict kernel types to fix the world
Date: Thu, 26 Feb 2009 00:51:38 +0100
Message-ID: <20090225235138.062045835@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60074 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbZBZABv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:01:51 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

I've gone through the files again and fixed up all
non-strict types I could find. I did not check all
architectures for this though.

I split out netfilter, DRM and MTD, because of both
size and potentially controversial changes.

	Arnd <><
