From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Wed, 1 Jun 2011 16:15:09 -0400
Message-ID: <4DE69DCD.7010608@tilera.com>
References: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com> <201105292027.10350.arnd@arndb.de> <1306704624.3001.1206.camel@localhost> <tOr60tkHMHA.716@exchange1.tad.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([206.83.70.75]:30041 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1FAUPR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2011 16:15:17 -0400
In-Reply-To: <tOr60tkHMHA.716@exchange1.tad.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On 5/29/2011 5:57 PM, Arnd Bergmann wrote:
> On Sunday 29 May 2011 23:30:24 Jonas Bonn wrote:
>>> * remove all __ARCH_WANT_* from asm/unistd.h and use the generic glibc
>>>   implementation.
>>
>> I tried this earlier but ran into issues with uClibc, which is the only
>> libc port that we currently have.  Is uClibc known to be compatible with
>> the reduced set of syscalls?
>>
>> A good compromise here may be to submit the patch upstream with the
>> reduced set of syscalls but to maintain a separate tree locally that
>> reenables these for use with our current uClibc port until we can get it
>> straightened out.  It would be good to know, however, what's known to be
>> working for others in this area...
> 
> I don't think that there is a port today, but you can maybe Chris Metcalf,
> Guan Xuetao or Linas Vepstas know more about this, as they have all
> worked on the glibc support for the generic syscall interface.

The arch/tile glibc port works with none of the "extra" syscalls.  It has
not yet been pushed back to the community (although we just got our FSF
paperwork complete), but you can grab our version from
http://www.tilera.com/scm/ .  I tried to extract the asm-generic aspects
into a sysdeps/unix/sysv/linux/generic/ hierarchy as distinct from the
actual tile-specific code.

We hacked up uclibc to handle our architecture, too, but then discontinued
support for it, and the code was a pretty gnarly set of hacks on top of the
old nptl branch (long since merged into the uclibc trunk).

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
