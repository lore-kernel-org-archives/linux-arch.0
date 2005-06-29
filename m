Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 12:36:05 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task
Message-ID: <20050629103605.GF21575@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk> <20050628.134736.45885284.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628.134736.45885284.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: matthew@wil.cx, ak@suse.de, sfr@canb.auug.org.au, hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Why don't we do the following to resolve this issue?
> Create a "is_compat_syscall()" macro, in compat syscall
> trap entry, the bit is set, and it is cleared otherwise.

It would work for me, however I think it would be cleaner
to add compat_read/write for input.

-Andi
