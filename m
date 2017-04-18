From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Date: Tue, 18 Apr 2017 13:15:34 +0300
Message-ID: <20170418101534.oa3mchqyap2yvh7v@node.shutemov.name>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
 <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
 <20170411112845.GA15212@gmail.com>
 <20170411114616.otx2f6aw5lcvfc2o@black.fi.intel.com>
 <20170411140907.GD4021@tassilo.jf.intel.com>
 <20170412101804.cxo6h472ns76ukgo@node.shutemov.name>
 <20170417103225.ycv73fdrfx33e5sd@gmail.com>
 <20170418085926.bzdzs2wwxjmdxqxm@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35399 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbdDRKPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2017 06:15:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so24003327wrc.2
        for <linux-arch@vger.kernel.org>; Tue, 18 Apr 2017 03:15:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170418085926.bzdzs2wwxjmdxqxm@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue, Apr 18, 2017 at 11:59:26AM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 17, 2017 at 12:32:25PM +0200, Ingo Molnar wrote:
> > 
> > * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > > On Tue, Apr 11, 2017 at 07:09:07AM -0700, Andi Kleen wrote:
> > > > > I'll look closer (building proccess it's rather complicated), but my
> > > > > understanding is that VDSO is stand-alone binary and doesn't really links
> > > > > with the rest of the kernel, rather included as blob, no?
> > > > > 
> > > > > Andy, may be you have an idea?
> > > > 
> > > > There isn't any way I know of to directly link them together. The ELF 
> > > > format wasn't designed for that. You would need to merge blobs and then use
> > > > manual jump vectors, like the 16bit startup code does. It would be likely
> > > > complicated and ugly.
> > > 
> > > Ingo, can we proceed without coverting this assembly to C?
> > > 
> > > I'm committed to convert it to C later if we'll find reasonable solution
> > > to the issue.
> > 
> > So one way to do it would be to build it standalone as a .o, then add it not to 
> > the regular kernel objects link target (as you found out it's not possible to link 
> > 32-bit and 64-bit objects), but to link it in a manual fashion, as part of 
> > vmlinux.bin.all-y in arch/x86/boot/compressed/Makefile.
> > 
> > But there would be other complications with this approach, such as we'd have to 
> > add a size field and there might be symbol linking problems ...
> > 
> > Another, pretty hacky way would be to generate a .S from the .c, then post-process 
> > the .S and essentially generate today's 32-bit .S from it.
> > 
> > Probably not worth the trouble.
> 
> So, do I need to do anything else to get part 4 applied?

Doh!

I've just realized we don't really need to enable 5-level paging in
decompression code. Leaving 4-level paging there works perfectly fine.

I'll drop changes to arch/x86/boot/compressed/head_64.S and resubmit the
patchset.

-- 
 Kirill A. Shutemov
