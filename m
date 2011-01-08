From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] kbuild: asm-generic support
Date: Sat, 8 Jan 2011 15:03:47 +0100
Message-ID: <20110108140347.GA3928@merkur.ravnborg.org>
References: <20110108130302.GA21698@merkur.ravnborg.org> <20110108130427.GA25461@merkur.ravnborg.org> <20110109004539.5bf33510.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110109004539.5bf33510.sfr@canb.auug.org.au>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 09, 2011 at 12:45:39AM +1100, Stephen Rothwell wrote:
> Hi Sam,
> 
> On Sat, 8 Jan 2011 14:04:27 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > -LINUXINCLUDE    := -I$(srctree)/arch/$(hdr-arch)/include -Iinclude \
> > +LINUXINCLUDE    := -I$(srctree)/arch/$(hdr-arch)/include \
> > +                   -Iarch/$(hrd-arch)/include/generated -Iinclude \
>                                ^^^
> hdr-arch?
Good spotted.

I wonder how this slipped in?!?

If anyone try this - then please fix the misspelling.
I will repost patch later.

	Sam
