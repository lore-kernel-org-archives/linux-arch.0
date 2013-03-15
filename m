From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing access_ok() check
Date: Fri, 15 Mar 2013 11:04:31 -0700
Message-ID: <CA+55aFy3zUrDL-G+CD2gEJEoG100k56HArKbCrGnQEFCofXcPQ@mail.gmail.com>
References: <20130315133748.GA31887@Krystal>
	<20130315152326.GM31875@kernel.dk>
	<20130315155808.GB1659@Krystal>
	<CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com>
	<20130315171000.GA2342@Krystal>
	<CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
	<20130315175710.GA2748@Krystal>
	<CA+55aFwuL-nB=xDfCfP1+Sn2Q0DEruhWcsrp_oP2meEyeF71jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:34516 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab3COSEd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 14:04:33 -0400
Received: by mail-vc0-f175.google.com with SMTP id hf12so1444168vcb.6
        for <linux-arch@vger.kernel.org>; Fri, 15 Mar 2013 11:04:31 -0700 (PDT)
In-Reply-To: <CA+55aFwuL-nB=xDfCfP1+Sn2Q0DEruhWcsrp_oP2meEyeF71jg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, "security@kernel.org" <security@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Piggin <npiggin@kernel.dk>

On Fri, Mar 15, 2013 at 11:01 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> get_user_pages() does check permissions. It looks up the vma and
> checks them there, which is much more than access_ok() ever does.

To clarify: the fact that a vma exists at all already means "it's a
user mapping" (with the special gate area being a secondary user
mapping). So you don't need any kind of explicit user check.

              Linus
