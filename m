From: David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] User API Disintegrate: Preparatory patches
Date: Thu, 04 Oct 2012 18:36:46 +0100
Message-ID: <29855.1349372206@warthog.procyon.org.uk>
References: <CAMuHMdUx6he0MdL5etO6pDrMgd=JZWsf1TZj5WevjSpFANCWRA@mail.gmail.com> <18137.1349203013@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUx6he0MdL5etO6pDrMgd=JZWsf1TZj5WevjSpFANCWRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, torvalds@osdl.org, arnd@arndb.de, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> >  include/linux/libfdt.h                           |  4 +-
> 
> So what happened here?
> 
>  -#include "../../scripts/dtc/libfdt/fdt.h"
> -#include "../../scripts/dtc/libfdt/libfdt.h"
> +#include <>
> +#include <>

I didn't expect 'system' header files to be outside of include/ or
arch/*/include/, so the bit of perl I had to turn this into <...> quietly
malfunctioned when it stripped too much off of the front.

Out of interest, why aren't these in include/?  The normal way seems to be to
point the tool build at the kernel headers, not the kernel build at the script
headers.

David
