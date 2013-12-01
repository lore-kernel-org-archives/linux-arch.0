From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: Re: Re: Re: [PATCH -tip v3 00/23] kprobes: introduce
	NOKPROBE_SYMBOL() and general cleaning of kprobe blacklist
Date: Sun, 01 Dec 2013 11:16:34 +0900
Message-ID: <529A9C02.4090909@hitachi.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<y0mvbznxi6k.fsf@fche.csb> <20131120153801.GA9743@gmail.com>
	<20131120173600.GK8993@redhat.com> <528D6C9F.8050809@hitachi.com>
	<20131121072938.GA16912@gmail.com> <528EC2FF.30301@hitachi.com>
	<528F4406.3090309@hitachi.com> <20131127133045.GC18422@gmail.com>
	<52971E66.9080006@hitachi.com> <20131130134618.GA18768@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131130134618.GA18768@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, "Frank Ch. Eigler" <fche@redhat.com>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

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
