Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 26 Jan 2005 12:26:23 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: (resend) Converting architectures to 4 level page tables
Message-Id: <20050126122623.34b40437.davem@davemloft.net>
In-Reply-To: <41F78364.6060409@yahoo.com.au>
References: <41F2EB0E.30407@yahoo.com.au>
	<20050125195043.45fed74b.davem@davemloft.net>
	<41F78364.6060409@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 26 Jan 2005 22:47:48 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> So you shouldn't even need that runtime check there I think.
> The #if was just a small space saving, but you could simply
> remove that and be done with it I think. Or have I missed
> something?

For the architectures where it is a constant "1", keeping
the check there makes GCC not output any code more than
a NULL pointer return.  I figured that would be desirable :)
