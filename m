From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Thu, 6 Sep 2018 21:19:22 +0200
Message-ID: <20180906191922.GB4816@worktop.programming.kicks-ass.net>
References: <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
 <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
 <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
 <20180906183157.GK24106@hirez.programming.kicks-ass.net>
 <9F76711C-393C-4F8D-B460-26D400458690@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9F76711C-393C-4F8D-B460-26D400458690@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 06:38:30PM +0000, Nadav Amit wrote:
> Note that patch 1/6 is still needed to fix false lockdep shoutouts due to a
> recent patch.

For some reason I do not appear to have 1/6 in my inbox. Let me dig
through lkml.
