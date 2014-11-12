From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: compiler bug gcc4.6/4.7 with ACCESS_ONCE and workarounds
Date: Wed, 12 Nov 2014 09:05:41 +0100
Message-ID: <546314D5.4010108@de.ibm.com>
References: <1415360716-9670-2-git-send-email-borntraeger@de.ibm.com> <54611D86.4040306@de.ibm.com> <CA+55aFyEigSL64RJH8AO86gFBBB84+dgk7eEUPx=CaLwJMcO_w@mail.gmail.com> <54627CBF.2000704@de.ibm.com> <CA+55aFz1oxCgZiY4oWu41fFUbKft9g5_gQXXzAKuW8+pnR72Vw@mail.gmail.com> <CA+55aFw+cLJ6xW0Wk6nMbK+e1yr2KGCWN+-v2a7xK1u8zTtDtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:34945 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaKLIFs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Nov 2014 03:05:48 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Nov 2014 08:05:46 -0000
In-Reply-To: <CA+55aFw+cLJ6xW0Wk6nMbK+e1yr2KGCWN+-v2a7xK1u8zTtDtA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andreas Krebbel <Andreas.Krebbel@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Am 12.11.2014 um 01:36 schrieb Linus Torvalds:
> On Tue, Nov 11, 2014 at 4:33 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I guess as a workaround it is fine, as long as we don't lose sight of
>> trying to eventually do a better job.
> 
> Oh, and when it comes to the actual gcc bug - do you have any reason
> to believe that it's somehow triggered more easily by something
> particular in the arch/s390/kvm/gaccess.c code?

Yes there are reasons. First of all the bug if SRA removes the volatile tag, but that does not mean that this breaks things. As long as the operation is simple enough things will be mostly ok. If things are not simple like in gaccess things get more complicated. Lets look at the ipte lock. The lock itself consists of 3 parts: k (1 bit:locked), kh(31bit counter for the host) and kg(32 bit counter for the millicode when doing specific guest instructions). There are 3 valid states
1. k=0, kh=0; kg=0
2. k=1, kh!=0, kg=0
3. k=1, kh=0, kg!=0

So the host code must check if the guest counter is zero and can then set the k bit to one and increase the counter. (for unlock it has to decrement kh and if that becomes zero also zero the k bit)
That means that we have multiple accesses to subcomponents. As the host counter is bit 1-31 (ibm speak, linux speak bit 32-62) gcc wants to use the load thirty one bit instruction. 
So far so good. The ticket lock is also not a trivial set/clear bit.

Now: In gcc the memory costs for s390 are modeled to have the same costs as register accesses (TARGET_MEMORY_MOVE_COST==1, TARGET_REGISTER_MOVE_COST=1)
So for gcc a re-loading of a part of the lock from memory costs the same as loading it from a register. That probably triggered that bug.

Christian




> 
> IOW, why does this problem not hit the x86 spinlocks that also use
> volatile pointers to aggregate types? Or does it?

I think we would have noticed if that hits. But there are certainly cases where this bug triggers also on x86, see
the initial bug report of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 This bug is certainly different, (instead of transforming one load into multiple loads , it combines multiple write into one) but it shows, that a volatile marker is removed.
