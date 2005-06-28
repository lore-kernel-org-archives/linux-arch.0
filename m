Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 12:18:28 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-ID: <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
References: <20050628072710.GA29916@lst.de> <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628091704.GP4171@wotan.suse.de>
Sender: <willy@www.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 28, 2005 at 11:17:04AM +0200, Andi Kleen wrote:
> No, it's not because it makes it impossible to have 64bit processes
> that run with 32bit ABI (not implemented right now but we don't
> want to break that).
> 
> Please don't do this. It is absolutely the wrong thing to do.

So.  You want to deliver a signal to a task.  How do you know whether
to send it a 64-bit signal or a 32-bit signal?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
