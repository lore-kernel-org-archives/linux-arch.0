From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 02/15] arm: __NR_syscalls fix
Date: Wed, 23 Apr 2014 14:00:51 +0200
Message-ID: <CAJfpegv0iJtzukJMbWR2n7ANxAQmLnf+ekRfmf8V5RdyK20w6Q@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<1397211951-20549-3-git-send-email-miklos@szeredi.hu>
	<20140411103351.GJ16119@n2100.arm.linux.org.uk>
	<CAJfpegvZ-n4sT0ojj9iUg_R5gMZHT0caad6TpOdcmF=pdiXkqg@mail.gmail.com>
	<20140411115421.GL16119@n2100.arm.linux.org.uk>
	<CAJfpegtenNUCEAJ3SZpQ8NYcdbCeS8pVxaT767szkR1PF8YPNA@mail.gmail.com>
	<20140411124502.GO16119@n2100.arm.linux.org.uk>
	<20140423102718.GA6434@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:43391 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaDWMAw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 08:00:52 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so786927qcx.24
        for <linux-arch@vger.kernel.org>; Wed, 23 Apr 2014 05:00:51 -0700 (PDT)
In-Reply-To: <20140423102718.GA6434@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Wade Farnsworth <wade_farnsworth@mentor.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>

On Wed, Apr 23, 2014 at 12:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 11, 2014 at 01:45:02PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Apr 11, 2014 at 02:02:32PM +0200, Miklos Szeredi wrote:
>> > On Fri, Apr 11, 2014 at 1:54 PM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> > > On Fri, Apr 11, 2014 at 01:50:50PM +0200, Miklos Szeredi wrote:
>> > >> Yes, and the padding will be of wrong length if NR_syscalls is
>> > >> incorrect (which may be Oopsable?).  At least that is my impression
>> > >> from a casual glance.
>> > >
>> > > Please explain.
>> >
>> > Look at ending lines of arch/arm/kernel/calls.S: if  NR_syscalls is a
>> > multiple of 4, then syscalls_padding will be zero.  I.e. no padding
>> > despite the fact that there is in fact only 382 system calls in table
>> > and there should be 2 sys_ni_syscall pads.
>>
>> Hmm, it looks like you're right... this used to work fine until...
>>
>> commit 1f66e06fb6414732bef7bf4a071ef76a837badec
>> Author: Wade Farnsworth <wade_farnsworth@mentor.com>
>> Date:   Fri Sep 7 18:18:25 2012 +0100
>>
>>     ARM: 7524/1: support syscall tracing
>>
>> because the tracing code wanted to know the number of syscalls.  I don't
>> know what the answer is here, because the current solution is IMHO far
>> to fragile.
>
> Actually, no, you're wrong.  Look closely at the definitions. __NR_syscalls
> is not the same as NR_syscalls.
>
> __NR_syscalls is the statically defined size of the syscall table for
> *probes purposes.
>
> NR_syscalls is the assembly-counted number of CALL() macros in
> arch/arm/kernel/calls.S.

All I can say is: UGGGGH.

But I've not had close encounters with arch code, so this may be
acceptable to you.  Whatever...

Thanks,
Miklos
