From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Minimal linker script
Date: Sat, 09 May 2009 16:27:20 -0700
Message-ID: <4A061158.3010604@zytor.com>
References: <20090509080006.GA22617@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754587AbZEIX15@vger.kernel.org>
In-Reply-To: <20090509080006.GA22617@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Tim Abbott <tabbott@mit.edu>
List-Id: linux-arch.vger.kernel.org

Sam Ravnborg wrote:
>  *      . = START;
>  *      __init_begin = .;
>  *      HEAD_SECTION
>  *      INIT_TEXT_SECTION(PAGE_SIZE)
>  *      INIT_DATA_SECTION(...)
>  *      PERCPU(PAGE_SIZE)
>  *      __init_end = .;
>  *
>  *      _stext = .;
>  *      TEXT_SECTION = 0
>  *      _etext = .;
>  *
>  *      _sdata = .;
>  *      RO_DATA_SECTION(PAGE_SIZE)
>  *      RW_DATA_SECTION(...)
>  *      _edata = .;
>  *
>  *      EXCEPTION_TABLE(...)
>  *      NOTES
>  *
>  *      __bss_start = .;
>  *      BSS_SECTION(0, 0)
>  *      __bss_stop = .;
>  *      _end = .;
>  *
>  *
>  * [__init_begin, __init_end] is the init section that may be freed after init
>  * [_stext, _etext] is the text section
>  * [_sdata, _edata] is the data section
>  *
>  * Some of the included output section include their own set of constants.
>  * Examples are: [__initramfs_start, __initramfs_end] for initramfs and
>  *               [__nosave_begin, __nosave_end] for the nosave data
>  */
> 

It seems rather disturbing to me that different sections have different
start and end symbols.  I realize this is largely for historical
reasons, but if we used a single pattern (e.g. something like
__text_start, __text_end for the .text section) then at least in the
i386 case we could easily recognize those as relocatable symbols even if
they show up as absolute.

Furthermore, consistency is a good thing, even if it means a bigger
changeset.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
