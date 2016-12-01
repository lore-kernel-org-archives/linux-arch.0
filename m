From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 1 Dec 2016 15:32:15 +1100
Message-ID: <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
References: <20161129131922.GA31466@angband.pl>
        <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
        <20161201051852.28dc335f@roar.ozlabs.ibm.com>
        <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
        <20161201041325.GX35881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161201041325.GX35881@redhat.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 30 Nov 2016 23:13:25 -0500
Don Zickus <dzickus@redhat.com> wrote:

> On Wed, Nov 30, 2016 at 10:40:02AM -0800, Linus Torvalds wrote:
> > On Wed, Nov 30, 2016 at 10:18 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> > >
> > > Here's an initial rough hack at removing modversions. It gives an idea
> > > of the complexity we're carrying for this feature (keeping in mind most
> > > of the lines removed are generated parser).  
> > 
> > You definitely don't have to try to convince me. We've had many issues
> > with modversions over the years. This was just the "last drop" as far
> > as I'm concerned, we've had random odd crc generation failures due to
> > some build races too.
> >   
> > > In its place I just added a simple config option to override vermagic
> > > so distros can manage it entirely themselves.  
> > 
> > So at least Fedora doesn't even enable CONFIG_MODVERSIONS as-is. I'm
> > _hoping_ it's just Debian that wants this, and we'd need to get some
> > input from the Debian people whether that "control vermagic" is
> > sufficient? I suspect it isn't, but I can't come up with any simple
> > alternate model either..  
> 
> Oddly, I just posted a patch to enable this for Fedora and then someone
> pointed me at this thread. :-/
> 
> Sorry for chiming in late, but yes RHEL is a big user of MODVERSIONS for our
> kabi protection work.  Despite our best intentions we still have lots of
> partners and customers that provide value-add out-of-tree drivers to their
> customers.  These module builders requested we have a mechanism to allow
> rolling modules forward for each of our minor RHEL updates without breaking
> their drivers.
> 
> They requested this to save time and money on rebuilding and retesting.  It
> also helps deal with situations where RHEL puts out a security fix or new
> minor release and the provider of OOT driver has not released the
> appropriate update.  Customers like the ability to roll their special
> drivers forward quickly to their schedule.
> 
> Now we don't protect every symbol, just a select few that our meets our
> customers needs (and developers willing to support it).
> 
> Anyway, MODVERSIONS is our way of protecting our kabi for the last 10 years.
> It isn't perfect and we have fixed the genksyms tool over the years, but so
> far it mostly works fine.

Okay. It would be good to get all the distros in on this.

What I want to do is work out exactly what it is that modversions is
giving you.

We know it's fairly nasty code to maintain and it does not detect ABI
changes very well. But it's not such a burden that we can't maintain
it if there are good reasons to keep it.

> I am not sure what 'control vermagic' is, but it sounds like a string check,
> which won't protect against the boatload of backports we do to structs,
> enums, and functions.

Basically vermagic is the string all modules and the kernel get, which
must match in order to load modules. If you have modversions disabled,
then vermagic includes the kernel version. If modversions is enabled,
then vermagic does not include the kernel version but the CRCs have to
also match.

Controlling it explicitly is just a couple of lines where a distro can
control it (so they can update their kernel version without breaking).
It's not meant to solve everything, just the first one.
 
> Currently we are exploring various ways to get smarter here.  The genksyms
> tool has its limitations and handling kabi hacks in RHEL is getting
> tiresome.
> 
> I think GregKH pointed to one such tool, libabigail?  We are working on
> others too.
> 
> 
> Circling back to enabling MODVERSIONS in Fedora, that was to start the
> process of syncing Fedora with RHEL stuff in preparation for smarter tools.
> 
> 
> If you take away MODVERSIONS, that would put a damper in our work, but
> easily carried privately (much like MODSIGNING for 8 years until it went
> upstream :-) ).

I don't think that's necessary. A feature requirement for a distro is just
as valid as any other user of upstream. I don't want to hinder any distro,
I'm just still not quite seeing the big picture of exactly what functionality
you need from the kernel.

Thanks,
Nick
