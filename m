From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Date: Tue, 30 Oct 2018 01:38:52 +0800
Message-ID: <20181029173852.GB3532@guoren-Inspiron-7460>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, peterz@infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 29, 2018 at 11:54:26AM -0500, Rob Herring wrote:
> On Fri, Oct 26, 2018 at 11:09 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:
> >
> >   Linux 4.19 (2018-10-22 07:37:37 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/c-sky/csky-linux.git tags/csky-for-linus-4.20
> >
> > for you to fetch changes up to 2347e7e1aea410865e3c3f92014b07ff7d4c5b02:
> >
> >   dt-bindings: interrupt-controller: C-SKY APB intc (2018-10-26 00:54:31 +0800)
> >
> > ----------------------------------------------------------------
> > This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> > Release, which has been through 10 rounds of review on mailing list.
> >
> > We almost got the Acked-by/Reviewed-by of all patches except "Process
> > management and Signal", but all've been tested.
> 
> I just noticed a couple of build related issues. First, you agreed to
> remove the built-in dtb part way back on v1[1], but that's still
> there. Please remove it. As Arnd mentioned that is for legacy use and
> we shouldn't be adding that for new arches.
> 
> Second, the dtb build infrastructure was re-worked for 4.20. See
> commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build
> rules"). You'll need similar changes for c-sky as other arches. It's
> mostly deleting lines.
Ok, I'll give an another patch include deleting built-in dtb and
deleting lines in Makefile for 4.20 dtb build infrastructure. 

> Rob
> 
> [1] https://lkml.org/lkml/2018/3/21/332
