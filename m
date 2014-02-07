From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [ARCH question] Do syscall_get_nr and syscall_get_arguments
 always work?
Date: Fri, 7 Feb 2014 08:40:45 -0800
Message-ID: <CALCETrXXnSdyc5VpT8f6uu6kbO1cq4QwdKqr9z8AOhY_wsoBLA@mail.gmail.com>
References: <CALCETrU6M=Abo1z2cRoZy07-=3bwKiK84gCSMcBPLA1TkXPb8A@mail.gmail.com>
 <CACM3HyHwrKQAWZRhE2N1VtGKu1xSvcGeuMG1Ag+vzP2BA111cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:54319 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaBGQlH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Feb 2014 11:41:07 -0500
Received: by mail-ve0-f171.google.com with SMTP id pa12so2932214veb.2
        for <linux-arch@vger.kernel.org>; Fri, 07 Feb 2014 08:41:06 -0800 (PST)
In-Reply-To: <CACM3HyHwrKQAWZRhE2N1VtGKu1xSvcGeuMG1Ag+vzP2BA111cQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, linux-audit@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>

On Fri, Feb 7, 2014 at 4:58 AM, Jonas Bonn <jonas.bonn@gmail.com> wrote:
> Hi Andy,
>
> On 5 February 2014 00:50, Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> I can't even find the system call entry point on mips.
>>
>>
>> Is there a semi-official answer here?
>
> I don't have an official answer for you, but when I wanted to do
> something with these entry points a couple of years back I discovered
> that they aren't very thoroughly implemented across the various
> architectures.  I started cleaning this up and can probably dig up
> some of this for you if you need it.

The syscall_get_xyz functions are certainly implemented and functional
in all relevant architectures -- the audit code is already using them.
 The thing I'm uncertain about is whether they are usable with no
syscall slow path bits set.

I guess that, if the syscall restart logic needs to read the argument
registers, then they're probably reliably saved...

--Andy
