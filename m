From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare
 for x32
Date: Wed, 22 Feb 2012 10:14:30 -0800
Message-ID: <4F453086.8030602@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <CA+55aFy__c1j=APK9tjJ__daYtZN74GySANxBZ9kT9e1Zx9DXQ@mail.gmail.com> <4F419A28.1060903@zytor.com> <201202221222.58399.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51757 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab2BVSOp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Feb 2012 13:14:45 -0500
In-Reply-To: <201202221222.58399.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com

On 02/22/2012 04:22 AM, Arnd Bergmann wrote:
> On Monday 20 February 2012, H. Peter Anvin wrote:
>> We are using __u64 as x86-32 compatible since we are sharing most of the
>> really complex path (like ioctl) with i386 much more so than x86-64.  So
>> it is defined in userspace as:
>>
>> typedef unsigned long long __u64 __attribute__((aligned(4)));
>>
>> __aligned_u64 obviously is naturally aligned, which matches uint64_t is
>> userspace.
> 
> Has someone audited the interfaces to check if there are data structures that
> use a plain signed or unsigned "long long" instead of __s64/__u64 in places
> where i386 differs from the other compat implementations?
> 
> I found DRM_IOCTL_UPDATE_DRAW, but there could be more like this one.
> 

Has someone audited every single ioctl in the kernel?  Definitely not,
which is why x32 is marked EXPERIMENTAL.  I think it is still time for
this work to switch to happening in the upstream, however.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
