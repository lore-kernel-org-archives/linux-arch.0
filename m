Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 7 Feb 2005 09:11:06 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050207081106.GA16035@wotan.suse.de>
References: <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org> <20050205090619.C30866@flint.arm.linux.org.uk> <20050205154448.1cc89ee9.davem@davemloft.net> <20050206105047.GB6819@wotan.suse.de> <20050206131947.6524ece9.davem@davemloft.net> <20050206213148.GI18245@wotan.suse.de> <20050206133110.528ce713.davem@davemloft.net> <20050206215020.GJ18245@wotan.suse.de> <20050206143110.59dc039f.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206143110.59dc039f.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Feb 06, 2005 at 02:31:10PM -0800, David S. Miller wrote:
> This is kind of strange to be arguing about, given that we just
> put 4-level page tables into the tree, right?  That regressed
> everybody performance wise, even people not using the full

Hmm, are you sure? I benchmarked i386 and there was no
measurable difference. x86-64 is regressed right now for fork etc., but
that is to be expected because it walks twice as many page tables.
And there is a plan to fix it.

Text size has increased a little bit for all people, but not
too bad.

My benchmarking was with the PML4 patchkit though, I haven't retried it 
with PUD. 

> And it's not just a sparc64 issue.  Sparc64 hardware traps the
> access, but it's a bug regardless of platform to try to do user
> accesses whilst get_fs()==KERNEL_DS.  All the user has to do is

On x86-64 it's not a bug and we have code in the x86-64 specific
compat layer that relies on this.

Also BTW your proposed check wouldn't catch all cases anyways,
it would only handle the case where the access_ok() check is 
done inside the KERNEL_DS. 

-Andi
