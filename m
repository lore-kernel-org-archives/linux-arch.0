From: "Carlos O'Donell" <carlos@systemhalted.org>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Sun, 22 Feb 2009 22:00:45 -0500
Message-ID: <119aab440902221900u14b88554ha86ac40093f76c33@mail.gmail.com>
References: <200902222252.45051.sf@sfritsch.de>
	 <20090222224924.GA13157@bombadil.infradead.org>
	 <20090223014224.GB13157@bombadil.infradead.org>
	 <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
	 <20090223025414.GC13157@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:9163 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbZBWDAq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 22:00:46 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1112824qwi.37
        for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2009 19:00:45 -0800 (PST)
In-Reply-To: <20090223025414.GC13157@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@infradead.org>
Cc: linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On Sun, Feb 22, 2009 at 9:54 PM, Kyle McMartin <kyle@infradead.org> wrote:
>> A more robust solution would be?
>>
>> if ((ret == -EAGAIN) || (ret == -EWOULDBLOK))
>>         ret = -EWOULDBLOCK
>>
>> This covers our ass since POSIX says that EAGAIN and EWOULDBLOCK *may*
>> be the same.
>>
>
> I have no idea what you're on about here, this is a parisc specific
> file, where we know they aren't. I don't want to pollute generic linux
> code with workarounds for moronic HPUX "let's be different for
> difference sake" crap.

If sys_flock can return one of -EAGAIN or -WOULDBLOCK, perhaps because
the generic code uses them interchangeably, then a more robust
solution is to check for both, and *then* return the expected value to
userspace.

Would this be a possible solution:
1) Make EAGAIN and EWOULDBLOCK the same for the kernel.
2) Leave the values the same for userspace.
3) Add wrappers in the parisc specific kernel code when a syscall need
to return one of EAGAIN or EWOULDBLOCK to userspace?

Cheers,
Carlos.
