From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 24 Nov 2016 08:36:39 +0100
Message-ID: <20161124073639.GA12728@kroah.com>
References: <20161123205338.GA12050@angband.pl>
 <20161123210256.31501-1-kilobyte@angband.pl>
 <20161124044028.GA12704@gmail.com>
 <20161124162051.5e336127@roar.ozlabs.ibm.com>
 <20161124060050.GA788@gmail.com>
 <20161124182026.34e6570b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124182026.34e6570b@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 24, 2016 at 06:20:26PM +1100, Nicholas Piggin wrote:
> But still, modversions is pretty complicated for what it gives us. It sends
> preprocessed C into a C parser that makes CRCs using type definitions of
> exported symbols, then turns those CRCs into a linker script which which is
> used to link the .o file with. What we get in return is a quite limited and
> symbol "versioning" system.
> 
> What if we ripped all that out and just attached an explicit version to
> each export, and incompatible changes require an increment?

How would that work for structures?  Would that be required for every
EXPORT_SYMBOL* somehow?

> Google tells me
> Linus is not a neutral bystander on the topic of symbol versioning, so I'm
> bracing for a robust response :) (actually I don't much care either way, I'm
> happy to put a couple of bandaids on it and keep it going)

There are tools that people are working on to make it more obvious where
API breaks happen by looking at the .o debug data instead of our crazy
current system (which is really better than nothing), perhaps we should
start using them instead?

See here for more details about this:
	https://kernel-recipes.org/en/2016/talks/would-an-abi-changes-visualization-tool-be-useful-to-linux-kernel-maintenance/

thanks,

greg k-h
