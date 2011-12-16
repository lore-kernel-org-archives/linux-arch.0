From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Fri, 16 Dec 2011 07:27:25 -0800
Message-ID: <4EEB635D.2050508@zytor.com>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <5476903.m0O6cTqH9B@wuerfel> <4EEA89B6.7030204@zytor.com> <201112161357.14463.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49019 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759872Ab1LPP1o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Dec 2011 10:27:44 -0500
In-Reply-To: <201112161357.14463.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On 12/16/2011 05:57 AM, Arnd Bergmann wrote:
>>
>> Yes, it's one of many issues with this stuff.  After tracking down
>> things a bit further it looks like this was simply a conversion error in
>> checkin:
>>
>> d57594c203b1 bitops: use __fls for fls64 on 64-bit archs
> 
> Hmm, I also looked a bit closer and noticed that we don't actually
> export any bitops headers to user space, so any use of __KERNEL__ in
> those headers is bogus, but I don't think there is an actual bug here.
> 

That whole thing probably wants to be cleaned up, then.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
