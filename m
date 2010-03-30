From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v10 00/29] use lmb with x86
Date: Tue, 30 Mar 2010 04:19:34 -0700
Message-ID: <1269948003-17221-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:32513 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab0C3LVv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2010 07:21:51 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

the new lmb could be used to early_res in x86.

Suggested by: David, Ben, and Thomas

First one should go into 2.6.34

-v6: change sequence as requested by Thomas
-v7: seperate them to more patches
-v8: add boundary checking to make sure not free partial page.
-v9: use lmb_debug to control print out of reserve_lmb.
     add e820 clean up, and e820 become __initdata
-v10:use lmb.rmo_size and ARCH_DISCARD_LMB according to Michael
     change name to lmb_find_area/reserve_lmb_area/free_lmb_area, according to Michael
     update find_lmb_area to use __lmb_alloc_base according to ben

our orginal find_lmb_area is from low to high, but this __lmb_alloc_base is from
to low.

looks like it make bootmem have more segments

Please check

Thanks

Yinghai
