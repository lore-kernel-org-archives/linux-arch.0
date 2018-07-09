From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 16:10:19 +0000
Message-ID: <b42f7223e0e54a5589f75fc21039f348@AcuMS.aculab.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
 <20180709153427.GY2476@hirez.programming.kicks-ass.net>
 <20180709154521.GS2512@hirez.programming.kicks-ass.net>
 <20180709154844.5p5yk34ezw2gbt3y@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709154844.5p5yk34ezw2gbt3y@lakrids.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Mark Rutland' <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland
> Sent: 09 July 2018 16:49
> 
> On Mon, Jul 09, 2018 at 05:45:21PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 05:34:27PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 09, 2018 at 04:29:58PM +0100, Mark Rutland wrote:
> > > > Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
> > > > x86_32:
> > >
> > > Curious, I wonder why we put that align in atomic64_32 then.
> >
> > Shiny, look at this: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54188
> >
> 
> Ouch.

Indeed.

changing the definition to:
struct ull {
        unsigned long long v __attribute__((aligned(__alignof__(long long))));
};

prints 8 for the structure alignment.

Time to audit uses of __alignof__().

#define actual_alignof(type) __alignof__(struct { type jsdjdhjdjh; })

	David
