From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: subtle side effect of  commit a1c48bb160f836
Date: Thu, 18 Jun 2015 12:17:02 +0530
Message-ID: <55826966.6050202@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56478 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbFRGzo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2015 02:55:44 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Michal Marek <mmarek@suse.cz>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hi Geert,

commit a1c48bb160f8368 "Makefile: Fix unrecognized cross-compiler command line
options" moved ARCH specific cc option handling before common -Os/O2 setup.

For ARC this had a subtle effect that we can no longer over-ride generic -O2 with
-O3, hence a performance regression observed going from 3.13 to 3.18 (the above
commit went into 3.16)

I want to understand how to properly fix this. Moving the include of arch makefile
will bring back the old issue. I can introduce another option to set default optim
level, but only arc/m32r care about it anyways.

Thx,
-Vineet
