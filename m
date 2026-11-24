Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514044;
	b=cPhJi6Yswfj2VZvLZLzZjaBdO5wKZ+vhqwRw6lgeCX8LheXrQ3Y21tABwom1y9MvogqE
	 VcCq0DvIjKRAdvoHD7BlU4ZuszCM+Dgu+Lj5ivjMu3yPabfCAhUlS/ow9glGoMVK7kWjM
	 cvX4NCt2p5/BHYAdV2cfIpHbo3MXPHj97bPoJCxp6lkDLWkm9AZb05moEipFjmqJfvJ/X
	 63P6oIRBz59WHV072uoZhS/FNBAZxZq54FLpr/aeG61fGgzElbHAL0NBOMOS+0MkWEPpX
	 cxILAcUf3ng5pEwOEoiYiJhmUzSC+ISQ3Mi171dMARA8lUpbeVSclKij8mZcR5jzonw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3XE0uUjqPgbY6qz1CMjmYZM0fFm1iknNSAbfQAkxjC8=;
	b=ZgsU+lHOClRnTCMdRdaQvwqxwirKJwiF6FNNnF1hSQequc/z7LNswrUf9Wd1/mjoLk+K
	 k/hkhUUaBLK0wrnHu6dTe38x6XiXXIe4bfRIqQvS2P+blt6+nav2EItSQeo1yafsSbZe1
	 ckKA9PCCuYQwRruQtGVUgThWY/2tg6OVmEybhJhhyOeCFw0KQuQOIQ7Af3wxLyOfDwijM
	 gwHRjJ6RdxJsaj6ucfh7LZH5WSWbsDNv0LrSKPYhmZJJHRTyrzPUgipBxwqGWElzNYYyx
	 llljGN70H81fk5DezC+cI7Me+fvku1o4x1/xthT8GTe+XDYI2FHGfDKpsSdmntcpBgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DHHe0QMY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F8606A31E
	for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 09:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6F8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DHHe0QMY
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so3512645f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 01:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795514042; cv=none;
        d=google.com; s=arc-20260327;
        b=nGhEg2K6a+JtNJBaTQaJNNSMS1zx2bVXT3XDwUxY4IOsybl27/eFWhJzn+lSC1VeCc
         2fIXr6xCfQgXEDmfo2v6JFoYKcgmAVWqpSDxUQnVapW1xZNJR6FTOj5xSD7puUYb4Uo/
         m+R1aC7kzGYJ8luCsY3MW5CXSHJeFLTzQ7W3GZZeHI+9UPuvQc3BCtj/W777IRf6u0FD
         anOKT8hs+YFV/JS0yb2DFBm8odijsk8f3oDUyFMkYBAM+ZDR0fmmP6m0Y6Xk1jhf7QqK
         R7AtmnucpbJC+fudvujdLsdmL1xQNnLQcB8AhozmpFEgpiR+bAtpXbQS3HhVNq/PHDcr
         f+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3XE0uUjqPgbY6qz1CMjmYZM0fFm1iknNSAbfQAkxjC8=;
        fh=pQnpR1K9mDn+eZWaM+Kpq/QmT68T2NsgTCNxW2tchZw=;
        b=XDdct4gWgqqYi3JOaES+FUdlQeCGXm9NF0QqYuw6zyl9Y8RDyPz+w3cJU0tpgzeegk
         bXfW6k0cvmKY5s8sEYoR/BBKxIRiDC+6lHt1moT6JGP6qaT1q4YlhezR8NA24lWc535X
         u3B+cML7ZfZd4nTMJS6Y7AjLbOIOFUjPjFIPPJLYiqMff4pKP3EWjfVeo/G4o4Ssi5ku
         H+UGF2vpZb0+tITDmshzRp+zucp58TXSnT67FZq8HyZqFuF7DjgSUWb5Pyo1P2TEHXu2
         RTFhDQ/LeciIsVXRTMM8Rr3DxQdcGfbYCG2SVg8kX2CL9dCJkckWk94CRZJWC9eeF2Pw
         MxAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795514042; x=1796118842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3XE0uUjqPgbY6qz1CMjmYZM0fFm1iknNSAbfQAkxjC8=;
        b=DHHe0QMYtCZgFu2jFwEFow28e2kp6IbOR3cmnjFHUzjRdUvS6TcUs2Zj7mDV9LXd7r
         kPRCBu8hKuG57sSxvh4i4ngC9Qp2dt5rFaW24SBskpTm1YROZ2qiZyHYCFZz9oX2eRFV
         aF4gAi6WIAtdXK8G7uCc7kqClI+NjeVkH0lY3NaQpK/HpFQvHT2KKxF8LnHuTipukfpG
         kMDjPEsoclckPHJmNOzlnjQyP0vpN7HlwtISVLyf1FU5ZMN7i3KGxC/XudCFHdFMd8tn
         31Vrs3WOxrr7kATomRQcuaT04GMiqS8hkVdKDIHtpuT8RdG8VCRHBtrFNS6rQAXIUmFm
         K5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514042; x=1796118842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XE0uUjqPgbY6qz1CMjmYZM0fFm1iknNSAbfQAkxjC8=;
        b=Hu/0T9ZF2YqSo/DhzWKmzcSg2ZIZ7oOErUDv75O77X4dhi+Jzbu3RX6c1UEGDka1Rr
         9P4atKVLXDy5qyt+8WsgVWuqNsKS5bxZ7PGTurrf3Ypk6LLvrEpdMOxcRwtVAUmxjTwh
         rfuNIwWcsCBT554zuhiOW9qdoHp/zgfQ86UqTtvPnwtCnKYhNoVHOwC8uNLG5GVhUE+h
         uy6UVfflanJn2qS/Cz4xeu8qTOQXysd6DjOizotgjy0TW2ZWQavzswklSZN37SkvCJW7
         yqv+oBfXCweVoonlEDrQat0AqanItVrzJJMXu+4BQT0ergHsZukNjb/LBt6pG7pj4Db7
         F/MQ==
X-Forwarded-Encrypted: i=1; AL+hErFevTw3AeILZAotCMXPdhYPyzqoWfy/id3vU9wtKCArMo5aaxBJtDzhFY9Ct7Q89fB9uCIHGmSy38Fo@vger.kernel.org
X-Gm-Message-State: APuU4Z/giFmGFk3/o7rWUFCBD9RCcWPV7lBclcxl9UkfttGBa/n92RbE
	FXLIC4ipjGGFm5nr4eesZTOu/Si85owZ8Z1RfjNDeBiA/30x3P9StU/syETVmNPzyGn0pMnHrgm
	sVV6UqaXhuDIY7IIIJ6dwPzjNRqpnIfw=
X-Gm-Gg: AZFdTZeVVwafEJ4UgDbDzSY7O44PBc0rqP0h6bskyFZ3/i7Q9Xs42FtqHHy05RNQS+6
	kD/AsvjHR6Rhvya5qAanvElxPJgcmCr6xxcDSpngC/SxGJ/sfGBXmbG6JA9D/QywXW33Ggr5eWm
	P5pjZaUKj648p9BNl/OP/izPS/ny0ZkFR0gjLY/hzbSFQzb5pEu/Z9NLczaE4HusipYHjRTEMGh
	FMTKQLUbdXkeTWYaFjdJrwXoBwFhQLDDw0ZtLn+4VS1JzZwUIUWEa2/5iKupgbnqS5XUC882HAw
	AIW2qzaBU1H/1zvGMWSNJ9eci75x3PyFOU6Vk0y3+ymr2KzSRegnaYIp3QPJ+UoER53vi1PthYU
	VTrYNcY4oAS+5fcvXNoA+CNUMH6in+XP72ChKGnQHgu9sa5aplBZc7ZMTdTtcl6AP5GSzoSqLAL
	57nVR1xokFRcqDdAEW45TIR8oyA7ypa59odl6EMXZ7DKHwV5nFYrJQ
X-Received: by 2002:a05:600c:674f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb8880fb9bmr279676525e9.23.1795514041244; Tue, 24 Nov 2026
 01:54:01 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135148.1146372-1-elver@google.com>
In-Reply-To: <20261123135148.1146372-1-elver@google.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 24 Nov 2026 17:53:49 +0800
X-Gm-Features: Aa3M54ro1GsGN0T_OAbnrj_d9U_4hm2dWKW679JHZVAzKlNygS-dbtMDACIBNxo
Message-ID: <CAN_Opa_TKjDAWz8EQaw6ro=joymwurpcy-k_x=q4E6TLt6ZpUQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:51=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() identify accesses to
> per-CPU data that are intended to race only with other contexts on the
> same CPU. So far they are plain READ_ONCE() and WRITE_ONCE(): no marked
> accesses involving them are reported, incl. from other CPUs.
>
> Make the new accessors assert exclusivity but ignore same-CPU accesses:
> READ_ONCE_THIS_CPU() asserts no concurrent writers,
> WRITE_ONCE_THIS_CPU() asserts no concurrent accesses.
>
> For KCSAN to ignore racing accesses from other contexts on the same CPU,
> introduce KCSAN_ACCESS_THIS_CPU, which makes KCSAN keep interrupts
> disabled while the watchpoint is set up.
>
> With that, any racing accesses (incl. marked ones) from other CPUs
> involving READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() will be
> reported as "KCSAN: assert: race ...".
>
> Suggested-by: KunWu Chan <kunwu.chan@gmail.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/asm-generic/rwonce.h | 22 +++++++--
>  include/linux/kcsan-checks.h |  1 +
>  kernel/kcsan/core.c          |  6 ++-
>  kernel/kcsan/kcsan_test.c    | 90 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+), 5 deletions(-)
>
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 3dc65a3310fb..e2d563096738 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -66,11 +66,25 @@ do {                                                 =
                       \
>   * which are intended to race only with accesses from other execution
>   * contexts on the same CPU, e.g. task and interrupt context.
>   *
> - * For now, these are simple wrappers around READ_ONCE() and
> - * WRITE_ONCE().
> + * With KCSAN, concurrent writes (for READ_ONCE_THIS_CPU()) or any concu=
rrent
> + * accesses (for WRITE_ONCE_THIS_CPU()) from other CPUs are reported.
>   */
> -#define READ_ONCE_THIS_CPU(x)          READ_ONCE(x)
> -#define WRITE_ONCE_THIS_CPU(x, val)    WRITE_ONCE(x, val)
> +#define READ_ONCE_THIS_CPU(x)                                          \
> +({                                                                     \
> +       auto __tc_p =3D &(x);                                            =
 \
> +       kcsan_check_access(__tc_p, sizeof(*__tc_p),                     \
> +                          KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_THIS_CPU);\
> +       READ_ONCE(*__tc_p);                                             \
> +})
> +
> +#define WRITE_ONCE_THIS_CPU(x, val)                                    \
> +do {                                                                   \
> +       auto __tc_p =3D &(x);                                            =
 \
> +       kcsan_check_access(__tc_p, sizeof(*__tc_p),                     \
> +                          KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE |   \
> +                          KCSAN_ACCESS_THIS_CPU);                      \
> +       WRITE_ONCE(*__tc_p, val);                                       \
> +} while (0)
>
>  static __no_sanitize_or_inline
>  unsigned long __read_once_word_nocheck(const void *addr)
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index e135dacaa90f..afe50fe351fa 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -20,6 +20,7 @@
>  /* The following are special, and never due to compiler instrumentation.=
 */
>  #define KCSAN_ACCESS_ASSERT    (1 << 3) /* Access is an assertion. */
>  #define KCSAN_ACCESS_SCOPED    (1 << 4) /* Access is a scoped access. */
> +#define KCSAN_ACCESS_THIS_CPU  (1 << 5) /* Ignore races from same-CPU ac=
cesses. */
>
>  /*
>   * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This =
may be used
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 26755add7cdb..51340bf1d4a3 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -567,9 +567,13 @@ kcsan_setup_watchpoint(const volatile void *ptr, siz=
e_t size, int type, unsigned
>          *      1. Races of the reordered access with interrupts. To avoi=
d, if
>          *         the current access is reorder_access, disable interrup=
ts.
>          *      2. Avoid races of scoped accesses from nested interrupts =
(below).
> +        *
> +        * Similarly, KCSAN_ACCESS_THIS_CPU accesses may only race with
> +        * interrupts on the same CPU: disable interrupts, so that only r=
aces
> +        * with other CPUs are detected.
>          */
>         is_reorder_access =3D find_reorder_access(ctx, ptr, size, type, i=
p);
> -       if (is_reorder_access)
> +       if (is_reorder_access || (type & KCSAN_ACCESS_THIS_CPU))
>                 interrupt_watcher =3D false;
>         /*
>          * Avoid races of scoped accesses from nested interrupts (or sche=
duler).
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 1c8853f14dae..3e9689492abe 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -22,6 +22,7 @@
>  #include <linux/kcsan-checks.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> +#include <linux/percpu.h>
>  #include <linux/sched.h>
>  #include <linux/seqlock.h>
>  #include <linux/spinlock.h>
> @@ -337,6 +338,7 @@ static struct {
>         long val[8];
>  } test_struct;
>  static long __data_racy test_data_racy;
> +static DEFINE_PER_CPU(long, test_pcpu_var);
>  static DEFINE_SEQLOCK(test_seqlock);
>  static DEFINE_SPINLOCK(test_spinlock);
>  static DEFINE_MUTEX(test_mutex);
> @@ -403,6 +405,34 @@ static noinline void test_kernel_assert_access(void)
>         ASSERT_EXCLUSIVE_ACCESS(test_var);
>  }
>
> +static noinline void test_kernel_read_this_cpu(void)
> +{
> +       sink_value(READ_ONCE_THIS_CPU(test_var));
> +}
> +
> +static noinline void test_kernel_write_this_cpu(void)
> +{
> +       WRITE_ONCE_THIS_CPU(test_var, 42);
> +}
> +
> +static noinline void test_kernel_write_this_cpu_local(void)
> +{
> +       preempt_disable();
> +       WRITE_ONCE_THIS_CPU(*this_cpu_ptr(&test_pcpu_var), 1);
> +       preempt_enable();
> +}
> +
> +static noinline void test_kernel_reset_this_cpu_local(void)
> +{
> +       long *p;
> +
> +       preempt_disable();
> +       p =3D this_cpu_ptr(&test_pcpu_var);
> +       if (READ_ONCE_THIS_CPU(*p))
> +               WRITE_ONCE_THIS_CPU(*p, 0);
> +       preempt_enable();
> +}
> +
>  #define TEST_CHANGE_BITS 0xff00ff00
>
>  static noinline void test_kernel_change_bits(void)
> @@ -1223,6 +1253,63 @@ static void test_assert_exclusive_access_scoped(st=
ruct kunit *test)
>         KUNIT_EXPECT_FALSE(test, match_expect_inscope);
>  }
>
> +/* Test that remote writes racing with READ_ONCE_THIS_CPU() are reported=
. */
> +__no_kcsan
> +static void test_this_cpu_remote_write(struct kunit *test)
> +{
> +       struct expect_report expect =3D {
> +               .access =3D {
> +                       { test_kernel_read_this_cpu, &test_var, sizeof(te=
st_var), KCSAN_ACCESS_ASSERT },
> +                       { test_kernel_write_atomic, &test_var, sizeof(tes=
t_var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC },
> +               },
> +       };
> +       bool match_expect =3D false;
> +
> +       KCSAN_TEST_REQUIRES(test, !IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS=
));
> +
> +       begin_test_checks(test_kernel_read_this_cpu, test_kernel_write_at=
omic);
> +       do {
> +               match_expect =3D report_matches(&expect);
> +       } while (!end_test_checks(match_expect));
> +       KUNIT_EXPECT_TRUE(test, match_expect);
> +}
> +
> +/* Test that remote reads racing with WRITE_ONCE_THIS_CPU() are reported=
. */
> +__no_kcsan
> +static void test_this_cpu_remote_read(struct kunit *test)
> +{
> +       struct expect_report expect =3D {
> +               .access =3D {
> +                       { test_kernel_write_this_cpu, &test_var, sizeof(t=
est_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
> +                       { test_kernel_read, &test_var, sizeof(test_var), =
0 },
> +               },
> +       };
> +       bool match_expect =3D false;
> +
> +       begin_test_checks(test_kernel_write_this_cpu, test_kernel_read);
> +       do {
> +               match_expect =3D report_matches(&expect);
> +       } while (!end_test_checks(match_expect));
> +       KUNIT_EXPECT_TRUE(test, match_expect);
> +}
> +
> +/*
> + * Test that races between task and interrupt on the same CPU's instance=
 are not
> + * reported; the test threads' timers access the same per-CPU instance a=
s the
> + * interrupted thread. Only meaningful with CONFIG_KCSAN_INTERRUPT_WATCH=
ER=3Dy.
> + */
> +__no_kcsan
> +static void test_this_cpu_local_noreport(struct kunit *test)
> +{
> +       bool match_never =3D false;
> +
> +       begin_test_checks(test_kernel_write_this_cpu_local, test_kernel_r=
eset_this_cpu_local);
> +       do {
> +               match_never =3D report_available();
> +       } while (!end_test_checks(match_never));
> +       KUNIT_EXPECT_FALSE(test, match_never);
> +}
> +
>  /*
>   * jiffies is special (declared to be volatile) and its accesses are typ=
ically
>   * not marked; this test ensures that the compiler nor KCSAN gets confus=
ed about
> @@ -1485,6 +1572,9 @@ static struct kunit_case kcsan_test_cases[] =3D {
>         KCSAN_KUNIT_CASE(test_assert_exclusive_bits_nochange),
>         KCSAN_KUNIT_CASE(test_assert_exclusive_writer_scoped),
>         KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
> +       KCSAN_KUNIT_CASE(test_this_cpu_remote_write),
> +       KCSAN_KUNIT_CASE(test_this_cpu_remote_read),
> +       KCSAN_KUNIT_CASE(test_this_cpu_local_noreport),
>         KCSAN_KUNIT_CASE(test_jiffies_noreport),
>         KCSAN_KUNIT_CASE(test_seqlock_noreport),
>         KCSAN_KUNIT_CASE(test_atomic_builtins),
> --
> 2.56.1.750.gf70dc682cf-goog
>

Hi Marco,

I tested the patch on next-20261123. A 60-second rcutorture run
with strict KCSAN and interruptible watchers completed successfully.
I saw no reports involving got_idle_tick or tick_nohz_handler.
There was one report involving move_linked_works / queue_work_on.

The latest KUnit run with kunit.filter_glob=3Dkcsan.test_this_cpu_* gave:

  local_noreport: 7/7 passed
  remote_write:   6/7 passed; threads=3D2 failed setup with -EBUSY
                  ("rcu running")
  remote_read:    5/7 passed; threads=3D16 and 32 failed

The -EBUSY log shows that rcutorture was already running. The
remote_read failure at 32 threads occurred in both runs. I'll
rerun the KUnit cases with rcutorture disabled and check the
console for the failed cases.

One test question: should local_noreport skip when interruptible
watchers are disabled? In that setup the ordinary watchpoint
path already masks local IRQs, so a pass wouldn't exercise the
new THIS_CPU behavior.

Thanks,
Kunwu
