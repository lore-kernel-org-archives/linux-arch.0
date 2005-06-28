Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 02:23:46 -0700 (PDT)
Message-Id: <20050628.022346.34749336.davem@davemloft.net>
Subject: Re: RFC: is_compat_task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050628091704.GP4171@wotan.suse.de>
References: <20050628072710.GA29916@lst.de>
	<20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: ak@suse.de
Cc: sfr@canb.auug.org.au, hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: Tue, 28 Jun 2005 11:17:04 +0200

> No, it's not because it makes it impossible to have 64bit processes
> that run with 32bit ABI (not implemented right now but we don't
> want to break that).

I've been hearing this for years, and still there's nothing
that really wants to do this.

The one case that emulates 32-bit programs from a 64-bit
process (ia64) makes 64-bit system calls.

We can't sit on our hands forever on this issue because of
some pseudo-feature that's been in perpetual beta since the
first time it was ever mentioned :-)
