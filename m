From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to
 apply GCC -Og optimization
Date: Thu, 3 May 2018 21:45:46 +0800
Message-ID: <20180503134546.5p3z4g5na7ew4fun@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-5-git-send-email-changbin.du@intel.com>
 <20180502101707.206984e9@gandalf.local.home>
 <20180502134558.1f388e097dcde6f589635404@linux-foundation.org>
 <20180502211956.6c9e8d7b@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502211956.6c9e8d7b@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 02, 2018 at 09:19:56PM -0400, Steven Rostedt wrote:
> On Wed, 2 May 2018 13:45:58 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Wed, 2 May 2018 10:17:07 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > > Comparison of vmlinux size: a bit smaller.
> > > > 
> > > >     w/o CONFIG_DEBUG_EXPERIENCE  
> > > 
> > > I hate the config name.
> > > 
> > > I probably can't come up with better ones but let's try:
> > > 
> > >  CONFIG_DEBUG_OPTIMIZE ?
> > >  CONFIG_OPTIMIZE_DEBUG ?
> > > 
> > > But "EXPERIENCE" sounds like I'm on some DEBUG LSD.  
> > 
> > Metoo, but the gcc people decided on "-Og: Optimize debugging
> > experience ..." and I think there are benefits if the kernel is to
> > align the naming with that.
> 
> I still see that as "Optimize debugging" and "experience" is just the
> platform of what was done.
> 
> With that gcc comment, I still think CONFIG_OPTIMIZE_DEBUG is more
> inline with what it is and understandable than
> CONFIG_DEBUG_EXPERIENCE. The "OPTIMIZE" is the key word there.
> 
> -- Steve
What about CONFIG_CC_OPTIMIZE_FOR_DEBUGGING? We alreay have
CONFIG_CC_OPTIMIZE_FOR_SIZE and CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE.

And do we need to move it to existing configuration menu "General setup->
Compiler optimization level"? But I also want it appear in "kernel hacking"
since this is a debug option.

-- 
Thanks,
Changbin Du
