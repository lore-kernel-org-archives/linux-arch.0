Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0055.outbound.protection.outlook.com ([157.56.112.55]:18828
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752492AbbBXV7t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Feb 2015 16:59:49 -0500
Message-ID: <54ECF309.3020509@ezchip.com>
Date: Tue, 24 Feb 2015 16:54:17 -0500
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
Message-ID: <20150224215417._Gg6nd9nH94rZdwQwMWnRSZG_gedt6YhM5aLawqpMZ4@z>

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
>
> So delivering such signals to compat user always sets si_int to 0.
> Little endian is fine.

I looked at this again as I was getting ready to do a tile patch, and realized
why tile and arm64 are different here: tile does a field-by-field copy in
copy_siginfo_from_user32(), like parisc and s390.  As a result, we initialize
the 64-bit kernel si_ptr value by cast from the 32-bit user si_ptr value, rather
than blindly writing into the lower-addressed half of the 64-bit sigval.

As a result, I think I will leave the existing code alone, though unfortunately
that leaves it somewhat unique in manipulating the si_ptr field directly.
But I think the s390 and parisc copy_siginfo_from_user32 leave the high
bits of si_ptr uninitialized, which also strikes me as a bad idea in general.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

