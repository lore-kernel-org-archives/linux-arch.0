Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF83B3C17
	for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825921; cv=pass; b=TuMjcLzkSwZshar5I3XtQS5iHD8rEz/rsem7MgQjVe2og95T04OaMsH/F0vghflxo9RkdU/uEbqf407qzSEiZLKrsqN1F3yWNnZuNvaGmoz5YVfCMAxG1cRHiLX1ZcCLRK10WU3UptkUj+FEiMAhvx/me71I5WbzCbJlp4fv9dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825921; c=relaxed/simple;
	bh=9JuiciVIz25KyqDHZ9CSCPab+sXTsNkxP0wOlTCdKgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPjuk7gsoJ2VGGsYuZuscqdgKZroPUCIUjGvGQe/5VOeVjWqMegVeomHBUJheiRdc/NgiEGaOxq8TgHABMneBtlhHeQl47UkhIFO7VUwRuxQk/8QVNMxGzPkT3UFEpnzLgtqpcGlyojJjSTcRibrxGsox29uHwn07P97QfZNHtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hsb6b0uw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICZdwRgH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hsb6b0uw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICZdwRgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773825915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iK/ov8EJ/J0ZYfo49iWJBtZbkdFjmhliHBuy1k9tqk4=;
	b=Hsb6b0uw0vjivjtBPbu0qYaZ0uW7SgpogTKWTlfckL/tqNhfw/Jkpw3FR2AEV9eLT+yo+A
	7mmBKMxUIPdIt28r7Lolxd8ebMGU8WASdM5f5vYYZcmwddfoL8nuz1uPUshaAc0UxML8zl
	tjUNE4GNecW6PyNibuysjYkkNrsezwA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-ojfrKstBPPuVe3MlcrFwJw-1; Wed, 18 Mar 2026 05:25:13 -0400
X-MC-Unique: ojfrKstBPPuVe3MlcrFwJw-1
X-Mimecast-MFC-AGG-ID: ojfrKstBPPuVe3MlcrFwJw_1773825913
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64ca3de57f1so878617d50.0
        for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 02:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773825913; cv=none;
        d=google.com; s=arc-20240605;
        b=IDElEpHti1JklJdpv92CkFTdRbLc07lr+acssiNEtD16Nd3et7h2LNta1Hi7TdkWVr
         BYXqv609y7NaWAl8oqSURFQXfeMcJ+eXIZ3vGoI8exkFR+mqDVO4hYnRZjexY8fTzLYy
         GJxDMpmov8sEq64CA8tZ416G8usIaVSQS+9iQi3KR97mf40Hh0bpBM+f+tUmP4gA2Tiu
         OHSC0uKeZFZNOvJVm+eOJGugFjf5s6ZDRD7+XpYcZxWuph69dB9BX3KfYljpH8ibNcdD
         CAQ3vgEcCbndq1Usf2PRjGBl22jOUBDLkN2yVdKLE/9TVrG9y0yoTDNnR/Iu3yLbkM21
         EFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iK/ov8EJ/J0ZYfo49iWJBtZbkdFjmhliHBuy1k9tqk4=;
        fh=cSfwHJDyKeUfgRSItnMLXBMorvvgkSbv/jjUITIHSJw=;
        b=FbKuB0hoDAHsXDhpY1NK5Ku1FGdAdAtbzPypbxN2okw3VhvEf7jprsS1x/wcphpmMS
         rbRE+fUH9JWJBjrO8aAaMzzuQ6Jr3JRLHWZquPwJH9eHvEGh4rcD1clUE4M/GWli8Kdb
         0x23EvPR2gQWcuMpU7c0+h6QuQoIOcms4kc97saEYoB+VSVQvSHSFnMHmdLMutt79KwF
         HRthsJiqElDi7AQIqN0HFGKXGoGQk8GjoF6Qpez3ouKIyHDSV1OSm/saaP9c3sz8gb0U
         L1jDKgHHvItcK8rgZwItJh4QmHAy0m5fdffRLsWjYhhf5BX6JpA13UTp6HKUud3n4yhj
         BrbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773825913; x=1774430713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK/ov8EJ/J0ZYfo49iWJBtZbkdFjmhliHBuy1k9tqk4=;
        b=ICZdwRgHxXS2c2A3/y/aDMi18NqfhDjB5tbWxiSZplUKZn51ds/UWK4ks2E19cMpoJ
         z3KWprX/eZYN2Ww+lM4lFKCsdOAJbI1hLtXCjdWSG7bZ+wO7icvJSHQYmiGIcs6FWp7G
         Dos1xd/8yvfbGrDdjCdlaLgTqinhXzL9TCyeS6jg5vsVbf8Bxy/6exMLm0L/9aILGREs
         zzPZIufwxQPggvPhjMEp+wSIguOFtgZSu8jzhqM+bqtGtbrVWf03th/9beyEXSyi8loB
         8SZYPXO1m/qOhXP9reUdTXWqKpI5Fb1kNfwjyUURAppRFVDl6mFo8mUAoG26+SHAgBgF
         4PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773825913; x=1774430713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iK/ov8EJ/J0ZYfo49iWJBtZbkdFjmhliHBuy1k9tqk4=;
        b=SdIBvynIJ9sfM3Sv5NaE5/8Q+7NNG8JNLEfEI3xpQDe1RhVtxMvwiVMKN33jvD4yZV
         IqSKRv/WJ1zAmKUFD5mdwNTWl9ik6jkT8srI/MC1eZMn9coKRut2Iim4ArgMK+lMX/Ux
         sOoccQUiMBwA5JSLqbb0RehrH/31YuJJKjp8HcXhRpkLc9w155hZaSc4Tx3ddxJoFJSm
         Jl4NqrUx6UiNCIHezMlfw+te3vKapm8hYMNJCPRFs+fJzEmJqPSaoOik68xpaa38Bd0g
         3LmeLFy4OF5llVwzqtKeIvqiGtUaeOXCDxkbhHfQa6QffkzwGYCPCk6+1WnM5V1h27+k
         kweQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvG9apGUC/U889bsm0dTTnySYBP3IPLg2/It15E2h2qLL27kLJne5bytHDmsAvbugW8Nqio346XeU9@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIRhBLLP/6fCpaA90Rckwxq9LvNHXGuelN13cYin0df2iCA8f
	HGwW+AH3fywoBqewHEckjAkEnJB3rdQHUeS4iwdsQrs/VUgzwohf4pDoQIAuE84GNUWGhnnIRG7
	ckVaR0jtQdNO1sDEmlXijb3NnekgDON7zkBWGSXmJOPJI7qBRVvNaBrukMEsSnLTRq2euguvSNN
	62ePbWb0ecGD6QqilImNHqyb+jHauWcUqlWTjEsg==
X-Gm-Gg: ATEYQzyOE84R8IJiQ5LzaFZAn1rT4wH5cUOqHgs3gTjEHiBNNW3xP2WkjWhe64AYQKZ
	0UMAy3SNcX5EdjnOuyrDenSGf8TA31QZqkj4pYdyHTBkO0RQop3/O/rDm5w2P7K3tDonqnkCiLP
	P5vhCbUS37fktY91DeNz1QEkAJ7IO4S2kbv8Yb89xSy6MJEv++DAuQ83XRsAilE/tCCbMR2j1US
	Q==
X-Received: by 2002:a53:c7cb:0:b0:649:e294:a380 with SMTP id 956f58d0204a3-64e915ced27mr2363101d50.37.1773825913120;
        Wed, 18 Mar 2026 02:25:13 -0700 (PDT)
X-Received: by 2002:a53:c7cb:0:b0:649:e294:a380 with SMTP id
 956f58d0204a3-64e915ced27mr2363055d50.37.1773825912496; Wed, 18 Mar 2026
 02:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org> <20260317113025.GG2872@noisy.programming.kicks-ass.net>
In-Reply-To: <20260317113025.GG2872@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Mar 2026 10:25:00 +0100
X-Gm-Features: AaiRm53OPQc-5hULPIiQu9-AZhqy7-XEfz_gt4uMR3ixjOm0K2seVoOetSgKzgk
Message-ID: <CADSE00Jy=G7HhRkb7vmFSuGFmvpGGt1TQ2NA+7XGLZ4b=g3rxQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	Alessandro Carminati <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, Mar 17, 2026 at 12:33=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Mar 17, 2026 at 12:20:26PM +0100, Vlastimil Babka (SUSE) wrote:
> > > For this iteration, the `__report_bug()` centralized approach was
> > > revisited after the discussion in the previous version [1].
> >
> > Discussion with PeterZ, who is not CC'd here? (did it now for my reply)=
.

(Sorry not to put you on CC, I thought auto-cc would pick you up already)

> >
> > > However, again this approach did not work because:
> > > - Some warning output is generated directly in the macros before call=
ing
> > >   the centralized functions (e.g., `__warn_printk()` in `__WARN_print=
f()`)
> > > - Functions in the warning path like `warn_slowpath_fmt()` are marked
> > >   `__always_inline`, making it difficult to intercept early enough
> > > - So, by the time `__report_bug()` is called, output has already been=
 written
> > >   to the console, making suppression ineffective
> > >
> > > Current Proposal: Check Directly in the `WARN()` Macros.
> > > This avoids the need for function symbol resolution or ELF section
> > > modification.
> > > Suppression is implemented directly in the `WARN*()` macros.
> >
> > So does that bloat every warn/bug site (as Peter objected to) or not?
> > And is it compatible with x86? I see you modify include/asm-generic/bug=
.h
> > but x86 has its own version of e.g. __WARN_printf ?
>
> Yeah, they done it all wrong again :-(
>
> This should be pushed inside __report_bug() through __WARN_printf with a
> new BUGFLAG thing.

Thanks for the specific suggestion to use BUGFLAG, but I do not think
this is what we need. These flags seem to be used statically, but the
goal is to enable and disable these warning suppressions dynamically
in the tests. Happy to be corrected if I missed something.

I want to highlight that I did not bluntly ignore your point in the
last version. I thoroughly read the discussions there, and as I
mentioned in the cover letter, I tried to move away from the per-macro
approach. However, while doing that, I encountered the same issues
Alessandro found in the last iteration. I=E2=80=99ll address that below, bu=
t I
decided to give this approach one more try and tackle the raised
drawbacks.

The main concern was the increased size of the code emitted by the
WARN*() macros, which was a fair point. I tried to alleviate this with
a static key and branching, and addressed other concerns by using RCU
protection on the list for thread safety. I think it was worth a try,
as all options seemed to have their own tradeoffs. However, if this
option remains unacceptable even after trying to diminish its
drawbacks, I am happy to focus on finding the best solution for the
centralised approach, and keeping the discussion constructive.

So back to my test on this. Alessandro detailed two strategies in the
last version, one of them (storing the function name in `struct
bug_entry`) was already used and discarded in older iterations of this
series. So let's focus on the other strategy, using 'kallsyms`. Let's
assume we still store the function name when registering a new symbol
to suppress. Otherwise, we might need to check address ranges to
ensure bugaddr is within the function's scope, which sounds trickier?
With `kallsyms` we can infer the originating functionid. But this
approach works unreliably with compiler-induced transformations (e.g.,
inlining, cloning, code fragmentation). And we still cannot prevent
all output. Additionally, we would need to prevent prints in
`warn_slowpath_fmt()`. There may be other `printk`s embedded in the
macros, but let's focus on suppressing all warnings as a best effort.
It would already improve the quality of life for testers.

Considering these remaining issues, I managed to create a centralised
proposal. Please find the main changes at the bottom of this message.

But again, even with these, the solution remains unreliable. We can
mitigate this by registering the test name on the suppression list (at
least, I can make the new test in this series pass with that). Not
ideal, but we could mention it in the documentation. Something like
"Suppression is matched by the function where the warning is reported.
If the warning is triggered from a helper (or the compiler inlines it
into the test), that function name may differ. In that case, register
and start suppression for both the test and the helper so the test
passes regardless of inlining."

Would that be a more acceptable solution? Is there a better option I
am not seeing?

BR,
Albert.

diff --git a/kernel/panic.c b/kernel/panic.c
index c78600212b6c1..3cb004a7803f4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <kunit/bug.h>

 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void
*caller, unsigned taint,
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
                       const char *fmt, ...)
 {
-       bool rcu =3D warn_rcu_enter();
+       bool rcu;
        struct warn_args args;

+       if (__kunit_is_suppressed_warning_at((unsigned
long)__builtin_return_address(0)))
+               return;
+
+       rcu =3D warn_rcu_enter();
+
        pr_warn(CUT_HERE);

        if (!fmt) {

diff --git a/lib/bug.c b/lib/bug.c
index 623c467a8b76c..e90b038d9225e 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -48,6 +48,7 @@
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
 #include <linux/context_tracking.h>
+#include <kunit/bug.h>

 extern struct bug_entry __start___bug_table[], __stop___bug_table[];

@@ -223,6 +224,9 @@ static enum bug_trap_type __report_bug(struct
bug_entry *bug, unsigned long buga
        no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
        has_args =3D bug->flags & BUGFLAG_ARGS;

+       if (warning && __kunit_is_suppressed_warning_at(bugaddr))
+               return BUG_TRAP_TYPE_WARN;
+
        if (warning && once) {
                if (done)
                        return BUG_TRAP_TYPE_WARN;

diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index 9c2c4ee013d92..13ffddb044636 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/instrumentation.h>
 #include <linux/jump_label.h>
+#include <linux/kallsyms.h>
 #include <linux/rculist.h>
 #include <linux/string.h>

@@ -68,4 +69,16 @@ noinstr bool __kunit_is_suppressed_warning(const
char *function)
 }
 EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning);

+bool __kunit_is_suppressed_warning_at(unsigned long addr)
+{
+       char buf[KSYM_SYMBOL_LEN];
+
+       if (!static_branch_unlikely(&kunit_suppress_warnings_key))
+               return false;
+       if (sprint_symbol_no_offset(buf, addr) <=3D 0)
+               return false;
+       return __kunit_check_suppress(buf);
+}
+EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning_at);
+
 #endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */



>
> So NAK from me on this -- again!
>

