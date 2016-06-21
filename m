From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 09:47:00 -0400
Message-ID: <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0074.outbound.protection.outlook.com ([104.47.2.74]:60748
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751235AbcFUOXf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jun 2016 10:23:35 -0400
In-Reply-To: <20160621124247.GM30921@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 6/21/2016 8:42 AM, Peter Zijlstra wrote:
> On Tue, Jun 21, 2016 at 08:08:29AM -0400, Chris Metcalf wrote:
>> You need to have a tilepro toolchain (not tilegx)
> Ah, should I go use TARGET=tilepro-linux ?

Yes.

>> and build with ARCH=tilepro.
>          tilepro)
>                  ARCH=tile
>                  CROSS_COMPILE=tilegx-linux-
>                  if [ "$CONFIG" == "defconfig" ] ; then
>                          CONFIG=tilepro_defconfig
>                  fi
>                  ;;
>
> So I suppose that too is wrong.

Yup.  That's actually just building exactly what "tilegx" would build by default.

I'm not sure who builds the toolchains, but tilepro is in upstream gcc/binutils/etc
so should be easy enough to include.  There's also a cross-toolchain for x64 I put
up a while ago [1] that you could grab if you wanted to try it.

[1] http://www.mellanox.com/repository/solutions/tile-scm/tilepro-x86_64.tar.bz2

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
