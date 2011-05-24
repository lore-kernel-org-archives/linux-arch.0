Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:53305 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757385Ab1EXVaV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 May 2011 17:30:21 -0400
Message-ID: <4DDC2236.6010608@mit.edu>
Date: Tue, 24 May 2011 17:25:10 -0400
From: Andy Lutomirski <luto@MIT.EDU>
MIME-Version: 1.0
Subject: Re: (Short?) merge window reminder
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com> <20110523192056.GC23629@elte.hu> <BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
In-Reply-To: <BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, DRI <dri-devel@lists.freedesktop.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>
Message-ID: <20110524212510.HlNWZXqX27_lh0qjyYKywb7D8lRlWKoAI2EohrHefnw@z>

On 05/23/2011 04:33 PM, Linus Torvalds wrote:
> On Mon, May 23, 2011 at 12:20 PM, Ingo Molnar<mingo@elte.hu>  wrote:
>>
>> I really hope there's also a voice that tells you to wait until .42 before
>> cutting 3.0.0! :-)
>
> So I'm toying with 3.0 (and in that case, it really would be "3.0",
> not "3.0.0" - the stable team would get the third digit rather than
> the fourth one.
>
> But no, it wouldn't be for 42. Despite THHGTTG, I think "40" is a
> fairly nice round number.
>
> There's also the timing issue - since we no longer do version numbers
> based on features, but based on time, just saying "we're about to
> start the third decade" works as well as any other excuse.
>

I don't think year-based versions (like 2011.0 for the first 2011 
release, or maybe 2011.5 for May 2011) are pretty, but I'll make an 
argument for them anyway: it makes it easier to figure out when hardware 
ought to be supported.

So if I buy a 2014-model laptop and the coffee-making button doesn't 
work, and my favorite distro is running the 2013 kernel, then I know I 
shouldn't expect to it to work.  (Graphics drivers are probably a more 
realistic example.)

Also, when someone in my lab installs <insert ancient enterprise distro 
here> on a box that's running software I wrote that needs to support 
modern high-speed peripherals, then I can say "What?  You seriously 
expect this stuff to work on Linux 2007?  Let's install a slightly less 
stable distro from at least 2010."  This sounds a lot less nerdy than 
"What?  You seriously expect this stuff to work on Linux 2.6.27?  Let's 
install a slightly less stable distro that uses at least 2.6.36."


--Andy
