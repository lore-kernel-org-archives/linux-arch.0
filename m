Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:54572 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937344AbWLFTZP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Dec 2006 14:25:15 -0500
Date: Wed, 6 Dec 2006 11:24:58 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it [try #2]
In-Reply-To: <Pine.LNX.4.64.0612061101110.27047@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612061123280.27339@schroedinger.engr.sgi.com>
References: <20061206175622.31077.96046.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061101110.27047@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Have a look at arch/i386/kernel/cpu/intel.c. You can probably replace my 
code that simulates cmpxchg for 386s

arch/i386/kernel/cpu/intel.c:

#ifndef CONFIG_X86_CMPXCHG
unsigned long cmpxchg_386_u8(volatile void *ptr, u8 old, u8 new)
{
        u8 prev;
        unsigned long flags;

        /* Poor man's cmpxchg for 386. Unsuitable for SMP */
        local_irq_save(flags);
        prev = *(u8 *)ptr;
        if (prev == old)
                *(u8 *)ptr = new;
        local_irq_restore(flags);
        return prev;
}
EXPORT_SYMBOL(cmpxchg_386_u8);

unsigned long cmpxchg_386_u16(volatile void *ptr, u16 old, u16 new)
{
        u16 prev;
        unsigned long flags;

        /* Poor man's cmpxchg for 386. Unsuitable for SMP */
        local_irq_save(flags);
        prev = *(u16 *)ptr;
        if (prev == old)
                *(u16 *)ptr = new;
        local_irq_restore(flags);
        return prev;
}
EXPORT_SYMBOL(cmpxchg_386_u16);

unsigned long cmpxchg_386_u32(volatile void *ptr, u32 old, u32 new)
{
        u32 prev;
        unsigned long flags;

        /* Poor man's cmpxchg for 386. Unsuitable for SMP */
        local_irq_save(flags);
        prev = *(u32 *)ptr;
        if (prev == old)
                *(u32 *)ptr = new;
        local_irq_restore(flags);
        return prev;
}
EXPORT_SYMBOL(cmpxchg_386_u32);
#endif


