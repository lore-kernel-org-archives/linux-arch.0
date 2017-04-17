Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34941 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdDQKc3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2017 06:32:29 -0400
Date: Mon, 17 Apr 2017 12:32:25 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Message-ID: <20170417103225.ycv73fdrfx33e5sd@gmail.com>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
 <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
 <20170411112845.GA15212@gmail.com>
 <20170411114616.otx2f6aw5lcvfc2o@black.fi.intel.com>
 <20170411140907.GD4021@tassilo.jf.intel.com>
 <20170412101804.cxo6h472ns76ukgo@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170412101804.cxo6h472ns76ukgo@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andi Kleen <ak@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170417103225.N1IINjOT-qx3mZheuZd_3rz2CwShbhhxTh6rcjCu6nU@z>


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Tue, Apr 11, 2017 at 07:09:07AM -0700, Andi Kleen wrote:
> > > I'll look closer (building proccess it's rather complicated), but my
> > > understanding is that VDSO is stand-alone binary and doesn't really links
> > > with the rest of the kernel, rather included as blob, no?
> > > 
> > > Andy, may be you have an idea?
> > 
> > There isn't any way I know of to directly link them together. The ELF 
> > format wasn't designed for that. You would need to merge blobs and then use
> > manual jump vectors, like the 16bit startup code does. It would be likely
> > complicated and ugly.
> 
> Ingo, can we proceed without coverting this assembly to C?
> 
> I'm committed to convert it to C later if we'll find reasonable solution
> to the issue.

So one way to do it would be to build it standalone as a .o, then add it not to 
the regular kernel objects link target (as you found out it's not possible to link 
32-bit and 64-bit objects), but to link it in a manual fashion, as part of 
vmlinux.bin.all-y in arch/x86/boot/compressed/Makefile.

But there would be other complications with this approach, such as we'd have to 
add a size field and there might be symbol linking problems ...

Another, pretty hacky way would be to generate a .S from the .c, then post-process 
the .S and essentially generate today's 32-bit .S from it.

Probably not worth the trouble.

Thanks,

	Ingo
