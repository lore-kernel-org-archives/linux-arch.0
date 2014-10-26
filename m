From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] all arches, signal: Move restart_block to struct task_struct
Date: Sun, 26 Oct 2014 11:11:41 -0700
Message-ID: <71A9FEBE-A07D-4DFE-BDF7-D6E9A60CEFF2@zytor.com>
References: <90d5683679179df27ffeef18c3e1010ed4e72695.1414342681.git.luto@amacapital.net> <20141026171819.GQ7996@ZenIV.linux.org.uk> <CALCETrW0pqGznCOEoFT3ttEkmqNmpZVaNu-FPb=RUB3D7k+aQg@mail.gmail.com> <20141026180938.GR7996@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36379 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbaJZSMQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 26 Oct 2014 14:12:16 -0400
In-Reply-To: <20141026180938.GR7996@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On x86 we have discussed to combine thread_info and task_struct into a single allocation with a percpu variable lining pointng at it.

On October 26, 2014 11:09:39 AM PDT, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>On Sun, Oct 26, 2014 at 10:36:45AM -0700, Andy Lutomirski wrote:
>
>> I never said it was the *only* juicy target, but we can fix the rest,
>> too.  Also, I suspect that overwriting task could be harder to
>> exploit.  First, you need to avoid crashing, and second, on systems
>> with SMAP or similar protection, you need to make task point
>somewhere
>> that contains a useful exploit payload.
>> 
>> We could probably get rid of thread_info's task pointer on x86, too
>--
>> it's not used by get_current() any more.
>
>Huh?  If you can overwrite that pointer, you can bloody well overwrite
>->task itself, making it point into the overwritten part of stack right
>next to thread_info.
>
>Again, on most of the architectures the _only_ way to reach task_struct
>is via thread_info:
>	* everything that uses asm-generic/current.h - arm, arm64, blackfin,
>c6x, hexagon, metag, mips, openrisc, sh, um, unicore32
>	* everything that should be using it - alpha, avr32, cris, m32r,
>parisc, score, tile.  These guys can simply add generic-y += current.h
>into their asm/Kbuild and remove asm/current.h.
>	* nearly the same situation - xtensa (there's an asm variant of
>the same thing + copy of asm-generic/current.h for C)
>	* sparc32
>	* m68k-noMMU
>	* mn10300-SMP
>
>It's a strong majority.  Check arch/*/asm/current.h and see for
>yourself.

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.
