From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] mm: slub: Ensure that slab_unlock() is atomic
Date: Wed, 9 Mar 2016 18:52:45 +0530
Message-ID: <56E023A5.2000105@synopsys.com>
References: <1457447457-25878-1-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1603080857360.4047@east.gentwo.org>
 <56DEF3D3.6080008@synopsys.com>
 <alpine.DEB.2.20.1603081438020.4268@east.gentwo.org>
 <56DFC604.6070407@synopsys.com>
 <20160309101349.GJ6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160309101349.GJ6344@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Noam Camus <noamc@ezchip.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, linux-snps-arc@lists.infradead.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-arch.vger.kernel.org

On Wednesday 09 March 2016 03:43 PM, Peter Zijlstra wrote:
>> There is clearly a problem in slub code that it is pairing a test_and_set_bit()
>> with a __clear_bit(). Latter can obviously clobber former if they are not a single
>> instruction each unlike x86 or they use llock/scond kind of instructions where the
>> interim store from other core is detected and causes a retry of whole llock/scond
>> sequence.
> 
> Yes, test_and_set_bit() + __clear_bit() is broken.

But in SLUB: bit_spin_lock() + __bit_spin_unlock() is acceptable ? How so
(ignoring the performance thing for discussion sake, which is a side effect of
this implementation).

So despite the comment below in bit_spinlock.h I don't quite comprehend how this
is allowable. And if say, by deduction, this is fine for LLSC or lock prefixed
cases, then isn't this true in general for lot more cases in kernel, i.e. pairing
atomic lock with non-atomic unlock ? I'm missing something !

| /*
|  *  bit-based spin_unlock()
|  *  non-atomic version, which can be used eg. if the bit lock itself is
|  *  protecting the rest of the flags in the word.
|  */
| static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
