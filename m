Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37133 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760082AbdLSFfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Dec 2017 00:35:19 -0500
Subject: Re: [PATCH v5] mmap.2: MAP_FIXED updated documentation
References: <20171212002331.6838-1-jhubbard@nvidia.com>
 <3a07ef4d-7435-7b8d-d5c7-3bce80042577@gmail.com>
 <fb49f293-2048-e64f-51da-ff039929c7ac@nvidia.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <fb834f23-bbae-ea1b-1a55-a20e1cc88c0f@gmail.com>
Date: Tue, 19 Dec 2017 06:35:12 +0100
MIME-Version: 1.0
In-Reply-To: <fb49f293-2048-e64f-51da-ff039929c7ac@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>, linux-api@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Cyril Hrubis <chrubis@suse.cz>, Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>
Message-ID: <20171219053512.AkyIauB0UAUC6eugnItmTAV0V2z4WF9NKa-rK_TqGJo@z>

Hi John,

On 12/18/2017 10:27 PM, John Hubbard wrote:
> On 12/18/2017 11:15 AM, Michael Kerrisk (man-pages) wrote:
>> On 12/12/2017 01:23 AM, john.hubbard@gmail.com wrote:
>>> From: John Hubbard <jhubbard@nvidia.com>
>>>
>>>     -- Expand the documentation to discuss the hazards in
>>>        enough detail to allow avoiding them.
>>>
>>>     -- Mention the upcoming MAP_FIXED_SAFE flag.
>>>
>>>     -- Enhance the alignment requirement slightly.
>>>
>>> CC: Michael Ellerman <mpe@ellerman.id.au>
>>> CC: Jann Horn <jannh@google.com>
>>> CC: Matthew Wilcox <willy@infradead.org>
>>> CC: Michal Hocko <mhocko@kernel.org>
>>> CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
>>> CC: Cyril Hrubis <chrubis@suse.cz>
>>> CC: Michal Hocko <mhocko@suse.com>
>>> CC: Pavel Machek <pavel@ucw.cz>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>
>> John,
>>
>> Thanks for the patch. I think you win the prize for the 
>> most iterations ever on a man-pages patch! (And Michal,
>> thanks for helping out.) I've applied your patch, made 
>> some minor tweaks, and removed the mention of 
>> MAP_FIXED_SAFE, since I don't like to document stuff
>> that hasn't yet been merged. (I only later noticed the
>> fuss about the naming...)
>>
> 
> Hi Michael,
> 
> The final result looks nice, thanks for all the editing fixes.
> 
> One last thing: reading through this, I think it might need a wording
> fix (this is my fault), in order to avoid implying that brk() or
> malloc() use dlopen().
> 
> Something approximately like this:
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index 79681b31e..1c0bd80de 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -250,8 +250,9 @@ suffice.
>  The
>  .BR dlopen (3)
>  call will map the library into the process's address space.
> -Furthermore, almost any library call may be implemented using this technique.
> -Examples include
> +Furthermore, almost any library call may be implemented in a way that
> +adds memory mappings to the address space, either with this technique,
> +or by simply allocating memory. Examples include
>  .BR brk (2),
>  .BR malloc (3),
>  .BR pthread_create (3),
> 
> 
> ...or does the current version seem OK to other people?

Thanks. Looks good to me. Applied.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
