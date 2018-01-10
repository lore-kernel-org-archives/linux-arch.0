From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via speculative execution
Date: Tue, 09 Jan 2018 18:54:26 -0600
Message-ID: <87bmi2edod.fsf@xmission.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
        <87lgh7n2tf.fsf@xmission.com>
        <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
        <87373fj9bv.fsf@xmission.com>
        <CAPcyv4jQ=2s25keWbk-6bHK=xqeKbvbd0wX5319Csgg+iM+b2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4jQ=2s25keWbk-6bHK=xqeKbvbd0wX5319Csgg+iM+b2w@mail.gmail.com>
        (Dan Williams's message of "Tue, 9 Jan 2018 10:01:47 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, Jan 9, 2018 at 8:17 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
> [..]
>> The user controlled value condition of your patchset implies that you
>> assume indirect branch predictor poisoning is handled in other ways.
>>
>> Which means that we can assume speculation will take some variation of
>> the static call chain.
>>
>> Further you are worrying about array accesses.  Which means you
>> are worried about attacks that are the equivalent of meltdown that
>> can give you reading of all memory available to the kernel.
>>
>>
>> The mpls code in question reads a pointer from memory.
>>
>>
>> The only thing the code does with that pointer is verify it is not NULL
>> and dereference it.
>>
>> That does not make it possible to extricate the pointer bits via a cache
>> side-channel as a pointer is 64bits wide.
>>
>> There might maybe be a timing attack where it is timed how long the
>> packet takes to deliver.  If you can find the base address of the array,
>> at best such a timeing attack will tell you is if some arbitrary cache
>> line is already cached in the kernel.  Which is not the class of attack
>> your patchset is worried about.  Further there are more direct ways
>> to probe the cache from a local process.
>>
>> So I submit to you that the mpls code is not vulnerable to the class of
>> attack you are addressing.
>>
>> Further I would argue that anything that reads a pointer from memory is
>> a very strong clue that it falls outside the class of code that you are
>> addressing.
>>
>> Show me where I am wrong and I will consider patches.
>
> No, the concern is a second dependent read (or write) within the
> speculation window after this first bounds-checked dependent read.
> I.e. this mpls code path appears to have the setup condition:
>
>     if (x < max)
>         val = array1[x];
>
> ...but it's not clear that there is an exploit condition later on in
> the instruction stream:
>
>         array2[val] = y;
>         /* or */
>         y = array2[val];
>
> My personal paranoia says submit the patch and not worry about finding
> that later exploit condition, if DaveM wants to drop the patch that's
> his prerogative. In general, with the performance conscious version of
> nospec_array_ptr() being the default, why worry about what is / is not
> in the speculation window?

Sigh.
I am not worrying about what is in the speculation window.  My
assumption is that the speculation window could be infinite, as we don't
know the limitations of all possible processors.

I am saying there is not a way to get the data out of the speculation
window.

I was saying that when you have:
	if (x < max)
        	val = array1[x];

When val is a pointer not an integer.
Then
	array2[val] = y;
        /* or */
        y = array2[va];

Won't happen.

	val->field;

Will happen.

Which looks similar.  However the address space of pointers is too
large.  Making it impossible for an attack to know where to look in the
cache to see if "val->field" happened.  At least on the assumption that
val is an arbitrary value.

Further mpls_forward is small enough the entire scope of "rt" the value
read possibly past the bound check is auditable without too much
trouble.  I have looked and I don't see anything that could possibly
allow the value of "rt" to be exfitrated.  The problem continuing to be
that it is a pointer and the only operation on the pointer besides
derferencing it is testing if it is NULL.

Other types of timing attacks are very hard if not impossible because
any packet presenting with a value outside the bounds check will be
dropped.  So it will hard if not impossible to find something to time to
see how long it took to drop the packet.

So no this code path does not present with the classic signature of
variant 1: bounds check bypass CVE-2017-5753

Show me where I am wrong and I will gladly take patches.  As it is the
mpls fast path does not appear vulnerable to the issue you are
addressing.  So the best thing we can do for performance is nothing at
all.

All I am after is a plausible scenario.  I just want to see it spelled
out which combinations of things could possibly be a problem.

Eric
