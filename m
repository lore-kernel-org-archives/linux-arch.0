Return-Path: <owner-linux-mm@kvack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Date: Tue, 14 Jan 2020 06:08:29 -0500
Message-ID: <53F6B915-AC53-41BB-BF32-33732515B3A0@lca.pw>
References: 
 <CANpmjNOC2PYFsE_TK2SYmKcHxyG+2arWc8x_fmeWPOMi0+ot8g@mail.gmail.com>
In-Reply-To: 
 <CANpmjNOC2PYFsE_TK2SYmKcHxyG+2arWc8x_fmeWPOMi0+ot8g@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Marco Elver <elver@google.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <Mark.Rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200114110829.pa32ds_evS1m1-PD4M6iLscSiaA13dNMeXIxriBjbXs@z>



> On Jan 6, 2020, at 7:47 AM, Marco Elver <elver@google.com> wrote:
>=20
> Thanks, I'll look into KCSAN + lockdep compatibility. It's probably
> missing some KCSAN_SANITIZE :=3D n in some Makefile.

Can I have a update on fixing this? It looks like more of a problem that kcs=
an_setup_watchpoint() will disable IRQs and then dive into the page allocato=
r where it would complain because it might sleep.

BTW, I saw Paul sent a pull request for 5.6 but it is ugly to have everybody=
 could trigger a deadlock (sleep function called in atomic context) like thi=
s during boot once this hits the mainline not to mention about only recently=
 it is possible to test this feature (thanks to warning ratelimit) with the e=
xisting debugging options because it was unable to boot due to the brokennes=
s with debug_pagealloc as mentioned in this thread, so this does sounds like=
 it needs more soak time for the mainline to me.

0000000000000400
[   13.416814][    T1] Call Trace:
[   13.416814][    T1]  lock_is_held_type+0x66/0x160
[   13.416814][    T1]  ___might_sleep+0xc1/0x1d0
[   13.416814][    T1]  __might_sleep+0x5b/0xa0
[   13.416814][    T1]  slab_pre_alloc_hook+0x7b/0xa0
[   13.416814][    T1]  __kmalloc_node+0x60/0x300
[   13.416814   T1]  ? alloc_cpumask_var_node+0x44/0x70
[   13.416814][    T1]  ? topology_phys_to_logical_die+0x7e/0x180
[   13.416814][    T1]  alloc_cpumask_var_node+0x44/0x70
[   13.416814][    T1]  zalloc_cpumask_var+0x2a/0x40
[   13.416814][    T1]  native_smp_prepare_cpus+0x246/0x425
[   13.416814][    T1]  kernel_init_freeable+0x1b8/0x496
[   13.416814][    T1]  ? rest_init+0x381/0x381
[   13.416814][    T1]  kernel_init+0x18/0x17f
[   13.416814][    T1]  ? rest_init+0x381/0x381
[   13.416814][    T1]  ret_from_fork+0x3a/0x50
[   13.416814][    T1] irq event stamp: 910
[   13.416814][    T1] hardirqs last  enabled at (909): [<ffffffff8d1240f3>]=
 _raw_write_unlock_irqrestore+0x53/0x57
[   13.416814][    T1] hardirqs last disabled at (910): [<ffffffff8c8bba76>]=
 kcsan_setup_watchpoint+0x96/0x460
[   13.416814][    T1] softirqs last  enabled at (0): [<ffffffff8c6b697a>] c=
opy_process+0x11fa/0x34f0
[   13.416814][    T1] softirqs last disabled at (0): [<0000000000000000>] 0=
x0
[   13.416814][    T1] ---[ end trace 7d1df66da055aa92 ]---
[   13.416814][    T1] possible reason: unannotated irqs-on.
[   13.416814][ent stamp: 910
[   13.416814][    T1] hardirqs last  enabled at (909): [<ffffffff8d1240f3>]=
 _raw_write_unlock_irqrestore+0x53/0x57
[   13.416814][    T1] hardirqs last disabled at (910): [<ffffffff8c8bba76>]=
 kcsan_setup_watchpoint+0x96/0x460
[   13.416814][    T1] softirqs last  enabled at (0): [<ffffffff8c6b697a>] c=
opy_process+0x11fa/0x34f0
[   13.416814][    T1] softirqs last disabled at (0): [<0000000000000000>] 0=
x0=
