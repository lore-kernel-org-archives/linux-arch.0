Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:50138 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LACQi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 30 Nov 2013 21:16:38 -0500
Message-ID: <529A9C02.4090909@hitachi.com>
Date: Sun, 01 Dec 2013 11:16:34 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
Subject: Re: Re: Re: Re: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL()
 and general cleaning of kprobe blacklist
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> <y0mvbznxi6k.fsf@fche.csb> <20131120153801.GA9743@gmail.com> <20131120173600.GK8993@redhat.com> <528D6C9F.8050809@hitachi.com> <20131121072938.GA16912@gmail.com> <528EC2FF.30301@hitachi.com> <528F4406.3090309@hitachi.com> <20131127133045.GC18422@gmail.com> <52971E66.9080006@hitachi.com> <20131130134618.GA18768@gmail.com>
In-Reply-To: <20131130134618.GA18768@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131201021634.VhIUk3-_ro54hWFsNvf3kmUp3_577tuO8iBz1gLGCUU@z>

(2013/11/30 22:46), Ingo Molnar wrote:
>>>> Anyway, to fix all of them, I think we need file-based blacklist
>>>> especially for assembler symbols.
>>>
>>> assembler symbols shouldn't be particular hard either, just put them 
>>> into the noprobes section.
>>
>> Would you mean .kprobes.text? Hmm, I hope not to use it anymore, but 
>> yeah, bugfix is more important. Agreed.
> 
> No, why not put the symbol address into the 'blacklist' section, 
> within the asm file? We fill out exception table entries in .S files 
> as well, see the _ASM_EXTABLE() macro, it's possible to do all that. 

Oh! I got it. Thank you for the pointer! :)

> 
> It needs not a CPP macro but an assembly macro.

OK, I'll try that.

Thanks again,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


