From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 02/10] linker script: throw away .discard section
Date: Wed, 24 Jun 2009 10:20:17 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3A8C95D49@orsmsx505.amr.corp.intel.com>
References: <1245825924-30412-1-git-send-email-tj@kernel.org>
 <1245825924-30412-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45325 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163AbZFXRUQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2009 13:20:16 -0400
In-Reply-To: <1245825924-30412-3-git-send-email-tj@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Bryan Wu <cooloney@kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Chris Zankel <chris@zankel.net>

> x86 throws away .discard section but no other archs do.  Also,
> .discard is not thrown away while linking modules.  Make every arch
> and module linking throw it away.  This will be used to define dummy
> variables for percpu declarations and definitions.

Seems harmless on ia64.  Kernel still builds, boots and loads
modules.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
