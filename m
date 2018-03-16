Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:51148 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeCPUHr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2018 16:07:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87k1wimybi.fsf_-_@xmission.com>
        <20180116004009.31036-13-ebiederm@xmission.com>
        <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
        <818f8945-f990-a770-476e-f82bdc77dbda@intel.com>
Date: Fri, 16 Mar 2018 15:06:55 -0500
In-Reply-To: <818f8945-f990-a770-476e-f82bdc77dbda@intel.com> (Dave Hansen's
        message of "Fri, 16 Mar 2018 12:24:44 -0700")
Message-ID: <87efkjeqe8.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for clarity
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Message-ID: <20180316200655.i3B0GeJpqhuxSxkywqeX87aykrAXnSfGWfFGVFhcGVM@z>

Dave Hansen <dave.hansen@intel.com> writes:

> On 03/16/2018 12:00 PM, Dave Hansen wrote:
>> On 01/15/2018 04:40 PM, Eric W. Biederman wrote:
>>> The addr_lsb fields is only valid and available when the
>>> signal is SIGBUS and the si_code is BUS_MCEERR_AR or BUS_MCEERR_AO.
>>> Document this with a comment and place the field in the _sigfault union
>>> to make this clear.
>>>
>>> All of the fields stay in the same physical location so both the old
>>> and new definitions of struct siginfo will continue to work.
>> 
>> This breaks the ABI and breaks protection keys.  The physical locations
>> *DO* change.
>> 
>> Before this patch:
>> 
>> #define si_pkey         _sifields._sigfault._pkey
>> (gdb) print &((siginfo_t *)0)->_sifields._sigfault._pkey
>> $1 = (__u32 *) 0x20 <irq_stack_union+32>
>> 
>> and after:
>> 
>> +#define si_pkey                _sifields._sigfault._addr_pkey._pkey
>> (gdb) print &((siginfo_t *)0)->_sifields._sigfault._addr_pkey._pkey
>> $1 = (__u32 *) 0x1c
>> 
>> Can we revert this, please?
>
> It does not revert cleanly so I reverted it manually.  Patch doing that
> is attached.  Should we do this, or is there a better option?

Please see:
859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")

Eric
