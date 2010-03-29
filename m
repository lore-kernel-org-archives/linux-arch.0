Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:43328 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab0C2Cqn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Mar 2010 22:46:43 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v9 00/31] use lmb with x86
Date: Sun, 28 Mar 2010 19:42:53 -0700
Message-ID: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20100329024253.sFaVTs2yqXGxgpLPDmulTt7dvtGvhtxxWU_QpnBFLC8@z>

the new lmb could be used to early_res in x86.

Suggested by: David, Ben, and Thomas

First three patches should go into 2.6.34

-v6: change sequence as requested by Thomas
-v7: seperate them to more patches
-v8: add boundary checking to make sure not free partial page.
-v9: use lmb_debug to control print out of reserve_lmb.
     add e820 clean up, and e820 become __initdata

> size vmlinux.*
   text		   data	    bss		    dec		    hex	filename
20195694	4149812	12627536	36973042	23429f2	vmlinux.before_lmb_patchset
20198187	4163892	12614736	36976815	23438af	vmlinux.after_lmb_patchset

Before:
[   12.124431] Freeing unused kernel memory: 2740k freed
After:
[   11.514822] Freeing unused kernel memory: 2764k freed

So We move about 24k to .init

Please check

Thanks

Yinghai
