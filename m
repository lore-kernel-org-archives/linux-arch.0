Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([119.145.14.52]:17447 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957AbcGUMn0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2016 08:43:26 -0400
Subject: Re: [RFD] Efficient unit test and fuzz tools for kernel/libc porting
References: <577CB5B7.7040204@huawei.com>
 <alpine.DEB.2.20.1607201544220.12251@digraph.polyomino.org.uk>
From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Message-ID: <5790C26F.4080408@huawei.com>
Date: Thu, 21 Jul 2016 20:39:11 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607201544220.12251@digraph.polyomino.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joseph Myers <joseph@codesourcery.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, libc-alpha@sourceware.org, trinity@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, aponomarenko@rosalab.ru, Jess Hertz <jesse.hertz@nccgroup.trust>, Tim Newsham <tim.newsham@nccgroup.trust>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, Andrew Pinski <pinskia@gmail.com>, Andreas Schwab <schwab@suse.de>, Alexander Graf <agraf@suse.de>, marcus.shawcroft@arm.com, Ding Tianhong <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, cuibixuan@huawei.com, lijinyue@huawei.com, Zefan Li <lizefan@huawei.com>
Message-ID: <20160721123911.VD8OlhevtDO1zvRlqctZ5Sxxa7-AtfbopgpLfJWh2TQ@z>

Hi, Joseph

On 2016/7/20 23:47, Joseph Myers wrote:
> On Wed, 6 Jul 2016, Zhangjian (Bamvor) wrote:
>
>> correct or not. After learn and compare some fuzz tools, I feel that there is
>> no such fuzz tools could help me. So, I wrote a new fuzz tools base on the
>> trinity and it found several wrapper issues in glibc. I will first explain the
>> different with existing fuzz tools and paste my propsosal in the end.
>
> I'm not at all clear on whether any of the people working on AArch64 ILP32
> glibc have run the glibc testsuite and investigated the results in detail
> (the patch submissions have failed to include glibc testsuite results and
>  have included bugs that would have been detected by the glibc testsuite).
I run test glibc testsuite in previous glibc version with v6 kernel patch
backport to kernel-4.1, without regression. I usually run glibc testsuite
after ltp test result looks good. So, maybe it hard to find a issue by
glibc testsuite in this case.
> But, if you've found bugs in a new glibc port that were not detected by
> the existing testsuite, then tests for those bugs should be contributed to
> glibc (even if no existing port has those bugs, improving the test
> coverage is still a good idea).
It is good idea. I will review the fixed issues(such as wrong context in
signal, wrong parameter in off_t/stat relative syscalls) and check if it is
suitable to add it to glibc testsuite. (Actually, I do not know which
test suite (ltp or glibc) I should improve for a specific issue).
I hope our tools could help on improving the coverage of syscall relative
code at least.

Thanks.

Bamvor

