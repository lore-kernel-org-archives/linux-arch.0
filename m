Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499201;
	b=BOB6m5LjL/+kAzBQWSL8LFRp99iRpBEmlzSDufP+3Q6IQo7yLAPpz0+ZcY2EieG6Hm4p
	 cDIJtL7VxZ38ZyzSr3ex1AOqB4aLenrB7b6g9J3rlQGDgapb52ezerbLZE2Euvj/n9zIM
	 x1+090UWy3KPyhriH2XPVPvLH6luv33nsmrNHgPYd+AEhQIUzZPAaPK1ZWseoDvKZ+zE3
	 HMSrfJRRqPXe0+CehefuCHq3+r/s6YIRWNJS9MEnBTn8n4+3wIyzHq37sRyDw+CmmQRA7
	 IE8iDPACg32Lfi5WQo1fzRMHXzUSekohwc+t3BwOlVARtBA3imMnUFXmisvk6nzP5iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
	b=FxPoraOHJzTEUBAJKH56dKozMyoRNnF2HYMOBUFJTwIm6QRnKz3sW4JSKqxRpWWJqJH9
	 1gVDY7vOwb6850L1CYzyC8Knk0MLfA5/e5y51yEkuptGw0SXcGCLeqg9jWlZLNB5By4BN
	 pgy9vKPk6iqquL7cC4M88jlpHwjXXlrniPI8QoZwp9ZM76yqV1W+E2eETuym2jMZJqHIB
	 P0PW+m3Q42dxlhMT38dtI7xEsQOFwypGC9ZYmq5uRWxdvQncFkfgXwhQhvWwJU7fcy4Fi
	 D8WaZLN+0Bxi1IrKTlqVf9lVdrz8sTDjfLxGcy84DpzCp21otoLsrirI1O1h3gUHNnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VNq/TS9Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B730606A334
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 16:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B730606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VNq/TS9Y
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so48505305e9.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 08:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499199; cv=none;
        d=google.com; s=arc-20260327;
        b=PfyRVSsxNsG+ww9FucletOa08UWmI74JWyNgQp3gl7ao34+AhYh9Dc3SvOZIGAg4Gs
         hgflUPu4kuFxIAh11D4S/XAaUdSscVez7zxBz8nCeIFj3qmxx7fYpCg2EfTCXK4r5w3i
         LJiX00CAaKd85t+jc1uM1ti/kEnFD+b/S2xx6KRNEVwVya1GUqrWlQZriFCmXNO26zd/
         TMG0NV1VKAOSMHR3l9LAmKlujt9boq0zTXDj2U+9j04CmQVKOj5ndZZq6M423p6TIoxN
         JfChlF9VGDkUzzHZBYxplAfmPsMdtT+jgzp/WbgH0fXmGXd/dBf72FEYrfj8ZLyDLi50
         KzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
        fh=5H4DxCwuIA6SldeFsSDx2aMkGctf3vX7X5DQ77gfRvc=;
        b=nkJ6m05QvuNiKNhmxH9jupOaADtoK6wbKf1Yr5lAay06sik6bANW+KMcwRZL/xa1dN
         zxhw/qSyYdhITipQA/sXsWhEpE2LXzP0yVHPmJ+8+0dT0QmeYl1tUwqnPX48mvlYlvyV
         o073rJhw1/jBwJYJf1VA/tV9OljAhNzZpRK1KB7rqh1drlEJs7UtEryv6plRHdq5U6qi
         1a2eTK4HgAw1+lGSR5AKdqI0X0tpMjqzKP6XB7w9FQ5ETsC17r1MVTGPJNVI0YYLU5DM
         QJzSYFL6fNHrieTU9RLPxa4Fd62UWaulxKQxSgWZuP4HE8e/ZX3Vu2zbCxUt6NI1vx/O
         g47Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499199; x=1795103999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
        b=VNq/TS9YxMxpbxP3+3LmkMowYv8beN+AZb3BYPOxmeYCeq9+wN7D+1Kyz71UyEdZF4
         IkvZSUOob95mNXALzE8xn3UgGVvP1eilHuH2U+u79e5E6ebphwRqn0mF6VRmKlKbGuJV
         tX0doJRuOkq2kcmCTLV6p8qoCbmNRJKe+nDaeE5VHBDXVlMDcguz4kusAP5WttG8yNL9
         3VO7sjdZKkPWklzSyO1jeUoz0ev96lP1NhlgObkTjbJ0pR8NLBKYy+7KOmYJ4U2CmPlt
         2g4GlHdLb9s+LAr08FGs3b8IRKIIoVRwlbqGIrwvA4w3PCfbmNbrUIrHWx1ydZ4pSl2y
         z6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499199; x=1795103999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
        b=XJ9JX2NgNk3XUA6ACY029x3rxOhhDnWeKrZq0AwD2MfAa5jxXFc2gsk6M2bHLaSgRb
         f4F/ef0waxGq5k5C8bfUCql0QD2FQCvevNeQHwsVwSEkqkH5Fq+HW1NcLLJz7uXG+BSD
         ucF0tMcHDPAC7ytBP1pM4iDnrcFGzvG+BvXX+I236RZSzepneonNHYX3/iOYgmUnOtag
         1vncRjgkvQ4/XhlUgjjjm/PPRlGs2ScIxfYmR915+/3w8XEDGxrYLwSRMZ4d0j4DpUlV
         PPWt+kXWQNkxr6uiJ5WsCpey+msvAAsNVulcmXdUb74Sb8Jmnu5W5KfQDeKx07DmkNb2
         hfsg==
X-Forwarded-Encrypted: i=1; AL+hErHTyDw7OtGHVzjGFk0eHuqBMqnDVl0yozTEKiIqVzSeTTq/E1E88GjESNkiLp2WELsXrU/ogJMoaP6N@vger.kernel.org
X-Gm-Message-State: APuU4Z/kBBzF6QyvIwMvqBNlSJH7jRnO/WoUrxgSKBcbiUEnUATAiqeb
	XruuLfVsgKx8spXNBHBdjgWuDnbRUapRkMExrzfVBXVZ3bsr6ylx29McHFVazRL39+sQfnwsmJA
	WwJgd0RboV64fz1zj8rXMRSepBXICBg8=
X-Gm-Gg: AYBFou0LdGrmrqhESkHs748e6T481Q+tgrStcgJkLKk8FwV2a1zJiwgxkuS7ABF3PP5
	Be2yPwVC4n1LbCIGC/FGPOaBgPPOJ35NILGx9tEVx6rLyBC83uelC5xl4lvX5zKBWrVBN1K5IC0
	fYbgR+5HSqsSetqQzMEQGM0/thrA0kiPNdhKcOsI1QUtbvlfJJs2CCduOBWSWcpssXV/OjqVDw1
	rXaWEZUJRFjh3Gv4QpXMC2gNX/37zt5wMZHCeeb6a5f71cb30wk8w61ABBkOPRRBQSZIMMCyHoX
	zcCEt/nX7Fe7kckJ1AQAjq02UwQ8Uk0dnba1nW5fyH9ySn7RFhrZfAncnHtQp71Jz/O2LX23OOG
	A0cNbUWArKYhLrB0H6I1Uohun631/NmjFPMxVE/a8KDaloP2Q5gZ+bIQZWkapu1N2xsUfDw==
X-Received: by 2002:a05:600c:e558:20b0:4bb:4b30:8042 with SMTP id
 5b1f17b1804b1-4bb4b308088mr61967275e9.19.1794499199056; Thu, 12 Nov 2026
 07:59:59 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-11-kunwu.chan@gmail.com> <83463788-5e18-4932-99c9-4cbf4148a213@paulmck-laptop>
In-Reply-To: <83463788-5e18-4932-99c9-4cbf4148a213@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 23:59:47 +0800
X-Gm-Features: AclHuK-mTFCsu5EzH21jY8YFD-8az2xhySVKCOowInql9XH_2VCFG8c3gHLmBa8
Message-ID: <CAN_Opa-bdkVQWNHm1N7Kk-sD36SM8Z99odPkCTngcnkWwU8tpw@mail.gmail.com>
Subject: Re: [PATCH 10/28] hazptrtorture: Add 128- and 256-CPU configs
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:35=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:28AM +0800, Kunwu Chan wrote:
> > Add CPU128 and CPU256 configs for hazptr-stack torture testing.
> > These configs exercise the shared-scan path at larger CPU counts.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> For these, why not instead add '--kconfig "CONFIG_NR_CPUS=3D128"' to a
> run in torture.sh?  Ditto for 256 CPUs.  These will override the values
> given in the hazptr Kconfig files.
>

Hi Paul,

Agreed. I added these to keep the 128- and 256-CPU cases explicit
and repeatable, but the configurations duplicate PREEMPT. I'll
drop the separate configs and retain the cases as scripted PREEMPT
runs using --cpus N and --kconfig "CONFIG_NR_CPUS=3DN".

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > Acked-by: Bradley Morgan <brads@mainlining.org>
> > ---
> >  .../selftests/rcutorture/configs/hazptr/CPU128   | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/CPU128.boot        |  1 +
> >  .../selftests/rcutorture/configs/hazptr/CPU256   | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/CPU256.boot        |  1 +
> >  4 files changed, 34 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU128
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU128.boot
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU256
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU256.boot
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128 b=
/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> > new file mode 100644
> > index 000000000000..079b463607e8
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D128
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.b=
oot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> > new file mode 100644
> > index 000000000000..1d09a6446080
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256 b=
/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> > new file mode 100644
> > index 000000000000..b00a984977f3
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D256
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.b=
oot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> > new file mode 100644
> > index 000000000000..1d09a6446080
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > --
> > 2.43.0
> >
