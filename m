From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC][PATCH 0/3] gcc work-around and math128
Date: Tue, 24 Apr 2012 14:15:18 -0700
Message-ID: <4F9717E6.8030506@amacapital.net>
References: <20120424161039.293018424@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:51722 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab2DXVP3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 17:15:29 -0400
Received: by dadz8 with SMTP id z8so1418106dad.10
        for <linux-arch@vger.kernel.org>; Tue, 24 Apr 2012 14:15:29 -0700 (PDT)
In-Reply-To: <20120424161039.293018424@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>

On 04/24/2012 09:10 AM, Peter Zijlstra wrote:
> Hi all,
> 
> The SCHED_DEADLINE review resulted in the following three patches;
> 
> The first is a cleanup of various copies of the same GCC loop optimization
> work-around. I don't think this patch is too controversial, at worst I've
> picked a wrong name, but I wanted to get it out there in case people
> know more sites.
> 
> The second two implement a few u128 operations so we can do 128bit math.. I
> know a few people will die a little inside, but having nanosecond granularity
> time accounting leads to very big numbers very quickly and when you need to
> multiply them 64bit really isn't that much.

I played with some of this stuff awhile ago, and for timekeeping, it
seemed like a 64x32->96 bit multiply followed by a right shift was
enough, and that operation is a lot faster on 32-bit architectures than
a full 64x64->128 multiply.  Something like:

uint64_t mul_64_32_shift(uint64_t a, uint32_t mult, uint32_t shift)
{
  return (uint64_t)( ((__uint128_t)a * (__uint128_t)mult) >> shift );
}

or (untested, but compilable 32-bit gcc)

uint64_t mul_64_32_shift(uint64_t a, uint32_t mult, uint32_t shift)
{
  uint64_t part1 = ((a & 0xFFFFFFFFULL) * mult) >> shift;
  uint64_t part2 = ((a >> 32) * mult) << (32 - shift);
  return part1 + part2;
}

--Andy
