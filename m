Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:64401 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750971AbWIMTZy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Sep 2006 15:25:54 -0400
Message-ID: <45085B31.3080504@yahoo.com.au>
Date: Thu, 14 Sep 2006 05:25:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Why Semaphore Hardware-Dependent?
References: <45084833.4040602@yahoo.com.au>  <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com>
In-Reply-To: <22461.1158173455@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, ak@suse.de, Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>+	while ((tmp = atomic_read(&sem->count)) >= 0) {
>>+		if (tmp == atomic_cmpxchg(&sem->count, tmp,
>>+				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> 
> 
> NAK for FRV.  Do not use atomic_cmpxchg() there as it isn't strictly atomic
> (FRV only has one strictly atomic operation: SWAP).  Please leave FRV as using
> the spinlock version which is more efficient on UP.

 From what I can read of the asm and the documentation, it is atomic. If
it were not atomic then it is badly broken.

BTW. if atomic_cmpxchg is slower than a local_irq_disable+local_irq_enable
on your architecture then you have probably not implemented cmpxchg well
because you may as well just implement it with local_irq_disable.

> Please also show benchmarks to show the performance difference between your
> version and the old version before Ingo messed it up and made everything
> unconditionally out of line without cleaning the inline asm up.

I'm not so interested in counting cycles so much as consolidating duplicated
code and reduce complexity and icache footprint. I'll leave you to benchmark
Ingo's changes if you're concerned about them.

Of course I will benchmark the end results when I finish the patch, though.

> If you are going to generalise, you should get rid of everything barring the
> spinlock-based version and stick with that.  It will cost you performance
> under some circumstances, but it's better under others than attempting to use
> atomic_cmpxchg() which may not really exist on all archs.

atomic_cmpxchg exists on all architectures.

I'm happy to go with the spinlock version (it is even simpler), but I will
have to benchmark that. I have seen small slowdowns there in high contention
situations but it was improved with my rwsem scalability patch. If
performance is no different between the two, then the spinlock version is a
no brainer.

> You've also caused another problem: the spinlock based version permits up to
> 2^31 - 1 readers at one time, the inline optimised version, on a 32-bit arch,
> will only permit up to 2^16 - 1 at most.  By doing this to x86_64, you've
> reduced the number of processes it can support.

Yep, Christoph pointed this out. I'll fix it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
