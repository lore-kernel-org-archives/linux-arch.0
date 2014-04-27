Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:49195 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaD0TrY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Apr 2014 15:47:24 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so7031215veb.16
        for <linux-arch@vger.kernel.org>; Sun, 27 Apr 2014 12:47:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140427193355.GA17778@laptop.programming.kicks-ass.net>
References: <1398393700.8437.22.camel@pasglop>
	<CA+55aFyO+-GehPiOAPy7-N0ejFrsNupWHG+j5hAs=R=RuPQtDg@mail.gmail.com>
	<5359CD7C.5020604@zytor.com>
	<CA+55aFzktDDr5zNh-7gDhXW6-7_BP_MvKHEoLi9=td6XvwzaUA@mail.gmail.com>
	<alpine.LSU.2.11.1404250414590.5198@eggly.anvils>
	<20140425135101.GE11096@twins.programming.kicks-ass.net>
	<alpine.LSU.2.11.1404251215280.5909@eggly.anvils>
	<20140426180711.GM26782@laptop.programming.kicks-ass.net>
	<20140427072034.GC1429@laptop.programming.kicks-ass.net>
	<alpine.LSU.2.11.1404270459160.2688@eggly.anvils>
	<20140427193355.GA17778@laptop.programming.kicks-ass.net>
Date: Sun, 27 Apr 2014 12:47:23 -0700
Message-ID: <CA+55aFys4+G7P+-YtoNn0pUsmGwon+B7RdvFg9qqNbBHz_dg3A@mail.gmail.com>
Subject: Re: Dirty/Access bits vs. page content
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>, Dave Hansen <dave.hansen@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140427194723.ncbnWUzLDIGjLrsteLptN4BvlAvx64GGT_3ScMiZgLw@z>

On Sun, Apr 27, 2014 at 12:33 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Oh, absolutely. I wasn't arguing it didn't need it. I was merely
> pointing out that if one was to add to Linus' patch such that we'd only
> do the force_flush for mapping_cap_account_dirty() we wouldn't need
> extra things to deal with shmem.

I think we can certainly add that check if we find out that it is
indeed a performance problem. I *could* imagine loads where people
mmap/munmap shmem regions at a high rate, but don't actually know of
any (remember: for this to matter they also have to dirty the pages).

In the absence of such knowledge, I'd rather not make things more
complex than they already are.

              Linus
