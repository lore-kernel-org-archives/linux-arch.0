Return-Path: <ink@jurassic.park.msu.ru>
Received: from jurassic.park.msu.ru ([195.208.223.243]:13991 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264554AbUEMVwT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 17:52:19 -0400
Date: Fri, 14 May 2004 01:52:22 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: atomic ops for a VM fix
Message-ID: <20040514015222.A1569@den.park.msu.ru>
References: <20040513133526.0e5efed3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513133526.0e5efed3.akpm@osdl.org>; from akpm@osdl.org on Thu, May 13, 2004 at 01:35:26PM -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, May 13, 2004 at 01:35:26PM -0700, Andrew Morton wrote:
> They require that the architecture implement atomic_add_negative() and
> atomic_inc_and_test().  I managed to cobble these together for many
> architectures, but there are a few gaps.  Please review the third and
> fourth patches.

It seems atomic_inc_and_test() is missing on alpha.

Ivan.

--- 2.6/include/asm-alpha/atomic.h	Mon May 10 06:32:52 2004
+++ linux/include/asm-alpha/atomic.h	Fri May 14 01:41:57 2004
@@ -178,6 +178,7 @@ static __inline__ long atomic64_sub_retu
 #define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 #define atomic64_sub_and_test(i,v) (atomic64_sub_return((i), (v)) == 0)
 
+#define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 #define atomic64_dec_and_test(v) (atomic64_sub_return(1, (v)) == 0)
 
