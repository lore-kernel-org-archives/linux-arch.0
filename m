From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] asm-generic/unistd.h: support new process_vm_{readv,write}
 syscalls
Date: Fri, 2 Dec 2011 10:11:06 -0500
Message-ID: <4ED8EA8A.2050900@tilera.com>
References: <201112011815.pB1IFACw004908@farm-0002.internal.tilera.com> <12496289.FSF46xab1G@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([206.83.70.75]:64032 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab1LBPLI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2011 10:11:08 -0500
In-Reply-To: <12496289.FSF46xab1G@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org

On 12/1/2011 5:48 PM, Arnd Bergmann wrote:
> On Thursday 01 December 2011 12:54:31 Chris Metcalf wrote:
>> Also prototype the "compat" functions so they can be referenced
>> from C code.
>>
>> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
>> ---
>>  include/asm-generic/unistd.h |    8 +++++++-
>>  include/linux/compat.h       |    9 +++++++++
>>  2 files changed, 16 insertions(+), 1 deletions(-)
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Chris, I don't have any other patches for asm-generic right now. Can you handle
> this through the tile tree?

I will.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
