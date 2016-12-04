From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Sun, 4 Dec 2016 18:14:35 +1030
Message-ID: <20161204074435.GQ4829@bubble.grove.modra.org>
References: <20161129131922.GA31466@angband.pl>
 <2899250.iZaPagXLk8@wuerfel>
 <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
 <14455987.OWjnZpEEup@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <14455987.OWjnZpEEup@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 02, 2016 at 11:55:58AM +0100, Arnd Bergmann wrote:
> I have managed to bisect the link failure to a specific binutils
> commit by Alan Modra now:
> 
> d983c8c ("Strip undefined symbols from .symtab")
> 
> went into binutils-2_26 and was reverted in 
> 
> a82e3ef ("Revert "Strip undefined symbols from .symtab"")
> 
> after the release branch for 2.26 was started, so that version
> ended up being fine. However, the 2.27 version never saw the revert
> and causes loadable kernel modules to become unusable when they refer
> to a weak symbol in vmlinux. This works with 2.26 and lower:

See https://sourceware.org/ml/binutils/2016-01/msg00118.html thread
for discussion on why the patch was reverted for 2.26.  At the time I
believed that only the ppc64 kernel was affected, by a weak undefined
"__crc_TOC." disappearing.  Am I correct in thinking that remained
true up until Linus' merge commit 84d69848c9 2016-10-14?

As far as reverting the binutils commit goes, I'm quite willing to do
that if necessary.  You can see how important I think the fix was by
viewing https://sourceware.org/bugzilla/show_bug.cgi?id=4317 and
noticing that the bug was reported in 2007 and didn't see any action
for 8 years..

-- 
Alan Modra
Australia Development Lab, IBM
