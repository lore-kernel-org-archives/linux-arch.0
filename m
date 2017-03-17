Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35864 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdCRRBV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2017 13:01:21 -0400
Received: by mail-wr0-f180.google.com with SMTP id u108so68877984wrb.3
        for <linux-arch@vger.kernel.org>; Sat, 18 Mar 2017 10:01:20 -0700 (PDT)
Date: Fri, 17 Mar 2017 20:57:14 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above
 47-bits
Message-ID: <20170317175714.3bvpdylaaudf4ig2@node.shutemov.name>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
 <87a88jg571.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a88jg571.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170317175714.XgpJMji6OsM-mI-TmGWgX7KzN5B_dDrFgb6GW0xd75A@z>

On Fri, Mar 17, 2017 at 11:23:54PM +0530, Aneesh Kumar K.V wrote:
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
> 
> > On x86, 5-level paging enables 56-bit userspace virtual address space.
> > Not all user space is ready to handle wide addresses. It's known that
> > at least some JIT compilers use higher bits in pointers to encode their
> > information. It collides with valid pointers with 5-level paging and
> > leads to crashes.
> >
> > To mitigate this, we are not going to allocate virtual address space
> > above 47-bit by default.
> >
> > But userspace can ask for allocation from full address space by
> > specifying hint address (with or without MAP_FIXED) above 47-bits.
> >
> > If hint address set above 47-bit, but MAP_FIXED is not specified, we try
> > to look for unmapped area by specified address. If it's already
> > occupied, we look for unmapped area in *full* address space, rather than
> > from 47-bit window.
> >
> > This approach helps to easily make application's memory allocator aware
> > about large address space without manually tracking allocated virtual
> > address space.
> >
> 
> So if I have done a successful mmap which returned > 128TB what should a
> following mmap(0,...) return ? Should that now search the *full* address
> space or below 128TB ?

No, I don't think so. And this implementation doesn't do this.

It's safer this way: if an library can't handle high addresses, it's
better not to switch it automagically to full address space if other part
of the process requested high address.

-- 
 Kirill A. Shutemov
