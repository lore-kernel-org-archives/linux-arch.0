From: Nicholas Piggin <npiggin@gmail.com>
Subject: io_uring kthread_use_mm / mmget_not_zero possible abuse
Date: Mon, 20 Jul 2020 10:38:15 +1000
Message-ID: <1595203632.x8vplwce1a.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTAiV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 20:38:21 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, "David S. Miller" <davem@davemloft.net>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

When I last looked at this (predating io_uring), as far as I remember it wa=
s=20
not permitted to actually switch to (use_mm) an mm user context that was=20
pinned with mmget_not_zero. Those pins were only allowed to look at page=20
tables, vmas, etc., but not actually run the CPU in that mm context.

sparc/kernel/smp_64.c depends heavily on this, e.g.,

void smp_flush_tlb_mm(struct mm_struct *mm)
{
        u32 ctx =3D CTX_HWBITS(mm->context);
        int cpu =3D get_cpu();

        if (atomic_read(&mm->mm_users) =3D=3D 1) {
                cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
                goto local_flush_and_out;
        }

        smp_cross_call_masked(&xcall_flush_tlb_mm,
                              ctx, 0, 0,
                              mm_cpumask(mm));

local_flush_and_out:
        __flush_tlb_mm(ctx, SECONDARY_CONTEXT);

        put_cpu();
}

If a kthread comes in concurrently between the mm_users test and the=20
mm_cpumask reset, and does mmget_not_zero(); kthread_use_mm() then we have=20
another CPU switched to mm context but not in the mm_cpumask. It's then=20
possible for our thread to schedule on that CPU and not go through a=20
switch_mm (because kthread_unuse_mm will make it lazy, then we can switch=20
back to our user thread and un-lazy it).

powerpc has something similar.

I don't think this is documented anywhere and certainly isn't checked for=20
unfortunately, so I don't really blame io_uring.

The simplest fix is for io_uring to carry mm_users references. If that can'=
t=20
be done or we decide to lift the limitation on mmget_not_zero references, w=
e=20
can come up with a way to synchronize things.

On powerpc for example, we IPI all targets in mm_cpumask before clearing=20
them, so we could disable interrupts while kthread_use_mm does the mm switc=
h=20
sequence, and have the IPI handler check that current->mm hasn't been set t=
o=20
mm, for example.

sparc is a bit harder because it doesn't IPI targets if it thinks it can=20
avoid it. But powerpc found that just doing one IPI isn't a big burden here=
=20
so maybe we change sparc to do that too. I would be inclined to fix this=20
mmget_not_zero quirk if we can, unless someone has a very good way to test=20
and enforce it, it'll just happen again.

Comments?

Thanks,
Nick
