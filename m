Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253Ab2JDRhD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Oct 2012 13:37:03 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAMuHMdUx6he0MdL5etO6pDrMgd=JZWsf1TZj5WevjSpFANCWRA@mail.gmail.com>
References: <CAMuHMdUx6he0MdL5etO6pDrMgd=JZWsf1TZj5WevjSpFANCWRA@mail.gmail.com> <18137.1349203013@warthog.procyon.org.uk>
Subject: Re: [GIT PULL] User API Disintegrate: Preparatory patches
Date: Thu, 04 Oct 2012 18:36:46 +0100
Message-ID: <29855.1349372206@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, torvalds@osdl.org, arnd@arndb.de, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20121004173646.SCv251RxJZ9po4z3-0MbvN5QFEs2FIZ-RHnl_4UlXL0@z>

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
