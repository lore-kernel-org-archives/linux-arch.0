From: Michal Marek <mmarek@suse.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Tue, 1 Nov 2016 16:48:48 +0100
Message-ID: <7b7c237c-c779-f695-e320-d9e00e48d1d2@suse.com>
References: <20161017100130.GA16013@angband.pl> <871szfb1x1.fsf@gmail.com>
 <20161018001626.GA5976@angband.pl>
 <20161018123418.6121175b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161018123418.6121175b@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Adam Borowski <kilobyte@angband.pl>
Cc: Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2016-10-18 03:34, Nicholas Piggin wrote:
> Hi Adam,
> 
> Thanks, this is looking good. powerpc will be able to use the generic
> header.
> 
> On Tue, 18 Oct 2016 02:16:26 +0200
> Adam Borowski <kilobyte@angband.pl> wrote:
> 
>> On Mon, Oct 17, 2016 at 02:22:34PM +0200, Mathieu OTHACEHE wrote:
>>>> +#include <asm/uaccess.h>
>>>> +#include <asm/uaccess.h>  
>>>
>>> Included twice.  
>>
>> D'oh!
>>
>>>> +#include <asm/string.h>
>>>> +#include <asm/page.h>
>>>> +#include <asm/checksum.h>
>>>> +
>>>> +#include <asm-generic/asm-prototypes.h>
>>>> +
>>>> +#include <asm/page.h>
>>>> +#include <asm/pgtable.h>
>>>> +#include <asm/special_insns.h>
>>>> +#include <asm/preempt.h>  
>>>
>>> No <asm/arch_hweight.h> for __sw_hweight32 and __sw_hweight64 ?   
>>
>> diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
>> new file mode 100644
>> index 0000000..df13637
>> --- /dev/null
>> +++ b/include/asm-generic/asm-prototypes.h
>> @@ -0,0 +1,7 @@
>> +#include <linux/bitops.h>
>>
>> ... which has these.
>>
>> Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> } bitops.h is wrong header as well.
>> } Why do you need bitops for bunch of function prototypes?
>>
>> Unless you guys prefer using low-level headers only, that is.
> 
> Well you can't use asm/arch_hweight.h in a generic header of course.
> I would suggest just including linux/ variants where practical for
> the asm-generic/asm-prototypes.h header.
> 
> We should probably just bring all these arch patches through the
> kbuild tree.

Adam,

are you submitting a new version of your x86 asm-prototypes.h patch?

Thanks,
Michal
