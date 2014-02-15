From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Fri, 14 Feb 2014 18:48:02 -0800
Message-ID: <CA+55aFzoqKGG3iJMZxfaGnDAtpiOCOZcXf7f6cA4+uw2ST2N9w@mail.gmail.com>
References: <1392183564.18779.2187.camel@triegel.csb>	<20140212180739.GB4250@linux.vnet.ibm.com>	<CA+55aFw3S82GYdtnV2nJCvBGcuZf6kXdF5b7Vp9yb21QKr49Jw@mail.gmail.com>	<20140213002355.GI4250@linux.vnet.ibm.com>	<1392321837.18779.3249.camel@triegel.csb>	<20140214020144.GO4250@linux.vnet.ibm.com>	<1392352981.18779.3800.camel@triegel.csb>	<20140214172920.GQ4250@linux.vnet.ibm.com>	<CA+55aFx9CbgrfK4rBVYD75y2KoWiO90dSYsAW83O-tYVLK-gkg@mail.gmail.com>	<CA+55aFypfiTFwundih8QEA6ZwVGk=g5L4sabsN0932eih5knOQ@mail.gmail.com>	<20140215020815.GS4250@linux.vnet.ibm.com>	<CA+55aFyQTE-CzOoNn=KfDgt9bTLrUxBCXzhQ2T9kNoTy+bRQrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <gcc-return-182046-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <CA+55aFyQTE-CzOoNn=KfDgt9bTLrUxBCXzhQ2T9kNoTy+bRQrQ@mail.gmail.com>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 14, 2014 at 6:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And conversely, the C11 people can walk away from us too. But if they
> can't make us happy (and by "make us happy", I really mean no stupid
> games on our part) I personally think they'll have a stronger
> standard, and a real use case, and real arguments. I'm assuming they
> want that.

I should have somebody who proof-reads my emails before I send them out.

I obviously meant "if they *can* make us happy" (not "can't").

            Linus
