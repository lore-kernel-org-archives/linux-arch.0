Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11321 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdLCAWf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Dec 2017 19:22:35 -0500
Subject: Re: [PATCH] mmap.2: MAP_FIXED is no longer discouraged
References: <20171202021626.26478-1-jhubbard@nvidia.com>
 <20171202150554.GA30203@bombadil.infradead.org>
 <CAG48ez2u3fjBDCMH4x3EUhG6ZD6VUa=A1p441P9fg=wUdzwHNQ@mail.gmail.com>
 <20171202221910.GA8228@bombadil.infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <f44bf239-6ef1-3d3f-a1b8-97ff0bc0afbe@nvidia.com>
Date: Sat, 2 Dec 2017 16:22:30 -0800
MIME-Version: 1.0
In-Reply-To: <20171202221910.GA8228@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-man <linux-man@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171203002230.pZWLADuaRtdgwSG8VqfPFlORwUgUmkQhjCML0G0vVyw@z>

On 12/02/2017 02:19 PM, Matthew Wilcox wrote:
> On Sat, Dec 02, 2017 at 07:49:20PM +0100, Jann Horn wrote:
>> On Sat, Dec 2, 2017 at 4:05 PM, Matthew Wilcox <willy@infradead.org> wrote:
>>> On Fri, Dec 01, 2017 at 06:16:26PM -0800, john.hubbard@gmail.com wrote:
>>>> MAP_FIXED has been widely used for a very long time, yet the man
>>>> page still claims that "the use of this option is discouraged".
>>>
>>> I think we should continue to discourage the use of this option, but
>>> I'm going to include some of your text in my replacement paragraph ...
>>>
>>> -Because requiring a fixed address for a mapping is less portable,
>>> -the use of this option is discouraged.
>>> +The use of this option is discouraged because it forcibly unmaps any
>>> +existing mapping at that address.  Programs which use this option need
>>> +to be aware that their memory map may change significantly from one run to
>>> +the next, depending on library versions, kernel versions and random numbers.
>>
>> How about adding something explicit about when it's okay to use MAP_FIXED?
>> "This option should only be used to displace an existing mapping that is
>> controlled by the caller, or part of such a mapping." or something like that?
>>
>>> +In a threaded process, checking the existing mappings can race against
>>> +a new dynamic library being loaded
>>
>> malloc() and its various callers can also cause mmap() calls, which is probably
>> more relevant than library loading.
> 
> That's a bit more expected though.  "I called malloc and my address
> space changed".  Well, yeah.  But "I called getpwnam and my address
> space changed" is a bit more surprising.  Don't you think?
> 
> Maybe that should be up front rather than buried at the end of the sentence.
> 
> "In a multi-threaded process, the address space can change in response to
> virtually any library call.  This is because almost any library call may be
> implemented by using dlopen(3) to load another shared library, which will be
> mapped into the process's address space.  The PAM libraries are an excellent
> example, as well as more obvious examples like brk(2), malloc(3) and even
> pthread_create(3)."
> 
> What do you think?
> 

I'm working on some updated wording to capture these points. I'm even slower
at writing than I am at coding, so there will be a somewhat-brief pause here... :)

thanks,
John Hubbard
NVIDIA
