From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 24 Nov 2016 21:03:55 +1100
Message-ID: <20161124210355.4875c61a@roar.ozlabs.ibm.com>
References: <20161123205338.GA12050@angband.pl>
        <20161123210256.31501-1-kilobyte@angband.pl>
        <20161124044028.GA12704@gmail.com>
        <20161124162051.5e336127@roar.ozlabs.ibm.com>
        <20161124060050.GA788@gmail.com>
        <20161124182026.34e6570b@roar.ozlabs.ibm.com>
        <20161124073639.GA12728@kroah.com>
        <20161124185322.1e2a492c@roar.ozlabs.ibm.com>
        <250b3310-6e4a-1352-be7a-a5a472829cec@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <250b3310-6e4a-1352-be7a-a5a472829cec@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Adam Borowski <kilobyte@angband.pl>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 24 Nov 2016 10:32:12 +0100
Michal Marek <mmarek@suse.com> wrote:

> On 2016-11-24 08:53, Nicholas Piggin wrote:
> > On Thu, 24 Nov 2016 08:36:39 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >   
> >> On Thu, Nov 24, 2016 at 06:20:26PM +1100, Nicholas Piggin wrote:  
> >>> But still, modversions is pretty complicated for what it gives us. It sends
> >>> preprocessed C into a C parser that makes CRCs using type definitions of
> >>> exported symbols, then turns those CRCs into a linker script which which is
> >>> used to link the .o file with. What we get in return is a quite limited and
> >>> symbol "versioning" system.
> >>>
> >>> What if we ripped all that out and just attached an explicit version to
> >>> each export, and incompatible changes require an increment?    
> >>
> >> How would that work for structures?  Would that be required for every
> >> EXPORT_SYMBOL* somehow?  
> > 
> > Yeah just have EXPORT_SYMBOL take another parameter which attaches a version
> > number and use that as the value for the __crc_ symbol versions rather than
> > a calculated CRC.  
> 
> The problem is that with every kernel release, the structures change in
> a way that you would have to bump the version of virtually every export.
>
> At which point, there would be little difference between
> CONFIG_MODVERSION on and off (without CONFIG_MODVERSION, we compare the
> kernel version strings when loading modules).


I'm not sure about that. If they are truly incompatible changes and
MODVERSIONS does not pick up a different CRC, then it's even worse if
incompatible modules are missed so often.

Thanks,
Nick
