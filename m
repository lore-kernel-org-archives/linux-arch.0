Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 1 Mar 2005 15:32:21 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 2 arch usage
Message-Id: <20050301153221.6922d3e1.davem@davemloft.net>
In-Reply-To: <1109643738.6475.1.camel@gaston>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	<1109222328.15027.12.camel@gaston>
	<20050224143601.12c340ca.davem@davemloft.net>
	<1109309524.14993.56.camel@gaston>
	<1109316055.14992.60.camel@gaston>
	<20050225103730.75adf2f0.davem@davemloft.net>
	<1109379369.15027.99.camel@gaston>
	<20050226190943.7aa031e2.davem@davemloft.net>
	<20050226211910.79dbfa45.davem@davemloft.net>
	<1109643738.6475.1.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 01 Mar 2005 13:22:18 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> And here's an updated version of your 3rd patch to make it apply on top
> of current bk (a small fix to hpte_update broke it).

I should be able to resolve the conflict when I
re-root the tree for submission to Linus.  If for
some reason I can't, sure I'll use your patch
thanks :-)
