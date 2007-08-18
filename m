Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48098 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbXHRB35 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Aug 2007 21:29:57 -0400
In-Reply-To: <18116.61246.856760.243185@cargo.ozlabs.ibm.com>
References: <11867913303733-git-send-email-segher@kernel.crashing.org> <d6775e129db48371cdf86e94ddfaa1d15617bb8f.1186773842.git.segher@kernel.crashing.org> <18116.61246.856760.243185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5f948fd33e0908c03c07f32ae89834a9@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Implement atomic{,64}_{read,write}() without volatile
Date: Sat, 18 Aug 2007 03:29:48 +0200
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>> Instead, use asm() like all other atomic operations already do.
>
>> +static __inline__ long atomic64_read(const atomic_t *v)
>
>> +static __inline__ void atomic64_set(atomic_t *v, long i)
>
> s/atomic_t/atomic64_t/ in both lines.  I've edited my copy of the 
> patch.

Ouch, sorry about that.


Segher

