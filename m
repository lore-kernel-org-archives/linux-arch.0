From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 1 Dec 2016 10:20:39 -0500
Message-ID: <20161201152039.GB35881@redhat.com>
References: <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 01, 2016 at 03:32:15PM +1100, Nicholas Piggin wrote:
> > Anyway, MODVERSIONS is our way of protecting our kabi for the last 10 years.
> > It isn't perfect and we have fixed the genksyms tool over the years, but so
> > far it mostly works fine.
> 
> Okay. It would be good to get all the distros in on this.
> 
> What I want to do is work out exactly what it is that modversions is
> giving you.
> 
> We know it's fairly nasty code to maintain and it does not detect ABI
> changes very well. But it's not such a burden that we can't maintain
> it if there are good reasons to keep it.

Hi Nick,

I won't disagree with you there. :-)

modversions is a pretty heavy handed approach that basically says if all the
symbols and types haven't changed for a given EXPORT_SYMBOL (recursively
checked), then there is a high degree of confidence the OOT driver will not
only load, but run correctly.

The question is how to provide a similar guarantee if a different way?

We have plenty of customers with 10 year old drivers, where the expertise
has long left the company.  The engineers still around, recompile and make
tweaks to get things working on the latest RHEL.  Verify it passes testing
and release it.  Then they hope to not touch it again for a few years until
the next RHEL comes along.

Scary, huh? :-)

Common examples, filesystems and storage drivers.


There is no way that I see to provide a 100% guarantee, but if we do enough
checks, we should be able to have a high degree of confidence the driver
won't blow up.

On the flip side, easy things in the kernel to do is:

- provide the memory allocation (instead of having the driver staticly
  allocate)
- provide functions to retrieve various internal data (instead of having the
  driver do direct referencing to deep internal elements)
- cut down on some static inlines (and use accessory functions instead),
  etc.

Those types of changes allow the OOT driver to be more ignorant of kernel
changes and struct modifications.


Look to Stanislav's responses for his ideas on new tooling.

Thanks for helping!

Cheers,
Don


> 
> > I am not sure what 'control vermagic' is, but it sounds like a string check,
> > which won't protect against the boatload of backports we do to structs,
> > enums, and functions.
> 
> Basically vermagic is the string all modules and the kernel get, which
> must match in order to load modules. If you have modversions disabled,
> then vermagic includes the kernel version. If modversions is enabled,
> then vermagic does not include the kernel version but the CRCs have to
> also match.
> 
> Controlling it explicitly is just a couple of lines where a distro can
> control it (so they can update their kernel version without breaking).
> It's not meant to solve everything, just the first one.
>  
> > Currently we are exploring various ways to get smarter here.  The genksyms
> > tool has its limitations and handling kabi hacks in RHEL is getting
> > tiresome.
> > 
> > I think GregKH pointed to one such tool, libabigail?  We are working on
> > others too.
> > 
> > 
> > Circling back to enabling MODVERSIONS in Fedora, that was to start the
> > process of syncing Fedora with RHEL stuff in preparation for smarter tools.
> > 
> > 
> > If you take away MODVERSIONS, that would put a damper in our work, but
> > easily carried privately (much like MODSIGNING for 8 years until it went
> > upstream :-) ).
> 
> I don't think that's necessary. A feature requirement for a distro is just
> as valid as any other user of upstream. I don't want to hinder any distro,
> I'm just still not quite seeing the big picture of exactly what functionality
> you need from the kernel.
> 
> Thanks,
> Nick
