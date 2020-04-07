From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 1/4] powerpc/64s: implement probe_kernel_read/write
 without touching AMR
Date: Tue, 7 Apr 2020 11:09:50 +0200
Message-ID: <e01d8139-dca4-2239-d660-bfc962426c7a@iogearbox.net>
References: <20200403093529.43587-1-npiggin@gmail.com>
 <558b6131-60b4-98b7-dc40-25d8dacea05a@c-s.fr>
 <1585911072.njtr9qmios.astroid@bobo.none>
 <1586230235.0xvc3pjkcj.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:46680 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgDGJJ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Apr 2020 05:09:59 -0400
In-Reply-To: <1586230235.0xvc3pjkcj.astroid@bobo.none>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org

Hey Nicholas,

On 4/7/20 6:01 AM, Nicholas Piggin wrote:
> Nicholas Piggin's on April 3, 2020 9:05 pm:
>> Christophe Leroy's on April 3, 2020 8:31 pm:
>>> Le 03/04/2020 à 11:35, Nicholas Piggin a écrit :
>>>> There is no need to allow user accesses when probing kernel addresses.
>>>
>>> I just discovered the following commit
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75a1a607bb7e6d918be3aca11ec2214a275392f4
>>>
>>> This commit adds probe_kernel_read_strict() and probe_kernel_write_strict().
>>>
>>> When reading the commit log, I understand that probe_kernel_read() may
>>> be used to access some user memory. Which will not work anymore with
>>> your patch.
>>
>> Hmm, I looked at _strict but obviously not hard enough. Good catch.
>>
>> I don't think probe_kernel_read() should ever access user memory,
>> the comment certainly says it doesn't, but that patch sort of implies
>> that they do.
>>
>> I think it's wrong. The non-_strict maybe could return userspace data to
>> you if you did pass a user address? I don't see why that shouldn't just
>> be disallowed always though.
>>
>> And if the _strict version is required to be safe, then it seems like a
>> bug or security issue to just allow everyone that doesn't explicitly
>> override it to use the default implementation.
>>
>> Also, the way the weak linkage is done in that patch, means parisc and
>> um archs that were previously overriding probe_kernel_read() now get
>> the default probe_kernel_read_strict(), which would be wrong for them.
> 
> The changelog in commit 75a1a607bb7 makes it a bit clearer. If the
> non-_strict variant is used on non-kernel addresses, then it might not
> return -EFAULT or it might cause a kernel warning. The _strict variant
> is supposed to be usable with any address and it will return -EFAULT if
> it was not a valid and mapped kernel address.
> 
> The non-_strict variant can not portably access user memory because it
> uses KERNEL_DS, and its documentation says its only for kernel pointers.
> So powerpc should be fine to run that under KUAP AFAIKS.
> 
> I don't know why the _strict behaviour is not just made default, but
> the implementation of it does seem to be broken on the archs that
> override the non-_strict variant.

Yeah, we should make it default and only add a "opt out" for the old legacy
cases; there was also same discussion started over here just recently [0].

Thanks,
Daniel

   [0] https://lore.kernel.org/lkml/20200403133533.GA3424@infradead.org/T/
