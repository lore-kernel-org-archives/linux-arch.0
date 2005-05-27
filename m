Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200505270306.09425.blaisorblade@yahoo.it> 
References: <200505270306.09425.blaisorblade@yahoo.it>  <20050527003843.433BA1AEE88@zion.home.lan> 
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE 
Date: Fri, 27 May 2005 14:33:49 +0100
Message-ID: <14927.1117200829@redhat.com>
Sender: dhowells@redhat.com
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org
List-ID: <linux-arch.vger.kernel.org>

Blaisorblade <blaisorblade@yahoo.it> wrote:

> Ok, a grep shows that possible culprits (i.e. giving success to
> grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTIVE, 
> as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a first 
> glance): frv, sh, sh64.

For FRV that's simply because it got copied from the parent arch along with
other stuff. Feel free to move it... Do you want me to make you up a patch to
do so?

David
