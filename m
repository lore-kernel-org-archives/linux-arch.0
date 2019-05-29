Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.136]:33709 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2OaY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 10:30:24 -0400
Date: Wed, 29 May 2019 07:29:01 -0700
In-Reply-To: <20190529141500.193390-3-elver@google.com>
References: <20190529141500.193390-1-elver@google.com> <20190529141500.193390-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
From: hpa@zytor.com
Message-ID: <EE911EC6-344B-4EB2-90A4-B11E8D96BEDC@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>, peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Message-ID: <20190529142901.4P1bycy5ZxDEi3QHJlWxLKhvkgrU5t07FBkdO0wlL_g@z>

On May 29, 2019 7:15:00 AM PDT, Marco Elver <elver@google=2Ecom> wrote:
>This patch is a pre-requisite for enabling KASAN bitops
>instrumentation:
>moves boot_cpu_has feature test out of the uaccess region, as
>boot_cpu_has uses test_bit=2E With instrumentation, the KASAN check would
>otherwise be flagged by objtool=2E
>
>This approach is preferred over adding the explicit kasan_check_*
>functions to the uaccess whitelist of objtool, as the case here appears
>to be the only one=2E
>
>Signed-off-by: Marco Elver <elver@google=2Ecom>
>---
>v1:
>* This patch replaces patch: 'tools/objtool: add kasan_check_* to
>  uaccess whitelist'
>---
> arch/x86/ia32/ia32_signal=2Ec | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/ia32/ia32_signal=2Ec b/arch/x86/ia32/ia32_signal=2E=
c
>index 629d1ee05599=2E=2E12264e3c9c43 100644
>--- a/arch/x86/ia32/ia32_signal=2Ec
>+++ b/arch/x86/ia32/ia32_signal=2Ec
>@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal
>*ksig,
> 	void __user *restorer;
> 	int err =3D 0;
> 	void __user *fpstate =3D NULL;
>+	bool has_xsave;
>=20
> 	/* __copy_to_user optimizes that into a single 8 byte store */
> 	static const struct {
>@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct ksignal
>*ksig,
> 	if (!access_ok(frame, sizeof(*frame)))
> 		return -EFAULT;
>=20
>+	/*
>+	 * Move non-uaccess accesses out of uaccess region if not strictly
>+	 * required; this also helps avoid objtool flagging these accesses
>with
>+	 * instrumentation enabled=2E
>+	 */
>+	has_xsave =3D boot_cpu_has(X86_FEATURE_XSAVE);
> 	put_user_try {
> 		put_user_ex(sig, &frame->sig);
> 		put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
> 		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
>=20
> 		/* Create the ucontext=2E  */
>-		if (boot_cpu_has(X86_FEATURE_XSAVE))
>+		if (has_xsave)
> 			put_user_ex(UC_FP_XSTATE, &frame->uc=2Euc_flags);
> 		else
> 			put_user_ex(0, &frame->uc=2Euc_flags);

This was meant to use static_cpu_has()=2E Why did that get dropped?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
