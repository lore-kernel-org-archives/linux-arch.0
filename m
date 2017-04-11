From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Date: Tue, 11 Apr 2017 07:09:07 -0700
Message-ID: <20170411140907.GD4021@tassilo.jf.intel.com>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
 <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
 <20170411112845.GA15212@gmail.com>
 <20170411114616.otx2f6aw5lcvfc2o@black.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9549 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751875AbdDKOJI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 10:09:08 -0400
Content-Disposition: inline
In-Reply-To: <20170411114616.otx2f6aw5lcvfc2o@black.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

> I'll look closer (building proccess it's rather complicated), but my
> understanding is that VDSO is stand-alone binary and doesn't really links
> with the rest of the kernel, rather included as blob, no?
> 
> Andy, may be you have an idea?

There isn't any way I know of to directly link them together. The ELF 
format wasn't designed for that. You would need to merge blobs and then use
manual jump vectors, like the 16bit startup code does. It would be likely
complicated and ugly.

-Andi
