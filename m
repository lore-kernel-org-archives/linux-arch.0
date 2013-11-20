From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and
	general cleaning of kprobe blacklist
Date: Wed, 20 Nov 2013 16:38:01 +0100
Message-ID: <20131120153801.GA9743@gmail.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<y0mvbznxi6k.fsf@fche.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <y0mvbznxi6k.fsf@fche.csb>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org


* Frank Ch. Eigler <fche@redhat.com> wrote:

> masami.hiramatsu.pt wrote:
> 
> > [...]  This series also includes a change which prohibits probing 
> > on the address in .entry.text because the code is used for very 
> > low-level sensitive interrupt/syscall entries. Probing such code 
> > may cause unexpected result (actually most of that area is already 
> > in the kprobe blacklist).  So I've decide to prohibit probing all 
> > of them. [...]
> 
> Does this new blacklist cover enough that the kernel now survives a 
> broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?

That's generally the purpose of the annotations - if it doesn't then 
that's a bug.

Thanks,

	Ingo
