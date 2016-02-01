From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 05/12] m68k: move exports to definitions
Date: Mon, 1 Feb 2016 12:18:34 +0000
Message-ID: <20160201121834.GJ17997@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <1454095114-4128-5-git-send-email-viro@ZenIV.linux.org.uk>
 <CAMuHMdXTu9t9Jnd4F2X=U16X9psF-_oxj5Oxd6tz9wnK+BY2sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXTu9t9Jnd4F2X=U16X9psF-_oxj5Oxd6tz9wnK+BY2sQ@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 01, 2016 at 11:52:27AM +0100, Geert Uytterhoeven wrote:
> Hi Al,
> 
> On Fri, Jan 29, 2016 at 8:18 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > the rest of architectures should just use generic-y += export.h in
> > asm/Kbuild
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Looks good, and (some of, not all) the symbols end up in kstrtab, so
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Note that none of the m68k defconfigs build modules that refer to these
> symbols. This changes completely with allmodconfig, which adds lots of
> references in many of the same modules.
> CONFIG_LBDAF=y is set in the defconfigs.
> 
> Unfortunately I haven't managed to boot a kernel that uses these symbols
> in modules...

Details, please...  Which symbols are missing?
