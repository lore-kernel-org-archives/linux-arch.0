From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH -tip v6 06/22] [BUGFIX] x86: Prohibit probing on memcpy/memset
Date: Fri, 20 Dec 2013 11:37:49 +0900
Message-ID: <52B3AD7D.2020104@hitachi.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal> <20131219090409.14309.25677.stgit@kbuild-fedora.novalocal> <CAGdX0WFKYHqXrVQ6LBw0YgH_H6cP=LZVCBe1iOvEXsHQPD8Zmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:47000 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab3LTCh5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Dec 2013 21:37:57 -0500
In-Reply-To: <CAGdX0WFKYHqXrVQ6LBw0YgH_H6cP=LZVCBe1iOvEXsHQPD8Zmg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jovi Zhangwei <jovi.zhangwei@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>

Hi Jovi,

(2013/12/19 18:37), Jovi Zhangwei wrote:
> Hi Masami,
> 
> On Thu, Dec 19, 2013 at 5:04 PM, Masami Hiramatsu
> <masami.hiramatsu.pt@hitachi.com> wrote:
>> memcpy/memset functions are fundamental functions and
>> those are involved in kprobe's exception handling.
>> Prohibit probing on them to avoid kernel crash.
>>
> Would you please let me know the LKML link of that bugfix, I cannot
> find it in my LKML fold.

Yeah, that was found in my testing environment.

> No objection on this patch. :) just want to know more, It seems there
> have no problem to probe memcpy in my box, maybe I didn't hit the
> crash code path.

Ah, I see. Originally the problem happened when I put a probe on
__memcpy. And it looks the instances of memcpy and __memcpy are
same on x86-64. Thus I decided to blacklist both. (memset/__memset too)
Have you ever tried to probe __memcpy on your box?

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
