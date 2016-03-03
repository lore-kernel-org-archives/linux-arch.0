From: Alexander Potapenko <glider@google.com>
Subject: Re: [PATCHv2 0/3] KASAN: clean stale poison upon cold re-entry to kernel
Date: Thu, 3 Mar 2016 18:17:31 +0100
Message-ID: <CAG_fn=WAfu4oD1Qb1xUnX765RpUznWm1y+FKYqqiM8VO53F+Ag@mail.gmail.com>
References: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
Sender: owner-linux-mm@kvack.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, mingo@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, catalin.marinas@arm.com, lorenzo.pieralisi@arm.com, peterz@infradead.org, will.deacon@arm.com, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Please replace "ASAN" with "KASAN".

On Thu, Mar 3, 2016 at 5:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Functions which the compiler has instrumented for ASAN place poison on
> the stack shadow upon entry and remove this poison prior to returning.
>
> In some cases (e.g. hotplug and idle), CPUs may exit the kernel a number
> of levels deep in C code. If there are any instrumented functions on
> this critical path, these will leave portions of the idle thread stack
> shadow poisoned.
>
> If a CPU returns to the kernel via a different path (e.g. a cold entry),
> then depending on stack frame layout subsequent calls to instrumented
> functions may use regions of the stack with stale poison, resulting in
> (spurious) KASAN splats to the console.
>
> Contemporary GCCs always add stack shadow poisoning when ASAN is
> enabled, even when asked to not instrument a function [1], so we can't
> simply annotate functions on the critical path to avoid poisoning.
>
> Instead, this series explicitly removes any stale poison before it can
> be hit. In the common hotplug case we clear the entire stack shadow in
> common code, before a CPU is brought online.
>
> On architectures which perform a cold return as part of cpu idle may
> retain an architecture-specific amount of stack contents. To retain the
> poison for this retained context, the arch code must call the core KASAN
> code, passing a "watermark" stack pointer value beyond which shadow will
> be cleared. Architectures which don't perform a cold return as part of
> idle do not need any additional code.
>
> This is a combination of previous approaches [2,3], attempting to keep
> as much as possible generic.
>
> Since v1 [4]:
> * Clean from task_stack_page(task)
> * Add acks from v1
>
> Andrew, the conclusion [5] from v1 was that this should go via the mm tre=
e.
> Are you happy to pick this up?
>
> Ingo was happy for the sched patch to go via the arm64 tree, and I assume=
 that
> also holds for going via mm. Ingo, please shout if that's not the case!
>
> Thanks,
> Mark.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D69863
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/4=
09466.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/4=
11850.html
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/4130=
93.html
> [5] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/4134=
75.html
>
> Mark Rutland (3):
>   kasan: add functions to clear stack poison
>   sched/kasan: remove stale KASAN poison after hotplug
>   arm64: kasan: clear stale stack poison
>
>  arch/arm64/kernel/sleep.S |  4 ++++
>  include/linux/kasan.h     |  6 +++++-
>  kernel/sched/core.c       |  3 +++
>  mm/kasan/kasan.c          | 20 ++++++++++++++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
>
> --
> 1.9.1
>



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Diese E-Mail ist vertraulich. Wenn Sie nicht der richtige Adressat sind,
leiten Sie diese bitte nicht weiter, informieren Sie den
Absender und l=C3=B6schen Sie die E-Mail und alle Anh=C3=A4nge. Vielen Dank=
.
This e-mail is confidential. If you are not the right addressee please
do not forward it, please inform the sender, and please erase this
e-mail including any attachments. Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
