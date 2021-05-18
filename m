Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80682C433B4
	for <linux-arch@archiver.kernel.org>; Tue, 18 May 2021 22:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F782611BF
	for <linux-arch@archiver.kernel.org>; Tue, 18 May 2021 22:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhERWrB (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 18 May 2021 18:47:01 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45516 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhERWrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 18:47:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lj8T1-00C3FV-Jh; Tue, 18 May 2021 16:45:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lj8Sz-0000jv-Fq; Tue, 18 May 2021 16:45:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
References: <20210517203343.3941777-1-arnd@kernel.org>
        <20210517203343.3941777-2-arnd@kernel.org>
        <m1bl982m8c.fsf@fess.ebiederm.org>
        <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
        <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
Date:   Tue, 18 May 2021 17:45:23 -0500
In-Reply-To: <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
        (Arnd Bergmann's message of "Tue, 18 May 2021 16:17:53 +0200")
Message-ID: <m1y2cbzmnw.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lj8Sz-0000jv-Fq;;;mid=<m1y2cbzmnw.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4EKDkInLXQv/kdxJtbD4q26Fyh8T6eMg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Arnd Bergmann <arnd@kernel.org> writes:

> On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> > Arnd Bergmann <arnd@kernel.org> writes:
>> >
>> > > From: Arnd Bergmann <arnd@arndb.de>KEXEC_ARCH_DEFAULT
>> > >
>> > > The compat version of sys_kexec_load() uses compat_alloc_user_space to
>> > > convert the user-provided arguments into the native format.
>> > >
>> > > Move the conversion into the regular implementation with
>> > > an in_compat_syscall() check to simplify it and avoid the
>> > > compat_alloc_user_space() call.
>> > >
>> > > compat_sys_kexec_load() now behaves the same as sys_kexec_load().
>> >
>> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >KEXEC_ARCH_DEFAULT
>> > The patch is wrong.
>> >
>> > The logic between the compat entry point and the ordinary entry point
>> > are by necessity different.   This unifies the logic and breaks the compat
>> > entry point.
>> >
>> > The fundamentally necessity is that the code being loaded needs to know
>> > which mode the kernel is running in so it can safely transition to the
>> > new kernel.
>> >
>> > Given that the two entry points fundamentally need different logic,
>> > and that difference was not preserved and the goal of this patchset
>> > was to unify that which fundamentally needs to be different.  I don't
>> > think this patch series makes any sense for kexec.
>>
>> Sorry, I'm not following that explanation. Can you clarify what different
>> modes of the kernel you are referring to here, and how my patch
>> changes this?

I think something like the untested diff below is enough to get rid of
compat_alloc_user cleanly.

Certainly it should be enough to give any idea what I am thinking.

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..ce69a5d68023 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,26 +19,21 @@
 
 #include "kexec_internal.h"
 
-static int copy_user_segment_list(struct kimage *image,
+static void copy_user_segment_list(struct kimage *image,
 				  unsigned long nr_segments,
-				  struct kexec_segment __user *segments)
+				  struct kexec_segment *segments)
 {
-	int ret;
 	size_t segment_bytes;
 
 	/* Read in the segments */
 	image->nr_segments = nr_segments;
 	segment_bytes = nr_segments * sizeof(*segments);
-	ret = copy_from_user(image->segment, segments, segment_bytes);
-	if (ret)
-		ret = -EFAULT;
-
-	return ret;
+	memcpy(image->segment, segments, segment_bytes);
 }
 
 static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 			     unsigned long nr_segments,
-			     struct kexec_segment __user *segments,
+			     struct kexec_segment *segments,
 			     unsigned long flags)
 {
 	int ret;
@@ -59,9 +54,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 
 	image->start = entry;
 
-	ret = copy_user_segment_list(image, nr_segments, segments);
-	if (ret)
-		goto out_free_image;
+	copy_user_segment_list(image, nr_segments, segments);
 
 	if (kexec_on_panic) {
 		/* Enable special crash kernel control page alloc policy. */
@@ -103,8 +96,8 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	return ret;
 }
 
-static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
-		struct kexec_segment __user *segments, unsigned long flags)
+static int do_kexec_load_locked(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment *segments, unsigned long flags)
 {
 	struct kimage **dest_image, *image;
 	unsigned long i;
@@ -174,6 +167,27 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	return ret;
 }
 
+static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment *segments, unsigned long flags)
+{
+	int result;
+
+	/* Because we write directly to the reserved memory
+	 * region when loading crash kernels we need a mutex here to
+	 * prevent multiple crash  kernels from attempting to load
+	 * simultaneously, and to prevent a crash kernel from loading
+	 * over the top of a in use crash kernel.
+	 *
+	 * KISS: always take the mutex.
+	 */
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
+
+	result = do_kexec_load_locked(entry, nr_segments, segments, flags);
+	mutex_unlock(&kexec_mutex);
+	return result;
+}
+
 /*
  * Exec Kernel system call: for obvious reasons only root may call it.
  *
@@ -224,6 +238,11 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
 		return -EINVAL;
 
+	/* Verify we are on the appropriate architecture */
+	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
+	    ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+		return -EINVAL;
+
 	/* Put an artificial cap on the number
 	 * of segments passed to kexec_load.
 	 */
@@ -236,33 +255,29 @@ static inline int kexec_load_check(unsigned long nr_segments,
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	int result;
+	struct kexec_segment *ksegments;
+	unsigned long bytes, result;
 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
 		return result;
 
-	/* Verify we are on the appropriate architecture */
-	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
-		return -EINVAL;
-
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
+	bytes = nr_segments * sizeof(ksegments[0]);
+	ksegments = kmalloc(bytes, GFP_KERNEL);
+	if (!ksegments)
+		return -ENOMEM;
 
+	result = copy_from_user(ksegments, segments, bytes);
+	if (result)
+		goto fail;
+	
 	result = do_kexec_load(entry, nr_segments, segments, flags);
+	kfree(ksegments);
 
-	mutex_unlock(&kexec_mutex);
-
+fail:
+	kfree(ksegments);
 	return result;
+	
 }
 
 #ifdef CONFIG_COMPAT
@@ -272,9 +287,9 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 		       compat_ulong_t, flags)
 {
 	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
-	unsigned long i, result;
-
+	struct kexec_segment *ksegments;
+	unsigned long bytes, i, result;
+ 
 	result = kexec_load_check(nr_segments, flags);
 	if (result)
 		return result;
@@ -285,37 +300,26 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
 		return -EINVAL;
 
-	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
+	bytes = nr_segments * sizeof(ksegments[0]);
+	ksegments = kmalloc(bytes, GFP_KERNEL);
+	if (!ksegments)
+		return -ENOMEM;
+
 	for (i = 0; i < nr_segments; i++) {
 		result = copy_from_user(&in, &segments[i], sizeof(in));
 		if (result)
-			return -EFAULT;
-
-		out.buf   = compat_ptr(in.buf);
-		out.bufsz = in.bufsz;
-		out.mem   = in.mem;
-		out.memsz = in.memsz;
+			goto fail;
 
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
+		ksegments[i].buf   = compat_ptr(in.buf);
+		ksegments[i].bufsz = in.bufsz;
+		ksegments[i].mem   = in.mem;
+		ksegments[i].memsz = in.memsz;
 	}
 
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
-
 	result = do_kexec_load(entry, nr_segments, ksegments, flags);
 
-	mutex_unlock(&kexec_mutex);
-
+fail:
+	kfree(ksegments);
 	return result;
 }
 #endif
