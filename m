Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34378 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933461AbcH2NyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2016 09:54:10 -0400
MIME-Version: 1.0
In-Reply-To: <20160829134604.GT10153@twins.programming.kicks-ass.net>
References: <1472362755-26776-1-git-send-email-chengang@emindsoft.com.cn>
 <201608291503.41630.arnd@arndb.de> <20160829134604.GT10153@twins.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Aug 2016 15:54:07 +0200
Message-ID: <CAMuHMdW35Ec8G=jeOBLuHH4fqnFZeNZRFyydJ8NqSYRjPdTc0A@mail.gmail.com>
Subject: Re: [PATCH] arch: all: include: asm: bitops: Use bool instead of int
 for all bit test functions
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, chengang@emindsoft.com.cn, Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, gi-oh.kim@profitbricks.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, hillf.zj@alibaba-inc.com, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, cmetcalf@mellanox.com, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Noam Camus <noamc@ezchip.com>, brueckner@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Chen Gang <gang.chen.5i5j@gmail.com>
Message-ID: <20160829135407.CO362xxkONupyyTHQe3tSWzEsA0zR9OnZoEPW_X7Obs@z>

On Mon, Aug 29, 2016 at 3:46 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Aug 29, 2016 at 03:03:41PM +0200, Arnd Bergmann wrote:
>> - Change the Documentation/atomic_ops.txt file accordingly
>
> Not sure that really matters; that document is so out of date its nearly
> useless :-(
>
> Rewriting it is somewhere on the TODO list...

Resphinxing?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
