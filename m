Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:28090 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190AbXFFAtE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jun 2007 20:49:04 -0400
Received: from spaceape9.eur.corp.google.com (spaceape9.eur.corp.google.com [172.28.16.143])
	by smtp-out.google.com with ESMTP id l560n0X1027082
	for <linux-arch@vger.kernel.org>; Wed, 6 Jun 2007 01:49:00 +0100
Received: from py-out-1112.google.com (pygy77.prod.google.com [10.34.226.77])
	by spaceape9.eur.corp.google.com with ESMTP id l560mpFh030484
	for <linux-arch@vger.kernel.org>; Wed, 6 Jun 2007 01:48:55 +0100
Received: by py-out-1112.google.com with SMTP id y77so3413801pyg
        for <linux-arch@vger.kernel.org>; Tue, 05 Jun 2007 17:48:55 -0700 (PDT)
Message-ID: <65dd6fd50706051748y2e7791c3q41722f0d7d536312@mail.gmail.com>
Date: Tue, 5 Jun 2007 17:48:54 -0700
From: "Ollie Wild" <aaw@google.com>
Subject: Re: [PATCH 4/4] mm: variable length argument support
In-Reply-To: <20070605163925.bfc417ca.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070605150523.786600000@chello.nl>
	 <20070605151203.790585000@chello.nl>
	 <20070605163925.bfc417ca.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

OK.  It sounds like a healthy dose of comments is in order.  I'll
clean things up and send out a new patch sometime tonight or tomorrow.

Additional comments inline below:

> > -             len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
> > -             if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
> > +             len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
> > +             if (!len || len > MAX_ARG_STRLEN)
>
> strnlen_user() is a scary function.  Please do remember that if the memory
> we just strlen'ed is writeable by any user thread then that thread can at
> any time invalidate the number which the kernel now holds.

At this point, we've already called setup_arg_pages(), so the user
memory is our own private copy.  No other threads can access it.

> > -                     !(len = strnlen_user(compat_ptr(str), bprm->p))) {
> > +                 !(len = strnlen_user(compat_ptr(str), MAX_ARG_STRLEN))) {
> >                       ret = -EFAULT;
> >                       goto out;
> >               }
> >
> > -             if (bprm->p < len)  {
> > +             if (MAX_ARG_STRLEN < len) {
> >                       ret = -E2BIG;
> >                       goto out;
> >               }
>
> Do we have an off-by-one here?  Should it be <=?

No, strnlen_user() returns N+1 (where N==MAX_ARG_STRLEN) if the string
is too large.

> If not, then this code is relying upon the string's terminating \0 coming
> from userspace?  If so, that's buggy: userspace can overwrite the \0 after
> we ran the strnlen_user(), perhaps, and confound the kernel?

If that's the case, then we will fail to copy the null terminator, and
the string will munge into the following string.  Since we always
access this data via the various userspace access routines, we will
either return an error on a later operation, or the new process will
segfault shortly upon starting.

> > +             vma_adjust(vma, new_start, old_end,
> > +                        vma->vm_pgoff - (-shift >> PAGE_SHIFT), NULL);
>
> hm, a right-shift of a negated unsigned value.  That's pretty unusual.  I
> hope you know what you're doing ;)

This is correct.  In this case, shift is already populated with a
negative, wrapped unsigned value.  The -shift is needed to make it
positive before the bitwise shift.

> >  #define EXTRA_STACK_VM_PAGES 20      /* random */
> >
> > +/* Finalizes the stack vm_area_struct.  The flags and permissions are updated,
> > + * the stack is optionally relocated, and some extra space is added.
> > + */
>
> That's better.
>
> But what extra space is added, and why?

We add EXTRA_STACK_VM_PAGES.  To be honest, I think neither of us know
why this is done.  It's just what the old code did, so we preserved
it.

Ollie
