Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 7 Feb 2005 21:15:47 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050207201547.GA6790@wotan.suse.de>
References: <20050205090619.C30866@flint.arm.linux.org.uk> <20050205154448.1cc89ee9.davem@davemloft.net> <20050206105047.GB6819@wotan.suse.de> <20050206131947.6524ece9.davem@davemloft.net> <20050206213148.GI18245@wotan.suse.de> <20050206133110.528ce713.davem@davemloft.net> <20050206215020.GJ18245@wotan.suse.de> <20050206143110.59dc039f.davem@davemloft.net> <20050207081106.GA16035@wotan.suse.de> <20050207112837.5594c314.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207112837.5594c314.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Feb 07, 2005 at 11:28:37AM -0800, David S. Miller wrote:
> On Mon, 7 Feb 2005 09:11:06 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > Also BTW your proposed check wouldn't catch all cases anyways,
> > it would only handle the case where the access_ok() check is 
> > done inside the KERNEL_DS. 
> 
> There must be a verify area done (either via explicit call or
> via the user access macros which do not have the "__" prefix)
> for each range of "userspace" accesses done through the uaccess.h accessors.

Yes, but it is done outside KERNEL_DS (otherwise it is a security hole) 
And then later in KERNEL_DS there is no verify_area.

So this change wouldn't help you at all because it would rarely if 
ever catch any bugs.

-Andi
