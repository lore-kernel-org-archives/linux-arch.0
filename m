From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH v2] arch: all: include: asm: bitops: Use bool instead
 of int for all bit test functions
Date: Sat, 17 Sep 2016 14:33:36 +0800
Message-ID: <57DCE3C0.8010508@emindsoft.com.cn>
References: <1472396129-28665-1-git-send-email-chengang@emindsoft.com.cn> <201609040802.ueL85Ttu%fengguang.wu@intel.com> <20160906122732.2086f1bcb1c3daa378e21d3b@linux-foundation.org> <20160907015219.4bk5ptcfyrosowwi@wfg-t540p.sh.intel.com> <57D0349F.1080706@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out1134-243.mail.aliyun.com ([42.120.134.243]:8770 "EHLO
        out1134-243.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752001AbcIQGcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 17 Sep 2016 02:32:05 -0400
In-Reply-To: <57D0349F.1080706@emindsoft.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fengguang Wu <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kbuild-all@01.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.ne


If necessary to send patch v3 for it, please let me know (I guess not).

Next, I shall try to find and make another patches for our kernel.

Thanks.

On 9/7/16 23:39, Chen Gang wrote:
> 
> Thank you all for your work. Commonly, I should send patch v3 for it.
> 
> And very sorry for replying too late. During these days I have no
> enough time on it (working, buying house, and catching a cold, but I am
> lucky enough that my father's health is OK).
> 
> Thanks.
> 
> On 9/7/16 09:52, Fengguang Wu wrote:
>> Hi Andrew,
>>
>> On Tue, Sep 06, 2016 at 12:27:32PM -0700, Andrew Morton wrote:
>>> On Sun, 4 Sep 2016 08:27:36 +0800 kbuild test robot <lkp@intel.com> wrote:
>>>
>>>> [auto build test ERROR on linus/master]
>>>> [also build test ERROR on v4.8-rc4 next-20160825]
>>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
>>>> [Check https://git-scm.com/docs/git-format-patch for more information]
>>>>
>>>> url:    https://github.com/0day-ci/linux/commits/chengang-emindsoft-com-cn/arch-all-include-asm-bitops-Use-bool-instead-of-int-for-all-bit-test-functions/20160828-230301
>>>> config: s390-default_defconfig (attached as .config)
>>>> compiler: s390x-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
>>>> reproduce:
>>>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # save the attached .config to linux build tree
>>>>         make.cross ARCH=s390
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>    In file included from include/linux/bitops.h:36:0,
>>>>                     from fs/btrfs/extent_io.c:1:
>>>>>> arch/s390/include/asm/bitops.h:176:15: error: unknown type name 'bool'
>>>>     static inline bool
>>>>                   ^
>>>>    arch/s390/include/asm/bitops.h:187:15: error: unknown type name 'bool'
>>>>     static inline bool
>>>
>>> My s390 cross compiler doesn't like that config.  Can someone test this?
>>
>> Tested-by: Fengguang Wu <fengguang.wu@intel.com>
>>
>> It works fine with Debian's gcc-6-s390x-linux-gnu and crosstool gcc:
>>
>> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/x86_64-gcc-4.9.0-nolibc_s390x-linux.tar.xz
>>
>>> --- a/arch/s390/include/asm/bitops.h~a
>>> +++ a/arch/s390/include/asm/bitops.h
>>> @@ -40,6 +40,7 @@
>>> #error only <linux/bitops.h> can be included directly
>>> #endif
>>>
>>> +#include <linux/types.h>
>>> #include <linux/typecheck.h>
>>> #include <linux/compiler.h>
>>> #include <asm/barrier.h>
>>
>> Regards,
>> Fengguang
> 

-- 
Chen Gang (陈刚)

Managing Natural Environments is the Duty of Human Beings.
