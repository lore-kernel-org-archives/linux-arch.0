From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] do_div(): generic optimization for constant divisor on 32-bit machines
Date: Tue, 03 Nov 2015 10:15:13 +0100
Message-ID: <21544300.LSjO3j3Xy7@wuerfel>
References: <201511031333.Yk9ngQZJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59476 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbKCJQE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2015 04:16:04 -0500
In-Reply-To: <201511031333.Yk9ngQZJ%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, kbuild-all@01.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 03 November 2015 13:32:17 kbuild test robot wrote:
> 
>    net/can/bcm.c: In function 'bcm_proc_show':
> >> net/can/bcm.c:223:1: warning: the frame size of 1156 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     }

Interesting, that is a lot of stack for a function that only has a couple
of local variables:

#define IFNAMSIZ        16
        char ifname[IFNAMSIZ];
        struct sock *sk = (struct sock *)m->private;
        struct bcm_sock *bo = bcm_sk(sk);
        struct bcm_op *op;


This is a parisc-allyesconfig kernel, so I assume that CONFIG_PROFILE_ALL_BRANCHES
is on, which instruments every 'if' in the kernel. If that causes problems,
we could decide to disable the do_div optimization whenever CONFIG_PROFILE_ALL_BRANCHES
is enabled.

	Arnd
