From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Sun, 23 Feb 2014 17:35:28 -0800
Message-ID: <CA+55aFx06UTTeypXOGUiwwbzJyqpVNR90zBDLPmxFzBkz=VwgQ@mail.gmail.com>
References: <20140220181116.GT4250@linux.vnet.ibm.com>	<CA+55aFwn9gXWVq_GL=tPPP63vsqs-9QB4ii4s06xqG4UscCV5w@mail.gmail.com>	<1392922421.28840.36.camel@triegel.csb>	<CA+55aFwos2Gwd2LEvht4ymVxHb6GRVjtZ9wwJSaj1p--FqNUWw@mail.gmail.com>	<1393095223.28840.4914.camel@triegel.csb>	<CA+55aFz9=RQoMO2ipyZgNPNzWGVXi_R9Ar5=o9VBWwXzDDz6jg@mail.gmail.com>	<20140223003933.GQ4250@linux.vnet.ibm.com>	<CA+55aFyjzR_Ga_HOKnBXpKYbuesqovj1-sFTVisD9UwA6JuJtw@mail.gmail.com>	<20140223063426.GT4250@linux.vnet.ibm.com>	<CA+55aFxMJvaQhoEwqgN=XA6gDOdZwoZQHdcAnB-FhAri_hK-6Q@mail.gmail.com>	<20140224011651.GC8264@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <gcc-return-182267-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <20140224011651.GC8264@linux.vnet.ibm.com>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 23, 2014 at 5:16 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>>
>>  (a) we've said 'q' is restricted, so there is no aliasing between q
>> and the pointers b/c. So the compiler is free to move those accesses
>> around the "q = p->next" access.
>
> Ah, if I understand you, very good!
>
> My example intentionally left "q" -not- restricted.

No, I 100% agree with that. "q" is *not* restricted. But "p" is, since
it came from that consuming load.

But "q = p->next" is ordered by how something can alias "p->next", not by 'q'!

There is no need to restrict anything but 'p' for all of this to work.

Btw, it's also worth pointing out that I do *not* in any way expect
people to actually write the "restrict" keyword anywhere. So no need
to change source code.

What you have is a situation where the pointer coming out of the
memory_order_consume is restricted. But if you assign it to a
non-restricted pointer, that's *fine*. That's perfectly normal C
behavior. The "restrict" concept is not something that the programmer
needs to worry about or ever even notice, it's basically just a
promise to the compiler that "if somebody has another pointer lying
around, accesses though that other pointer do not require ordering".

So it sounds like you believe that the programmer would mark things
"restrict", and I did not mean that at all.

             Linus
