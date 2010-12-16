From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Thu, 16 Dec 2010 11:53:09 +0200
Message-ID: <4D09E185.2040600@panasas.com>
References: <12853.1292353313@jrobl>	<AANLkTinjkcciZhJM5FmUkh_YCJ6bc9aTq8zV=SACDb1O@mail.gmail.com>	<4D08BF5D.1060509@panasas.com> <20101215.100055.226772943.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from daytona.panasas.com ([67.152.220.89]:13096 "EHLO
	daytona.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab0LPJxN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Dec 2010 04:53:13 -0500
In-Reply-To: <20101215.100055.226772943.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: npiggin@gmail.com, hooanon05@yahoo.co.jp, npiggin@kernel.dk, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On 12/15/2010 08:00 PM, David Miller wrote:
> From: Boaz Harrosh <bharrosh@panasas.com>
> Date: Wed, 15 Dec 2010 15:15:09 +0200
> 
>> I agree that the byte-compare or long-compare should give you very close
>> results in modern pipeline CPUs. But surly 12 increments-and-test should
>> show up against 3 (or even 2). I would say it must be a better plan.
> 
> For strings of these lengths the setup code necessary to initialize
> the inner loop and the tail code to handle the sub-word ending cases
> eliminate whatever gains there are.
> 

You miss understood me. I'm saying that we know the beggining of the
string is aligned and Nick offered to pad the last long, so surly
a shift by 2 (or 3) + the reduction of the 12 dec-and-test to 3
should give you an optimization?

> I know this as I've been hacking on assembler optimized strcmp() and
> memcmp() in my spare time over the past year or so.

Boaz
