From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: slub: Ensure that slab_unlock() is atomic
Date: Thu, 10 Mar 2016 10:10:58 +0100
Message-ID: <20160310091058.GQ6344@twins.programming.kicks-ass.net>
References: <1457447457-25878-1-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1603080857360.4047@east.gentwo.org>
 <56DEF3D3.6080008@synopsys.com>
 <alpine.DEB.2.20.1603081438020.4268@east.gentwo.org>
 <56DFC604.6070407@synopsys.com>
 <20160309101349.GJ6344@twins.programming.kicks-ass.net>
 <56E023A5.2000105@synopsys.com>
 <20160309145119.GN6356@twins.programming.kicks-ass.net>
 <56E10B59.1060700@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56E10B59.1060700@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Noam Camus <noamc@ezchip.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Christoph Lameter <cl@linux.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 10, 2016 at 11:21:21AM +0530, Vineet Gupta wrote:
> On Wednesday 09 March 2016 08:21 PM, Peter Zijlstra wrote:
> >> But in SLUB: bit_spin_lock() + __bit_spin_unlock() is acceptable ? How so
> >> (ignoring the performance thing for discussion sake, which is a side effect of
> >> this implementation).
> > 
> > The sort answer is: Per definition. They are defined to work together,
> > which is what makes __clear_bit_unlock() such a special function.
> > 
> >> So despite the comment below in bit_spinlock.h I don't quite comprehend how this
> >> is allowable. And if say, by deduction, this is fine for LLSC or lock prefixed
> >> cases, then isn't this true in general for lot more cases in kernel, i.e. pairing
> >> atomic lock with non-atomic unlock ? I'm missing something !
> > 
> > x86 (and others) do in fact use non-atomic instructions for
> > spin_unlock(). But as this is all arch specific, we can make these
> > assumptions. Its just that generic code cannot rely on it.
> 
> OK despite being obvious now, I was not seeing the similarity between spin_*lock()
> and bit_spin*lock() :-(
> 
> ARC also uses standard ST for spin_unlock() so by analogy __bit_spin_unlock() (for
> LLSC case) would be correctly paired with bit_spin_lock().
> 
> But then why would anyone need bit_spin_unlock() at all. Specially after this
> patch from you which tightens __bit_spin_lock() even more for the general case.
> 
> Thing is if the API exists majority of people would would use the more
> conservative version w/o understand all these nuances. Can we pursue the path of
> moving bit_spin_unlock() over to __bit_spin_lock(): first changing the backend
> only and if proven stable replacing the call-sites themselves.

So the thing is, __bit_spin_unlock() is not safe if other bits in that
word can have concurrent modifications.

Only if the bitlock locks the whole word (or something else ensures no
other bits will change) can you use __bit_spin_unlock() to clear the
lock bit.
