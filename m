From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] Revert "perf tools: Allow to specify custom linker
 command"
Date: Mon, 13 Jul 2015 23:24:06 +0300
Message-ID: <20150713202406.GB5020@blackmetal.musicnaut.iki.fi>
References: <1436785853-4260-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436785853-4260-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Jiri Olsa <jolsa@kernel.org>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Mon, Jul 13, 2015 at 02:10:53PM +0300, Alexey Brodkin wrote:
> This reverts commit 5ef7bbb09f7b
> ("perf tools: Allow to specify custom linker command").
> 
> LD is a pre-defined variable in GNU Make. I.e. it is always defined.
> Which means there's no point to check "LD ?= ..." because it will never
> succeed. And so LD will be either that explicitly passed to make like
> this:
>  ------->8-------
>  make LD=path_to_my_ld ...
>  ------->8-------
>  or default value, which is host's "ld".
> 
> Latter leads to failure of cross-linkage because instead of cross linker
> "$(CROSS_COMPILE)ld" host's "ld" is used.
> 
> As for commit which is reverted here:
>  [1] Usually for selection of non-default flavour of CPU core/options
>      linker flags are used like "-mtune=xxx" or "-mMyCPUType" etc.
> 
>  [2] Still to implement ability to use "ld" that differs from
>     "$(CROSS_COMPILE)ld" one will need to add new makefile variable like
>     TARGET_LD and then check if $(TARGET_LD) is not specified on make
>     invocation then use "$(CROSS_COMPILE)ld".
> 
> But for now to fix cross-building of perf this revert is enough.

Hmm. You are probably right, my build system always exports LD with
correct linker for cross builds so perhaps that's why I this "worked"
for me when testing. Sorry.

I guess the correct fix would be [1], i.e. there should be some new
variable to pass flags to ld command.

Or maybe [2], could we use make "origin" function? If LD is "default",
then use "$(CROSS_COMPILE)ld", otherwise use what the user passed?

A.
