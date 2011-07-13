From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET x86/mm] memblock, x86: Allow node info in memblock and
 remove x86 specific memblock code
Date: Wed, 13 Jul 2011 11:11:30 +0200
Message-ID: <20110713091130.GD2872@htj.dyndns.org>
References: <1310462166-31469-1-git-send-email-tj@kernel.org>
 <CAE9FiQUfHB=EtzDBhPr2ntn__0AC0NcCdi0e7NiwmKb0bZmBbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38489 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965050Ab1GMJLf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2011 05:11:35 -0400
Content-Disposition: inline
In-Reply-To: <CAE9FiQUfHB=EtzDBhPr2ntn__0AC0NcCdi0e7NiwmKb0bZmBbg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, benh@kernel.crashing.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

Hello, Yinghai.

On Tue, Jul 12, 2011 at 04:26:57PM -0700, Yinghai Lu wrote:
> On Tue, Jul 12, 2011 at 2:15 AM, Tejun Heo <tj@kernel.org> wrote:
> > 0005-0013 adds generic memblock free area iterator and gradually
> > replaces x86 specific memblock mechanism with generic one.
> 
> that is great, merge early_node_map into memblock array.

Yeah and with proper top down allocator and iterator, we should be
able to add back the early per-node allocaiton thing.

> looks it comes with some mismatch section warning...
> 
> WARNING: vmlinux.o(.text+0x120ba5): Section mismatch in reference from
> the function memblock_set_node() to the variable .init.data:memblock
> The function memblock_set_node() references
> the variable __initdata memblock.
> This is often because memblock_set_node lacks a __initdata
> annotation or the annotation of memblock is wrong.

Oh, the __memblock_init thing.  Can you please attach .config you
used?

Thanks.

-- 
tejun
