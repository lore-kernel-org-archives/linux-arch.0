Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:3751 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbYEULzg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 May 2008 07:55:36 -0400
Date: Wed, 21 May 2008 13:44:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: -ffreestanding or not -ffreestanding
In-Reply-To: <20080521075233.GA18352@cs181133002.pp.htv.fi>
Message-ID: <Pine.LNX.4.64.0805211326080.19545@localhost.localdomain>
References: <E1JycsB-0000M9-36@ZenIV.linux.org.uk> <20080521075233.GA18352@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@linux-foundation.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080521114406.oT2Uxd4idJmEeeA0yUr8gsWiJYgDuW1lwfOhpQXZG4U@z>

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
