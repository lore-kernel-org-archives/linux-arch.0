Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43337 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfBYPDP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2019 10:03:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so7461830oib.10
        for <linux-arch@vger.kernel.org>; Mon, 25 Feb 2019 07:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190211163653.97742-1-jannh@google.com> <f89de711-d73b-96be-75b6-0e9054022708@gmail.com>
In-Reply-To: <f89de711-d73b-96be-75b6-0e9054022708@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 25 Feb 2019 16:02:48 +0100
Message-ID: <CAG48ez2h6eavM9YWXYa69OLY7mFFKn1KN=roH2dZJCi7PSSmuQ@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: linux-man <linux-man@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Linux API <linux-api@vger.kernel.org>
Message-ID: <20190225150248.DQNbBtmR_KXsE2AUwm8k0m0lYCzsTJlBJzL7_XBMSME@z>

On Mon, Feb 25, 2019 at 3:55 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 2/11/19 5:36 PM, Jann Horn wrote:
> > The manpage is missing information about the compatibility hack for
> > 5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
> > Allow userspace have mappings above 47-bit"). Add some information about
> > that.
> >
> > While I don't think any hardware supporting this is shipping yet (?), I
> > think it's useful to try to write a manpage for this API, partly to
> > figure out how usable that API actually is, and partly because when this
> > hardware does ship, it'd be nice if distro manpages had information about
> > how to use it.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > This patch goes on top of the patch "[PATCH] mmap.2: fix description of
> > treatment of the hint" that I just sent, but I'm not sending them in a
> > series because I want the first one to go in, and I think this one might
> > be a bit more controversial.
> >
> > It would be nice if the architecture maintainers and mm folks could have
> > a look at this and check that what I wrote is right - I only looked at
> > the source for this, I haven't tried it.
> >
> >  man2/mmap.2 | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/man2/mmap.2 b/man2/mmap.2
> > index 8556bbfeb..977782fa8 100644
> > --- a/man2/mmap.2
> > +++ b/man2/mmap.2
> > @@ -67,6 +67,8 @@ is NULL,
> >  then the kernel chooses the (page-aligned) address
> >  at which to create the mapping;
> >  this is the most portable method of creating a new mapping.
> > +On Linux, in this case, the kernel may limit the maximum address that can be
> > +used for allocations to a legacy limit for compatibility reasons.
> >  If
> >  .I addr
> >  is not NULL,
> > @@ -77,6 +79,19 @@ or equal to the value specified by
> >  and attempt to create the mapping there.
> >  If another mapping already exists there, the kernel picks a new
> >  address, independent of the hint.
> > +However, if a hint above the architecture's legacy address limit is provided
> > +(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
> > +book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
> > +kernel is permitted to allocate mappings beyond the architecture's legacy
> > +address limit. The availability of such addresses is hardware-dependent.
> > +Therefore, if you want to be able to use the full virtual address space of
> > +hardware that supports addresses beyond the legacy range, you need to specify an
> > +address above that limit; however, for security reasons, you should avoid
> > +specifying a fixed valid address outside the compatibility range,
> > +since that would reduce the value of userspace address space layout
> > +randomization. Therefore, it is recommended to specify an address
> > +.I beyond
> > +the end of the userspace address space.
> >  .\" Before Linux 2.6.24, the address was rounded up to the next page
> >  .\" boundary; since 2.6.24, it is rounded down!
> >  The address of the new mapping is returned as the result of the call.
> >
>
> Hi Jann,
>
> A few comments came in on this patch. Is there anything from
> those comments that should be rolled into the text?

Hi!

Yeah, I think all the feedback on the patch were good points, and I'll
have to integrate that into my patch.
