From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] asm-generic/io.h: remove asm/cacheflush.h include
Date: Mon, 29 Oct 2012 09:28:09 +0000
Message-ID: <508E4C29.4030308@imgtec.com>
References: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com> <57835.162.105.203.8.1351474122.squirrel@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55735 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2J2J2O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Oct 2012 05:28:14 -0400
In-Reply-To: <57835.162.105.203.8.1351474122.squirrel@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guanxuetao@mprc.pku.edu.cn
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>, linux-arch@vger.kernel.org, linux@openrisc.net, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 29/10/12 01:28, guanxuetao@mprc.pku.edu.cn wrote:
>> Including <asm/cacheflush.h> from <asm-generic/io.h> prevents
>> cacheflush.h being able to use I/O functions like readl and writel due
>> to circular include dependencies. It doesn't appear as if anything from
>> cacheflush.h is actually used by the generic io.h, so remove the
>> include.
>>
>> I've compile tested a defconfig compilation of blackfin, openrisc (which
>> needed <asm/pgtable.h> including from it's <asm/io.h> to get the PAGE_*
>> definitions), and xtensa.
>>
>> Other architectures which use asm-generic/io.h are score and unicore32,
>> and looking at their io.h I don't see any obvious problems.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Cc: Mike Frysinger <vapier@gentoo.org>
>> Cc: Chen Liqin <liqin.chen@sunplusct.com>
>> Cc: Lennox Wu <lennox.wu@gmail.com>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> 
> Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Thanks Guan

Cheers
James
