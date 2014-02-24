From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Mon, 24 Feb 2014 08:40:50 -0800
Message-ID: <CA+55aFwc=1rGngpY1vUUxow11ao4Q36T6u7p9i7m7H6DdNdcRw@mail.gmail.com>
References: <20140220083032.GN4250@linux.vnet.ibm.com>	<CA+55aFwfx==u7o1NZ66aPbkOgsvGqW3UscGqrQkGuzOkjSpm6Q@mail.gmail.com>	<20140220181116.GT4250@linux.vnet.ibm.com>	<CA+55aFwn9gXWVq_GL=tPPP63vsqs-9QB4ii4s06xqG4UscCV5w@mail.gmail.com>	<1392922421.28840.36.camel@triegel.csb>	<CA+55aFwos2Gwd2LEvht4ymVxHb6GRVjtZ9wwJSaj1p--FqNUWw@mail.gmail.com>	<1393095223.28840.4914.camel@triegel.csb>	<CA+55aFz9=RQoMO2ipyZgNPNzWGVXi_R9Ar5=o9VBWwXzDDz6jg@mail.gmail.com>	<20140223003933.GQ4250@linux.vnet.ibm.com>	<CA+55aFyjzR_Ga_HOKnBXpKYbuesqovj1-sFTVisD9UwA6JuJtw@mail.gmail.com>	<20140223063426.GT4250@linux.vnet.ibm.com>	<CA+55aFxMJvaQhoEwqgN=XA6gDOdZwoZQHdcAnB-FhAri_hK-6Q@mail.gmail.com>	<CA+55aFw5tdjmNyHCdcyZ8NPpd1wCgOjLRzstRhp0Njs9azpi8Q@mail.gmail.com>	<CAFiYyc08cusFTsydD2C4rEZB-k38NnorzEXzKvqab0m3R+qn8
 w@mail.gmail.com>	<CA+55aFyYtMm1_UsPVw8mi7o2iH_--1wLvxPUt5Z9mAEOGMgXdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <gcc-return-182277-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <CA+55aFyYtMm1_UsPVw8mi7o2iH_--1wLvxPUt5Z9mAEOGMgXdQ@mail.gmail.com>
To: Richard Biener <richard.guenther@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 24, 2014 at 8:37 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So yes, the atomic_read() would be ordered wrt '*ptr' (getting 'q')
> _and_ '**ptr' (getting 'i'), but nothing else - including just the
> aliasing access of dereferencing 'i' directly.

Btw, what CPU architects and memory ordering guys tend to do in
documentation is give a number of "litmus test" pseudo-code sequences
to show the effects and intent of the language.

I think giving those kinds of litmus tests for both "this is ordered"
and "this is not ordered" cases like the above is would be a great
clarification. Partly because the language is going to be somewhat
legalistic and thus hard to wrap your mind around, and partly to
really hit home the *intent* of the language, which I think is
actually fairly clear to both compiler writers and to programmers.

               Linus
