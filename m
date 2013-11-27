From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Re: Re: [PATCH -tip v3 00/23] kprobes: introduce
	NOKPROBE_SYMBOL() and general cleaning of kprobe blacklist
Date: Wed, 27 Nov 2013 14:30:45 +0100
Message-ID: <20131127133045.GC18422@gmail.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<y0mvbznxi6k.fsf@fche.csb> <20131120153801.GA9743@gmail.com>
	<20131120173600.GK8993@redhat.com> <528D6C9F.8050809@hitachi.com>
	<20131121072938.GA16912@gmail.com> <528EC2FF.30301@hitachi.com>
	<528F4406.3090309@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <528F4406.3090309@hitachi.com>
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
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, "Frank Ch. Eigler" <fche@redhat.com>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> (2013/11/22 11:35), Masami Hiramatsu wrote:
> > (2013/11/21 16:29), Ingo Molnar wrote:
> >>
> >> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> >>
> >>> (2013/11/21 2:36), Frank Ch. Eigler wrote:
> >>
> >> [ ... ]
> >>>> one needs to resort to something like:
> >>>>
> >>>> # cat /proc/kallsyms | grep ' [tT] ' | while read addr type symbol; do
> >>>>    perf probe $symbol
> >>>> done
> >>>>
> >>>> then wait for a few hours for that to finish. Then, or while the loop
> >>>> is still running, run
> >>>>
> >>>> # perf record -e 'probe:*' -aR sleep 1
> >>>>
> >>>> to take a kernel down.
> >>>
> >>> Um, indeed, current blacklist is not perfect. [...]
> >>
> >> Then it needs to be fixed ASAP!
> > 
> > OK, I see. At least the two patches included this series
> > should be fixed. :)
> > 
> > And more, I need to test all symbols and drills down.
> 
> OK, what I've found was;
>  - The functions which can be ftraced look good.
>    (see tracing/available_filter_functions)
>  - following functions should not be able to be probed.
>    - memcpy, memset
>    - native_load_sp0 and some other native functions (need to be clear)
>    - restore
>    - trace_graph_return
>    - trace_hardirqs_off_thunk, trace_hardirqs_on_thunk
>    - This list still be not perfect. I just enabled/disabled kprobes
>      one by one. There might be combined bugs (combination of several
>      kprobes).
>  - Some of them are hard to specify by NOKPROBE_SYMBOL because they are
>    defined in assembly file.
> 
> Anyway, to fix all of them, I think we need file-based blacklist
> especially for assembler symbols.

assembler symbols shouldn't be particular hard either, just put them 
into the noprobes section.

> For example, we can get all text symbols by below command;
>  nm some-file.o | grep -i " t " | cut -f3 -d" "
> so that we can make a blacklisted-symbol list for the file.
> I need to look the Kbuild for how I can do that in Makefile.

I think it's generally better to add explicit annotations to the code.

Thanks,

	Ingo
