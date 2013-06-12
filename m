From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Get rid of cpuinit?
Date: Tue, 11 Jun 2013 20:31:55 -0400
Message-ID: <CAP=VYLo047g+U3GJhkObJtNPubFNpHuGUJAF7oOh_7dPtSFd9A@mail.gmail.com>
References: <519AA53F.1020107@zytor.com> <20130520231203.GA21682@kroah.com> <20130528092038.GC32068@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:40493 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3FLAcZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jun 2013 20:32:25 -0400
In-Reply-To: <20130528092038.GC32068@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, May 28, 2013 at 5:20 AM, Ingo Molnar <mingo@kernel.org> wote:
>
> * Greg KH <greg@kroah.com> wrote:
>
>> On Mon, May 20, 2013 at 03:35:43PM -0700, H. Peter Anvin wrote:
>> > We have gotten rid of devinit markup.  A recent patch of Linus' makes me
>> > wonder if we similarly should get rid of cpuinit markup?
>> >
>> > Just as with devices, the CPU hotplug machinery has been leveraged to
>> > support a number of pieces of functionality such as suspend, which means
>> > that on anything but the most embedded systems this functionality is
>> > likely needed anyway.
>> >
>> > On x86-64, for an "allyesconfig" build, the total amount of space in all
>> > the .cpu* sections combined is 100K.
>>
>> No objection from me on removing it, it just causes problems from what I
>> can tell.
>
> Indeed, there's a steady trickle of mis-annotated cpuinit sections, and no
> real tooling to make the annotations automatic or so in most of the cases.
> Manual simply does not seem to work in this case.

Is anyone actively working on weeding this out?  If not, it is probably
one of those tree-wide kind of changes that I can volunteer to tackle...

Paul.
--

>
> Thanks,
>
>         Ingo
> --
