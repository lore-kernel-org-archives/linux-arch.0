From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Thu, 15 Dec 2011 15:58:46 -0800
Message-ID: <4EEA89B6.7030204@zytor.com>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <4EEA66A3.4010205@zytor.com> <5476903.m0O6cTqH9B@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43964 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab1LOX7A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Dec 2011 18:59:00 -0500
In-Reply-To: <5476903.m0O6cTqH9B@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On 12/15/2011 02:43 PM, Arnd Bergmann wrote:
> On Thursday 15 December 2011 13:29:07 H. Peter Anvin wrote:
>> On 12/13/2011 06:56 AM, David Howells wrote:
>>>  
>>> +#if BITS_PER_LONG == 32
>>>  #include <asm-generic/bitops/fls64.h>
>>> +#endif
>>>  
>>
>> This is outside __KERNEL__, and thus ends up changing what is exported
>> to userspace (specifically, fls64.h won't be included for 64-bit
>> non-__KERNEL__ anymore.)  Is this a bug?
> 
> Not sure, but I think it's a bug to use BITS_PER_LONG rather than
> __BITS_PER_LONG outside of __KERNEL__.
> 

Yes, it's one of many issues with this stuff.  After tracking down
things a bit further it looks like this was simply a conversion error in
checkin:

d57594c203b1 bitops: use __fls for fls64 on 64-bit archs

	-hpa
