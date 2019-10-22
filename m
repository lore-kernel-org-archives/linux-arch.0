Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388435AbfJVPtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2019 11:49:16 -0400
Date: Tue, 22 Oct 2019 17:48:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191022154858.GA13700@redhat.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-2-elver@google.com>
MIME-Version: 1.0
In-Reply-To: <20191017141305.146193-2-elver@google.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191022154858.FXlRBk_sWGbDitShAADPScOEW2xpKCE3LzaZPRgsRP4@z>

On 10/17, Marco Elver wrote:
>
> +=09/*
> +=09 * Delay this thread, to increase probability of observing a racy
> +=09 * conflicting access.
> +=09 */
> +=09udelay(get_delay());
> +
> +=09/*
> +=09 * Re-read value, and check if it is as expected; if not, we infer a
> +=09 * racy access.
> +=09 */
> +=09switch (size) {
> +=09case 1:
> +=09=09is_expected =3D expect_value._1 =3D=3D READ_ONCE(*(const u8 *)ptr)=
;
> +=09=09break;
> +=09case 2:
> +=09=09is_expected =3D expect_value._2 =3D=3D READ_ONCE(*(const u16 *)ptr=
);
> +=09=09break;
> +=09case 4:
> +=09=09is_expected =3D expect_value._4 =3D=3D READ_ONCE(*(const u32 *)ptr=
);
> +=09=09break;
> +=09case 8:
> +=09=09is_expected =3D expect_value._8 =3D=3D READ_ONCE(*(const u64 *)ptr=
);
> +=09=09break;
> +=09default:
> +=09=09break; /* ignore; we do not diff the values */
> +=09}
> +
> +=09/* Check if this access raced with another. */
> +=09if (!remove_watchpoint(watchpoint)) {
> +=09=09/*
> +=09=09 * No need to increment 'race' counter, as the racing thread
> +=09=09 * already did.
> +=09=09 */
> +=09=09kcsan_report(ptr, size, is_write, smp_processor_id(),
> +=09=09=09     kcsan_report_race_setup);
> +=09} else if (!is_expected) {
> +=09=09/* Inferring a race, since the value should not have changed. */
> +=09=09kcsan_counter_inc(kcsan_counter_races_unknown_origin);
> +#ifdef CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> +=09=09kcsan_report(ptr, size, is_write, smp_processor_id(),
> +=09=09=09     kcsan_report_race_unknown_origin);
> +#endif
> +=09}

Not sure I understand this code...

Just for example. Suppose that task->state =3D TASK_UNINTERRUPTIBLE, this t=
ask
does __set_current_state(TASK_RUNNING), another CPU does wake_up_process(ta=
sk)
which does the same UNINTERRUPTIBLE -> RUNNING transition.

Looks like, this is the "data race" according to kcsan?

Hmm. even the "if (!(p->state & state))" check in try_to_wake_up() can trig=
ger
kcsan_report() ?

Oleg.
