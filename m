Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfBNLXA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 06:23:00 -0500
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
References: <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
 <20190213145834.GJ3567@e103592.cambridge.arm.com>
 <90c54249-00dd-f8dd-6873-6bb8615c2c8a@arm.com>
 <20190213174318.GM3567@e103592.cambridge.arm.com>
 <CAFKCwrgV0VNJ_jEU79XwkX0o7qLFcqh3MbVMg2=Vs8VKYyY9=Q@mail.gmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <8047504c-3b9d-0c46-c0cf-9d584f5ca241@arm.com>
Date: Thu, 14 Feb 2019 11:22:52 +0000
MIME-Version: 1.0
In-Reply-To: <CAFKCwrgV0VNJ_jEU79XwkX0o7qLFcqh3MbVMg2=Vs8VKYyY9=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Evgenii Stepanov <eugenis@google.com>, Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Branislav Rankov <Branislav.Rankov@arm.com>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20190214112252.7pzY9OLtvVtTPPpSeXzpZlhuCTCFklAz6Cy6mI5HXRw@z>

On 13/02/2019 21:41, Evgenii Stepanov wrote:
> On Wed, Feb 13, 2019 at 9:43 AM Dave Martin <Dave.Martin@arm.com> wrote:
>> On Wed, Feb 13, 2019 at 04:42:11PM +0000, Kevin Brodsky wrote:
>>> (+Cc other people with MTE experience: Branislav, Ruben)
>> [...]
>>
>>>> I'm wondering whether we can piggy-back on existing concepts.
>>>>
>>>> We could say that recolouring memory is safe when and only when
>>>> unmapping of the page or removing permissions on the page (via
>>>> munmap/mremap/mprotect) would be safe.  Otherwise, the resulting
>>>> behaviour of the process is undefined.
>>> Is that a sufficient requirement? I don't think that anything prevents you
>>> from using mprotect() on say [vvar], but we don't necessarily want to map
>>> [vvar] as tagged. I'm not sure it's easy to define what "safe" would mean
>>> here.
>> I think the origin rules have to apply too: [vvar] is not a regular,
>> private page but a weird, shared thing mapped for you by the kernel.
>>
>> Presumably userspace _cannot_ do mprotect(PROT_WRITE) on it.
>>
>> I'm also assuming that userspace cannot recolour memory in read-only
>> pages.  That sounds bad if there's no way to prevent it.
> That sounds like something we would like to do to catch out of bounds
> read of .rodata globals.
> Another potentially interesting use case for MTE is infinite hardware
> watchpoints - that would require trapping reads for individual tagging
> granules, include those in read-only binary segment.

I think we should keep this discussion for a later, separate thread. Vincenzo's 
proposal is about allowing userspace to pass tags at the syscall interface. The set 
of mappings allowed to be tagged by userspace (in MTE) should be contained in the set 
of mappings that userspace can pass tagged pointers to (at the syscall interface), 
but they are not necessarily the same. Private read-only mappings are an edge case 
(you can pass tagged pointers to them, the memory may or may not be mapped as tagged, 
but in any case it is not possible to change the memory tags via such mapping).

>
>> [...]
>>
>>>> It might be reasonable to do the check in access_ok() and skip it in
>>>> __put_user() etc.
>>>>
>>>> (I seem to remember some separate discussion about abolishing
>>>> __put_user() and friends though, due to the accident risk they pose.)
>>> Keep in mind that with MTE, there is no need to do any explicit check when
>>> accessing user memory via a user-provided pointer. The tagged user pointer
>>> is directly passed to copy_*_user() or put_user(). If the load/store causes
>>> a tag fault, then it is handled just like a page fault (i.e. invoking the
>>> fixup handler). As far as I can tell, there's no need to do anything special
>>> in access_ok() in that case.
>>>
>>> [The above applies to precise mode. In imprecise mode, some more work will
>>> be needed after the load/store to check whether a tag fault happened.]
>> Fair enough, I'm a bit hazy on the details as of right now..
>>
>> [...]
>>
>>> There are many possible ways to deploy MTE, and debugging is just one of
>>> them. For instance, you may want to turn on heap colouring for some
>>> processes in the system, including in production.
>> To implement enforceable protection, or as a diagnostic tool for when
>> something goes wrong?
>>
>> In the latter case it's still OK for the kernel's tag checking not to be
>> exhaustive.
>>
>>> Regarding those cases where it is impossible to check tags at the point of
>>> accessing user memory, it is indeed possible to check the memory tags at the
>>> point of stripping the tag from the user pointer. Given that some MTE
>>> use-cases favour performance over tag check coverage, the ideal approach
>>> would be to make these checks configurable (e.g. check one granule, check
>>> all of them, or check none). I don't know how feasible this is in practice.
>> Check all granules of a massive DMA buffer?
>>
>> That doesn't sounds feasible without explicit support in the hardware to
>> have the DMA check tags itself as the memory is accessed.  MTE by itself
>> doesn't provide for this IIUC (at least, it would require support in the
>> platform, not just the CPU).
>>
>> We do not want to bake any assumptions into the ABI about whether a
>> given data transfer may or may not be offloaded to DMA.  That feels
>> like a slippery slope.
>>
>> Providing we get the checks for free in put_user/get_user/
>> copy_{to,from}_user(), those will cover a lot of cases though, for
>> non-bulk-IO cases.
>>
>>
>> My assumption has been that at this point in time we are mainly aiming
>> to support the debug/diagnostic use cases today.

MTE can be used both for diagnostics (imprecise mode is especially suitable for 
that), and to halt execution when something wrong is detected. Even in the latter 
case, one cannot expect exhaustive checking from MTE, because the way it works is 
fundamentally statistical; an invalid pointer may by chance have the right tag to 
access the given location. So again, I think that a best-effort approach is 
appropriate when the kernel accesses user memory, in terms of checking that tags match.

More specifically, different use-cases come with different tradeoffs (performance / 
tag check coverage). That's why I am suggesting that in the cases where tag checks 
would need to be done _explicitly_ (before losing the user-provided tag), it would be 
nice to be able to choose how much should be checked. I am not suggesting that always 
checking all the granules by default is sane. Maybe checking just the first granule 
is the right default.

I don't think we need to get to the bottom of this specific aspect at this point. 
This ABI proposal is not about memory tagging, so there is no need to specify how or 
when tag checking is done. As long as this ABI allows tagged pointers, pointing to 
mappings that could be potentially tagged, to be passed to syscalls, I don't think 
further relaxations are needed to enable memory tagging.

Kevin

>>
>> At least, those are the low(ish)-hanging fruit.
>>
>> Others are better placed than me to comment on the goals here.
>>
>> Cheers
>> ---Dave
