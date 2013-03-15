From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing access_ok() check
Date: Fri, 15 Mar 2013 11:01:16 -0700
Message-ID: <CA+55aFwuL-nB=xDfCfP1+Sn2Q0DEruhWcsrp_oP2meEyeF71jg@mail.gmail.com>
References: <20130315133748.GA31887@Krystal>
	<20130315152326.GM31875@kernel.dk>
	<20130315155808.GB1659@Krystal>
	<CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com>
	<20130315171000.GA2342@Krystal>
	<CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
	<20130315175710.GA2748@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:57671 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab3COSBR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 14:01:17 -0400
Received: by mail-ve0-f178.google.com with SMTP id db10so2814309veb.23
        for <linux-arch@vger.kernel.org>; Fri, 15 Mar 2013 11:01:16 -0700 (PDT)
In-Reply-To: <20130315175710.GA2748@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, "security@kernel.org" <security@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Piggin <npiggin@kernel.dk>

On Fri, Mar 15, 2013 at 10:57 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> In addition to get_user_pages_fast() issues, I see that there are many
> direct callers of get_user_pages() that seem to assume that access
> checks are performed within this function.

get_user_pages() does check permissions. It looks up the vma and
checks them there, which is much more than access_ok() ever does.

>  AFAIU, on architectures that
> have a _PAGE_USER flag, this check is performed internally by pgd_bad()
> and pud_bad(), but what happens to all the others ?

Irrelevant. See above.

              Linus
