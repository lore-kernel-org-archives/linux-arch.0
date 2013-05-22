Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62010 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab3EVOBX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2013 10:01:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
Date: Wed, 22 May 2013 15:59:01 +0200
References: <cover.1368702323.git.mst@redhat.com> <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
In-Reply-To: <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201305221559.01806.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, microblaze-uclinux@itee.uq.edu.au, linux-am33-list@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
Message-ID: <20130522135901.vCSCo_Vu2MM9OU7TU4LQbsXNCW0pYdGEAh2Z5hJXcco@z>

On Thursday 16 May 2013, Michael S. Tsirkin wrote:
> @@ -178,7 +178,7 @@ do {                                                                \
>         long __pu_err;                                          \
>         __typeof__(*(ptr)) __user *__pu_addr = (ptr);           \
>         if (!is_kernel_addr((unsigned long)__pu_addr))          \
> -               might_sleep();                                  \
> +               might_fault();                                  \
>         __chk_user_ptr(ptr);                                    \
>         __put_user_size((x), __pu_addr, (size), __pu_err);      \
>         __pu_err;                                               \
> 

Another observation:

	if (!is_kernel_addr((unsigned long)__pu_addr))
		might_sleep();

is almost the same as

	might_fault();

except that it does not call might_lock_read().

The version above may have been put there intentionally and correctly, but
if you want to replace it with might_fault(), you should remove the
"if ()" condition.

	Arnd
