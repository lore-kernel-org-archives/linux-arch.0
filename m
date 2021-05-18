Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E10C433ED
	for <linux-arch@archiver.kernel.org>; Tue, 18 May 2021 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650AC61285
	for <linux-arch@archiver.kernel.org>; Tue, 18 May 2021 13:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhERNmn (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 18 May 2021 09:42:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37022 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhERNmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 09:42:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lizyG-00Axt3-Vi; Tue, 18 May 2021 07:41:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lizyF-0005tf-St; Tue, 18 May 2021 07:41:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
References: <20210517203343.3941777-1-arnd@kernel.org>
        <20210517203343.3941777-2-arnd@kernel.org>
Date:   Tue, 18 May 2021 08:41:07 -0500
In-Reply-To: <20210517203343.3941777-2-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 17 May 2021 22:33:40 +0200")
Message-ID: <m1bl982m8c.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lizyF-0005tf-St;;;mid=<m1bl982m8c.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3MixM5wFfwyFMlKmVM10vOLfImi60fNc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The compat version of sys_kexec_load() uses compat_alloc_user_space to
> convert the user-provided arguments into the native format.
>
> Move the conversion into the regular implementation with
> an in_compat_syscall() check to simplify it and avoid the
> compat_alloc_user_space() call.
>
> compat_sys_kexec_load() now behaves the same as sys_kexec_load().

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

The patch is wrong.

The logic between the compat entry point and the ordinary entry point
are by necessity different.   This unifies the logic and breaks the compat
entry point.

The fundamentally necessity is that the code being loaded needs to know
which mode the kernel is running in so it can safely transition to the
new kernel.

Given that the two entry points fundamentally need different logic,
and that difference was not preserved and the goal of this patchset
was to unify that which fundamentally needs to be different.  I don't
think this patch series makes any sense for kexec.

Eric




>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kexec.h |  2 -
>  kernel/kexec.c        | 95 +++++++++++++++++++------------------------
>  2 files changed, 42 insertions(+), 55 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..f61e310d7a85 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -88,14 +88,12 @@ struct kexec_segment {
>  	size_t memsz;
>  };
>  
> -#ifdef CONFIG_COMPAT
>  struct compat_kexec_segment {
>  	compat_uptr_t buf;
>  	compat_size_t bufsz;
>  	compat_ulong_t mem;	/* User space sees this as a (void *) ... */
>  	compat_size_t memsz;
>  };
> -#endif
>  
>  #ifdef CONFIG_KEXEC_FILE
>  struct purgatory_info {
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c82c6c06f051..6618b1d9f00b 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -19,21 +19,46 @@
>  
>  #include "kexec_internal.h"
>  
> +static int copy_user_compat_segment_list(struct kimage *image,
> +					 unsigned long nr_segments,
> +					 void __user *segments)
> +{
> +	struct compat_kexec_segment __user *cs = segments;
> +	struct compat_kexec_segment segment;
> +	int i;
> +
> +	for (i = 0; i < nr_segments; i++) {
> +		if (copy_from_user(&segment, &cs[i], sizeof(segment)))
> +			return -EFAULT;
> +
> +		image->segment[i] = (struct kexec_segment) {
> +			.buf   = compat_ptr(segment.buf),
> +			.bufsz = segment.bufsz,
> +			.mem   = segment.mem,
> +			.memsz = segment.memsz,
> +		};
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static int copy_user_segment_list(struct kimage *image,
>  				  unsigned long nr_segments,
>  				  struct kexec_segment __user *segments)
>  {
> -	int ret;
>  	size_t segment_bytes;
>  
>  	/* Read in the segments */
>  	image->nr_segments = nr_segments;
>  	segment_bytes = nr_segments * sizeof(*segments);
> -	ret = copy_from_user(image->segment, segments, segment_bytes);
> -	if (ret)
> -		ret = -EFAULT;
> +	if (in_compat_syscall())
> +		return copy_user_compat_segment_list(image, nr_segments, segments);
>  
> -	return ret;
> +	if (copy_from_user(image->segment, segments, segment_bytes))
> +		return -EFAULT;
> +
> +	return 0;
>  }
>  
>  static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> @@ -233,8 +258,9 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	return 0;
>  }
>  
> -SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> -		struct kexec_segment __user *, segments, unsigned long, flags)
> +static int kernel_kexec_load(unsigned long entry, unsigned long nr_segments,
> +			     struct kexec_segment __user * segments,
> +			     unsigned long flags)
>  {
>  	int result;
>  
> @@ -265,57 +291,20 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	return result;
>  }
>  
> +SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> +		struct kexec_segment __user *, segments, unsigned long, flags)
> +{
> +	return kernel_kexec_load(entry, nr_segments, segments, flags);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
>  		       compat_ulong_t, nr_segments,
>  		       struct compat_kexec_segment __user *, segments,
>  		       compat_ulong_t, flags)
>  {
> -	struct compat_kexec_segment in;
> -	struct kexec_segment out, __user *ksegments;
> -	unsigned long i, result;
> -
> -	result = kexec_load_check(nr_segments, flags);
> -	if (result)
> -		return result;
> -
> -	/* Don't allow clients that don't understand the native
> -	 * architecture to do anything.
> -	 */
> -	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
> -		return -EINVAL;
> -
> -	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
> -	for (i = 0; i < nr_segments; i++) {
> -		result = copy_from_user(&in, &segments[i], sizeof(in));
> -		if (result)
> -			return -EFAULT;
> -
> -		out.buf   = compat_ptr(in.buf);
> -		out.bufsz = in.bufsz;
> -		out.mem   = in.mem;
> -		out.memsz = in.memsz;
> -
> -		result = copy_to_user(&ksegments[i], &out, sizeof(out));
> -		if (result)
> -			return -EFAULT;
> -	}
> -
> -	/* Because we write directly to the reserved memory
> -	 * region when loading crash kernels we need a mutex here to
> -	 * prevent multiple crash  kernels from attempting to load
> -	 * simultaneously, and to prevent a crash kernel from loading
> -	 * over the top of a in use crash kernel.
> -	 *
> -	 * KISS: always take the mutex.
> -	 */
> -	if (!mutex_trylock(&kexec_mutex))
> -		return -EBUSY;
> -
> -	result = do_kexec_load(entry, nr_segments, ksegments, flags);
> -
> -	mutex_unlock(&kexec_mutex);
> -
> -	return result;
> +	return kernel_kexec_load(entry, nr_segments,
> +				 (struct kexec_segment __user *)segments,
> +				 flags);
>  }
>  #endif
