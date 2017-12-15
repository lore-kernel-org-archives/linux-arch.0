From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: Re: [RFC PATCH v2 4/4] Allow to trace fd usage with rlimit-events
Date: Fri, 15 Dec 2017 09:05:45 +0100
Message-ID: <654cbd0c-4319-8e3f-c207-11c7e4ea1c85@samsung.com>
References: <20171214220012.10103-1-k.opasiak@samsung.com>
        <CGME20171214220049epcas2p222a0a63c7aa70908ae316644e121100b@epcas2p2.samsung.com>
        <20171214220012.10103-5-k.opasiak@samsung.com>
        <BD3E2B25-B09B-497B-A017-C95C59BDEB83@dilger.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58264 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdLOIFx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Dec 2017 03:05:53 -0500
In-reply-to: <BD3E2B25-B09B-497B-A017-C95C59BDEB83@dilger.ca>
Content-language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Greg KH <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com



On 12/15/2017 12:59 AM, Andreas Dilger wrote:
> On Dec 14, 2017, at 3:00 PM, Krzysztof Opasiak <k.opasiak@samsung.com> wrote:
>>
>> Add rlimit-events calls to file descriptors management
>> code to allow tracing of FD usage.
>>
>> This allows userspace process (monitor) to get notification when
>> other process (subject) uses given amount of file descriptors.
>>
>> This can be used to for example asynchronously monitor number
>> of open FD's in system services instead of polling with
>> predefined interval.
> 
> I'm not involved in this area of code, but one optimization question:
> 
>> +static unsigned int count_open_fds(struct fdtable *fdt)
>> +{
>> +	unsigned int maxfd = fdt->max_fds;
>> +	unsigned int maxbit = maxfd / BITS_PER_LONG;
>> +	unsigned int count = 0;
>> +	int i;
>> +
>> +	i = find_next_zero_bit(fdt->full_fds_bits, maxbit, 0);
>> +	/* If there is no free fds */
>> +	if (i > maxbit)
>> +		return maxfd;
>> +#if BITS_PER_LONG == 32
>> +#define HWEIGHT_LONG hweight32
>> +#else
>> +#define HWEIGHT_LONG hweight64
>> +#endif
>> +
>> +	count += i * BITS_PER_LONG;
>> +	for (; i < maxbit; ++i)
>> +		count += HWEIGHT_LONG(fdt->open_fds[i]);
>> +
>> +#undef HWEIGHT_LONG
>> +	return count;
>> +}
> 
> Since find_next_zero_bit() needs to process all of the words anyway
> as well as lots of extra operations that add overhead, it looks more
> efficient to just compute HWEIGHT_LONG(open_fds[]) for the whole array.
> 

I may try to measure this but I'm not sure now because there are two 
levels of bit maps. First one (open_fds) is a real bitmap of open file 
descriptors (which can be quite large) while full_fds_bits is a second 
level bitmap (which is 8 times smaller) and if bit there is set it means 
that whole byte in lower bitmap (open_fds) is set. Because we are always 
opening the lowest fd number that is available we should have quite 
large contiguous region in the beginning so using this 
find_next_zero_bit() at first should allow us to skip this region.

But anyway I can try your suggestion and check if it speeds up.

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
