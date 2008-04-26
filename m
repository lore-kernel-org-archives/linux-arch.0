From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Fri, 25 Apr 2008 23:28:41 -0700
Message-ID: <4812CB99.1070600@goop.org>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-2-git-send-email-jens.axboe@oracle.com> <20080424220157.GA26179@flint.arm.linux.org.uk> <20080425071823.GF12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080425071823.GF12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, Jes Sorensen <jes-sJ/iWh9BUns@public.gmane.org>

Jens Axboe wrote:
> On Thu, Apr 24 2008, Russell King wrote:
>   
>> On Tue, Apr 22, 2008 at 08:50:17PM +0200, Jens Axboe wrote:
>>     
>>> +		data->csd.func(data->csd.info);
>>> +
>>> +		spin_lock(&data->lock);
>>> +		cpu_clear(cpu, data->cpumask);
>>> +		WARN_ON(data->refs == 0);
>>> +		data->refs--;
>>> +		refs = data->refs;
>>>       
>> Probably a silly question, but what does data->refs do that
>> cpus_empty(data->cpumask) wouldn't do?  (as indeed ARM presently does.)
>>     
>
> I guess it can be marginally slower for NR_CPUS > BITS_PER_LONG,
> otherwise there's absolutely no reason to have a seperate ref counter.
>   

Jes was concerned about scanning bitmasks on a 4096 CPU Altix.  I'm not 
sure its all that important, but a refcount check would definitely be 
quicker.

    J
