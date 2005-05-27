Return-Path: <linux-arch-owner@vger.kernel.org>
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
Date: Fri, 27 May 2005 03:06:09 +0200
References: <20050527003843.433BA1AEE88@zion.home.lan>
In-Reply-To: <20050527003843.433BA1AEE88@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270306.09425.blaisorblade@yahoo.it>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org, dhowells@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:
> After porting this fixlet to UML:
>
> http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ
>
> , I've also added a warning which should refuse compilation with insane
> values for PREEMPT_ACTIVE... maybe we should simply move PREEMPT_ACTIVE out
> of architectures using GENERIC_IRQS.
Ok, a grep shows that possible culprits (i.e. giving success to
grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTIVE, 
as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a first 
glance): frv, sh, sh64.

After a bit of checking, I also verified if they had overriden the value of 
HARDIRQ_BITS. Which they haven't (it seems it's defined exactly where 
CONFIG_HARDIRQS is not used, i.e. nobody is using the ability to override it 
currently).

This was not a very deep investigation, however, so feel free to verify this 
better.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
