Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:22139
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751260AbcFUMZh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jun 2016 08:25:37 -0400
Subject: Re: linux-next: Tree for Jun 21
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
Date: Tue, 21 Jun 2016 08:08:29 -0400
MIME-Version: 1.0
In-Reply-To: <5768E650.2080506@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160621120829.SIdtoSuicllxESl8Fsnb84f_t7g8LcF7YxtoNG9khBI@z>

On 6/21/2016 3:01 AM, Sudip Mukherjee wrote:
> On Tuesday 21 June 2016 06:46 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20160620:
>
> tilepro defconfig is failing while doing "make prepare" and bisect shows the first bad commit as:
>
> 1af5de9af138 ("locking/atomic, arch/tile: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()")
>
> You can find today's build log at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/139112570

On inspection, I note that the arch/tile/include/atomic_32.h header has

ATOMIC64_OP(and)
ATOMIC64_OP(or)
ATOMIC64_OP(xor)

but these should be ATOMIC64_OPS, plural.

Peter, what toolchain were you using for tilepro build testing?  You need to have a tilepro toolchain (not tilegx) and build with ARCH=tilepro.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

