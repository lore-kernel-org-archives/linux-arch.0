Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38945 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeCVJ15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:27:57 -0400
Date: Thu, 22 Mar 2018 10:27:54 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 43/45] x86/sigreturn: use SYSCALL_DEFINE0
In-Reply-To: <20180322090059.19361-44-linux@dominikbrodowski.net>
Message-ID: <alpine.DEB.2.21.1803221027410.1579@nanos.tec.linutronix.de>
References: <20180322090059.19361-1-linux@dominikbrodowski.net> <20180322090059.19361-44-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, "Tautschnig, Michael" <tautschn@amazon.co.uk>, Michael Tautschnig <tautschn@amazon.com>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Jaswinder Singh <jaswinder@infradead.org>, Andi Kleen <ak@linux.intel.com>, x86@kernel.org
Message-ID: <20180322092754.0Z-kKStD8Rbgm7mgBTxaU46ntaD12XrR7UZIekvoD3I@z>

On Thu, 22 Mar 2018, Dominik Brodowski wrote:

> From: "Tautschnig, Michael" <tautschn@amazon.co.uk>
> 
> All definitions of syscalls in x86 except for those patched here have
> already been using the appropriate SYSCALL_DEFINE*.
> 
> Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Jaswinder Singh <jaswinder@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
