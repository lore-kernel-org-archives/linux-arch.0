From: Michael Kerrisk <mtk.manpages@googlemail.com>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Mon, 23 Feb 2009 16:31:17 +1300
Message-ID: <cfd18e0f0902221931o453eace4ra234c91e5943411b@mail.gmail.com>
References: <200902222252.45051.sf@sfritsch.de>
	 <20090222224924.GA13157@bombadil.infradead.org>
	 <20090223014224.GB13157@bombadil.infradead.org>
	 <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:28502 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZBWDbS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 22:31:18 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1744517rvb.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2009 19:31:17 -0800 (PST)
In-Reply-To: <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Kyle McMartin <kyle@infradead.org>, linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On 2/23/09, Carlos O'Donell <carlos@systemhalted.org> wrote:
> On Sun, Feb 22, 2009 at 8:42 PM, Kyle McMartin <kyle@infradead.org> wrote:
>>> Definitely a kernel bug, if posix says it should return EWOULDBLOCK...
>
> flock is not POSIX, it's an interface invented by 4.2BSD, and was
> previously emulated by glibc. The glibc wrapper implemented flock with
> fcntl and made sure to return EWOULDBLOCK.
>
>> This is really going to suck, it looks like a lot of the locking
>> primitives used EAGAIN and EWOULDBLOCK interchangeably... The fcntl
>> manpage says 'EAGAIN or EWOULDBLOCK' so is flock(2) the only problem
>> here? From a quick glance at posix, fcntl(2) returning EAGAIN is
>> correct.
>
> I would warn you that the linux man pages are often incorrect.

Hmmm -- "often" is rather strong.  I will certainly allow
"occasionally" (or perhaps a little more), and I note in passing that
for someone making the claim of "often", I never saw a patch from you
so far to correct an error...

Cheers,

Michael
