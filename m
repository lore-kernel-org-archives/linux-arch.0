From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sun, 21 Aug 2016 02:40:30 +0100
Message-ID: <20160821014020.GW2356@ZenIV.linux.org.uk>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk>
 <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
 <20160821001141.GV2356@ZenIV.linux.org.uk>
 <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
 <CA+55aFwgPkDE7AUQ3vDrDgE384B5JGQ3XV3pjQ2tyuWc56M9Kg@mail.gmail.com>
 <DEDD7B96-A44C-4992-A1C3-067D607EB419@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57336 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcHUBlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2016 21:41:18 -0400
Content-Disposition: inline
In-Reply-To: <DEDD7B96-A44C-4992-A1C3-067D607EB419@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jakub Jelinek <jakub@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>

On Sat, Aug 20, 2016 at 06:09:15PM -0700, H. Peter Anvin wrote:

> >Sorry for the bogus noise. I don't know why I was so convinced setjmp
> >needed special gcc semantics.
> >
> >             Linus
> 
> I think the specific name setjmp() is magic in gcc.

It is; attribute equivalent is returns_twice.  I wonder if "explicitly
clobber everything if we got false" + asm volatile to prevent reordering
would suffice for our purposes, but that's really a question for gcc
folks...
