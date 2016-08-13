Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0061.outbound.protection.outlook.com ([104.47.40.61]:23225
	"EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752648AbcHMP0r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 13 Aug 2016 11:26:47 -0400
Date: Sat, 13 Aug 2016 17:52:28 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] ilp32: fix {GET,SET}SIGMASK request for ptrace
Message-ID: <20160813145228.GA24335@yury-N73SV>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-13-git-send-email-ynorov@caviumnetworks.com>
 <5770B041.3040509@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5770B041.3040509@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: zhouchengming <zhouchengming1@huawei.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net
Message-ID: <20160813145228.4mAbQFYOc_btACL3pSg2rr281XUeSD-GLWPAf5Buia8@z>

On Mon, Jun 27, 2016 at 12:49:05PM +0800, zhouchengming wrote:
> The function compat_ptrace_request(used by ilp32) don't handle
> {GET,SET}SIGMASK request, so it will be handled by ptrace_request.
> But it's wrong because the compat_sigset_t of ilp32 differs from
> the sigset_t of aarch64. The patch fixes it.

Hi Zhou, all,

Reviewing your patch I found that we have 2 identical declarations of
put_sigset_t() and get_sigset_t(). So I moved it under 
arch/arm64/include/asm/signal32_common.h

I also reworked related code to remove unneeded function and variable
declarations. With all that your patch is looking like below. You can
try latest series here: https://github.com/norov/linux/tree/ilp32-4.8

It's based on v4.8, and addresses some comments. I'm going to meld
this patch with current patchset as it basicly the bugfux and update
submission when I'll finish with all comments.

Yury.
