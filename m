From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: -ffreestanding or not -ffreestanding
Date: Wed, 21 May 2008 13:44:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805211326080.19545@localhost.localdomain>
References: <E1JycsB-0000M9-36@ZenIV.linux.org.uk> <20080521075233.GA18352@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933021AbYEULqV@vger.kernel.org>
In-Reply-To: <20080521075233.GA18352@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@linux-foundation.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Wed, 21 May 2008, Adrian Bunk wrote:

> Can we try to get this sorted out properly instead of constantly 
> fiddling with it?
> 
> Currently we use -ffreestanding on some architectures and fix breakages 
> on the other architectures when they arise.

This won't help completely unless you also clean up all archs to use the 
same mappings to the builtin functions.

The main problem I had with -ffreestanding is that it's awkward to map a 
library function to the builtin function and also provide the fallback 
from lib/string.c.
If you look at asm-m68k/string.h I once tried this with the mem* functions 
and I still have the duplicated memcmp in arch/m68k/lib/string.c.
(You could argue that it would be easier to just remove the define for 
memcmp in this specific case, but I'm interested in the general case.)

bye, Roman
