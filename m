Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1109309524.14993.56.camel@gaston>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	 <1109222328.15027.12.camel@gaston>
	 <20050224143601.12c340ca.davem@davemloft.net>
	 <1109309524.14993.56.camel@gaston>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 18:20:55 +1100
Message-Id: <1109316055.14992.60.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2005-02-25 at 16:32 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2005-02-24 at 14:36 -0800, David S. Miller wrote:
> > On Thu, 24 Feb 2005 16:18:48 +1100
> > Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> > 
> > > Seems to be happy on ppc32, I'll try ppc64 asap.
> > 
> > Thanks for testing, let me know how ppc64 goes.
> 
> Looks fine. Didn't stress much yet tho, but certainly good enough for
> early 2.6.12, we can always push further fixes in if necessary.

Ok, LTP dies on POWER5, investigation in progress ;)

Ben.
