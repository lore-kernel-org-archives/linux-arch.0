From: czankel <chris@zankel.net>
Subject: Re: [PATCH 5/5] xtensa: Use generic asm/mmu.h for nommu
Date: Mon, 03 Dec 2012 00:55:01 -0800
Message-ID: <50BC68E5.6070605@zankel.net>
References: <1351765467-29244-1-git-send-email-lars@metafoo.de> <1351765467-29244-5-git-send-email-lars@metafoo.de> <50BC62BD.2060602@zankel.net> <50BC661C.6080002@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50517 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab2LCIyz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2012 03:54:55 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1850754pbc.19
        for <linux-arch@vger.kernel.org>; Mon, 03 Dec 2012 00:54:54 -0800 (PST)
In-Reply-To: <50BC661C.6080002@metafoo.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

On 12/3/12 12:43 AM, Lars-Peter Clausen wrote:
> On 12/03/2012 09:28 AM, czankel wrote:
>> Thanks Lars, I have added it to the Xtensa for_next tree.
>>
>> -Chris
> Hi,
>
> While the patch works standalone. It would be better if it'd go through the
> same tree as the other patches in this series. Patch 1 removes the unused
> vmlist field from the mm_context_t struct in asm-generic/mmu.h. So without that
> patch this patch basically doubles the size of your mm_context_t.
OK, reverted it. Regarding the Xtensa patch,

Acked-by: Chris Zankel <chris@zankel.net>

Thanks,
-Chris
