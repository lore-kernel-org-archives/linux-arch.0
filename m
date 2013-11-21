From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -tip v3 18/23] x86/dumpstack: Use NOKPROBE_SYMBOL macro
	in dumpstack.c
Date: Thu, 21 Nov 2013 12:30:06 +0100
Message-ID: <20131121113006.GA27659@gmail.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<20131120042233.15296.31189.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20131120042233.15296.31189.stgit@kbuild-fedora.novalocal>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> Use NOKPROBE_SYMBOL macro for protecting functions
> from kprobes instead of __kprobes annotation in
> dumpstack.c.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/x86/kernel/dumpstack.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Btw., all these mechanic changes of the __kprobes annotation can be 
merged into a single patch. That will cut down on the size of the 
series substantially.

Thanks,

	Ingo
