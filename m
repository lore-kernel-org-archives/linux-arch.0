From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] arm: add __initbss section attribute
Date: Tue, 13 Oct 2015 13:28:18 +0200
Message-ID: <5171473.bOz59Zi81c__42333.6262502291$1444735797$gmane$org@wuerfel>
References: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com> <5369261.8uuGVmeUFP@wuerfel> <8004E8C3-F1EC-45C3-A995-88726B257563@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58905 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbJML3i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Oct 2015 07:29:38 -0400
In-Reply-To: <8004E8C3-F1EC-45C3-A995-88726B257563@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Victor Kamensky <victor.kamensky@linaro.org>, Mark Salter <msalter@redhat.com>, vladimir.murzin@arm.com, ggdavisiv@gmail.com, paul.gortmaker@windriver.com, mingo@kernel.org, rusty@rustcorp.com.au, mcgrof@suse.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com, aarcange@redhat.com, mhocko@suse.com, jack@suse.cz, iamjoonsoo.kim@lge.com, xiexiuqi@huawei.com, vbabka@suse.cz, Vineet.Gupta1@synopsys.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org

On Tuesday 13 October 2015 17:51:32 yalin wang wrote:

> > 32	__earlycon_table_sentinel
> > 200	__earlycon_of_table_sentinel
> > 6	__irf_end
> > 
> > 
> > 26398 total
> i am curious about your scripts ,
> could you show me ?

I was using some ad-hoc command line tricks, including

objcopy  -j .init.data  build/multi_v7_defconfig/vmlinux   /tmp/initdata
nm initdata  | sort -n | { read start b sym ; while read a b c ; do objdump -Dr --start-address=0x$start --stop-address=0x$a initdata > initdata.d/$sym  ; start=$a ; sym=$c  ; done }
(some manual sorting to delete the files that have pre-initialized symbols)
sum=0 ; nm /tmp/initdata  | sort -n | { read start b sym ; while read a b c ; do test -e ../$sym  && { echo $[0x$a - 0x$start]\      $sym  ; sum=$[$sum + $[0x$a - 0x$start]] ; } ; start=$a ; sym=$c ; done ; echo $sum;}

I'm sure there are better ways to do this, and the manual step I used at
first was faulty.

	Arnd
