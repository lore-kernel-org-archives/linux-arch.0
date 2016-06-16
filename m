From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Thu, 16 Jun 2016 21:55:05 +0200
Message-ID: <CAMuHMdXxw23dUpSgQRZz0XO=4tx-ZEbpmjfx3ivHqL8Qx0vn9g@mail.gmail.com>
References: <20160531102642.333689893@infradead.org> <CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com>
 <20160616101309.GD30921@twins.programming.kicks-ass.net> <mvmk2hpxq1a.fsf@hawking.suse.de>
 <20160616124949.GF30921@twins.programming.kicks-ass.net> <mvma8ilxpl6.fsf@hawking.suse.de>
 <20160616143530.GG30921@twins.programming.kicks-ass.net> <mvma8ilw66n.fsf@hawking.suse.de>
 <20160616145653.GH30921@twins.programming.kicks-ass.net> <mvm4m8tw4xz.fsf@hawking.suse.de>
 <20160616174421.GK30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33556 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbcFPTzH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2016 15:55:07 -0400
In-Reply-To: <20160616174421.GK30921@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>James

Hi Peter,

On Thu, Jun 16, 2016 at 7:44 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Jun 16, 2016 at 05:04:24PM +0200, Andreas Schwab wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>> > If not, do you want me to 'fix' this or just remove the comment?
>>
>> It's not broken, so nothing to fix.
>
> Its non obvious code, that's usually plenty reason to change it.
>
> Geert, you maintain this stuff, what say you? Is there still a good
> reason (like supporting ancient compilers that don't do "+d" for
> example) to keep the code as is?

I don't know when support for "+d" was introduced.
But given people regularly use old compilers, I'm not inclined to change it,
unless there's a very good reason.

BTW, what's the failure mode if an old compiler not supporting "+d"
encounters it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
