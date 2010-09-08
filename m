From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [RFC trollpatch 1/1] genirq: Remove the fits all and nothing
 __do_IRQ() code
Date: Wed, 8 Sep 2010 16:28:07 -0400
Message-ID: <AANLkTimC1kBuAvd_kei8cdWvgzL-u8FdfEfEGZH1t2ZM@mail.gmail.com>
References: <20100908152036.643594727@linutronix.de> <1283971919.11763.35.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <1283971919.11763.35.camel@mulgrave.site>
Sender: linux-alpha-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-alpha@vger.kernel.org, linux-cris-kernel@axis.com, Haavard Skinnemoen <hskinnemoen@atmel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Greg Ungerer <gerg@uclinux.org>, Jeff Dike <jdike@addtoit.com>, linux-parisc@vger.kernel.org, Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 8, 2010 at 14:51, James Bottomley wrote:
> On Wed, 2010-09-08 at 18:14 +0000, Thomas Gleixner wrote:
>> plain text document attachment (genirq-troll-patch.patch)
>> __do_IRQ() has been deprecated after a two years migration phase in
>> commit 0e57aa1. Since then another 18 month have gone by.
>>
>> So here's the status three and a half years after the flow based
>> infrastructure was merged:
>>
>> =C2=A0The following architectures are still using __do_IRQ():
>>
>> =C2=A0 alpha, cris, ia64, h8300, m32r, m68knommu, parisc, um
>>
>> So now the question arises what to do with __do_IRQ().
>>
>> Removing it would be the right thing, but that'll break 8 archs, so
>> it's probably not considered a good idea, though for most of them th=
e
>> conversion should be reasonably trivial.
>>
>> I'm happy to move that code into kernel/irq/cruft.c forever if there
>> is no way to get the remaining users converted in the forseeable
>> future. It looks like they can cope with the annoying build warning
>> nicely.
>
> Well, if you're going to deprecate something that 8 architectures rel=
y
> on, it would be nice to tell people ... or even just linux-arch ... m=
ost
> of us do read that. =C2=A0I've actually never noticed the warning the=
 commit
> activated in any of my parisc compiles for some reason.

the only reason Blackfin was converted quickly is because the code
issues a warning (that has been there for a long time):
# warning __do_IRQ is deprecated. Please convert to proper flow handler=
s

so i guess you're saying that you disable the "ENABLE_WARN_DEPRECATED"
option ?  or you dont pay attention to warnings when compiling kernels
?
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-alpha" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
