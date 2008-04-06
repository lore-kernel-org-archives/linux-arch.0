From: "Alexander van Heukelum" <heukelum-97jfqw80gc6171pxa8y+qA@public.gmane.org>
Subject: Re: [0/3] Improve generic fls64 for 64-bit machines
Date: Sun, 06 Apr 2008 21:10:50 +0200
Message-ID: <1207509050.21093.1246359933@webmail.messagingengine.com>
References: <20080315172913.GA21648@mailshack.com> <47F511BF.8090506@panasas.com>
   <20080404142214.GA8322@mailshack.com> <47F8E64C.9030104@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47F8E64C.9030104-C4P08NqkoRlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benny Halevy <bhalevy-C4P08NqkoRlBDgjK7y7TUQ@public.gmane.org>, Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sun, 06 Apr 2008 18:03:40 +0300, "Benny Halevy" <bhalevy-C4P08NqkoRlBDgjK7y7TUQ@public.gmane.org>
said:
> On Apr. 04, 2008, 17:22 +0300, Alexander van Heukelum
> <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org> wrote:
> > On Thu, Apr 03, 2008 at 08:19:59PM +0300, Benny Halevy wrote:
> >> On Mar. 15, 2008, 19:29 +0200, Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org> wrote:
> >>> This series of patches:
> >>>
> >>> [1/3] adds __fls.h to asm-generic
> >>> [2/3] modifies asm-*/bitops.h for 64-bit archs to implement __fls
> >>> [3/3] modifies asm-generic/fls64.h to make use of __fls
> >> I strongly support this.
> >>
> >> I wish we'd also have a consistent naming convention for all
> >> the bitops functions so it will be clearer what data type the
> >> function is working on and is the result 0 or 1 based.
> >>
> >> It seems like what we currently have is:
> >>
> >> name	type	first bit#
> >> ----	----	----------
> >> ffs	int	1
> >> fls	int	1
> >> __ffs	ulong	0
> >> __fls	ulong	0	# in your proposal
> >> ffz	ulong	0
> >> fls64	__u64	1
> >>
> >> so it seems like
> >> - ffz is misnamed and is rather confusing.
> >>   Apprently is should be renamed to __ffz.
> >>
> >> - (new) ffz(x) can be defined to ffs(~(x))
> >>
> >> - It'd be nice to have ffs64, and maybe ffz64.
> >>
> >> Benny
> > 
> > I think every programmer who thinks in terms of bits realises
> > that ffz(x) == __ffs(~x) and ffz(~x) == __ffs(x) etc... so I
> > would rather get rid of ffz entirely by converting all uses
> > to __ffs. Patch (against current linus) below. After that all
> > implementations of ffz could be removed.
> 
> Yeah, very few architectures have an optimized version of ffz
> that will perform noticeably better than __ffs(~x).
> (e.g. h8300, sh)

Yeah, and these implementations seem to be based on a loop over
all bits in the word. I don't think adding one extra not-operation
to convert ffz to __ffs will hurt much ;).

> > ffs64 would be a good addition to complete the set of functions,
> > but that would be the same as glibc's (and gcc-builtin) ffsll.
> > 
> > Looking into that... the relevant gcc builtins are __builtin_ffs
> > (find first set bit), __builtin_clz (count leading zeroes),
> > __builtin_ctz (count trailing zeroes), __builtin_popcount, maybe
> > __builtin_parity and their -l and -ll variants. Maybe the kernel
> > should be changed to use those names instead of the current
> > ones? ffs would stay as it is. __ffs would become ctz, __fls
> > would become something like 31-clz, and hweight would become
> > popcount.
> 
> Interesting idea.  ctz much better than __ffs with regards to the
> return value's first bit number, but unless you expose clz
> and convert the code how do you get rid of the __fls vs. fls
> confusion?

Exposing clz/ctz on all architectures will be the harder part. Changing
all current uses of ffs/fls (and __fls) will take some time. Mostly
because converting code using fls to use clz instead needs to be
done a bit carefully, because fls(0) has defined behaviour, while
clz(0) is undefined.

> (BTW for __fls, I'd use BITS_PER_LONG - 1, not 31 :)

:)

> I think that adopting libc's convention might make more sense,
> i.e., define ffs, ffsl, ffsll, and fls, flsl, flsll, and have *all*
> be 1-based.

I agree that it makes sense for fls. For clz (and ctz) I would choose
clz(unsigned long), clz32(u32), and clz64(u64).

Greetings,
    Alexander

> Benny
-- 
  Alexander van Heukelum
  heukelum-97jfqw80gc6171pxa8y+qA@public.gmane.org

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own
