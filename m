From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip RFC v2 01/22] kprobes: Prohibit probing on
	.entry.text code
Date: Fri, 15 Nov 2013 11:43:06 -0500
Message-ID: <20131115114306.5d14db66@gandalf.local.home>
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
	<20131115045318.27580.69554.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131115045318.27580.69554.stgit@kbuild-fedora.novalocal>
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
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David
	S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 15 Nov 2013 04:53:18 +0000
Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> .entry.text is a code area which is used for interrupt/syscall
> entries, and there are many sensitive codes.
> Thus, it is better to prohibit probing on all of such codes
> instead of a part of that.
> Since some symbols are already registered on kprobe blacklist,
> this also removes them from the blacklist.

This change only works with x86. On other archs, I get this:

kernel/built-in.o: In function `register_kprobe':
(.kprobes.text+0x9f4): undefined reference to `__entry_text_start'
kernel/built-in.o: In function `register_kprobe':
(.kprobes.text+0x9f8): undefined reference to `__entry_text_end'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

-- Steve
