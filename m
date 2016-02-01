From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 05/12] m68k: move exports to definitions
Date: Mon, 1 Feb 2016 14:53:55 +0000
Message-ID: <20160201145355.GK17997@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <1454095114-4128-5-git-send-email-viro@ZenIV.linux.org.uk>
 <CAMuHMdXTu9t9Jnd4F2X=U16X9psF-_oxj5Oxd6tz9wnK+BY2sQ@mail.gmail.com>
 <20160201121834.GJ17997@ZenIV.linux.org.uk>
 <CAMuHMdUUecCdGcK5FxL6e2FeD6-gyoWkbC_+RZzzb_mzHrcGyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUecCdGcK5FxL6e2FeD6-gyoWkbC_+RZzzb_mzHrcGyg@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 01, 2016 at 02:30:16PM +0100, Geert Uytterhoeven wrote:
> The kernel has all the *di3 variants:
> 
> 002eae2c T __ashldi3
> 002eae70 T __ashrdi3
> 002eaebc T __lshrdi3
> 002eaf00 T __muldi3
> 0038a6d0 R __ksymtab___ashldi3
> 0038a6d8 R __ksymtab___ashrdi3
> 0038ab68 R __ksymtab___lshrdi3
> 0038ab90 R __ksymtab___muldi3
> 003a8a5a r __kstrtab___ashldi3
> 003a8a64 r __kstrtab___ashrdi3
> 003a8a6e r __kstrtab___lshrdi3
> 003a8a78 r __kstrtab___muldi3
> 
> Hence the *si3 are missing:
> 
> __divsi3
> __modsi3
> __mulsi3
> __udivsi3
> __umodsi3

Does your .config have CPU_HAS_NO_MULDIV64?  Because otherwise these objects
won't be built and their exports had been conditional on that as well:

#if defined(CONFIG_CPU_HAS_NO_MULDIV64)
/*
 * Simpler 68k and ColdFire parts also need a few other gcc functions.
 */
extern long long __divsi3(long long, long long);
extern long long __modsi3(long long, long long);
extern long long __mulsi3(long long, long long);
extern long long __udivsi3(long long, long long);
extern long long __umodsi3(long long, long long);

EXPORT_SYMBOL(__divsi3);
EXPORT_SYMBOL(__modsi3);
EXPORT_SYMBOL(__mulsi3);
EXPORT_SYMBOL(__udivsi3);
EXPORT_SYMBOL(__umodsi3);
#endif

is what we have in mainline m68k_ksyms.c.  Neither allmodconfig, nor any of
defconfigs have it.  And on a coldfire build they are built and exported as
expected:
$ grep si3 ../build/coldfire/System.map 
002be860 T __divsi3
002be890 T __modsi3
002be8b8 T __mulsi3
002be8dc T __udivsi3
002be90c T __umodsi3
003ed960 R __ksymtab___divsi3
003edc80 R __ksymtab___modsi3
003edca8 R __ksymtab___mulsi3
003edff8 R __ksymtab___udivsi3
003ee000 R __ksymtab___umodsi3
003f7ba4 r __kcrctab___divsi3
003f7d34 r __kcrctab___modsi3
003f7d48 r __kcrctab___mulsi3
003f7ef0 r __kcrctab___udivsi3
003f7ef4 r __kcrctab___umodsi3
004144fe r __kstrtab___divsi3
00414507 r __kstrtab___modsi3
00414510 r __kstrtab___mulsi3
00414519 r __kstrtab___udivsi3
00414523 r __kstrtab___umodsi3
