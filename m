Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34116 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdDKL2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2017 07:28:50 -0400
Date: Tue, 11 Apr 2017 13:28:45 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Message-ID: <20170411112845.GA15212@gmail.com>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
 <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170411112845.Q2Hb4HNNik0Fm8rz9nUx6Zord8w3nW90b1COVxJC_qI@z>


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Tue, Apr 11, 2017 at 09:02:03AM +0200, Ingo Molnar wrote:
> > I realize that you had difficulties converting this to C, but it's not going to 
> > get any easier in the future either, with one more paging mode/level added!
> > 
> > If you are stuck on where it breaks I'd suggest doing it gradually: first add a 
> > trivial .c, build and link it in and call it separately. Then once that works, 
> > move functionality from asm to C step by step and test it at every step.
> 
> I've described the specific issue with converting this code to C in cover
> letter: how to make compiler to generate 32-bit code for a specific
> function or translation unit, without breaking linking afterwards (-m32
> break it).

Have you tried putting it into a separate .c file, and building it 32-bit?

I think arch/x86/entry/vdso/Makefile contains an example of how to build 32-bit 
code even on 64-bit kernels.

Thanks,

	Ingo
