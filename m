From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing access_ok() check
Date: Fri, 15 Mar 2013 10:21:41 -0700
Message-ID: <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
References: <20130315133748.GA31887@Krystal>
	<20130315152326.GM31875@kernel.dk>
	<20130315155808.GB1659@Krystal>
	<CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com>
	<20130315171000.GA2342@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:36628 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab3CORVt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 13:21:49 -0400
Received: by mail-vb0-f41.google.com with SMTP id l22so2056379vbn.28
        for <linux-arch@vger.kernel.org>; Fri, 15 Mar 2013 10:21:41 -0700 (PDT)
In-Reply-To: <20130315171000.GA2342@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, "security@kernel.org" <security@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Piggin <npiggin@kernel.dk>

Adding linux-arch. Guys, can you check your architectures?

Also, make sure to check huge-pages if they are separate. Basically,
if you have code like this:

                if (!pte_present(pte) ||
                    pte_special(pte) || (write && !pte_write(pte))) {
                        pte_unmap(ptep);
                        return 0;
                }

it's probably buggy. It's not sufficient to just check write
permissions, you do need to check user permissions too.

Powerpc,x86 and sh seem to get it right by virtue of checking rthe
user bit. s390 checks against TASK_SIZE.

MIPS does seem buggy. Sparc I don't know the meaning of the bits for.
And powerpc does have several variants, so while the main one looks
fine, I didn't look at the other ones.

                     Linus

On Fri, Mar 15, 2013 at 10:10 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Linus Torvalds (torvalds@linux-foundation.org) wrote:
>>
>> It's a bit subtle, but at least the x86 get-user-pages does actually
>> check access_ok() implicitly. It's just that it does so using the bits
>> in the page table, and does the page table lookup as a "user access".
>> So it checks the page tables themselves, not the user limit.
>>
>> Which is fine, because that's what the *hardware* does. So if the page
>> tables make something readable to users, then they are readable by
>> definition.
>>
>> So get_user_pages_fast() doesn't need access_ok() before it, and the
>> naming isn't actually confusing. And I'm sure we knew this at some
>> point.
>
> Ah, I see! so my guess is that it is expected that "gup_*" functions
> implicitly check that they are getting user pages. If we look at this
> through fresh eyes, across all architectures:
>
> * x86: looks OK: gup* checks with _PAGE_USER flag. The slow path that
>   goes through __get_user_pages() seem to rely on follow_page_mask() and
>   then pgd_bad() as well as pud_bad() to check the _PAGE_USER flag.
>
> * mips: access_ok missing in get_user_pages_fast,
>   -> I don't see any explicit mention of "USER" pages flags within the
>      gup functions.
>
> * powerpc: access_ok is there, everything is fine,
>
> * s390: access_ok missing in both __get_user_pages_fast and
>   get_user_pages_fast.
>   -> I don't see clear indication of USER pages being flagged.
>
> * sh: access_ok missing in get_user_pages_fast,
>   -> OK, gup_* functions are checking a _PAGE_USER flag.
>
> * sparc: access_ok missing in get_user_pages_fast,
>   -> no indication of any _PAGE_USER flag.
>
> * generic: mm/util.c:get_user_pages_fast() ends up calling
>   mm/memory.c:get_user_pages() and then __get_user_pages(), which are
>   also used as slow-path for all architectures above:
>
>   -> from my understanding, through follow_page_mask() pgd_bad() and
>      pud_bad() are checking _PAGE_USER flags (when they exist).
>      Unfortunately, the following grep is slightly worrying:
