Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 12 Sep 2005 23:47:00 -0700 (PDT)
Message-Id: <20050912.234700.88643507.davem@davemloft.net>
Subject: Re: Kill HAVE_DEC_LOCK
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200509130815.51050.ak@suse.de>
References: <20050912.160503.93067051.davem@davemloft.net>
	<200509130815.51050.ak@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: ak@suse.de
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: Tue, 13 Sep 2005 08:15:50 +0200

> Looks good.  Unfortunately XADD cannot be used for that.

If that were possible, what would be the advantage
compared to cmpxchg{b,w,l}?
