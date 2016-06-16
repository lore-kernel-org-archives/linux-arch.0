From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Thu, 16 Jun 2016 21:18:06 +0200
Message-ID: <87vb19oscx.fsf@linux-m68k.org>
References: <20160531102642.333689893@infradead.org>
	<CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com>
	<20160616101309.GD30921@twins.programming.kicks-ass.net>
	<mvmk2hpxq1a.fsf@hawking.suse.de>
	<20160616124949.GF30921@twins.programming.kicks-ass.net>
	<mvma8ilxpl6.fsf@hawking.suse.de>
	<20160616143530.GG30921@twins.programming.kicks-ass.net>
	<mvma8ilw66n.fsf@hawking.suse.de>
	<20160616145653.GH30921@twins.programming.kicks-ass.net>
	<mvm4m8tw4xz.fsf@hawking.suse.de>
	<20160616174421.GK30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50791 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcFPTSU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2016 15:18:20 -0400
In-Reply-To: <20160616174421.GK30921@twins.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Thu, 16 Jun 2016 19:44:21 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>Ja

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jun 16, 2016 at 05:04:24PM +0200, Andreas Schwab wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>> > If not, do you want me to 'fix' this or just remove the comment?
>> 
>> It's not broken, so nothing to fix.
>
> Its non obvious code, that's usually plenty reason to change it.

You appear to be the only one who has a problem with that documented
construct.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
