Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39588 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290AbbG1LXj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jul 2015 07:23:39 -0400
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz> <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz> <20150727145409.GB21664@akamai.com>
 <20150728111725.GG24972@dhcp22.suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55B76631.6040802@suse.cz>
Date: Tue, 28 Jul 2015 13:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <20150728111725.GG24972@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuahkh@osg.samsung.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150728112329.F0vbWwxgbLSs0D5B69mn68vXJo9SjzekC0flXaDPlbg@z>

On 07/28/2015 01:17 PM, Michal Hocko wrote:
> [I am sorry but I didn't get to this sooner.]
>
> On Mon 27-07-15 10:54:09, Eric B Munson wrote:
>> Now that VM_LOCKONFAULT is a modifier to VM_LOCKED and
>> cannot be specified independentally, it might make more sense to mirror
>> that relationship to userspace.  Which would lead to soemthing like the
>> following:
>
> A modifier makes more sense.
>
>> To lock and populate a region:
>> mlock2(start, len, 0);
>>
>> To lock on fault a region:
>> mlock2(start, len, MLOCK_ONFAULT);
>>
>> If LOCKONFAULT is seen as a modifier to mlock, then having the flags
>> argument as 0 mean do mlock classic makes more sense to me.
>>
>> To mlock current on fault only:
>> mlockall(MCL_CURRENT | MCL_ONFAULT);
>>
>> To mlock future on fault only:
>> mlockall(MCL_FUTURE | MCL_ONFAULT);
>>
>> To lock everything on fault:
>> mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT);
>
> Makes sense to me. The only remaining and still tricky part would be
> the munlock{all}(flags) behavior. What should munlock(MLOCK_ONFAULT)
> do? Keep locked and poppulate the range or simply ignore the flag an
> just unlock?

munlock(all) already lost both MLOCK_LOCKED and MLOCK_ONFAULT flags in 
this revision, so I suppose in the next revision it will also not accept 
MLOCK_ONFAULT, and will just munlock whatever was mlocked in either mode.

> I can see some sense to allow munlockall(MCL_FUTURE[|MLOCK_ONFAULT]),
> munlockall(MCL_CURRENT) resp. munlockall(MCL_CURRENT|MCL_FUTURE) but
> other combinations sound weird to me.

The effect of munlockall(MCL_FUTURE|MLOCK_ONFAULT), which you probably 
intended for converting the onfault to full prepopulation for future 
mappings, can be achieved by calling mlockall(MCL_FUTURE) (without 
MLOCK_ONFAULT).

> Anyway munlock with flags opens new doors of trickiness.



