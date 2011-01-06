From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Thu, 6 Jan 2011 09:55:30 -0800
Message-ID: <AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>
References: <1294254337.16957.13.camel@mulgrave.site>
	<AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com>
	<1294256169.16957.18.camel@mulgrave.site>
	<20110105200008.GJ8638@n2100.arm.linux.org.uk>
	<1294259637.16957.25.camel@mulgrave.site>
	<AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
	<20110105210448.GM8638@n2100.arm.linux.org.uk>
	<AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm@mail.gmail.com>
	<1294262208.2952.4.camel@heimdal.trondhjem.org>
	<AANLkTi=3Gu-rz=-OdNtUXn4qw60Df6=YePnzvB=s-+Ov@mail.gmail.com>
	<1294268808.2952.18.camel@heimdal.trondhjem.org>
	<1294270104.16957.73.camel@mulgrave.site>
	<1294335614.22825.154.camel@mulgrave.site>
	<1294336054.2905.1.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1294336054.2905.1.camel@heimdal.trondhjem.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-arch@vger.kernel.org, linux-nfs@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Parisc List <linux-parisc@vger.kernel.org>, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Marc Kleine-Budde <mkl@pengutronix.de>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <m.kleine-budde@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 6, 2011 at 9:47 AM, Trond Myklebust
<Trond.Myklebust@netapp.com> wrote:
>
> Why is this line needed? We're not writing through the virtual mapping.

I haven't looked at the sequence of accesses, but you need to be
_very_ aware that "write-through" is absolutely NOT sufficient for
cache coherency.

In cache coherency, you have three options:

 - true coherency (eg physically indexed/tagged caches)

 - exclusion (eg virtual caches, but with an exclusion guarantee that
guarantees that aliases cannot happen: either by using physical
tagging or by not allowing cases that could cause virtual aliases)

 - write-through AND non-cached reads (ie "no caching at all").

You seem to be forgetting the "no cached reads" part. It's not
sufficient to flush after a write - you need to make sure that you
also don't have a cached copy of the alias for the read.

So "We're not writing through the virtual mapping" is NOT a sufficient
excuse. If you're reading through the virtual mapping, you need to
make sure that the virtual mapping is flushed _after_ any writes
through any other mapping and _before_ any reads through the virtual
one.

This is why you really really really generally don't want to have
aliasing. Purely virtual caches are pure crap. Really.

                       Linus
