Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63129 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcFUPro (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 11:47:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/19] arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
Date: Tue, 21 Jun 2016 17:47:44 +0200
Message-ID: <4650742.YG7pOR48ul@wuerfel>
In-Reply-To: <mvmk2hipyfw.fsf@hawking.suse.de>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com> <576915B0.5040706@huawei.com> <mvmk2hipyfw.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: libc-alpha@sourceware.org
Cc: Andreas Schwab <schwab@suse.de>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Yury Norov <ynorov@caviumnetworks.com>, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Message-ID: <20160621154744.ko_BfWxm-e4lOIyjHxP4XnEXS9CAMAZ8YWRh4oq9XKE@z>

On Tuesday, June 21, 2016 1:34:59 PM CEST Andreas Schwab wrote:
> "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> writes:
> 
> >> @@ -78,9 +79,9 @@
> >>
> >>   #ifdef CONFIG_COMPAT
> >>   #define TASK_SIZE_32               UL(0x100000000)
> >> -#define TASK_SIZE           (test_thread_flag(TIF_32BIT) ? \
> >> +#define TASK_SIZE           (is_compat_task() ?             \
> >>                              TASK_SIZE_32 : TASK_SIZE_64)
> >> -#define TASK_SIZE_OF(tsk)   (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
> >> +#define TASK_SIZE_OF(tsk)   (is_compat_thread(tsk) ? \
> > It should be
> > +#define TASK_SIZE_OF(tsk)      (is_compat_thread(task_thread_info(tsk)) ? \
> > is_compat_thread takes "struct thread_info *thread" while TASK_SIZE_OF takes
> > "struct task_struct *tsk"tsk.
> 
> If that doesn't throw an error does that mean that TASK_SIZE_OF is
> unused?

I think that is correct. On some architectures, TASK_SIZE (which is used)
is defined as TASK_SIZE_OF(current), but the definition above doesn't
do that and there are no other users.

	Arnd

