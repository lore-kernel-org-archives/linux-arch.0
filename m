Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35476 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbXHQAoB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Aug 2007 20:44:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18116.61246.856760.243185@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2007 10:43:42 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Implement atomic{,64}_{read,write}() without volatile
In-Reply-To: <11867913303733-git-send-email-segher@kernel.crashing.org>
References: <11867913303733-git-send-email-segher@kernel.crashing.org>
	<d6775e129db48371cdf86e94ddfaa1d15617bb8f.1186773842.git.segher@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Segher Boessenkool writes:

> Instead, use asm() like all other atomic operations already do.

> +static __inline__ long atomic64_read(const atomic_t *v)

> +static __inline__ void atomic64_set(atomic_t *v, long i)

s/atomic_t/atomic64_t/ in both lines.  I've edited my copy of the patch.

Paul.
