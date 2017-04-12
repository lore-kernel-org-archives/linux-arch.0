From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Date: Wed, 12 Apr 2017 13:18:04 +0300
Message-ID: <20170412101804.cxo6h472ns76ukgo@node.shutemov.name>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
 <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
 <20170411112845.GA15212@gmail.com>
 <20170411114616.otx2f6aw5lcvfc2o@black.fi.intel.com>
 <20170411140907.GD4021@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36490 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdDLKSJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 06:18:09 -0400
Received: by mail-wr0-f172.google.com with SMTP id c55so14259342wrc.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Apr 2017 03:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170411140907.GD4021@tassilo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue, Apr 11, 2017 at 07:09:07AM -0700, Andi Kleen wrote:
> > I'll look closer (building proccess it's rather complicated), but my
> > understanding is that VDSO is stand-alone binary and doesn't really links
> > with the rest of the kernel, rather included as blob, no?
> > 
> > Andy, may be you have an idea?
> 
> There isn't any way I know of to directly link them together. The ELF 
> format wasn't designed for that. You would need to merge blobs and then use
> manual jump vectors, like the 16bit startup code does. It would be likely
> complicated and ugly.

Ingo, can we proceed without coverting this assembly to C?

I'm committed to convert it to C later if we'll find reasonable solution
to the issue.

We're pretty late into release cycle. It would be nice to give the whole
thing time in tip/master and -next before the merge window.

Can I repost part 4?

-- 
 Kirill A. Shutemov
