From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 09:58:37 -0800
Message-ID: <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42792 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbeADR6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 12:58:39 -0500
Received: by mail-oi0-f67.google.com with SMTP id o64so1536019oia.9
        for <linux-arch@vger.kernel.org>; Thu, 04 Jan 2018 09:58:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1801040728140.2148@hadrien>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Wed, Jan 3, 2018 at 10:28 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Wed, 3 Jan 2018, Dan Williams wrote:
>
>> [ adding Julia and Dan ]
>>
>> On Wed, Jan 3, 2018 at 5:07 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wr=
ote:
>> > On Wed, 3 Jan 2018 16:39:31 -0800
>> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> >
>> >> On Wed, Jan 3, 2018 at 4:15 PM, Dan Williams <dan.j.williams@intel.co=
m> wrote:
>> >> > The 'if_nospec' primitive marks locations where the kernel is disab=
ling
>> >> > speculative execution that could potentially access privileged data=
. It
>> >> > is expected to be paired with a 'nospec_{ptr,load}' where the user
>> >> > controlled value is actually consumed.
>> >>
>> >> I'm much less worried about these "nospec_load/if" macros, than I am
>> >> about having a sane way to determine when they should be needed.
>> >>
>> >> Is there such a sane model right now, or are we talking "people will
>> >> randomly add these based on strong feelings"?
>> >
>> > There are people trying to tune coverity and other tool rules to ident=
ify
>> > cases, and some of the work so far was done that way. For x86 we didn'=
t
>> > find too many so far so either the needed pattern is uncommon or .... =
 8)
>> >
>> > Given you can execute over a hundred basic instructions in a speculati=
on
>> > window it does need to be a tool that can explore not just in function
>> > but across functions. That's really tough for the compiler itself to d=
o
>> > without help.
>> >
>> > What remains to be seen is if there are other patterns that affect
>> > different processors.
>> >
>> > In the longer term the compiler itself needs to know what is and isn't
>> > safe (ie you need to be able to write things like
>> >
>> > void foo(tainted __user int *x)
>> >
>> > and have the compiler figure out what level of speculation it can do a=
nd
>> > (on processors with those features like IA64) when it can and can't do
>> > various kinds of non-trapping loads.
>> >
>>
>> It would be great if coccinelle and/or smatch could be taught to catch
>> some of these case at least as a first pass "please audit this code
>> block" type of notification.
>>
>
> What should one be looking for.  Do you have a typical example?
>

See "Exploiting Conditional Branch Misprediction" from the paper [1].

The typical example is an attacker controlled index used to trigger a
dependent read near a branch. Where an example of "near" from the
paper is "up to 188 simple instructions inserted in the source code
between the =E2=80=98if=E2=80=99 statement and the line accessing array..."=
.

if (attacker_controlled_index < bound)
     val =3D array[attacker_controlled_index];
else
    return error;

...when the cpu speculates that the 'index < bound' branch is taken it
reads index and uses that value to read array[index]. The result of an
'array' relative read is potentially observable in the cache.

[1]: https://spectreattack.com/spectre.pdf
