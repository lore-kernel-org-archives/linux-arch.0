Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:24742 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265966AbUHANv5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 09:51:57 -0400
Date: Sun, 1 Aug 2004 06:51:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: find_next_bit return type
Message-ID: <20040801135154.GV2334@holomorphy.com>
References: <20040731232434.7263b50c.akpm@osdl.org> <20040801115334.GP2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801115334.GP2334@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Aug 01, 2004 at 04:53:34AM -0700, William Lee Irwin III wrote:
> Not in particular, no. I'd sort of like 64-bit arches to keep their
> natural wordsize as the return value as davem pointed out sign
> extensions, conversions, etc. are overheads there.
> To address this without a negative impact on 64-bit architectures and
> to have the least code impact possible, I'd recommend the following.
> (sparc32 obviously doesn't care about this issue either way)

Paul Jackson wants the nbits thing to be respected, so as long as the
callers sensitive to the precise size can't be identified:


Index: hotplug-2.6.8-rc2/include/linux/cpumask.h
===================================================================
--- hotplug-2.6.8-rc2.orig/include/linux/cpumask.h	2004-07-29 04:44:59.000000000 -0700
+++ hotplug-2.6.8-rc2/include/linux/cpumask.h	2004-08-01 06:32:31.615472016 -0700
@@ -207,13 +207,13 @@
 #define first_cpu(src) __first_cpu(&(src), NR_CPUS)
 static inline int __first_cpu(const cpumask_t *srcp, int nbits)
 {
-	return find_first_bit(srcp->bits, nbits);
+	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
 }
 
 #define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
 static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
 {
-	return find_next_bit(srcp->bits, nbits, n+1);
+	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
 }
 
 #define cpumask_of_cpu(cpu)						\
