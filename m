From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH 5/5] tile: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Mon, 25 Jul 2016 12:37:50 -0400
Message-ID: <ac0ee1bd-572c-5c80-bf29-346c19a3aaa4@mellanox.com>
References: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
 <1469462394-8970-6-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:27121
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753073AbcGYVJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jul 2016 17:09:44 -0400
In-Reply-To: <1469462394-8970-6-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 7/25/2016 11:59 AM, James Hogan wrote:
> AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
> NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
> for tile at all even though ARCH_DLINFO will contain one NEW_AUX_ENT for
> the VDSO address.
>
> This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
> AT_BASE_PLATFORM which tile doesn't use, but lets define it now and add
> the comment above ARCH_DLINFO as found in several other architectures to
> remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
> date.
>
> Fixes: 4a556f4f56da ("tile: implement gettimeofday() via vDSO")
> Signed-off-by: James Hogan<james.hogan@imgtec.com>
> Cc: Chris Metcalf<cmetcalf@mellanox.com>
> ---
>   arch/tile/include/asm/elf.h         | 1 +
>   arch/tile/include/uapi/asm/auxvec.h | 2 ++
>   2 files changed, 3 insertions(+)

Thanks, taken into the tile tree.

I'm a little dubious that AT_VECTOR_SIZE_ARCH should be being defined
in the uapi version of auxvec.h, since I don't see why userspace should
be interested in it, but that does seem to be the current convention.
Ugh, there are even CONFIG_xxx ifdefs in the x86 and sh uapi/asm/auxvec.h ...
Maybe the define could be moved to arch/*/include/asm/elf.h?

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
