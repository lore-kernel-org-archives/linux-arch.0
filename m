Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 24 Feb 2005 23:57:08 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 2 arch usage
Message-Id: <20050224235708.79d636bf.davem@davemloft.net>
In-Reply-To: <1109316055.14992.60.camel@gaston>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	<1109222328.15027.12.camel@gaston>
	<20050224143601.12c340ca.davem@davemloft.net>
	<1109309524.14993.56.camel@gaston>
	<1109316055.14992.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 25 Feb 2005 18:20:55 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, LTP dies on POWER5, investigation in progress ;)

OK, FWIW I did a full LTP run on sparc64 with the changes
installed.
