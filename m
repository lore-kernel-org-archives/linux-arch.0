Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35064 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcFBALv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2016 20:11:51 -0400
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <574F386A.8070106@sr71.net>
References: <20160531152814.36E0B9EE@viggo.jf.intel.com> <20160531152822.FE8D405E@viggo.jf.intel.com>
 <20160601123705.72a606e7@lwn.net> <574F386A.8070106@sr71.net>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Wed, 1 Jun 2016 19:11:30 -0500
Message-ID: <CAKgNAkiyD_2tAxrBxirxViViMUsfLRRqQp5HowM58dG21LAa7Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] x86, pkeys: allocation/free syscalls
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: Jonathan Corbet <corbet@lwn.net>, lkml <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <20160602001130.b-20nxkFNVeX9cz0LeFuchezR1QoPWJI7Sndbl39FRU@z>

Hi Dave,

On 1 June 2016 at 14:32, Dave Hansen <dave@sr71.net> wrote:
> On 06/01/2016 11:37 AM, Jonathan Corbet wrote:
>>> +static inline
>>> +int mm_pkey_free(struct mm_struct *mm, int pkey)
>>> +{
>>> +    /*
>>> +     * pkey 0 is special, always allocated and can never
>>> +     * be freed.
>>> +     */
>>> +    if (!pkey || !validate_pkey(pkey))
>>> +            return -EINVAL;
>>> +    if (!mm_pkey_is_allocated(mm, pkey))
>>> +            return -EINVAL;
>>> +
>>> +    mm_set_pkey_free(mm, pkey);
>>> +
>>> +    return 0;
>>> +}
>>
>> If I read this right, it doesn't actually remove any pkey restrictions
>> that may have been applied while the key was allocated.  So there could be
>> pages with that key assigned that might do surprising things if the key is
>> reallocated for another use later, right?  Is that how the API is intended
>> to work?
>
> Yeah, that's how it works.
>
> It's not ideal.  It would be _best_ if we during mm_pkey_free(), we
> ensured that no VMAs under that mm have that vma_pkey() set.  But, that
> search would be potentially expensive (a walk over all VMAs), or would
> force us to keep a data structure with a count of all the VMAs with a
> given key.
>
> I should probably discuss this behavior in the manpages and address it

s/probably//

And, did I miss it. Was there an updated man-pages patch in the latest
series? I did not notice it.

> more directly in the changelog for this patch.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
