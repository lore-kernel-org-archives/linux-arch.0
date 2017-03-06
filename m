Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:34855 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbdCFTmn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2017 14:42:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170306190911.GB27719@node.shutemov.name>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
 <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
 <alpine.DEB.2.20.1703061935220.3771@nanos> <CA+55aFyL7UDP4AyscTOO=pxYuFG2GkG_rbEPgqBMBwkEi7t3vw@mail.gmail.com>
 <20170306190911.GB27719@node.shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Mar 2017 11:35:09 -0800
Message-ID: <CA+55aFyykmVyUmT+oQ-1-uUrLGht7qrAAWHxP7aFPgsoeV1uhA@mail.gmail.com>
Subject: Re: [PATCHv4 00/33] 5-level paging
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170306193509.sXdIyeaC1YF49nFJCHU6-IEimK6vFBWk2RCfMl52NgA@z>

On Mon, Mar 6, 2017 at 11:09 AM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> The first 7 patches are relatively low-risk. It would be nice to have them
> in earlier.

Ok, I gave those another look since you mentioned them in particular,
and they still look fine and non-controversial to me. I'd be willing
to take them directly, and into 4.11, to make future integration
eastier and avoid conflicts with other mm code during the 4.12 merge
window.

Just looking at my own inbox, I would suggest that maybe you should
send that small early series as a separate patch series, because those
patches actually got mixed up in my inbox with all the other patches
in the series. Email sending in quick succession does not tend to keep
things ordered. I suspect that happened to others too.

We might have people who are *not* willing to look at the whole
33-patch series that has a lot of x86 code in it, but are willing to
look through the first 7 emails when they are clearly separated out..

                  Linus
