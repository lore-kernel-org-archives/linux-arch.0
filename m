Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 6 Feb 2005 13:05:03 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050206130503.GQ20386@parcelfarce.linux.theplanet.co.uk>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <20050205065452.GA32565@wotan.suse.de> <20050204231816.76b989a6.akpm@osdl.org> <20050205074025.GA23814@wotan.suse.de> <20050205152752.671e7a72.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205152752.671e7a72.davem@davemloft.net>
Sender: <willy@www.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, torvalds@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Sat, Feb 05, 2005 at 03:27:52PM -0800, David S. Miller wrote:
> However, from another perspective it does make some sense.
> I only know of a cpu type or two that really provide strong
> address space protection for accidental supervisor mode accesses
> to user space.  I know sparc64 provides this for sure, and I
> think parisc has something similar as well.

Yes, we essentially have a 4G/4G split on PA.  We rather abuse addr_limit
though.  I'm not particularly happy with the current uaccess code and it's
something I plan to clean up long-term.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
