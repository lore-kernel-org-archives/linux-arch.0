From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 02/12] array_idx: sanitize speculative array de-references
Date: Tue, 30 Jan 2018 11:38:35 -0800
Message-ID: <CA+55aFxLEL+8YA4MYkeyeUH7K8rZwBmGe6Z9V8QS=TYCREWDTQ@mail.gmail.com>
References: <151703971300.26578.1185595719337719486.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151703972396.26578.7326612698912543866.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180128085500.djlm5rlbhjlpfj4i@gmail.com> <CAPcyv4jTaskPT1qXhdCO2mWVkcaMDMBq12vUJ_hSfjOU49qvgQ@mail.gmail.com>
 <alpine.DEB.2.20.1801281931180.2126@nanos> <CAPcyv4hSZ7=+076s+fmJ0HQ293H4X8829-LTrbvd8ZqJygGV6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35274 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeA3Tig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jan 2018 14:38:36 -0500
In-Reply-To: <CAPcyv4hSZ7=+076s+fmJ0HQ293H4X8829-LTrbvd8ZqJygGV6A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Cyril Novikov <cnovikov@lynx.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jan 29, 2018 at 10:29 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Of course, and everything about the technical feedback and suggestions
> was completely valid, on point, and made the patches that much better.
> What wasn't appreciated and what I am tired of grinning and bearing is
> the idea that it's only the maintainer that can show emotion, that
> it's only the maintainer that can be exasperated and burnt out.

Yeah, I think everybody is a bit tired of - and burnt out by - these
patches, and they are subtler and somewhat more core than most are,
which makes the stakes a bit higher too, and the explanations can be a
bit more difficult.

I think everybody is entitled to being a bit snippy occasionally.
Definitely not just maintainers.

So by all means, push right back.

Anyway, I do think the patches I've seen so far are ok, and the real
reason I'm writing this email is actually more about future patches:
do we have a good handle on where these array index sanitations will
be needed?

Also, while array limit checking was obviously the official
"spectre-v1" issue, I do wonder if there are possible other issues
where mispredicted conditional branches can end up leaking
information?

IOW, is there some work on tooling/analysis/similar? Not asking for
near-term, but more of a "big picture" question..

            Linus
