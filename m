Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754844AbdCGKLi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 05:11:38 -0500
Date: Tue, 7 Mar 2017 10:32:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv4 00/33] 5-level paging
In-Reply-To: <20170307114115.768312f4@canb.auug.org.au>
Message-ID: <alpine.DEB.2.20.1703071032040.3584@nanos>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com> <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com> <alpine.DEB.2.20.1703061935220.3771@nanos> <20170307114115.768312f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170307093253.C68bIpJgbNP1qQCek-6oMSdwof8LdA_Q0oOu7ooLtnc@z>

On Tue, 7 Mar 2017, Stephen Rothwell wrote:
> Hi Thomas,
> 
> On Mon, 6 Mar 2017 19:42:05 +0100 (CET) Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > We probably need to split it apart:
> > 
> >    - Apply the mm core only parts to a branch which can be pulled into
> >      Andrews mm-tree
> 
> Andrew's mm-tree is not a git tree it is a quilt series ...

I know, but creating a 'mm-base-5-level.patch' from a git branch is trivial
enough.

Thanks,

	tglx
