From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing
	access_ok() check
Date: Fri, 15 Mar 2013 14:07:52 -0400
Message-ID: <20130315180752.GA3113@Krystal>
References: <20130315133748.GA31887@Krystal> <20130315152326.GM31875@kernel.dk> <20130315155808.GB1659@Krystal> <CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com> <20130315171000.GA2342@Krystal> <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com> <20130315175710.GA2748@Krystal> <CA+55aFwuL-nB=xDfCfP1+Sn2Q0DEruhWcsrp_oP2meEyeF71jg@mail.gmail.com> <CA+55aFy3zUrDL-G+CD2gEJEoG100k56HArKbCrGnQEFCofXcPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:48826 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750920Ab3COSHx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Mar 2013 14:07:53 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFy3zUrDL-G+CD2gEJEoG100k56HArKbCrGnQEFCofXcPQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, "security@kernel.org" <security@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Piggin <npiggin@kernel.dk>

* Linus Torvalds (torvalds@linux-foundation.org) wrote:
> On Fri, Mar 15, 2013 at 11:01 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > get_user_pages() does check permissions. It looks up the vma and
> > checks them there, which is much more than access_ok() ever does.
> 
> To clarify: the fact that a vma exists at all already means "it's a
> user mapping" (with the special gate area being a secondary user
> mapping). So you don't need any kind of explicit user check.

Ah! That's the bit I was missing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
