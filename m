From: Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org>
Subject: [0/3] Improve generic fls64 for 64-bit machines
Date: Sat, 15 Mar 2008 18:29:14 +0100
Message-ID: <20080315172913.GA21648@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This series of patches:

[1/3] adds __fls.h to asm-generic
[2/3] modifies asm-*/bitops.h for 64-bit archs to implement __fls
[3/3] modifies asm-generic/fls64.h to make use of __fls

I have compiled i386 and x86_64, and they generate the same code as
before the change. The changes to the other archs are a best effort.
Please comment.

If this patch series is accepted, it will make one tiny bit of
the x86-unification a tiny bit cleaner. The patches are against
Linus' current tree.

Andrew, if no concensus can be reached that this is a bad patch
series, would you be willing to add this to your tree?

Greetings,
	Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
