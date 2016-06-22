From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Wed, 22 Jun 2016 16:43:15 -0400
Message-ID: <cea1e8b0-f0ca-7985-39f5-b66cfed50a9a@mellanox.com>
References: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
 <20160621185048.GR30909@twins.programming.kicks-ass.net>
 <3813680.TbHyagWbHe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0061.outbound.protection.outlook.com ([157.56.112.61]:7680
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751123AbcFVUnb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jun 2016 16:43:31 -0400
In-Reply-To: <3813680.TbHyagWbHe@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 6/21/2016 5:14 PM, Arnd Bergmann wrote:
> On Tuesday, June 21, 2016 8:50:48 PM CEST Peter Zijlstra wrote:
>>> So what's your build process for the cross tools, by the way?  I'm assuming
>>> you're not doing a total bootstrap cross-tool build since you'd need minimal
>>> kernel headers (linux/errno.h or whatever) in that case.  I assume you're using
>>> the host headers to build the cross tool?
>>>
>>> So I'm a little confused how the other kernel headers are working out for you,
>>> e.g. <arch/icache.h> is referenced when building the tilegx libgcc.
>> I've no idea; I use this thing:
>>
>>    git://git.infradead.org/users/segher/buildall.git
>>
>> Although I've got some local modifications, none are to the actual
>> toolchain building part (although I suppose I should send segher a
>> patch).
>>
>> I have binutils-gdb.git and gcc.bit checkouts and point the buildall
>> config to that (both are on latest stable branches binutils-2_26-branch
>> and gcc-6-branch resp.). And I point the kernel path to my current
>> hacked up tree.
>>
>> I don't really rebuild the entire toolchains often, mostly only when I
>> really need a new GCC or its getting really old (like I used 5.3.0 for a
>> long while).
> I think the kernel headers are only needed for building glibc, which
> buildall.git doesn't use: it only does the initial stage of creating
> a cross-toolchain.

It turns out there were a few places where we were #include'ing Linux
headers in the gcc build (asm/unistd.h, arch/icache.h, arch/spr_def.h).
I patched gcc to provide inline copies of what was needed (pretty simple
stuff and won't ever change) and asked our lead compiler guy to upstream
it back up to gcc, so using buildall.git should get easier for tilepro/tilegx.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
