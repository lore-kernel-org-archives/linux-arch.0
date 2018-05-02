From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to
 apply GCC -Og optimization
Date: Wed, 2 May 2018 13:45:58 -0700
Message-ID: <20180502134558.1f388e097dcde6f589635404@linux-foundation.org>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
        <1525268700-10631-5-git-send-email-changbin.du@intel.com>
        <20180502101707.206984e9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502101707.206984e9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2 May 2018 10:17:07 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> > Comparison of vmlinux size: a bit smaller.
> > 
> >     w/o CONFIG_DEBUG_EXPERIENCE
> 
> I hate the config name.
> 
> I probably can't come up with better ones but let's try:
> 
>  CONFIG_DEBUG_OPTIMIZE ?
>  CONFIG_OPTIMIZE_DEBUG ?
> 
> But "EXPERIENCE" sounds like I'm on some DEBUG LSD.

Metoo, but the gcc people decided on "-Og: Optimize debugging
experience ..." and I think there are benefits if the kernel is to
align the naming with that.
