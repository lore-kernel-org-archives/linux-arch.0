From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Sun, 23 Feb 2014 21:25:55 -0800
Message-ID: <CA+55aFz1sPZ9f0uGpd7pqe162pGdU_i2aXjYOV1y6SNKmYUDGQ@mail.gmail.com>
References: <1392922421.28840.36.camel@triegel.csb>	<CA+55aFwos2Gwd2LEvht4ymVxHb6GRVjtZ9wwJSaj1p--FqNUWw@mail.gmail.com>	<1393095223.28840.4914.camel@triegel.csb>	<CA+55aFz9=RQoMO2ipyZgNPNzWGVXi_R9Ar5=o9VBWwXzDDz6jg@mail.gmail.com>	<20140223003933.GQ4250@linux.vnet.ibm.com>	<CA+55aFyjzR_Ga_HOKnBXpKYbuesqovj1-sFTVisD9UwA6JuJtw@mail.gmail.com>	<20140223063426.GT4250@linux.vnet.ibm.com>	<CA+55aFxMJvaQhoEwqgN=XA6gDOdZwoZQHdcAnB-FhAri_hK-6Q@mail.gmail.com>	<20140224011651.GC8264@linux.vnet.ibm.com>	<CA+55aFx06UTTeypXOGUiwwbzJyqpVNR90zBDLPmxFzBkz=VwgQ@mail.gmail.com>	<20140224045951.GH8264@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <gcc-return-182269-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <20140224045951.GH8264@linux.vnet.ibm.com>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 23, 2014 at 8:59 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Sun, Feb 23, 2014 at 05:35:28PM -0800, Linus Torvalds wrote:
>>
>> But "q = p->next" is ordered by how something can alias "p->next", not by 'q'!
>>
>> There is no need to restrict anything but 'p' for all of this to work.
>
> I cannot say I understand this last sentence right new from the viewpoint
> of the standard, but suspending disbelief for the moment...

So 'p' is what comes from that consuming load that returns a
'restrict' pointer. That doesn't affect 'q' in any way.

But the act of initializing 'q' by dereferencing p (in "p->next") is -
by virtue of the restrict - something that the compiler can see cannot
alias with anything else, so the compiler could re-order other memory
accesses freely around it, if you see what I mean.

Modulo all the *other* ordering guarantees, of course. So other
atomics and volatiles etc may have their own rules, quite apart from
any aliasing issues.

> Understood -- in this variant, you are taking the marking from the
> fact that there was an assignment from a memory_order_consume load
> rather than from a keyword on the assigned-to variable's declaration.

Yes, and to me, it's really just a legalistic trick to make it clear
that any *other* pointer that  happens to point to the same object
cannot be dereferenced within scope of the result of the
atomic_read(mo_consume), at least not if you expect to get the memory
ordering semantics. You can do it, but then you violate the guarantee
of the restrict, and you get what you get - a potential non-ordering.

So if somebody just immediately assigns the value to a normal
(non-restrict) pointer nothing *really* changes. It's just there to
describe the guarantees.

              Linus
