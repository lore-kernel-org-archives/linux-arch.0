Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33744 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbcFUHCc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 03:02:32 -0400
Message-ID: <5768E650.2080506@gmail.com>
Date: Tue, 21 Jun 2016 08:01:36 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Subject: Re: linux-next: Tree for Jun 21
References: <20160621154638.1169904b@canb.auug.org.au>
In-Reply-To: <20160621154638.1169904b@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160621070136.DEVadl1jFGt2w0gOEkxuvGbQU6ntycMFV3JSN-OtHx0@z>

On Tuesday 21 June 2016 06:46 AM, Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20160620:

tilepro defconfig is failing while doing "make prepare" and bisect shows 
the first bad commit as:

1af5de9af138 ("locking/atomic, arch/tile: Implement 
atomic{,64}_fetch_{add,sub,and,or,xor}()")

You can find today's build log at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/139112570

Please do let me know if i can help in any way to debug/solve this.

regards
sudip
