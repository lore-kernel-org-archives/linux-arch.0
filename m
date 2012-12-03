From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/5] xtensa: Use generic asm/mmu.h for nommu
Date: Mon, 03 Dec 2012 09:43:08 +0100
Message-ID: <50BC661C.6080002@metafoo.de>
References: <1351765467-29244-1-git-send-email-lars@metafoo.de> <1351765467-29244-5-git-send-email-lars@metafoo.de> <50BC62BD.2060602@zankel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61361 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab2LCImd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2012 03:42:33 -0500
In-Reply-To: <50BC62BD.2060602@zankel.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: czankel <chris@zankel.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

On 12/03/2012 09:28 AM, czankel wrote:
> Thanks Lars, I have added it to the Xtensa for_next tree.
> 
> -Chris

Hi,

While the patch works standalone. It would be better if it'd go through the
same tree as the other patches in this series. Patch 1 removes the unused
vmlist field from the mm_context_t struct in asm-generic/mmu.h. So without that
patch this patch basically doubles the size of your mm_context_t.

- Lars

> 
> On 11/1/12 3:24 AM, Lars-Peter Clausen wrote:
>> The nommu portion of mmu.h of the extensa platform is basically the
>> same as the
>> asm-generic mmu.h. So use it instead.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>
>> ---
>> Note, due to lack of toolchain, etc this patch is completely untested.
>> ---
>>   arch/xtensa/include/asm/mmu.h   |    2 +-
>>   arch/xtensa/include/asm/nommu.h |    3 ---
>>   2 files changed, 1 insertions(+), 4 deletions(-)
>>   delete mode 100644 arch/xtensa/include/asm/nommu.h
>>
>> diff --git a/arch/xtensa/include/asm/mmu.h
>> b/arch/xtensa/include/asm/mmu.h
>> index 04890d6..8554b2c 100644
>> --- a/arch/xtensa/include/asm/mmu.h
>> +++ b/arch/xtensa/include/asm/mmu.h
>> @@ -12,7 +12,7 @@
>>   #define _XTENSA_MMU_H
>>     #ifndef CONFIG_MMU
>> -#include <asm/nommu.h>
>> +#include <asm-generic/mmu.h>
>>   #else
>>     /* Default "unsigned long" context */
>> diff --git a/arch/xtensa/include/asm/nommu.h
>> b/arch/xtensa/include/asm/nommu.h
>> deleted file mode 100644
>> index dce2c43..0000000
>> --- a/arch/xtensa/include/asm/nommu.h
>> +++ /dev/null
>> @@ -1,3 +0,0 @@
>> -typedef struct {
>> -    unsigned long end_brk;
>> -} mm_context_t;
> 
