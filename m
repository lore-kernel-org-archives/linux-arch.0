Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 27 Feb 2005 20:14:17 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 2 arch usage
Message-Id: <20050227201417.6cfa98bb.davem@davemloft.net>
In-Reply-To: <1109496957.14992.196.camel@gaston>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	<1109222328.15027.12.camel@gaston>
	<20050224143601.12c340ca.davem@davemloft.net>
	<1109309524.14993.56.camel@gaston>
	<1109316055.14992.60.camel@gaston>
	<20050225103730.75adf2f0.davem@davemloft.net>
	<1109379369.15027.99.camel@gaston>
	<20050226190943.7aa031e2.davem@davemloft.net>
	<1109496957.14992.196.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 27 Feb 2005 20:35:57 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> That's just another argument for having all these sharing common code,
> even if it's a bit bulky macro at first, the current state of affairs is
> just too prone to fail in weird ways.

Yep, the current situation is a joke.  That's why any arguments
against consolidation I hear will fall on deaf ears.  I'm really
tired of fixing bugs like these 5 or 6 times over instead of
once.
