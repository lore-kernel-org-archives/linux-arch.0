Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbdCFSmp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2017 13:42:45 -0500
Date: Mon, 6 Mar 2017 19:42:05 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv4 00/33] 5-level paging
In-Reply-To: <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703061935220.3771@nanos>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com> <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170306184205.J3ntRxr9LvzUi9xFOgN6Q6lwER5ZWfkPM3_fQvGJNR4@z>

On Mon, 6 Mar 2017, Linus Torvalds wrote:

> On Mon, Mar 6, 2017 at 5:53 AM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > Here is v4 of 5-level paging patchset. Please review and consider applying.
> 
> I think we should just aim for this being in 4.12. I don't see any
> real reason to delay merging it, the main question in my mind is which
> tree it would go through. A separate x86 -tip branch, or Andrew's mm
> tree or me just pulling directly, or what?

We can take it through -tip and I prefer to do so as there are other
changes in the page table code lurking.

We probably need to split it apart:

   - Apply the mm core only parts to a branch which can be pulled into
     Andrews mm-tree

   - Base the x86 changes on top of it

So both worlds can work on top of the mm core parts (almost
independently). From what I have seen so far, it's more likely that we get
delta changes/fixes on the x86 side than on the mm core side. And if we get
changes on the mm core side, we can deal with that via the seperate mm core
branch.

Andrew, does that work for you?

Thanks,

	tglx
