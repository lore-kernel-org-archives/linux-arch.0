Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 21 Mar 2005 15:06:19 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Message-Id: <20050321150619.2ea75257.davem@davemloft.net>
In-Reply-To: <20050321225904.GF23908@krispykreme>
References: <20050321225904.GF23908@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 22 Mar 2005 09:59:04 +1100
Anton Blanchard <anton@samba.org> wrote:

> Thinking some more about this, perhaps we should remove the ?mb() barriers
> and instead have only io_?mb() and smp_?mb(). This has the advantage of
> making it clear what barriers should be used in drivers to order
> cacheable and non cacheable memory (a problem on ppc/ppc64 at least).

No objections to this idea.

If I remember correctly, the ?mb() routines _were_ the original
SMP memory barriers.
