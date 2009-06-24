Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45991 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbZFXJI1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Jun 2009 05:08:27 -0400
Message-ID: <4A41ECBB.5040306@kernel.org>
Date: Wed, 24 Jun 2009 18:07:07 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 11/10] sparc64: fix build breakage introduced by percpu-convert-most
 patchset
References: <1245825924-30412-1-git-send-email-tj@kernel.org>	<4A41DDE6.1090209@kernel.org> <20090624.020047.175924588.davem@davemloft.net>
In-Reply-To: <20090624.020047.175924588.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, torvalds@linux-foundation.org, akpm@linux-foundation.org
Message-ID: <20090624090707.88wCrACJwu2-8RH75WoBPcuNWRuh-sbEwwlWv3h5Hlg@z>

David Miller wrote:
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 24 Jun 2009 17:03:50 +0900
> 
>> Commit e74e396204bfcb67570ba4517b08f5918e69afea incorrectly added
>> added HAVE_LEGACY_PER_CPU_AREA to sparc64 although it already has been
>> converted to dynamic percpu allocator.  Drop both
>> HAVE_{LEGACY|DYNAMIC}_PER_CPU_AREA.
>>
>> [ Impact: fix build breakage ]
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Acked-by added, patch description slightly updated as suggested by
Ingo and patch now available in percpu#for-next.

Thanks.

-- 
tejun
