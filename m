From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing
	access_ok() check
Date: Fri, 15 Mar 2013 13:57:10 -0400
Message-ID: <20130315175710.GA2748@Krystal>
References: <20130315133748.GA31887@Krystal> <20130315152326.GM31875@kernel.dk> <20130315155808.GB1659@Krystal> <CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com> <20130315171000.GA2342@Krystal> <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:48816 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753827Ab3COSDz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Mar 2013 14:03:55 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, "security@kernel.org" <security@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Piggin <npiggin@kernel.dk>

* Linus Torvalds (torvalds@linux-foundation.org) wrote:
> Adding linux-arch. Guys, can you check your architectures?
> 
> Also, make sure to check huge-pages if they are separate. Basically,
> if you have code like this:
> 
>                 if (!pte_present(pte) ||
>                     pte_special(pte) || (write && !pte_write(pte))) {
>                         pte_unmap(ptep);
>                         return 0;
>                 }
> 
> it's probably buggy. It's not sufficient to just check write
> permissions, you do need to check user permissions too.
> 
> Powerpc,x86 and sh seem to get it right by virtue of checking rthe
> user bit. s390 checks against TASK_SIZE.
> 
> MIPS does seem buggy. Sparc I don't know the meaning of the bits for.
> And powerpc does have several variants, so while the main one looks
> fine, I didn't look at the other ones.

In addition to get_user_pages_fast() issues, I see that there are many
direct callers of get_user_pages() that seem to assume that access
checks are performed within this function.  AFAIU, on architectures that
have a _PAGE_USER flag, this check is performed internally by pgd_bad()
and pud_bad(), but what happens to all the others ?

One possible way to fix this without adding unwelcomed performance
impact might be to add an access_ok check in __get_user_pages() that is
entirely skipped by architectures that define a non-nopped-out
pgd_bad()/pud_bad().

Thoughts ? 

Thanks,

Mathieu

> 
>                      Linus
> 
> On Fri, Mar 15, 2013 at 10:10 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Linus Torvalds (torvalds@linux-foundation.org) wrote:
> >>
> >> It's a bit subtle, but at least the x86 get-user-pages does actually
> >> check access_ok() implicitly. It's just that it does so using the bits
> >> in the page table, and does the page table lookup as a "user access".
> >> So it checks the page tables themselves, not the user limit.
> >>
> >> Which is fine, because that's what the *hardware* does. So if the page
> >> tables make something readable to users, then they are readable by
> >> definition.
> >>
> >> So get_user_pages_fast() doesn't need access_ok() before it, and the
> >> naming isn't actually confusing. And I'm sure we knew this at some
> >> point.
> >
> > Ah, I see! so my guess is that it is expected that "gup_*" functions
> > implicitly check that they are getting user pages. If we look at this
> > through fresh eyes, across all architectures:
> >
> > * x86: looks OK: gup* checks with _PAGE_USER flag. The slow path that
> >   goes through __get_user_pages() seem to rely on follow_page_mask() and
> >   then pgd_bad() as well as pud_bad() to check the _PAGE_USER flag.
> >
> > * mips: access_ok missing in get_user_pages_fast,
> >   -> I don't see any explicit mention of "USER" pages flags within the
> >      gup functions.
> >
> > * powerpc: access_ok is there, everything is fine,
> >
> > * s390: access_ok missing in both __get_user_pages_fast and
> >   get_user_pages_fast.
> >   -> I don't see clear indication of USER pages being flagged.
> >
> > * sh: access_ok missing in get_user_pages_fast,
> >   -> OK, gup_* functions are checking a _PAGE_USER flag.
> >
> > * sparc: access_ok missing in get_user_pages_fast,
> >   -> no indication of any _PAGE_USER flag.
> >
> > * generic: mm/util.c:get_user_pages_fast() ends up calling
> >   mm/memory.c:get_user_pages() and then __get_user_pages(), which are
> >   also used as slow-path for all architectures above:
> >
> >   -> from my understanding, through follow_page_mask() pgd_bad() and
> >      pud_bad() are checking _PAGE_USER flags (when they exist).
> >      Unfortunately, the following grep is slightly worrying:

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
