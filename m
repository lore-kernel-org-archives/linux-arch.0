Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38933 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCVJ1f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:27:35 -0400
Date: Thu, 22 Mar 2018 10:27:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 42/45] x86: fix sys_sigreturn() return type to be long,
 not unsigned long
In-Reply-To: <20180322090059.19361-43-linux@dominikbrodowski.net>
Message-ID: <alpine.DEB.2.21.1803221027180.1579@nanos.tec.linutronix.de>
References: <20180322090059.19361-1-linux@dominikbrodowski.net> <20180322090059.19361-43-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org, Michael Tautschnig <tautschn@amazon.co.uk>
Message-ID: <20180322092732.T3Y6B6rnB82GrRQf6DGYeATReC_8iur14eyVLFcEYPo@z>

On Thu, 22 Mar 2018, Dominik Brodowski wrote:

> Same as with other system calls, sys_sigreturn() should return a value
> of type long, not unsigned long. This also matches the behaviour for
> IA32_EMULATION, see sys32_sigreturn() in arch/x86/ia32/ia32_signal.c .
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: x86@kernel.org
> Cc: Michael Tautschnig <tautschn@amazon.co.uk>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
