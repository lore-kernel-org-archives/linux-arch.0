Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751007AbeGJGM4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Jul 2018 02:12:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6A68r1b090407
        for <linux-arch@vger.kernel.org>; Tue, 10 Jul 2018 02:12:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4kfx7hh3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 10 Jul 2018 02:12:55 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Tue, 10 Jul 2018 07:12:53 +0100
Date: Tue, 10 Jul 2018 08:12:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Can people please check this patch out for cross-arch issues
In-Reply-To: <CA+55aFxWZuFNHKpE0iA+vDJHTyPofSX3BPPOt2UUB2zXSSBZHQ@mail.gmail.com>
References: <CA+55aFxWZuFNHKpE0iA+vDJHTyPofSX3BPPOt2UUB2zXSSBZHQ@mail.gmail.com>
Message-Id: <20180710081249.73ccaac5@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Mon, 9 Jul 2018 16:57:46 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> We have a funny new bugzilla entry for an issue that is 12 years old,
> and not really all that critical, but one that *can* become a problem
> for people who do very specific things.
> 
> What happens is that 'fork()' will cause a re-try (with
> ERESTARTNOINTR) if a signal has come in between the point where the
> fork() started, but before we add the process to the process table.
> The reason is that the signal possibly *should* affect the new child
> process too, but it was never queued to it because we were obviously
> in the process of creating it.
> 
> That's normally entirely a non-issue, and I don't think anybody ever
> imagined it could matter in practice, but apparently there are loads
> where this becomes problematic.
> 
> See kernel bugzilla at
> 
>     https://bugzilla.kernel.org/show_bug.cgi?id=200447
> 
> which has a trial balloon patch for this issue already, to at least
> limit that retry to only signals that actually might affect the child
> (ie not any random signals sent explicitly and directly only to the
> parent process).
> 
> HOWEVER.
> 
> The very first thing I noticed while looking at this was that one of
> the more expensive parts of the fork() retry is actually marking all
> the parent page tables read-only. Now, it's one of _many_ expensive
> parts, and it's not nearly as expensive as all the reference counting
> we do for each page, but it's actually very easy to avoid. When we
> have repeated fork() calls, there's just no point in repeatedly
> marking pages read-only.
> 
> This the attached one-liner patch.
> 
> The reason I'm sending it to the arch people is that while this is a
> totally trivial patch on x86 ("pte_write()" literally tests exactly
> the same bit that "pte_wrprotect()" and "ptep_set_wrprotect()"
> clears), the same is not necessarily always true on other
> architectures.
> 
> Some other architectures make "ptep_set_wrprotect()" do more than just
> clear the one bit we test with "pte_write()".
> 
> Honestly, I don't think it could possibly matter: if "pte_write()"
> returns false, then whatever "ptep_set_writeprotect()" does can not
> really matter (at least for a COW mapping). But I thought I'd send
> this out for comments anyway, despite how trivial it looks.
> 
> So. Comments?
> 
> It doesn't make a huge difference, honestly, and the real fix for the
> "retry too eagerly" is completely different, but at the same time this
> one-liner trivial fix does feel like the RightThing(tm) regardless.

s390 does software dirty-bit tracking which makes the logic for the
page protection more bit more complicated. But !pte_write() always
implies not writable.

As a follow up patch we could remove the pte_write() check in the
s390 version of ptep_set_wrprotect.

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 5ab636089c60..e8f9f3cc676a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1069,8 +1069,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 {
        pte_t pte = *ptep;
 
-       if (pte_write(pte))
-               ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
+       ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
