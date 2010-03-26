From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v8 00/24] use lmb with x86
Date: Fri, 26 Mar 2010 15:21:30 -0700
Message-ID: <1269642114-16588-1-git-send-email-yinghai@kernel.org>
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

Please check them.

Thanks

Yinghai
