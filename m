From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] asm-generic/io.h: remove unnecessary #include of
 <linux/vmalloc.h>
Date: Tue, 9 May 2017 15:40:56 +0200
Message-ID: <20170509134056.GM6481@dhcp22.suse.cz>
References: <20170509085045.7342-1-tklauser@distanz.ch>
 <20170509090207.GE6481@dhcp22.suse.cz>
 <20170509131620.GH10395@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170509131620.GH10395@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>
List-Id: linux-arch.vger.kernel.org

On Tue 09-05-17 15:16:20, Tobias Klauser wrote:
> On 2017-05-09 at 11:02:07 +0200, Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 09-05-17 10:50:45, Tobias Klauser wrote:
> > > After commit 1f5307b1e094 ("mm, vmalloc: properly track vmalloc users")
> > > the build for ARCH=nios2 fails with:
> > > 
> > > In file included from ./include/asm-generic/io.h:767:0,
> > >   		 from ./arch/nios2/include/asm/io.h:61,
> > > 		 from ./include/linux/io.h:25,
> > > 		 from ./arch/nios2/include/asm/pgtable.h:18,
> > > 		 from ./include/linux/mm.h:70,
> > > 		 from ./include/linux/pid_namespace.h:6,
> > > 		 from ./include/linux/ptrace.h:9,
> > > 		 from ./arch/nios2/include/uapi/asm/elf.h:23,
> > > 		 from ./arch/nios2/include/asm/elf.h:22,
> > > 		 from ./include/linux/elf.h:4,
> > > 		 from ./include/linux/module.h:15,
> > > 		 from init/main.c:16:
> > > ./include/linux/vmalloc.h: In function '__vmalloc_node_flags':
> > > ./include/linux/vmalloc.h:99:40: error: 'PAGE_KERNEL' undeclared (first use in this function); did you mean 'GFP_KERNEL'?
> > > 
> > > which is due to the newly added #include <asm/pgtable.h>, which on nios2
> > > includes <linux/io.h> and thus <asm/io.h> and <asm-generic/io.h> which
> > > again includes <linux/vmalloc.h>.
> > > 
> > > It turns out the #include <linux/vmalloc.h> in <asm-generic/io.h> isn't
> > > necessary at all since none of it definitions are used there, so remove
> > > it alltogether.
> > 
> > Thanks for your fix but I have already posted a different one [1] which
> > doesn't include pgtable.h because this turned out to be a problem on
> > m68k already. I am just waiting for Andrew to drop the previous patch
> > and replace it with the one pointed out.
> > 
> > [1] http://lkml.kernel.org/r/20170503063750.GC1236@dhcp22.suse.cz
> 
> Thanks for the info. Though it looks like your original patch already
> made it into Linus' tree as commit 1f5307b1e094.

Ups! I though Andrew would leave it for later as it had compilation
issues.
 
> As for my patch, please disregard - it lead to several build regressions
> with the kernel build bot.

Yeah, I've learned that as well, so I've rather came with a different
solution. I will poke Andrew to marge a fix ASAP.
-- 
Michal Hocko
SUSE Labs
