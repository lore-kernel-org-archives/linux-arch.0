Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36485 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbdHVNxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2017 09:53:52 -0400
Received: by mail-wr0-f172.google.com with SMTP id f8so90051844wrf.3
        for <linux-arch@vger.kernel.org>; Tue, 22 Aug 2017 06:53:52 -0700 (PDT)
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com> <1502280338-23002-10-git-send-email-Dave.Martin@arm.com> <87y3qb52ez.fsf@linaro.org> <20170822111705.GT6321@e103592.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 09/27] arm64/sve: Signal frame and context structure definition
In-reply-to: <20170822111705.GT6321@e103592.cambridge.arm.com>
Date: Tue, 22 Aug 2017 14:53:49 +0100
Message-ID: <87tw0z4sk2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, gdb@sourceware.org, Yao Qi <Yao.Qi@arm.com>, Alan Hayward <alan.hayward@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20170822135349.Yx_1Fs0Np9_hpCYomGHPTPmGf4-eyy5lcbG14yKXQlI@z>


Dave Martin <Dave.Martin@arm.com> writes:

> On Tue, Aug 22, 2017 at 11:22:44AM +0100, Alex Bennée wrote:
>>
>> Dave Martin <Dave.Martin@arm.com> writes:
>>
>> > This patch defines the representation that will be used for the SVE
>> > register state in the signal frame, and implements support for
>> > saving and restoring the SVE registers around signals.
>> >
>> > The same layout will also be used for the in-kernel task state.
>> >
>> > Due to the variability of the SVE vector length, it is not possible
>> > to define a fixed C struct to describe all the registers.  Instead,
>> > Macros are defined in sigcontext.h to facilitate access to the
>> > parts of the structure.
>> >
>> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>> > ---
>> >  arch/arm64/include/uapi/asm/sigcontext.h | 113 ++++++++++++++++++++++++++++++-
>> >  1 file changed, 112 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
>> > index f0a76b9..0533bdf 100644
>> > --- a/arch/arm64/include/uapi/asm/sigcontext.h
>> > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
>> > @@ -16,6 +16,8 @@
>> >  #ifndef _UAPI__ASM_SIGCONTEXT_H
>> >  #define _UAPI__ASM_SIGCONTEXT_H
>> >
>> > +#ifndef __ASSEMBLY__
>> > +
>> >  #include <linux/types.h>
>> >
>> >  /*
>> > @@ -41,10 +43,11 @@ struct sigcontext {
>> >   *
>> >   *	0x210		fpsimd_context
>> >   *	 0x10		esr_context
>> > + *	0x8a0		sve_context (vl <= 64) (optional)
>> >   *	 0x20		extra_context (optional)
>> >   *	 0x10		terminator (null _aarch64_ctx)
>> >   *
>> > - *	0xdb0		(reserved for future allocation)
>> > + *	0x510		(reserved for future allocation)
>> >   *
>> >   * New records that can exceed this space need to be opt-in for userspace, so
>> >   * that an expanded signal frame is not generated unexpectedly.  The mechanism
>> > @@ -116,4 +119,112 @@ struct extra_context {
>> >  	__u32 __reserved[3];
>> >  };
>> >
>> > +#define SVE_MAGIC	0x53564501
>> > +
>> > +struct sve_context {
>> > +	struct _aarch64_ctx head;
>> > +	__u16 vl;
>> > +	__u16 __reserved[3];
>> > +};
>> > +
>> > +#endif /* !__ASSEMBLY__ */
>> > +
>> > +/*
>> > + * The SVE architecture leaves space for future expansion of the
>> > + * vector length beyond its initial architectural limit of 2048 bits
>> > + * (16 quadwords).
>> > + */
>> > +#define SVE_VQ_MIN		1
>> > +#define SVE_VQ_MAX		0x200
>> > +
>> > +#define SVE_VL_MIN		(SVE_VQ_MIN * 0x10)
>> > +#define SVE_VL_MAX		(SVE_VQ_MAX * 0x10)
>> > +
>> > +#define SVE_NUM_ZREGS		32
>> > +#define SVE_NUM_PREGS		16
>> > +
>> > +#define sve_vl_valid(vl) \
>> > +	((vl) % 0x10 == 0 && (vl) >= SVE_VL_MIN && (vl) <= SVE_VL_MAX)
>> > +#define sve_vq_from_vl(vl)	((vl) / 0x10)
>> > +#define sve_vl_from_vq(vq)	((vq) * 0x10)
>>
>> I got a little confused first time through over what VQ and VL where.
>> Maybe it would make sense to expand a little more from first principles?
>>
>>   /*
>>    * The SVE architecture defines vector registers as a multiple of 128
>>    * bit quadwords. The current architectural limit is 2048 bits (16
>>    * quadwords) but there is room for future expansion beyond that.
>>     */
>
> This comes up in several places and so I didn't want to comment it
> repeatedly everywhere.
>
> Instead, I wrote up something in section 2 (Vector length terminology)
> of Documentation/arm64/sve.txt -- see patch 25.  Can you take a look and
> see whether that's adequate?

Ahh, I hadn't got to that yet. I'm unsure to the order the kernel likes
to put things but I like to put design documents at the front of the
patch queue as they are useful primers and saves you having to patch a:

modified   arch/arm64/include/uapi/asm/sigcontext.h
@@ -132,19 +132,24 @@ struct sve_context {
 /*
  * The SVE architecture leaves space for future expansion of the
  * vector length beyond its initial architectural limit of 2048 bits
- * (16 quadwords).
+ * (16 quadwords). See Documentation/arm64/sve.txt for a summary of
+ * the terminology of Vector Quads (VQ) and Vector Lengths (VL).
  */
+
+#define SVE_VQ_BITS             128      /* 128 bits in one quadword */
+#define SVE_VQ_BYTES            (SVE_VQ_BITS / 8)
+
 #define SVE_VQ_MIN		1
 #define SVE_VQ_MAX		0x200

-#define SVE_VL_MIN		(SVE_VQ_MIN * 0x10)
-#define SVE_VL_MAX		(SVE_VQ_MAX * 0x10)
+#define SVE_VL_MIN		(SVE_VQ_MIN * SVE_VQ_BYTES)
+#define SVE_VL_MAX		(SVE_VQ_MAX * SVE_VQ_BYTES)

 #define SVE_NUM_ZREGS		32
 #define SVE_NUM_PREGS		16

 #define sve_vl_valid(vl) \
-	((vl) % 0x10 == 0 && (vl) >= SVE_VL_MIN && (vl) <= SVE_VL_MAX)
+	((vl) % SVE_VQ_BYTES == 0 && (vl) >= SVE_VL_MIN && (vl) <= SVE_VL_MAX)
 #define sve_vq_from_vl(vl)	((vl) / 0x10)
 #define sve_vl_from_vq(vq)	((vq) * 0x10)


>
> [...]
>
> Cheers
> ---Dave


--
Alex Bennée
