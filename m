From: Maciej Szmigiero <mhej@o2.pl>
Subject: Re: [GPIO]implement sleeping GPIO chip removal
Date: Wed, 10 Nov 2010 22:01:40 +0100
Message-ID: <4CDB0834.4080101@o2.pl>
References: <4CD6F049.10102@o2.pl> <20101110050947.GC4110@angua.secretlab.ca> <4CDABA03.2050000@o2.pl> <alpine.LFD.2.00.1011102134350.2900@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1011102134350.2900@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Greg Kroah-Hartman <gregkh@suse.de>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@cam.ac.uk>, Ben Nizette <bn@niasdigital.com>
List-Id: linux-arch.vger.kernel.org

W dniu 10.11.2010 21:42, Thomas Gleixner pisze:
> On Wed, 10 Nov 2010, Maciej Szmigiero wrote:
>> W dniu 10.11.2010 10:49, Thomas Gleixner pisze:
>>> Maybe because it open codes a sloppy refcounting with a loop and magic
>>> sleeps instead of converting the code to kobjects and proper
>>> refcounting ?
>>>
>>
>> The only way to do GPIO chip removal in the current code is to busy-loop.
>> "Sloppy" (as you called it) waiting is still more CPU-friendly than looping 
>> in hope that somebody will finally release the chip.
>> If you would like to implement it as kobject then go ahead and post the code
>> so it can be used in drivers.
> 
> Wait a moment. You are getting something backwards here.
> 
> Fact is that the current code is not designed for easy hotunplugging
> and therefor requires looping.
> 
> So _you_ propose a work-around to replace the busy-loop by a sleeping
> loop with "hope that ....". Hope is the least thing what counts in
> programming.
> 
> Now a reviewer tells you that your idea of replacing the busy-loop by
> a sleeping in hope loop is flawed, because it does not solve the
> underlying design problem of the GPIO code. And you get a suggestion
> how to solve it correctly.
> 
> Now you go and request from that reviewer to implement that? That's
> not how it works.
> 
> You sent a flawed patch in the first place and people try to tell you
> how to do it right. Then it's on you to either go and do it right or
> at least ask politely for help and pointers.
> 
> Thanks,
> 
> 	tglx
> 

You misunderstood me.
By "looping in hope that somebody will finally release the chip" I meant the only
real way to handle a GPIO chip unplugging in the current kernel.
Which is way worse that preventing new requests, then waiting for existing one to be released.
And this is exactly what my patch does.

I understand that it could be simplified by removing redundant code (as Grant Likely had suggested before), and
moving it to completion interface instead of manipulating a task structure directly, but this doesn't mean
that the whole GPIO code has to be rewritten just to add one functionality.

Best regards,
Maciej Szmigiero
