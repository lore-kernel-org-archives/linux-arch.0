Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:53756 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966015AbbBCT17 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Feb 2015 14:27:59 -0500
Date: Tue, 3 Feb 2015 13:27:30 -0600
From: Josh Cartwright <joshc@ni.com>
Subject: Re: __HAVE_ARCH_CMPXCHG on ARM?
Message-ID: <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
MIME-Version: 1.0
In-Reply-To: <20150202133933.GD31847@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Yong Zhang <yong.zhang0@gmail.com>, Yong Zhang <yong.zhang@windriver.com>, Nathan Sullivan <nathan.sullivan@ni.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org
Message-ID: <20150203192730.Tx93783EUbqRTrQfvnGIHDEGkFt60e2cgjP-m5Mwjcs@z>

On Mon, Feb 02, 2015 at 01:39:33PM +0000, Will Deacon wrote:
> On Fri, Jan 30, 2015 at 08:44:48AM +0000, Yong Zhang wrote:
> > On Fri, Jan 30, 2015 at 2:56 AM, Nathan Sullivan <nathan.sullivan@ni.com<mailto:nathan.sullivan@ni.com>> wrote:
> > 
> > While investigating a performance issue on RT 3.14, I noticed that
> > __HAVE_ARCH_CMPXCHG is not defined for ARM.  This causes -rt locks to
> > always use the slow path and impacts performance.  ARMv6 and above
> > have a cmpxchg implementation already that will work just fine.
> > 
> > In 2012, Yong Zhang submitted a patch to fix this[1], but it mysteriously
> > disappeared afterwards.  I did notice that the s-o-b line has a different
> > email address than the windriver one.  Yong, do you mind re-submitting the
> > 
> > It actually doesn't matter. Anyway feel free to add another s-o-b to
> > the patch:
> > 
> > Signed-off-by: Yong Zhang <yong.zhang@windriver.com<mailto:yong.zhang@windriver.com>>

I did a quick scan of architectures and looked at the various cmpxchg
implementations.  Assuming that __HAVE_ARCH_CMPXCHG really means "this
architecture implements a native cmpxchg which is faster than the
generic implementation", I put what I found in the following table; note
that I'm not 100% confident these are correct, as in some instances I
had to make a judgement call as to whether the implementation is "fast",
hopefully it's still useful :).

                 native         native
                cmpxchg (UP)   cmpxchg (SMP)    __HAVE_ARCH_CMPXCHG
          alpha     X               X                      X
            arc     X[1]            X[1]
arm (pre ARMv6)                    [2]
   arm (ARMv6+)     X               X
          arm64     X               X
          avr32     X               X                      X
       blackfin                     X
            c6x                    [2]
           cris                    [3]
            frv     X               X
        hexagon     X               X                      X
           ia64     X               X                      X
           m32r     X               X                      X
           m68k     X[4]            X[4]                   X[4]
          metag     X               X                      X
     microblaze                    [2]
           mips     X               X
        mn10300                     X[5]
          nios2                    [2]
       openrisc                    [6]
         parisc     X               X                      X
        powerpc     X               X                      X
           s390     X               X                      X
          score    [7]             [7]                     X[7]
             sh     X               X                      X
          sparc     X               X                      X
           tile     X               X
      unicore32                    [2]
            x86     X               X                      X
         xtensa     X               X

1: Conditional on CONFIG_ARC_HAS_LLSC
2: SMP not a supported configuration
3: No cmpxchg() implementation at all?
4: Conditional on CONFIG_RMW_INSNS
5: Conditional on CONFIG_MN10300_HAS_ATOMIC_OPS_UNIT
6: SMP not supported?  Uses generic cmpxchg.
7: Should use generic cmpxchg/cmpxchg_local?  Setting __HAVE_ARCH_CMPXCHG a bug?

> > +#define __HAVE_ARCH_CMPXCHG 1
> 
> Is it even possible to have CONFIG_SMP=y on an architecture that doesn't
> support native cmpxchg? Certainly, the asm-generic cmpxchg.h barfs if
> SMP, so couldn't we just change/extend the __HAVE_ARCH_CMPXCHG check in
> rtmutex.c to work automatically with SMP architectures? That would help
> arm64 too.

Looks like there are a few arch-specific conditionals that might need to
be worked out for arc, m68k, and mn10300; but this could potentially
work.

If we don't go down that route, we should probably at least add
__HAVE_ARCH_CMPXCHG for arm64, blackfin (on SMP), frv, mips, tile, and
xtensa as well.

  Josh
