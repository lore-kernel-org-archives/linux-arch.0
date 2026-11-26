Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661928;
	b=XZFfpVBpBDVv145LBdxIIFA/Ck9XF7cYUbT6CLfv6J/+d7tLqoSfPFqT+qz4btqbEnp0
	 xtPs8eEsxcSaQki03UI5/k0vktfSsZiUOgWH/ImeRr9oeSawL/CASGenmbzzYgx82pikz
	 pVmkDUqMUDN7boRTd3rqpZ3iWyu8Cu4Irez7LKOwNHbHNzV3EUulMt5zeLxZVzNArkLzS
	 htDbmw93BE46C6o1v5MmLAsd3Yq/TqJo94tHBZoF0f3Ulhomhum0n1jUUe0ALt7SI2rDe
	 paP97jkeYKKVu7NGYhq4vEcxwi4rZC3RB8ye3QOqBabXXekU9rWn+d3NL60gBX1DlbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Jcf46vMrL1Ak3SRRaGZ9cHEca600Xi/gbcvc53XSl6M=;
	b=RutY34QArTjnC/FLnd2F76SXqKCwshm+JAu6D7RHbEoVoakA/NwPBFeGnihJyS+ernSi
	 U+5PH0ODIYHhYy0mselhAtWhrJwrKBdN+TxLWNjiDljvKm7U6kvIIMxou15hj3t8SaEzX
	 jPrY/fEdhQWt05DJZZv/RJTLbZ54GWl2ax7HCcuIZqNqKUwWi0CmJwJLZiM3usllIvGTD
	 Iq9aAlA8dEGS6SC6nx6qQEb34kYu3ZBuHTNIvzb7b/tHWIitdiKwp970kR1QrFmckiJxT
	 ThgFD8bKRCLnb5s2BhsFz4mzDa4R+K5cTsXJ5f11Z1j2PcT3gh7foHfFzKEumf6KM4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s/r8Hg18";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0494606A31E
	for <linux-arch@vger.kernel.org>; Thu, 26 Nov 2026 02:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0494606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/r8Hg18
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so57604095e9.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 18:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661925; cv=none;
        d=google.com; s=arc-20260327;
        b=GSw8dpfeRDUosuGbVxbGOFo309oZvFsvJ1l5TFaRgX79tUgDl4Rjee5nP+fYR9zlDc
         B+d2eKyAPEQWz1bmv1I9hY5r1y69FupSNg81vsUoakwPb80Q2OhxWDT66qG7X5+Jv3xm
         sZed4Qj67XW8yevVVaMDvBfxITTV2PntpsSHRuQAVcigvsN/e1K+kRBYAA/yXQFUyKKe
         eo8ROr+yrx90Qus63avEuUEx98q87mC5P1ejd/Y/w8O2yVFYLmwT159Ts9N8U6LwFGBq
         fgYxivNKF3CxrDNCPROh2WqjYeNs9m3iDphlfF0GMT5N5bKDjECMwmYNvIMFjWJ7NF5G
         qmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jcf46vMrL1Ak3SRRaGZ9cHEca600Xi/gbcvc53XSl6M=;
        fh=gSIL+WFd0mVTeyQ6+77TkoO9HtAHUmB9zeivTQ7E5nw=;
        b=i/NYEspkrzZBt0P+sDu7gGH1StwXfqEeuj9gdQME7opj+zD3EHiZJGqar0WpCn80c2
         7hmU4S+ArwrID7mtt0/0XaCaRbis5WXdNWvOwjg/2neg3JNqSN5F38hUZ6+n/q65z9sA
         NckhFH1OgkmNMKDxc29hFt8JCte2QHUkmzd2iYl2mzb70qkSe3asQ6631DsICs/4DoDf
         OIG/XZ7W+Yt3ZgAmWCSSRu2T8J0stjIYMGjexuaWs04ITNuSZAqT2Iw+q/yXnPDO1P6x
         mr1N2VHBln2PpFMpXpRIGTU7WfOBw+PVG4jGnQ6hIGTKt+o8jjUDA58SXo25eYbAII0s
         f+wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795661925; x=1796266725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jcf46vMrL1Ak3SRRaGZ9cHEca600Xi/gbcvc53XSl6M=;
        b=s/r8Hg18FrJblqdWFGWVzUgbEgFq61sfKi5K9hLBScs0jKDLLbxEALFrQffzy5Weml
         BOj4zRpRn3NVZGNgzcoWo6iWQyqUvy3Db2M3VzhqC2EeEMpilqsPZfyiSBAkgA1+2oc6
         4te8oyjyFoLxMOWy3z1dw0tDGbC4CeITWURTt8vff6cSYIdSGaSgGCZp61RYwwnNHhQG
         TkByypWspNoq7djJOO0Zv+StD1LuMP2ebH5Fak0D+gJcnnBY8OiU4mdxotWU9WWSFUN7
         wWzRul7fgN/ZYDUCMJSNg+MlS0wAYutqZNi7LdLAtDbmjaWNADUePJ2+GX577aMK7M55
         8jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661925; x=1796266725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jcf46vMrL1Ak3SRRaGZ9cHEca600Xi/gbcvc53XSl6M=;
        b=fUrmR0CEdoWPiSKEwPl/x06RGk0u+A2xXO/HDTkxZUErecvRkVdOJqP92qJ/XQzA7L
         avvBVnjZucOkDiJWRF+qQJ8PqW2KheCnInzyZpm87v4bX8r295nEeNHjo1NP6D0dLenw
         V4Eq51f+g5avwircZc+ISdD4dly96WVChWKCvmmUEVQr6TWEx2HY6rcv3MEPOOWb643O
         MLWYT2f8YdqAGw4df4CnseO3db5e1H09V+Pv8Q3RV3LFsCRV7WjYhy+zybT6oOIVrsNw
         fWHqxRU1oKJdWGAosUh54uwzh+Ys5EPfrq8AMBsr/Q5dyBx6ABocJz/LrkCLtR0T/OU7
         DpSQ==
X-Forwarded-Encrypted: i=1; AL+hErFEgheQ7svkBUSBuFaW6TkeYoUeRp2+IRWxFOVSErSgDiRXrnHnrLDSguBU6jv94O6mNAhadFbipxbK@vger.kernel.org
X-Gm-Message-State: APuU4Z9xnuig31rgElEideJH5vZxyyC2NA2k2BfuXY0m6voKBBRvuLSP
	d8M3WpAm/rYZU8kMGO1paGk3TTFMu5WuXG+l8HTZve/sRBqdAqa/Rau7fOnT2ialidfWpkV7Dat
	gO/YpKhkh7SyAwM0ZKrktJASfzxQUKeg=
X-Gm-Gg: AZFdTZfwd8Lnndy22GPrgjXa1Rakv8tTtapxMHD/jdbJYEqUnBW7l/P7L0HR/IhRQja
	El8ZnEE88wmD9QbPvAP6rpeL+RauoG/w2OUoRp8ItFw0X4nOFfTUwIxIejjcuOCxGeFGiJnVxer
	29PnWBdmC9SBABPoDOlL55VPpoMW/Uyli/k1rMnhhP/8Xbii8BctvunjeocE5Iy4VRSZFDhf1Z2
	iBQ7geAqdfPeClYxWwh0YujuzHUf60RiVPShQzhRVaU6gDPjp5+rdYCJndlaLH/Inq/d98B6c+u
	5sHCLHNI8mZ2DamsCdPtckuwMb/5ePJE9gEWwPmZRSvsi/ER6nz64cOox6lXuBd+kBM5e6crJZD
	+OKcAm8KA83FRKXvopFpZ67y2rx6oWP06EkZx9F4s45MLbE4W55lE/+Y+2zwBYPiyDeONwSFiPo
	LGaK6xZbxvdLizWT6r/WOlIJUSvxCrUeFeO+qf
X-Received: by 2002:a05:600c:5303:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb88785d24mr379605215e9.0.1795661924538; Wed, 25 Nov 2026
 18:58:44 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135148.1146372-1-elver@google.com> <CAN_Opa_TKjDAWz8EQaw6ro=joymwurpcy-k_x=q4E6TLt6ZpUQ@mail.gmail.com>
 <CANpmjNNOVD3KVrau5KD4WzqxoMkZZoJCfdPzvjLmZsGy9zXBug@mail.gmail.com>
 <CAN_Opa9zKzSptpNOnCzaW_EK0oT=HDDVoJxy5Q0crM+6b9bR_g@mail.gmail.com> <awdlqAbyRyJdSVeG@elver.google.com>
In-Reply-To: <awdlqAbyRyJdSVeG@elver.google.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 26 Nov 2026 10:58:32 +0800
X-Gm-Features: Aa3M54ochhGaRkCzJjnnDdPYZBZX-ICAJDvpktjGqTffKLARgZDNnQQDN4W6cyY
Message-ID: <CAN_Opa-Oa1-NiR9bHLkT-Z1pb+JDTj+oTKv_phVitVtwsV1EDA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 6:48=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Wed, Nov 25, 2026 at 05:40PM +0800, KunWu Chan wrote:
> [...]
> > Makes sense to keep the test in both configurations.
> >
> > I reran the three new KUnit cases on next-20261123 with rcutorture
> > disabled, using the same image with interruptible watchers on and
> > off.  Both runs passed all three cases at all seven thread counts
> > (21/21 per run, no skips).
> >
> > With watchers on, I checked the console reports for both remote
> > cases.  The two accesses were on different CPUs in each report.
> > The earlier -EBUSY and remote_read failures did not reproduce.
> > The separate 60-second rcutorture run also completed without any
> > reports involving got_idle_tick or tick_nohz_handler.
> >
> > One question about the IRQ-off path.  A local NMI can still write
> > to the watched address while its KCSAN checks are disabled.  If
> > that changes the sampled value and no other access hits the
> > watchpoint, is an unknown-origin report expected for THIS_CPU?
>
> Yeah, but we can suppress it:

Thanks, that addresses my NMI concern. The trade-off makes sense
to me.

>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 51340bf1d4a3..b3e0c2627712 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -689,7 +689,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size=
_t size, int type, unsigned
>                 kcsan_report_known_origin(ptr, size, type, ip,
>                                           value_change, watchpoint - watc=
hpoints,
>                                           old, new, access_mask);
> -       } else if (value_change =3D=3D KCSAN_VALUE_CHANGE_TRUE) {
> +       } else if (value_change =3D=3D KCSAN_VALUE_CHANGE_TRUE &&
> +                  /* May be due to a permitted write from NMI on this CP=
U. */
> +                  !(type & KCSAN_ACCESS_THIS_CPU)) {
>                 /* Inferring a race, since the value should not have chan=
ged. */
>
>                 atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_RACES_UNKNO=
WN_ORIGIN]);
>
>
> The downside is not detecting races with uninstrumented code, but usage
> of *_ONCE_THIS_CPU() is still rare, and if someone wants that coverage
> back, we can think of something better. In general, I find the unknown-
> origin reports not all that helpful in many cases, so my preference is
> to just ignore those.
>
> > Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Below is the complete v2 patch with the unknown-origin suppression.

I tested v2 on next-20261123. A 60-second rcutorture run with
strict KCSAN completed without any reports involving got_idle_tick
or tick_nohz_handler.

With rcutorture disabled, I ran the three new KUnit cases twice
with interruptible watchers on and twice with them off.
remote_write and local_noreport passed at all seven thread counts
in all four runs. The remote_read results were:

  watchers on:  one run passed; threads=3D5 failed in the other
  watchers off: threads=3D4 failed in one run; threads=3D5 and 8
                failed in the other

I also saw intermittent remote_read failures on v1 with
rcutorture enabled. Have you seen this in your runs?

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Mon, 23 Nov 2026 11:03:32 +0000
> Subject: [PATCH v2] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_TH=
IS_CPU()
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
> disabled while the watchpoint is set up. A value change without a racing
> access is not reported for these accesses, since it may be due to a
> permitted write from an NMI on the same CPU.
>
> With that, any racing accesses (incl. marked ones) from other CPUs
> involving READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() will be
> reported as "KCSAN: assert: race ...".
>
> Suggested-by: KunWu Chan <kunwu.chan@gmail.com>
> Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/asm-generic/rwonce.h | 22 +++++++--
>  include/linux/kcsan-checks.h |  1 +
>  kernel/kcsan/core.c          | 10 +++-
>  kernel/kcsan/kcsan_test.c    | 90 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 117 insertions(+), 6 deletions(-)
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
> index 26755add7cdb..b3e0c2627712 100644
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
> @@ -685,7 +689,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size=
_t size, int type, unsigned
>                 kcsan_report_known_origin(ptr, size, type, ip,
>                                           value_change, watchpoint - watc=
hpoints,
>                                           old, new, access_mask);
> -       } else if (value_change =3D=3D KCSAN_VALUE_CHANGE_TRUE) {
> +       } else if (value_change =3D=3D KCSAN_VALUE_CHANGE_TRUE &&
> +                  /* May be due to a permitted write from NMI on this CP=
U. */
> +                  !(type & KCSAN_ACCESS_THIS_CPU)) {
>                 /* Inferring a race, since the value should not have chan=
ged. */
>
>                 atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_RACES_UNKNO=
WN_ORIGIN]);
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
> 2.56.1.839.g22a8290db9-goog
>
