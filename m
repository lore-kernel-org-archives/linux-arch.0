Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34355 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934666AbdEZPvu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2017 11:51:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com> <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 May 2017 08:51:48 -0700
Message-ID: <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170526155148.Fuc39ttMebpfgw9YIG6I4Uwy2egtayLIx_Ari6ZJi8I@z>

On Fri, May 26, 2017 at 6:00 AM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> I don't see how kernel threads can use 4-level paging. It doesn't work
> from virtual memory layout POV. Kernel claims half of full virtual address
> space for itself -- 256 PGD entries, not one as we would effectively have
> in case of switching to 4-level paging. For instance, addresses, where
> vmalloc and vmemmap are mapped, are not canonical with 4-level paging.

I would have just assumed we'd map the kernel in the shared part that
fits in the top 47 bits.

But it sounds like you can't switch back and forth anyway, so I guess it's moot.

Where *is* the LA57 documentation, btw? I had an old x86 architecture
manual, so I updated it, but LA57 isn't mentioned in the new one
either.

                       Linus
