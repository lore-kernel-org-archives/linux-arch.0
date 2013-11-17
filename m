Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:42202 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab3KQHVb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 17 Nov 2013 02:21:31 -0500
Message-ID: <52886E77.1000707@hitachi.com>
Date: Sun, 17 Nov 2013 16:21:27 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
Subject: Re: Re: [PATCH -tip RFC v2 01/22] kprobes: Prohibit probing on
 .entry.text code
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal> <20131115045318.27580.69554.stgit@kbuild-fedora.novalocal> <20131115114306.5d14db66@gandalf.local.home> <CAMuHMdXw+WGKiQuquQL7XOkbRLNOC_SPddY1irRGQwpvDHLMwA@mail.gmail.com>
In-Reply-To: <CAMuHMdXw+WGKiQuquQL7XOkbRLNOC_SPddY1irRGQwpvDHLMwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, the arch/x86 maintainers <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131117072127.LgGBhFeK1-qaoJRswGoxVf3v5poxzBu1EJ9qImCyCW0@z>

(2013/11/16 2:46), Geert Uytterhoeven wrote:
> On Fri, Nov 15, 2013 at 5:43 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Fri, 15 Nov 2013 04:53:18 +0000
>> Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
>>
>>> .entry.text is a code area which is used for interrupt/syscall
>>> entries, and there are many sensitive codes.
>>> Thus, it is better to prohibit probing on all of such codes
>>> instead of a part of that.
>>> Since some symbols are already registered on kprobe blacklist,
>>> this also removes them from the blacklist.
>>
>> This change only works with x86. On other archs, I get this:
>>
>> kernel/built-in.o: In function `register_kprobe':
>> (.kprobes.text+0x9f4): undefined reference to `__entry_text_start'
>> kernel/built-in.o: In function `register_kprobe':
>> (.kprobes.text+0x9f8): undefined reference to `__entry_text_end'
>> make[1]: *** [vmlinux] Error 1
>> make: *** [sub-make] Error 2
> 
> X86 is the sole architecture that has ENTRY_TEXT in its
> arch/*/kernel/vmlinux.lds.S.

Ah, thanks! I'll fix that.
BTW, should I add CONFIG_HAVE_ENTRY_TEXT for x86 and use it
or just use CONFIG_X86 to detect it?

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


