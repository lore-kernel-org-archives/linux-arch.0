From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 3/3] kcsan: Prefer __always_inline for fast-path
Date: Thu, 12 Dec 2019 22:11:59 +0100
Message-ID: <CANpmjNOvDHoapk1cR5rCAcYgfVwf8NS0wFJncJ-bQrWzCKLPpw@mail.gmail.com>
References: <20191126140406.164870-1-elver@google.com> <20191126140406.164870-3-elver@google.com>
 <00ee3b40-0e37-c9ac-3209-d07b233a0c1d@infradead.org> <20191203160128.GC2889@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203160128.GC2889@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 3 Dec 2019 at 17:01, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Dec 02, 2019 at 09:30:22PM -0800, Randy Dunlap wrote:
> > On 11/26/19 6:04 AM, Marco Elver wrote:
> > > Prefer __always_inline for fast-path functions that are called outside
> > > of user_access_save, to avoid generating UACCESS warnings when
> > > optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
> > > surprises with compiler versions that change the inlining heuristic even
> > > when optimizing for performance.
> > >
> > > Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Thank you, Randy!

Hoped this would have applied by now, but since KCSAN isn't in
mainline yet, should I send a version of this patch rebased on
-rcu/kcsan?
It will just conflict with the style cleanup that is in
-tip/locking/kcsan when another eventual merge happens. Alternatively,
we can delay it for now and just have to remember to apply eventually
(and have to live with things being messy for a bit longer :-)).

The version as-is here applies on -tip/locking/kcsan and -next (which
merged -tip/locking/kcsan).

Thanks,
-- Marco


>                                                         Thanx, Paul
>
> > Thanks.
> >
> > > ---
> > > Rebased on: locking/kcsan branch of tip tree.
> > > ---
> > >  kernel/kcsan/atomic.h   |  2 +-
> > >  kernel/kcsan/core.c     | 16 +++++++---------
> > >  kernel/kcsan/encoding.h | 14 +++++++-------
> > >  3 files changed, 15 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> > > index 576e03ddd6a3..a9c193053491 100644
> > > --- a/kernel/kcsan/atomic.h
> > > +++ b/kernel/kcsan/atomic.h
> > > @@ -18,7 +18,7 @@
> > >   * than cast to volatile. Eventually, we hope to be able to remove this
> > >   * function.
> > >   */
> > > -static inline bool kcsan_is_atomic(const volatile void *ptr)
> > > +static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
> > >  {
> > >     /* only jiffies for now */
> > >     return ptr == &jiffies;
> > > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > > index 3314fc29e236..c616fec639cd 100644
> > > --- a/kernel/kcsan/core.c
> > > +++ b/kernel/kcsan/core.c
> > > @@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
> > >   */
> > >  static DEFINE_PER_CPU(long, kcsan_skip);
> > >
> > > -static inline atomic_long_t *find_watchpoint(unsigned long addr,
> > > -                                        size_t size,
> > > -                                        bool expect_write,
> > > -                                        long *encoded_watchpoint)
> > > +static __always_inline atomic_long_t *
> > > +find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
> > >  {
> > >     const int slot = watchpoint_slot(addr);
> > >     const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> > > @@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
> > >   * 2. the thread that set up the watchpoint already removed it;
> > >   * 3. the watchpoint was removed and then re-used.
> > >   */
> > > -static inline bool
> > > +static __always_inline bool
> > >  try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
> > >  {
> > >     return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
> > > @@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
> > >     return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
> > >  }
> > >
> > > -static inline struct kcsan_ctx *get_ctx(void)
> > > +static __always_inline struct kcsan_ctx *get_ctx(void)
> > >  {
> > >     /*
> > >      * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
> > > @@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
> > >     return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> > >  }
> > >
> > > -static inline bool is_atomic(const volatile void *ptr)
> > > +static __always_inline bool is_atomic(const volatile void *ptr)
> > >  {
> > >     struct kcsan_ctx *ctx = get_ctx();
> > >
> > > @@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
> > >     return kcsan_is_atomic(ptr);
> > >  }
> > >
> > > -static inline bool should_watch(const volatile void *ptr, int type)
> > > +static __always_inline bool should_watch(const volatile void *ptr, int type)
> > >  {
> > >     /*
> > >      * Never set up watchpoints when memory operations are atomic.
> > > @@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
> > >     this_cpu_write(kcsan_skip, skip_count);
> > >  }
> > >
> > > -static inline bool kcsan_is_enabled(void)
> > > +static __always_inline bool kcsan_is_enabled(void)
> > >  {
> > >     return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
> > >  }
> > > diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> > > index b63890e86449..f03562aaf2eb 100644
> > > --- a/kernel/kcsan/encoding.h
> > > +++ b/kernel/kcsan/encoding.h
> > > @@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
> > >                   (addr & WATCHPOINT_ADDR_MASK));
> > >  }
> > >
> > > -static inline bool decode_watchpoint(long watchpoint,
> > > -                                unsigned long *addr_masked,
> > > -                                size_t *size,
> > > -                                bool *is_write)
> > > +static __always_inline bool decode_watchpoint(long watchpoint,
> > > +                                         unsigned long *addr_masked,
> > > +                                         size_t *size,
> > > +                                         bool *is_write)
> > >  {
> > >     if (watchpoint == INVALID_WATCHPOINT ||
> > >         watchpoint == CONSUMED_WATCHPOINT)
> > > @@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
> > >  /*
> > >   * Return watchpoint slot for an address.
> > >   */
> > > -static inline int watchpoint_slot(unsigned long addr)
> > > +static __always_inline int watchpoint_slot(unsigned long addr)
> > >  {
> > >     return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
> > >  }
> > >
> > > -static inline bool matching_access(unsigned long addr1, size_t size1,
> > > -                              unsigned long addr2, size_t size2)
> > > +static __always_inline bool matching_access(unsigned long addr1, size_t size1,
> > > +                                       unsigned long addr2, size_t size2)
> > >  {
> > >     unsigned long end_range1 = addr1 + size1 - 1;
> > >     unsigned long end_range2 = addr2 + size2 - 1;
> > >
> >
> >
> > --
> > ~Randy
> >
