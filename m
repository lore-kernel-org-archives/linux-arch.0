From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Tue, 29 Nov 2016 13:31:30 +1100
Message-ID: <20161129133130.164b4e2d@roar.ozlabs.ibm.com>
References: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
        <1480382148.16599.61.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33672 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbcK2Cbt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2016 21:31:49 -0500
In-Reply-To: <1480382148.16599.61.camel@decadent.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Adam Borowski <kilobyte@angband.pl>, Debian kernel maintainers <debian-kernel@lists.debian.org>

On Tue, 29 Nov 2016 01:15:48 +0000
Ben Hutchings <ben@decadent.org.uk> wrote:

> [I've had to guess at the cc list for this, because we no longer have
> mail archives that preserve them.]

You got it about right.

> On Fri, 2016-11-25 at 10:01 -0800, Linus Torvalds wrote:
> > On Thu, Nov 24, 2016 at 4:40 PM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > > 
> > > > Yes, manual "marking" is never going to be a viable solution.  
> > > 
> > > I guess it really depends on how exactly you want to use it. For distros
> > > that do stable ABI but rarely may have to break something for security
> > > reasons, it should work and give exact control.  
> 
> This is roughly how Debian handles the kernel module ABI during a
> stable release.
> 
> > No. Because nobody else will care, so unless it's like a single symbol
> > or something, it will just be a maintenance nightmare.  
> 
> I agree with this.  We can explicitly "version" individual symbols
> anyway by doing something like:
> 
> -int foo(void);
> +#define foo foo_2
> +int foo_2(int);

Yeah... Benefit being it's very simple and everybody can see exactly
what it does and knows how it will work.

> 
> > > What else do people *actually* use it for? Preventing mismatched modules
> > > when .git version is not attached and release version of the kernel has
> > > not been bumped. Is that it?  
> > 
> > It used to be very useful for avoiding loading stale modules and then
> > wasting days on debugging something that wasn't the case when you had
> > forgotten to do "make modules_install". Change some subtle internal
> > ABI issue (add/remove a parameter, whatever) and it would really help.
> > 
> > These days, for me, LOCALVERSION_AUTO and module signing are what I
> > personally tend to use.
> >
> > The modversions stuff may just be too painful to bother with. Very few
> > people probably use it, and the ones that do likely don't have any
> > overriding reason why.  
> [...]
> 
> Debian has some strong reasons:
> 
> 1. Changing the release string requires any out-of-tree modules to be
> upgraded (at least rebuilt) on end-user systems.  So we try to avoid
> doing that during the lifetime of a stable release, i.e. we don't let
> the release string change.  Also, the release string is reflected in
> package names (e.g. linux-image-4.8.0-1-amd64), and introducing new
> package names requires manual approval by the Debian archive team.

This is something I've noticed. Would it be better if the module loader
ignores the kernel version and instead used some internal ABI version
string to check against? Otherwise (AFAICT) you always have 4.8.0 versions
despite being 4.8.7 kernel, and you can't upgrade a point release without
overwriting your old kernel and modules.

That is something we could potentially replace modversions with. It would
be a far more reasonable complexity to carry for downstream distros than
modversions. Though not something we can add for 4.9.

> 2. We want to allow ABI breaks for "internal" symbols used only by in-
> tree modules, as those breaks will be resolved by rebooting to complete
> the upgrade.  But we need a run-time check to prevent loading an
> incompatible module before the reboot.
> 
> 3. So far as I can see, module signing doesn't work for a distribution
> kernel with out-of-tree modules as there has to be a trust path from a
> built-in certificate to the module signing certificate.  So signature
> enforcement will have to be disabled on systems that use out-of-tree
> modules, thus it's not a substitute for modversions.
> 
> We expect Linux 4.9 to be the basis for a longterm stable branch and on
> that basis intend to include it in the next Debian stable release. 
> Even if the decision is to get rid of modversions, it would be very
> helpful if they could be revived for 4.9 so that we have some time to
> adapt our packaging practices to work without them in future.

It would be nice to get upstream to the point where 4.9 modversions
works if you just patch out depends BROKEN. That would require reverting
a few more of Al's arch patches.

Then in 4.10 we can re-add all those arch patches (which are less
controversial without the asm-prototypes.h workaround), and implement a
simple stable ABI version string check, and then in 4.11 we can remove
modversions.

Thanks,
Nick
