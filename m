From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] Revert "perf tools: Allow to specify custom linker
 command"
Date: Tue, 14 Jul 2015 14:00:05 +0000
Message-ID: <1436882404.2839.28.camel@synopsys.com>
References: <1436785853-4260-1-git-send-email-abrodkin@synopsys.com>
	 <20150713202406.GB5020@blackmetal.musicnaut.iki.fi>
	 <20150714134623.GH2885@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:47552 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbGNOAL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 10:00:11 -0400
In-Reply-To: <20150714134623.GH2885@kernel.org>
Content-Language: en-US
Content-ID: <0D89A179EDE3B74E8190ADDC10578904@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "acme@kernel.org" <acme@kernel.org>
Cc: "aaro.koskinen@nokia.com" <aaro.koskinen@nokia.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "paulus@samba.org" <paulus@samba.org>, "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Arnaldo,

On Tue, 2015-07-14 at 10:46 -0300, Arnaldo Carvalho de Melo wrote:
+AD4- Em Mon, Jul 13, 2015 at 11:24:06PM +-0300, Aaro Koskinen escreveu:
+AD4- +AD4- Hi,
+AD4- +AD4- 
+AD4- +AD4- On Mon, Jul 13, 2015 at 02:10:53PM +-0300, Alexey Brodkin wrote:
+AD4- +AD4- +AD4- This reverts commit 5ef7bbb09f7b
+AD4- +AD4- +AD4- (+ACI-perf tools: Allow to specify custom linker command+ACI-).
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- LD is a pre-defined variable in GNU Make. I.e. it is always defined.
+AD4- +AD4- +AD4- Which means there's no point to check +ACI-LD ?+AD0- ...+ACI- because it will never
+AD4- +AD4- +AD4- succeed. And so LD will be either that explicitly passed to make like
+AD4- +AD4- +AD4- this:
+AD4- +AD4- +AD4-  -------+AD4-8-------
+AD4- +AD4- +AD4-  make LD+AD0-path+AF8-to+AF8-my+AF8-ld ...
+AD4- +AD4- +AD4-  -------+AD4-8-------
+AD4- +AD4- +AD4-  or default value, which is host's +ACI-ld+ACI-.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Latter leads to failure of cross-linkage because instead of cross linker
+AD4- +AD4- +AD4- +ACIAJA-(CROSS+AF8-COMPILE)ld+ACI- host's +ACI-ld+ACI- is used.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- As for commit which is reverted here:
+AD4- +AD4- +AD4-  +AFs-1+AF0- Usually for selection of non-default flavour of CPU core/options
+AD4- +AD4- +AD4-      linker flags are used like +ACI--mtune+AD0-xxx+ACI- or +ACI--mMyCPUType+ACI- etc.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4-  +AFs-2+AF0- Still to implement ability to use +ACI-ld+ACI- that differs from
+AD4- +AD4- +AD4-     +ACIAJA-(CROSS+AF8-COMPILE)ld+ACI- one will need to add new makefile variable like
+AD4- +AD4- +AD4-     TARGET+AF8-LD and then check if +ACQ-(TARGET+AF8-LD) is not specified on make
+AD4- +AD4- +AD4-     invocation then use +ACIAJA-(CROSS+AF8-COMPILE)ld+ACI-.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- But for now to fix cross-building of perf this revert is enough.
+AD4- +AD4- 
+AD4- +AD4- Hmm. You are probably right, my build system always exports LD with
+AD4- +AD4- correct linker for cross builds so perhaps that's why I this +ACI-worked+ACI-
+AD4- +AD4- for me when testing. Sorry.
+AD4- 
+AD4- So, I think this is an +ACI-Acked-by: Aaro Koskinen +ADw-aaro.koskinen+AEA-iki.fi+AD4AIg-
+AD4- for the revert, right?
+AD4-  
+AD4- +AD4- I guess the correct fix would be +AFs-1+AF0-, i.e. there should be some new
+AD4- +AD4- variable to pass flags to ld command.
+AD4- +AD4- 
+AD4- +AD4- Or maybe +AFs-2+AF0-, could we use make +ACI-origin+ACI- function? If LD is +ACI-default+ACI-,
+AD4- +AD4- then use +ACIAJA-(CROSS+AF8-COMPILE)ld+ACI-, otherwise use what the user passed?
+AD4- 
+AD4- When you guys get to some conclusion, please submit a new patch, for now
+AD4- I am taking the revert with the (implied) Acked-by Aaro, ok?

Please find my patch that both reverts initial Aaro's patch and implements
proper handling of CC, AR and LD substitution here - https://lkml.org/lkml/2015/7/14/149

-Alexey