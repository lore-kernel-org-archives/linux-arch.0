From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to
 apply GCC -Og optimization
Date: Sun, 6 May 2018 07:57:26 +0800
Message-ID: <20180505235725.hglh6u77spw55qa5@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-5-git-send-email-changbin.du@intel.com>
 <20180502101707.206984e9@gandalf.local.home>
 <20180502134558.1f388e097dcde6f589635404@linux-foundation.org>
 <20180502211956.6c9e8d7b@vmware.local.home>
 <20180503134546.5p3z4g5na7ew4fun@intel.com>
 <20180503102823.5b54cd56@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503102823.5b54cd56@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, Andrew Morton <akpm@linux-foundation.org>, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 03, 2018 at 10:28:23AM -0400, Steven Rostedt wrote:
> On Thu, 3 May 2018 21:45:46 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
> 
> > > With that gcc comment, I still think CONFIG_OPTIMIZE_DEBUG is more
> > > inline with what it is and understandable than
> > > CONFIG_DEBUG_EXPERIENCE. The "OPTIMIZE" is the key word there.
> > > 
> > > -- Steve  
> > What about CONFIG_CC_OPTIMIZE_FOR_DEBUGGING? We alreay have
> > CONFIG_CC_OPTIMIZE_FOR_SIZE and CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE.
> 
> Yes I like that much better.
> 
> > 
> > And do we need to move it to existing configuration menu "General setup->
> > Compiler optimization level"? But I also want it appear in "kernel hacking"
> > since this is a debug option.
> 
> I understand why you would want it by debugging, but I think it does
> make more sense to be included with the above two other options, as
> they are all mutually exclusive.
> 
> This brings up the topic of creating config paradigms. That is, a way
> of saying "I want a debug kernel" and select one option that selects
> everything you would expect. Or perhaps we should have a:
> 
>  make debug_config
> 
Agree, I accomplish this by running script scripts/kconfig/merge_config.sh.

> that does it.
> 
> But that's a different topic. For now, I would just included it in
> init/Kconfig, and not worry about it not showing up in kernel hacking.
> 
> 
> -- Steve

-- 
Thanks,
Changbin Du
