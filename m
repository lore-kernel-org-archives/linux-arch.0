From: Benny Halevy <bhalevy-C4P08NqkoRlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [0/3] Improve generic fls64 for 64-bit machines
Date: Thu, 03 Apr 2008 20:19:59 +0300
Message-ID: <47F511BF.8090506@panasas.com>
References: <20080315172913.GA21648@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080315172913.GA21648-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar. 15, 2008, 19:29 +0200, Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org> wrote:
> This series of patches:
> 
> [1/3] adds __fls.h to asm-generic
> [2/3] modifies asm-*/bitops.h for 64-bit archs to implement __fls
> [3/3] modifies asm-generic/fls64.h to make use of __fls

I strongly support this.

I wish we'd also have a consistent naming convention for all
the bitops functions so it will be clearer what data type the
function is working on and is the result 0 or 1 based.

It seems like what we currently have is:

name	type	first bit#
----	----	----------
ffs	int	1
fls	int	1
__ffs	ulong	0
__fls	ulong	0	# in your proposal
ffz	ulong	0
fls64	__u64	1

so it seems like
- ffz is misnamed and is rather confusing.
  Apprently is should be renamed to __ffz.

- (new) ffz(x) can be defined to ffs(~(x))

- It'd be nice to have ffs64, and maybe ffz64.

Benny

> 
> I have compiled i386 and x86_64, and they generate the same code as
> before the change. The changes to the other archs are a best effort.
> Please comment.
> 
> If this patch series is accepted, it will make one tiny bit of
> the x86-unification a tiny bit cleaner. The patches are against
> Linus' current tree.
> 
> Andrew, if no concensus can be reached that this is a bad patch
> series, would you be willing to add this to your tree?
> 
> Greetings,
> 	Alexander
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
