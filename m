From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 13:19:45 -0400 (EDT)
Message-ID: <20120523.131945.2252661917404305647.davem@davemloft.net>
References: <20120523.014627.497058725671088241.davem@davemloft.net>
	<CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
	<1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:60264 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab2EWRUx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 13:20:53 -0400
In-Reply-To: <1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James.Bottomley@HansenPartnership.com
Cc: geert@linux-m68k.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 23 May 2012 10:40:25 +0100

> On Wed, 2012-05-23 at 10:02 +0200, Geert Uytterhoeven wrote:
>> On Wed, May 23, 2012 at 7:46 AM, David Miller <davem@davemloft.net> wrote:
>> > [PATCH] sparc: Add full proper error handling to strncpy_from_user().
>> >
>> > Linus removed the end-of-address-space hackery from
>> > fs/namei.c:do_getname() so we really have to validate these edge
>> > conditions and cannot cheat any more (as x86 used to as well).
>> >
>> > Move to a common C implementation like x86 did.  And if both
>> > src and dst are sufficiently aligned we'll do word at a time
>> > copies and checks as well.
>> 
>> Now everybody is rewriting this in plain C, perhaps it make sense to
>> have it in lib/, so I don't have to write anything myself?
> 
> I think the sparc version will work for everybody (it will certainly
> work on parisc).  The only thing that might be necessary is to add these
> guards:
> 
> 
> #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>        if (((long) dst | (long) src) & (sizeof(long) - 1))
>                goto byte_at_a_time;
> #endif
> 
> Dave, did you want to add it to lib/ ?

Yes, but if so, the fixed version which I already pushed out to the
sparc tree :-)

But frankly this was only a temporary measure, I intend to put this
back into assembler so I can optimize it properly, I was just too
lazy to do so right now and wanted this bug fixed.
