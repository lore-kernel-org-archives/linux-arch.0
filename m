From: Jovi Zhangwei <jovi.zhangwei@gmail.com>
Subject: Re: [PATCH -tip v6 06/22] [BUGFIX] x86: Prohibit probing on memcpy/memset
Date: Thu, 19 Dec 2013 17:37:25 +0800
Message-ID: <CAGdX0WFKYHqXrVQ6LBw0YgH_H6cP=LZVCBe1iOvEXsHQPD8Zmg@mail.gmail.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal>	<20131219090409.14309.25677.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <systemtap-return-21826-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
In-Reply-To: <20131219090409.14309.25677.stgit@kbuild-fedora.novalocal>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Hi Masami,

On Thu, Dec 19, 2013 at 5:04 PM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> memcpy/memset functions are fundamental functions and
> those are involved in kprobe's exception handling.
> Prohibit probing on them to avoid kernel crash.
>
Would you please let me know the LKML link of that bugfix, I cannot
find it in my LKML fold.

No objection on this patch. :) just want to know more, It seems there
have no problem to probe memcpy in my box, maybe I didn't hit the
crash code path.

Thanks.

Jovi
