From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v1 0/7] tools: add linker table userspace sandbox
Date: Tue, 23 Aug 2016 17:49:06 +0200
Message-ID: <20160823154906.GY3296@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
 <CAOMGZ=G2wVYxbg9Jerkuq0HdoB3W5SwZdiKM2zNz5EXfVYR2jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMGZ=G2wVYxbg9Jerkuq0HdoB3W5SwZdiKM2zNz5EXfVYR2jQ@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-arch@vger.kernel.org, kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 22, 2016 at 11:59:46AM +0200, Vegard Nossum wrote:
> On 19 August 2016 at 23:41,  <mcgrof@kernel.org> wrote:
> > From: "Luis R. Rodriguez" <mcgrof@kernel.org>
> >
> > The original v3 series for linker tables made reference only to
> > an external repository userspace sandbox application, however
> > Boris noted it'd be difficult ot keep this in sync with the
> > kernel so advised to consider integrate with the kernel. I've
> > taken steps in this direction.
> [...]
> > Please let me know if there are any issue or questions.
> 
> +#define __VMLINUX_SYMBOL(x) x
> 
> +#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
> 
> +#define LINUX_SECTION_START(name)      VMLINUX_SYMBOL(name)
> 
> +#define DECLARE_LINUX_SECTION(type, name)                              \
> +        extern type VMLINUX_SYMBOL(name)[], \
> +                    VMLINUX_SYMBOL(name##__end)[]
> 
> +#define DECLARE_LINKTABLE(type, name)                                  \
> +       DECLARE_LINUX_SECTION(type, name)
> 
> +#define LINKTABLE_FOR_EACH(pointer, tbl)                               \
> +       for (pointer = LINUX_SECTION_START(tbl);                        \
> +            pointer < LINUX_SECTION_END(tbl);                          \
> +            pointer++)
> 
> I think this is subject to getting optimised out by newer gccs, since
> it sees the START(tbl) and END(tbl) symbols as two completely
> different arrays. See the short discussion here:
> 
> https://lkml.org/lkml/2016/6/26/73 (the first attempt is wrong, so
> don't look at that)
> 
> It is possible that < is different from != and always does the right
> thing, but I haven't checked.
> 
> I have a WIP branch that converts most of the existing tables in the
> kernel to use the external_array() macro which makes gcc throw away
> any knowledge it had about a pointer being part of an array.

Was there no compiler option to disable the optimization ?

Please do Cc me on your patches, either way we can coordinate changes depending
on which series gets merged. If your external_array() change lands upstream
first I'll see it on linux-next shortly can rebase and adjust code then as
that is what I base my patches on.

Do we know if there exceptions to the optimization issue for this and if so what
patterns follow ? We can test with simple userspace code if this will be an 
issue with gcc 7 by trying the demo in tools/linker-tables/ using this git tree
and branch 20160819-linker-table-v4 :

https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160819-linker-table-v4

  Luis
