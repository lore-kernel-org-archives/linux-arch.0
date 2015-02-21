Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0063.outbound.protection.outlook.com ([157.56.112.63]:1376
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751754AbbBUHVp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Feb 2015 02:21:45 -0500
Message-ID: <54E803FB.901@ezchip.com>
Date: Fri, 20 Feb 2015 23:05:15 -0500
From: Chris Metcalf <cmetcalf@ezchip.com>
MIME-Version: 1.0
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com> <20150210122718.GC32052@e104818-lin.cambridge.arm.com> <54DB3B60.4050100@huawei.com> <20150211154054.GD9058@e104818-lin.cambridge.arm.com> <54DDAF2B.2070707@huawei.com> <20150213104455.GA3508@e104818-lin.cambridge.arm.com> <54DE730D.3090100@ezchip.com> <20150214112220.GB10246@MBP.local>
In-Reply-To: <20150214112220.GB10246@MBP.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>, linux-arch@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org, deller@gmx.de, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, heiko.carstens@de.ibm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, jejb@parisc-linux.org, "lizefan@huawei.com" <lizefan@huawei.com>, paulus@samba.org, ralf@linux-mips.org, hpa@zytor.com, schwidefsky@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, davem@davemloft.net, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150221040515.qcHuJKNy9Mi1E0KUNcY-04cCIktimcF3qjET4hDD07I@z>

On 2/14/2015 6:22 AM, Catalin Marinas wrote:
> 1. user populates sival_int compat_sigevent and invokes
>     compat_sys_mq_notify()
> 2. kernel get_compat_sigevent() copies compat_sigevent into the native
>     sigevent. compat and native sival_int are the same, no problem so
>     far. The other half of 64-bit sival_ptr is zeroed by a memset in this
>     function (this other half can be top or bottom, depending on
>     endianness)
> 3. signal is about to be delivered to user via arch code. The
>     compat_ptr(from->si_ptr) conversion always takes the least
>     significant part of the native si_ptr. On big endian 64-bit, this is
>     zero because get_compat_sigevent() populated the top part of si_ptr
>     with si_int.

Thanks, that makes sense.  I was missing the fact that the conversion
issue was actually around the in-kernel 64-bit version of the structure.
Using si_int consistently does seem like it should do the right thing;
I'll post a patch for tilegx32 big-endian to do the right thing here.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

