Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 2 May 2005 19:26:17 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: iomap interface issue
Message-Id: <20050502192617.7698f052.davem@davemloft.net>
In-Reply-To: <20050503004756.GB12682@krispykreme>
References: <20050503004756.GB12682@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 3 May 2005 10:47:56 +1000
Anton Blanchard <anton@samba.org> wrote:

> With the current API we could work out if an address is IO or MMIO but
> it will be a bit ugly. I was wondering if it made sense to pass in the
> BAR to pci_iounmap. That would make it easy to work out if its an MMIO
> region.

If anything, a pointer to the resource would be more appropriate.
