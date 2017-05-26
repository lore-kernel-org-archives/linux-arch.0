Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33668 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbdEZP6Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2017 11:58:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so4748667wmh.0
        for <linux-arch@vger.kernel.org>; Fri, 26 May 2017 08:58:15 -0700 (PDT)
Date: Fri, 26 May 2017 18:58:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level
 paging
Message-ID: <20170526155812.gdc6x6pz2howdpjb@node.shutemov.name>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
 <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
 <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170526155812.JnStPVA8VF0IPHQ-CGA4gT9xst8dTkRWb-o53uJixKg@z>

On Fri, May 26, 2017 at 08:51:48AM -0700, Linus Torvalds wrote:
> On Fri, May 26, 2017 at 6:00 AM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> >
> > I don't see how kernel threads can use 4-level paging. It doesn't work
> > from virtual memory layout POV. Kernel claims half of full virtual address
> > space for itself -- 256 PGD entries, not one as we would effectively have
> > in case of switching to 4-level paging. For instance, addresses, where
> > vmalloc and vmemmap are mapped, are not canonical with 4-level paging.
> 
> I would have just assumed we'd map the kernel in the shared part that
> fits in the top 47 bits.
> 
> But it sounds like you can't switch back and forth anyway, so I guess it's moot.
> 
> Where *is* the LA57 documentation, btw? I had an old x86 architecture
> manual, so I updated it, but LA57 isn't mentioned in the new one
> either.

It's in a separate white paper for now:

https://software.intel.com/sites/default/files/managed/2b/80/5-level_paging_white_paper.pdf

-- 
 Kirill A. Shutemov
