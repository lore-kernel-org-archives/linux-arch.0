From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [0/3] Improve generic fls64 for 64-bit machines
Date: Fri, 21 Mar 2008 14:10:51 +0100
Message-ID: <20080321131046.GG27245@elte.hu>
References: <20080315172913.GA21648@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080315172913.GA21648-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


* Alexander van Heukelum <heukelum-hWlb6USbxJRiLUuM0BA3LQ@public.gmane.org> wrote:

> This series of patches:
> 
> [1/3] adds __fls.h to asm-generic
> [2/3] modifies asm-*/bitops.h for 64-bit archs to implement __fls
> [3/3] modifies asm-generic/fls64.h to make use of __fls
> 
> I have compiled i386 and x86_64, and they generate the same code as 
> before the change. The changes to the other archs are a best effort. 
> Please comment.

i've applied #1 and #3 to x86.git/testing, to see how this works out on 
x86. But it looks good to me in general.

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
