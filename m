Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 21 Feb 2005 21:43:03 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Changing  update_mmu_cache()
Message-Id: <20050221214303.2f283a6e.davem@davemloft.net>
In-Reply-To: <1109047997.5327.70.camel@gaston>
References: <1109047997.5327.70.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 22 Feb 2005 15:53:17 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> So I want to change all call sites to pass the ptep to
> update_mmu_cache() with the semantics that it will always be kmap'ed by
> the caller.
> 
> Is that ok with everybody ?

No objection.
