Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933203AbcKHLYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 06:24:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA8BJaqt141536
        for <linux-arch@vger.kernel.org>; Tue, 8 Nov 2016 06:24:12 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26kd9m2vta-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2016 06:24:11 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 8 Nov 2016 11:24:10 -0000
Date: Tue, 8 Nov 2016 12:24:01 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm: only enable sys_pkey* when ARCH_HAS_PKEYS
References: <1477958904-9903-1-git-send-email-mark.rutland@arm.com>
 <c716d515-409f-4092-73d2-1a81db6c1ba3@linux.intel.com>
 <20161104234459.GA18760@remoulade>
 <20161108093042.GC3528@osiris>
 <20161108104112.GM1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108104112.GM1041@n2100.armlinux.org.uk>
Message-ID: <20161108112400.GE3528@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org
Message-ID: <20161108112401.Ek1cSWvSR8gdWLZpSUVbvMqAlZ7QosiKlAJbZ9O4l4o@z>

On Tue, Nov 08, 2016 at 10:41:12AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2016 at 10:30:42AM +0100, Heiko Carstens wrote:
> > Two architectures (arm, mips) have wired them up and thus allocated system
> > call numbers, even though they don't have ARCH_HAS_PKEYS set. Which seems a
> > bit pointless.
> 
> I don't think it's pointless at all.  First, read the LWN article for
> the userspace side of the interface: https://lwn.net/Articles/689395/
> 
> From reading this, it seems (at least to me) that these pkey syscalls
> are going to be the application level API - which means applications
> are probably going to want to make these calls.
> 
> Sure, they'll have to go through glibc, and glibc can provide stubs,
> but the problem with that is if we do get hardware pkey support (eg,
> due to pressure to increase security) then we're going to end up
> needing both kernel changes and glibc changes to add the calls.
> 
> Since one of the design goals of pkeys is to allow them to work when
> there is no underlying hardware support, I see no reason not to wire
> them up in architecture syscall tables today, so that we have a cross-
> architecture kernel version where the pkey syscalls become available.
> glibc (and other libcs) don't then have to mess around with per-
> architecture recording of which kernel version the pkey syscalls were
> added.
> 
> Not wiring up the syscalls doesn't really gain anything: the code
> present when !ARCH_HAS_PKEYS will still be part of the kernel image,
> it just won't be callable.

That can be easily solved (see below).

> So, on balance, I've decided to wire them up on ARM, even though the
> hardware doesn't support them, to avoid unnecessary pain in userspace
> from the ARM side of things.
> 
> Obviously what other architectures do is their own business.

It would make sense if this would be handled the same across architectures.

We could simply ifdef the small pkey block in mprotect.c and rely on the
pkey cond_syscalls added with e2753293ac4b. The result would actually be
the same what Mark proposed, except with less generated code.

Something like this:

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 11936526b08b..9fb86b107e49 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -484,6 +484,8 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 	return do_mprotect_pkey(start, len, prot, -1);
 }
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
@@ -534,3 +536,4 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
 	 */
 	return ret;
 }
+#endif /* CONFIG_ARCH_HAS_PKEYS */

