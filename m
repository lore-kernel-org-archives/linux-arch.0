Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 11:33:10 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task
Message-ID: <20050628093310.GL8035@wotan.suse.de>
References: <20050628091704.GP4171@wotan.suse.de> <20050628.022346.34749336.davem@davemloft.net> <20050628092703.GK8035@wotan.suse.de> <20050628.022920.68151330.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628.022920.68151330.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, sfr@canb.auug.org.au, hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 28, 2005 at 02:29:20AM -0700, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Tue, 28 Jun 2005 11:27:04 +0200
> 
> > On what issue exactly? So far all the code was relatively easily
> > fixable. 
> 
> If this input layer case is too then the situation is different.  But
> I suspect this input case is hard to implement without the
> is_compat_task() thing.
> 
> Prove me wrong and then there's nothing to discuss :)

I suspect we would need a compat_read/write vector in VFS for this.

-Andi
