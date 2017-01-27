Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35655 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbdA0OCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2017 09:02:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id d140so58713529wmd.2
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2017 06:02:03 -0800 (PST)
Date: Fri, 27 Jan 2017 16:55:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 03/29] asm-generic: introduce __ARCH_USE_5LEVEL_HACK
Message-ID: <20170127135506.GB7662@node.shutemov.name>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-4-kirill.shutemov@linux.intel.com>
 <ed79cc79-8ea6-c2c3-189f-919004711d3f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed79cc79-8ea6-c2c3-189f-919004711d3f@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170127135506.v35KJ2CoBYVo-FkgrOvfVG4F12oHRSLqlCkcz4LCqyM@z>

On Fri, Jan 27, 2017 at 02:24:58PM +0100, Vlastimil Babka wrote:
> On 12/27/2016 02:53 AM, Kirill A. Shutemov wrote:
> >We are going to introduce <asm-generic/pgtable-nop4d.h> to provide
> >abstraction for properly (in opposite to 5level-fixup.h hack) folded
> >p4d level. The new header will be included from pgtable-nopud.h.
> >
> >If an architecture uses <asm-generic/nop*d.h>, we cannot use
> >5level-fixup.h directly to quickly convert the architecture to 5-level
> >paging as it would conflict with pgtable-nop4d.h.
> >
> >With this patch an architecture can define __ARCH_USE_5LEVEL_HACK before
> >inclusion <asm-genenric/nop*d.h> to 5level-fixup.h.
> >
> >Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >---
> > include/asm-generic/pgtable-nop4d-hack.h | 62 ++++++++++++++++++++++++++++++++
> 
> At risk of bikeshedding and coming from somebody not familiar with this
> code... IMHO it would be somewhat more intuitive and consistent to name the
> file "pgtable-nopud-hack.h" as it's about the pud stuff, not p4d stuff, and
> acts as an alternative implementation to pgtable-nopud.h, not
> pgtable-nop4d.h

Well, on other hand we hack-in p4d level here...

I don't really care. Either way works for me.

-- 
 Kirill A. Shutemov
