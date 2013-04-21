From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: Using __int128 on 64-bit architectures
Date: Sun, 21 Apr 2013 21:51:20 +1200
Message-ID: <20130421095120.GA6508@omega>
References: <51464C00.5090107@zytor.com>
 <alpine.LFD.2.03.1304210450490.17443@linux-mips.org>
 <20130421193531.43965f592f00dfd6e3cfcf45@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130421193531.43965f592f00dfd6e3cfcf45@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 21, 2013 at 07:35:31PM +1000, Stephen Rothwell wrote:
> On Sun, 21 Apr 2013 05:29:28 +0100 (BST) "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> >
> >  Hmm, nobody has replied, so just FYI such widening multiplication is 
> > available in all 64-bit MIPS hardware and GCC has supported it since 4.4 
> > or mid 2008 (older versions used a libgcc __multi3 helper, not quite so 
> > efficient as you can imagine).
> 
> i.e. for gcc 4.6.3, 64 bit powerpc calls out to __multi3
> 
> The same is true for sparc64.

Likewise, with gcc-4.6.3, alpha calls out to __multi3.

Cheers
Michael.
