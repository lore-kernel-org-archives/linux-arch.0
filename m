From: Michael Kerrisk <mtk.manpages@googlemail.com>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Mon, 23 Feb 2009 17:01:49 +1300
Message-ID: <cfd18e0f0902222001o2c7c7877p9e8ebba5bce56223@mail.gmail.com>
References: <200902222252.45051.sf@sfritsch.de>
	 <20090222224924.GA13157@bombadil.infradead.org>
	 <20090223014224.GB13157@bombadil.infradead.org>
	 <cfd18e0f0902221920o3fafe56w73e3534dfe355abb@mail.gmail.com>
	 <20090223035029.GD13157@bombadil.infradead.org>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:25600 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZBWEBt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 23:01:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1754976rvb.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2009 20:01:49 -0800 (PST)
In-Reply-To: <20090223035029.GD13157@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@infradead.org>
Cc: linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On 2/23/09, Kyle McMartin <kyle@infradead.org> wrote:
> On Mon, Feb 23, 2009 at 04:20:53PM +1300, Michael Kerrisk wrote:
>> * POSIX has no specification of flock() (only fcntl() locking is
>> specified by POSIX.1).
>>
>
> *nod* My mistake.
>
>> * My understanding is that EAGAIN originated on System V, and was the
>> error returned instead of blocking for system calls performing I/O,
>> semaphore operations, message queue operations, and (fcntl()) file
>> locking.  EWOULDBLOCK originated on BSD, and was returned by (flock())
>> file locking and socket-related system calls.
>>
>> * flock() is a BSDism, and the associated error was EWOULDBLOCK.
>>
>> * Generally POSIX requires that each error name must have  distinct
>> associated value.  EAGAIN and EWOULDBLOCK are one of the few
>> exceptions: POSIX permits, but does not require, that these error
>> constants have the same value.  On most systems they of course do have
>> the same value.  HP-UX is the most notable exception.
>>
>
> You appear to be be quite correct, I would imagine this is 'hysterical
> raisins.'

I suspect it comes from HP-UX's history of trying to ride two horses
(BSD and System V) in the days before standards had something to say
about it all, but that's just a guess on my part.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
