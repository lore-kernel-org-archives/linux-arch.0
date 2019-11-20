From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Date: Wed, 20 Nov 2019 16:54:48 +0100
Message-ID: <20191120155448.GA21320@google.com>
References: <20191114180303.66955-1-elver@google.com>
 <1574194379.9585.10.camel@lca.pw>
 <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-arch.vger.kernel.org

On Tue, 19 Nov 2019, Marco Elver wrote:

> On Tue, 19 Nov 2019 at 21:13, Qian Cai <cai@lca.pw> wrote:
> >
> > On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
> > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > only enables KCSAN for x86, but we expect adding support for other
> > > architectures is relatively straightforward (we are aware of
> > > experimental ARM64 and POWER support).
> >
> > This does not allow the system to boot. Just hang forever at the end.
> >
> > https://cailca.github.io/files/dmesg.txt
> >
> > the config (dselect KASAN and select KCSAN with default options):
> >
> > https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> Thanks! That config enables lots of other debug code. I could
> reproduce the hang. It's related to CONFIG_PROVE_LOCKING etc.
> 
> The problem is definitely not the fact that kcsan_setup_watchpoint
> disables interrupts (tested by removing that code). Although lockdep
> still complains here, and looking at the code in kcsan/core.c, I just
> can't see how local_irq_restore cannot be called before returning (in
> the stacktrace you provided, there is no kcsan function), and
> interrupts should always be re-enabled. (Interrupts are only disabled
> during delay in kcsan_setup_watchpoint.)
> 
> What I also notice is that this happens when the console starts
> getting spammed with data-race reports (presumably because some extra
> debug code has lots of data races according to KCSAN).
> 
> My guess is that some of the extra debug logic enabled in that config
> is incompatible with KCSAN. However, so far I cannot tell where
> exactly the problem is. For now the work-around would be not using
> KCSAN with these extra debug options.  I will investigate more, but
> nothing obviously wrong stands out..

It seems that due to spinlock_debug.c containing data races, the console
gets spammed with reports. However, it's also possible to encounter
deadlock, e.g.  printk lock -> spinlock_debug -> KCSAN detects data race
-> kcsan_print_report() -> printk lock -> deadlock.

So the best thing is to fix the data races in spinlock_debug. I will
send a patch separately for you to test.

The issue that lockdep still reports inconsistency in IRQ flags tracing
I cannot yet say what the problem is. It seems that lockdep IRQ flags
tracing may have an issue with KCSAN for numerous reasons: let's say
lockdep and IRQ flags tracing code is instrumented, which then calls
into KCSAN, which disables/enables interrupts, but due to tracing calls
back into lockdep code. In other words, there may be some recursion
which corrupts hardirqs_enabled.

Thanks,
-- Marco
