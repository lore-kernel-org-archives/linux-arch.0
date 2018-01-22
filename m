From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel-hardening] Re: [PATCH v4.1 07/10] x86: narrow out of
 bounds syscalls to sys_read under speculation
Date: Sun, 21 Jan 2018 18:04:37 -0800
Message-ID: <CA+55aFxLOMcSfodeV5WV=n0+tuz7rVs4bEtnfv9qT9c8H0TfLA@mail.gmail.com>
References: <151648235823.34747.15181877619346237802.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151648239535.34747.4422108674633222531.stgit@dwillia2-desk3.amr.corp.intel.com>
 <867402A5-BED8-4A44-9770-7D3B153BEE82@amacapital.net> <CAG48ez3dWLJEoiUOLKRD3e8uJmAz87FNQB5MOLTxJg=y3KahRw@mail.gmail.com>
 <CALCETrVxf06iNYWUxtsBU4ApNSK0jbnEUBoSvnGGQ7z1cyPJ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35803 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeAVCEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Jan 2018 21:04:38 -0500
Received: by mail-io0-f176.google.com with SMTP id m11so7867949iob.2
        for <linux-arch@vger.kernel.org>; Sun, 21 Jan 2018 18:04:38 -0800 (PST)
In-Reply-To: <CALCETrVxf06iNYWUxtsBU4ApNSK0jbnEUBoSvnGGQ7z1cyPJ9A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>, Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@linux.intel.com>

On Sun, Jan 21, 2018 at 5:38 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> 3. What's with sbb; and?  I can see two sane ways to do this.  One is
> cmovaq [something safe], %rax,

Heh. I think it's partly about being old-fashioned. sbb has always
been around, and is the traditional trick for 0/-1.

Also, my original suggested thing did the *access* too, and masked the
result with the same mask.

But I guess we could use cmov instead. It has very similar performance
(ie it was relatively slow on P4, but so was sbb).

However, I suspect it actually has a slightly higher register
pressure, since you'd need to have that zero register (zero being the
"safe" value), and the only good way to get a zero value is the xor
thing, which affects flags and thus needs to be before the cmp.

In contrast, the sbb trick has no early inputs needed.

So on the whole, 'cmov' may be more natural on a conceptual level, but
the sbb trick really is a very "traditional x86 thing" to do.

               Linus
