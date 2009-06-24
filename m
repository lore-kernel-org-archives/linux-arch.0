From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 11/10] sparc64: fix build breakage introduced by percpu-convert-most
 patchset
Date: Wed, 24 Jun 2009 18:07:07 +0900
Message-ID: <4A41ECBB.5040306@kernel.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org>	<4A41DDE6.1090209@kernel.org> <20090624.020047.175924588.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757324AbZFXJJB@vger.kernel.org>
In-Reply-To: <20090624.020047.175924588.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
