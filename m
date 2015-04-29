From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 00/17] Re-introduce h8300 architecture
Date: Wed, 29 Apr 2015 10:07:45 -0700
Message-ID: <20150429170745.GA15041@roeck-us.net>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
 <20150428132210.GA7499@roeck-us.net>
 <87pp6oi2qy.wl-ysato@users.sourceforge.jp>
 <55405F08.7020508@roeck-us.net>
 <87lhhbihcf.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lhhbihcf.wl-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 29, 2015 at 03:22:40PM +0900, Yoshinori Sato wrote:
[ ... ]
> 
> OK.
> I made h8300-*-linux target patch for release version.
> Please apply and rebuild to "h8300-unknown-linux"
> http://sourceforge.jp/projects/uclinux-h8/releases/p14625
> 
> My toolchain configure options bellow
> * binutils
> ../configure --prefix=/home/ysato/h8-linux --target=h8300-unknown-linux
> 
> * gcc
> ../configure --target=h8300-unknown-linux --prefix=/home/ysato/h8-linux \
> --disable-ssp --disable-libssp --disable-mpc --disable-gmp --disable-mpfr \
> --disable-threads --disable-shared --disable-libmudflap --disable-libgomp \
> --disable-zlib --disable-libquadmath --without-libc --disable-libatomic \
> --enable-languages=c
> 
Compilation passes with those patches - thanks a lot!

I get lots of warnings if I compile with C=1. Might be worthwhile looking at
those. It might also be a good idea to provide the functions found missing
when building "make allyesconfig".

Thanks,
Guenter
