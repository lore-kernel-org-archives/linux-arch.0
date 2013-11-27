From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [PATCH -tip v3 13/23] x86/trap: Use NOKPROBE_SYMBOL macro
	in trap.c
Date: Wed, 27 Nov 2013 10:38:12 +0900
Message-ID: <52954D04.8090101@hitachi.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<20131120042221.15296.85443.stgit@kbuild-fedora.novalocal>
	<20131122212119.GE19762@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131122212119.GE19762@tassilo.jf.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

(2013/11/23 6:21), Andi Kleen wrote:
> On Wed, Nov 20, 2013 at 04:22:21AM +0000, Masami Hiramatsu wrote:
>> Use NOKPROBE_SYMBOL macro to protect functions from kprobes
>> instead of __kprobes annotation in trap.c.
>> This also applies __always_inline annotation for some cases,
>> because NOKPROBE_SYMBOL() will inhibit inlining by referring
>> the symbol address.
> 
> NOKPROBE_SYMBOL seems to add a reference from some variable to the function?
> 
> With LTO we can optimize away unused functions, but not
> when there are references to the symbol. So this would likely
> prevent optimizations with LTO.

After considering this problem deeper, I decide to say NO against
to your opinion. IMHO, the LTO is just an optimization, on the other
hand, NOKPROBE_SYMBOL is more important because it is for avoiding
kernel crash. I mean, the safety and stability should be prior to
the performance. Anyway, such side-effect of NOKPROBE_SYMBOL looks
very limited. Perhaps, less than 1% of functions will be marked.
How much does it affect for the optimization?

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
