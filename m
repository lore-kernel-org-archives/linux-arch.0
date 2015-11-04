Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:49722 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965372AbbKDVnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2015 16:43:00 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/5] do_div(): generic optimization for constant divisor on 32-bit machines
References: <201511031333.Yk9ngQZJ%fengguang.wu@intel.com>
	<21544300.LSjO3j3Xy7@wuerfel>
	<alpine.LFD.2.20.1511041542130.630@knanqh.ubzr>
Date: Wed, 04 Nov 2015 21:42:58 +0000
In-Reply-To: <alpine.LFD.2.20.1511041542130.630@knanqh.ubzr> (Nicolas Pitre's
	message of "Wed, 4 Nov 2015 16:04:57 -0500 (EST)")
Message-ID: <yw1xoaf97865.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151104214258.kbyikTWCV5oO01NG4wOVhr1UjFWVxcJTNbUMISDd_Sw@z>

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

> On Tue, 3 Nov 2015, Arnd Bergmann wrote:
>
>> On Tuesday 03 November 2015 13:32:17 kbuild test robot wrote:
>> > 
>> >    net/can/bcm.c: In function 'bcm_proc_show':
>> > >> net/can/bcm.c:223:1: warning: the frame size of 1156 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> >     }
>> 
>> Interesting, that is a lot of stack for a function that only has a couple
>> of local variables:
>> 
>> #define IFNAMSIZ        16
>>         char ifname[IFNAMSIZ];
>>         struct sock *sk = (struct sock *)m->private;
>>         struct bcm_sock *bo = bcm_sk(sk);
>>         struct bcm_op *op;
>> 
>> 
>> This is a parisc-allyesconfig kernel, so I assume that CONFIG_PROFILE_ALL_BRANCHES
>> is on, which instruments every 'if' in the kernel. If that causes problems,
>> we could decide to disable the do_div optimization whenever CONFIG_PROFILE_ALL_BRANCHES
>> is enabled.
>
> I have an ARM allyesconfig build here where that function needs a frame 
> of 88 bytes only. And that is with my do_div optimization applied.
>
> With the do_div optimization turned off, the stack frame is still 88 
> bytes.
>
> Turning on CONFIG_PROFILE_ALL_BRANCHES makes the frame size to grow to 
> 96 bytes.
>
> Keeping CONFIG_PROFILE_ALL_BRANCHES=y and activating the do_div 
> optimization again, and the function frame size goes back to 88 bytes.
>
> So I wonder what parisc gcc could be doing with this code.

I've seen parisc gcc do many strange things.

-- 
Måns Rullgård
mans@mansr.com
