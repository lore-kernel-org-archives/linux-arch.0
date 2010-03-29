From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v9 00/31] use lmb with x86
Date: Sun, 28 Mar 2010 19:42:53 -0700
Message-ID: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

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
