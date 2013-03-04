From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] tile: work around bug in the generic sys_llseek
Date: Mon, 4 Mar 2013 12:45:57 -0500
Message-ID: <5134DDD5.50308@tilera.com>
References: <20130227194156.GQ4503@ZenIV.linux.org.uk> <201303041627.r24GR7Ql032052@farm-0021.internal.tilera.com> <20130304165410.GS4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:50746 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab3CDRp6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2013 12:45:58 -0500
In-Reply-To: <20130304165410.GS4503@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 3/4/2013 11:54 AM, Al Viro wrote:
> On Mon, Mar 04, 2013 at 11:19:09AM -0500, Chris Metcalf wrote:
>> sys_llseek should specify the high and low 32-bit seek values as "unsigned
>> int" but instead it specifies "unsigned long".  Since compat syscall
>> arguments are always sign-extended on tile, this means that a seek value
>> of 0xffffffff will be incorrectly interpreted as a value of -1ULL.
>>
>> To avoid the risk of breaking binary compatibility on architectures
>> that already use sys_llseek this way, we follow the same path as MIPS
>> and provide a wrapper override.
>>
>> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
>> Cc: stable@kernel.org [v3.6 onwards]
>> ---
>> Al Viro suggested changing the generic implementation but there has
>> been no followup, and his preference was just fixing tile anyway,
>> so this is what this patch does.  Al, can you ack this if it looks OK?
>> The generated code for compat_sys_llseek just clears the high 32 bits
>> of the two offset parameters and jumps to sys_llseek.
> That's not enough - the reason why mips variant works is that they
> use SYSCALL_DEFINE, which casts the sucker down to unsigned int.  Simply
> declaring it as something that takes unsigned int will just tell the
> compiler that upper bits of register are all zero, so it's free to pass
> the damn thing unchanged.

No, it actually works correctly for tile.  The reason is that "unsigned int" is represented, counter-intuitively, as a sign-extended 32-bit value.  (This lets us reuse some 64-bit comparison instructions for compat mode.)  So the compiler knows that if it is passing an unsigned int value to a function taking unsigned long, it must zero the high 32 bits explicitly.  I had the same concern about bypassing the SYSCALL_WRAPPER stuff, so I double-checked the generated code, and it's correct.

> Explicit cast down (for old versions) or use of COMPAT_SYSCALL_DEFINE would
> work; longer term I'd prefer to have something (select or explicit defines
> in asm/compat.h) telling whether we have a sign-extending or zero-extending
> biarch and have that COMPAT_SYSCALL_DEFINE in fs/read_write.c, under ifdef
> for arch being a sign-extender, but that's the next cycle fodder and can
> be done on top of minimal (and easier backportable) fix.

Yes, all that said, we should be using COMPAT_SYSCALL_DEFINE here.  Unfortunately it didn't exist in the code base where we first did the compat work (2.6.38) and I wasn't aware it had been added.  I'll post a followup patch switching things over to use COMPAT_SYSCALL_DEFINE, but I'd like to leave this patch as it is, since it makes it easier to backport the bug fix to previous releases.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
