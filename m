From: Tejun Heo <tj@kernel.org>
Subject: linux-next: inclusion request for temporary memblock testing branch
Date: Mon, 5 Dec 2011 13:04:05 -0800
Message-ID: <20111205210405.GK627@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46456 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab1LEVEW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2011 16:04:22 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sfr@canb.auug.org.au
Cc: mingo@elte.hu, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com, benh@kernel.crashing.org

Hello, Stephen.

Can you please include the following branch into linux-next?

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git memblock-kill-early_node_map

This eventually will go through tip/ but Ingo wants it to be tested a
bit before proceeding.

  http://thread.gmane.org/gmane.linux.kernel.cross-arch/11566/focus=1224459

Pulling it into linux-next creates conflicts in three files -
arch/arm/mm/init.c, arch/mips/Kconfig, arch/score/Kconfig.  All
conflicts are trivial.  Both parties try to add something and
combination of the two work fine.  The following branch contains
merged branch for reference.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git memblock-kill-early_node_map-next

allno/modconfig on x86 compile tested.  My randomish test kernel seems
to work fine too.  I tested building on different archs on good part
of the archs on first posting but my cross build setup is sorta
screwed now and couldn't get much done this time but there hasn't been
any substantial change since the first posting.  I'm planning on
getting the cross build env back up soonish once moving is complete.

Thank you.

-- 
tejun
