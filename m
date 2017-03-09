Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33845 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdCIU0M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2017 15:26:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170309142408.2868-1-kirill.shutemov@linux.intel.com>
References: <20170309142408.2868-1-kirill.shutemov@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Mar 2017 12:26:10 -0800
Message-ID: <CA+55aFzwYvtSA-E+eKjPb3AdmziLeZ5y0vfMjVUoJVC=JrmnBg@mail.gmail.com>
Subject: Re: [PATCHv2 0/7] 5-level paging: prepare generic code
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170309202610.oNnzjMNtrYpv2v3M3hMeAcUuR1ROUoZRsPC3owdLChw@z>

On Thu, Mar 9, 2017 at 6:24 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here's relatively low-risk part of 5-level paging patchset.
> Merging it now would make x86 5-level paging enabling in v4.12 easier.
>
> Linus, please consider applying.

Ok, I've applied this to a local branch in my tree for now, I'll wait
some more in case somebody wants to ack/nak before I merge that
branch.

                 Linus
