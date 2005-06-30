Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 30 Jun 2005 11:16:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-ID: <20050630101638.GE2935@linux-mips.org>
References: <20050628072710.GA29916@lst.de> <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628091704.GP4171@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 28, 2005 at 11:17:04AM +0200, Andi Kleen wrote:

> No, it's not because it makes it impossible to have 64bit processes
> that run with 32bit ABI (not implemented right now but we don't
> want to break that).

We do something like that on MIPS with N32.

(sigh...)

  Ralf
