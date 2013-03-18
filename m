From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing access_ok()
 check
Date: Mon, 18 Mar 2013 07:51:39 +0100
Message-ID: <1363589499.21545.5.camel@pasglop>
References: <20130315133748.GA31887@Krystal>
	 <20130315152326.GM31875@kernel.dk> <20130315155808.GB1659@Krystal>
	 <CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com>
	 <20130315171000.GA2342@Krystal>
	 <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47953 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab3CRG4O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Mar 2013 02:56:14 -0400
In-Reply-To: <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, "security@kernel.org" <security@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Piggin <npiggin@kernel.dk>

On Fri, 2013-03-15 at 10:21 -0700, Linus Torvalds wrote:
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

Took the train half way through... I assume we are talking gup_fast
here ? So we have an access_ok() accross the range, which should make
us safe. Additionally on ppc64 we have a different pgd for user and
kernel pages anyway.

We do check for huge pages at every level as far as I can tell (and
those are user only) and finally we check for _PAGE_USER.

The only "subtlety" I can think of is that PROT_NONE has no _PAGE_USER
for us and thus will fail a gup but that's expected right ?

Cheers,
Ben.
