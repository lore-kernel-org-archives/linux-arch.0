From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [kernel-hardening] [PATCH v5 03/32] x86/cpa: In populate_pgd,
 don't set the pgd entry until it's populated
Date: Fri, 22 Jul 2016 11:21:53 -0700
Message-ID: <CALCETrVKzUh_RYBoogWsEjYMe89en-NeNQhnWomy4LD=DaKfWQ@mail.gmail.com>
References: <cover.1468270393.git.luto@kernel.org> <fb3254e25e38790c538cca0f46c4a7a714c77ddf.1468270393.git.luto@kernel.org>
 <5741.1469162592@turing-police.cc.vt.edu> <4b028b92-81f3-362f-c5be-b7a35cedf5ee@kernel.org>
 <20160722102105.GA20771@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36568 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbcGVSWN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2016 14:22:13 -0400
Received: by mail-vk0-f48.google.com with SMTP id n129so122694275vke.3
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2016 11:22:13 -0700 (PDT)
In-Reply-To: <20160722102105.GA20771@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Fri, Jul 22, 2016 at 3:21 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Lutomirski <luto@kernel.org> wrote:
>
>> On 07/21/2016 09:43 PM, Valdis.Kletnieks@vt.edu wrote:
>> >On Mon, 11 Jul 2016 13:53:36 -0700, Andy Lutomirski said:
>> >>This avoids pointless races in which another CPU or task might see=
 a
>> >>partially populated global pgd entry.  These races should normally
>> >>be harmless, but, if another CPU propagates the entry via
>> >>vmalloc_fault and then populate_pgd fails (due to memory allocatio=
n
>> >>failure, for example), this prevents a use-after-free of the pgd
>> >>entry.
>> >>
>> >>Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> >>---
>> >> arch/x86/mm/pageattr.c | 9 ++++++---
>> >> 1 file changed, 6 insertions(+), 3 deletions(-)
>> >
>> >I just bisected a failure to boot down to this patch.  On my Dell L=
atitude
>> >laptop, it results in the kernel being loaded and then just basical=
ly sitting
>> >there dead in the water - as far as I can tell, it dies before the =
kernel
>> >ever gets going far enough to do any console I/O (even with ignore_=
loglevel).
>> >Nothing in /sys/fs/pstore either.  I admit not understanding the VM=
 code
>> >at all, so I don't have a clue *why* this causes indigestion...
>> >
>> >CPU is an Intel Core i5-3340M in case that matters....
>> >
>>
>> How much memory do you have and what's your config?  My code is obvi=
ously
>> buggy, but I'm wondering why neither I nor the 0day bot caught this.
>>
>> The attached patch is compile-tested only.  (Even Thunderbird doesn'=
t want
>> to send non-flowed text right now, sigh.)
>>
>> --Andy
>
>> From 6589ddf69a1369e1ecb95f0af489d90b980e256e Mon Sep 17 00:00:00 20=
01
>> Message-Id: <6589ddf69a1369e1ecb95f0af489d90b980e256e.1469165371.git=
=2Eluto@kernel.org>
>> From: Andy Lutomirski <luto@kernel.org>
>> Date: Thu, 21 Jul 2016 22:22:02 -0700
>> Subject: [PATCH] x86/mm: Fix populate_pgd()
>>
>> I make an obvious error in populate_pgd() -- it would fail to correc=
tly
>> populate the page tables when it allocated a new pud page.
>
> JFYI, on allnoconfig it gives:
>
>   arch/x86/mm/pageattr.c:1016:20: error: implicit declaration of func=
tion =E2=80=98pud_index=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]

As it happens, my fix interacts badly with the steaming pile of crap
that is Linux's support for <4 page table levels.  Can you just revert
the offending patch and I'll redo it differently?

<rant>
Holy crap the pagetable structures and helpers suck.  We have "pgd_t
*" that could point to a top-level entry, a top-level table, or to
something else entirely if we have fewer than four levels.  And we
have pud_t * that ambiguously points to a table or to an entry or to a
pmd if the build is feeling daft.  We have a helper called
"pud_offset" that doesn't compute any sort of offset -- it *traverses*
one level of the table and only works if you pass it the kind of pgt_t
* that points to an entry (not a table).

This garbage (as evidenced by my bug and my failed attempt to fix it)
only works if you never have a low-level page table that isn't linked
into a higher-level page table, and it mostly requires you to do
everything exactly the way it was originally done so all the horrible
inline helpers don't get confused.

And AFAICT all of this was done to manually unroll a loop, and I bet
it never sped anything up measurably even on 386 or PPro.

Whenever some vendor releases a 5 level page table CPU, can we
*please* clean this up first?  We should have a type that points to a
table, a different type that points to an entry (or maybe not have
pointers to entries at all), and the levels should be referred to by
*number*.  When you need to traverse all the way down, you write a
*loop* instead of four bloody helper functions, some of which are
incomprehensibly no-ops on some kernels.  And if this means that, on
Intel, we have a silly branch in the inner loop because the bottom
level entry format is special, who cares?
</rant>

--Andy
