From: Alexander Potapenko <glider@google.com>
Subject: Re: [PATCHv2 0/3] KASAN: clean stale poison upon cold re-entry to kernel
Date: Thu, 3 Mar 2016 18:45:55 +0100
Message-ID: <CAG_fn=VBOqPSwhKy2OCj7cgM=XaD338L=UfPDcg9X3tCwc6B_g@mail.gmail.com>
References: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
	<CAG_fn=WAfu4oD1Qb1xUnX765RpUznWm1y+FKYqqiM8VO53F+Ag@mail.gmail.com>
	<20160303174015.GG19139@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38389 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346AbcCCRp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Mar 2016 12:45:57 -0500
Received: by mail-wm0-f51.google.com with SMTP id l68so544988wml.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Mar 2016 09:45:56 -0800 (PST)
In-Reply-To: <20160303174015.GG19139@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, mingo@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, catalin.marinas@arm.com, lorenzo.pieralisi@arm.com, peterz@infradead.org, will.deacon@arm.com, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Mar 3, 2016 at 6:40 PM, Mark Rutland <mark.rutland@arm.com> wro=
te:
> Hi,
>
> On Thu, Mar 03, 2016 at 06:17:31PM +0100, Alexander Potapenko wrote:
>> Please replace "ASAN" with "KASAN".
>>
>> On Thu, Mar 3, 2016 at 5:54 PM, Mark Rutland <mark.rutland@arm.com> =
wrote:
>> > Functions which the compiler has instrumented for ASAN place poiso=
n on
>> > the stack shadow upon entry and remove this poison prior to return=
ing.
>> >
>> > In some cases (e.g. hotplug and idle), CPUs may exit the kernel a =
number
>> > of levels deep in C code. If there are any instrumented functions =
on
>> > this critical path, these will leave portions of the idle thread s=
tack
>> > shadow poisoned.
>> >
>> > If a CPU returns to the kernel via a different path (e.g. a cold e=
ntry),
>> > then depending on stack frame layout subsequent calls to instrumen=
ted
>> > functions may use regions of the stack with stale poison, resultin=
g in
>> > (spurious) KASAN splats to the console.
>> >
>> > Contemporary GCCs always add stack shadow poisoning when ASAN is
>> > enabled, even when asked to not instrument a function [1], so we c=
an't
>> > simply annotate functions on the critical path to avoid poisoning.
>> >
>> > Instead, this series explicitly removes any stale poison before it=
 can
>> > be hit. In the common hotplug case we clear the entire stack shado=
w in
>> > common code, before a CPU is brought online.
>> >
>> > On architectures which perform a cold return as part of cpu idle m=
ay
>> > retain an architecture-specific amount of stack contents. To retai=
n the
>> > poison for this retained context, the arch code must call the core=
 KASAN
>> > code, passing a "watermark" stack pointer value beyond which shado=
w will
>> > be cleared. Architectures which don't perform a cold return as par=
t of
>> > idle do not need any additional code.
>
> For the above, and the rest of the series, ASAN consistently refers t=
o
> the compiler AddressSanitizer feature, and KASAN consistently refers =
to
> the Linux-specific infrastructure. A simple s/[^K]ASAN/KASAN/ would
> arguably be wrong (e.g. when referring to GCC behaviour above).
I don't think there's been any convention about the compiler feature
name, we usually talked about ASan as a userspace tool and KASAN as a
kernel-space one, although they share the compiler part.

> If there is a this needs rework, then I'm happy to s/[^K]ASAN/ASan/ t=
o
> follow the usual ASan naming convention and avoid confusion. Otherwis=
e,
> spinning a v3 is simply churn.
I don't insist on changing this, I should've chimed in before.
=46eel free to retain the above patch description.
> Thanks,
> Mark.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Matthew Scott Sucherman, Paul Terence Manicl=
e
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Diese E-Mail ist vertraulich. Wenn Sie nicht der richtige Adressat sind=
,
leiten Sie diese bitte nicht weiter, informieren Sie den
Absender und l=C3=B6schen Sie die E-Mail und alle Anh=C3=A4nge. Vielen =
Dank.
This e-mail is confidential. If you are not the right addressee please
do not forward it, please inform the sender, and please erase this
e-mail including any attachments. Thanks.
