From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 43/45] x86/sigreturn: use SYSCALL_DEFINE0
Date: Thu, 22 Mar 2018 10:27:54 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803221027410.1579@nanos.tec.linutronix.de>
References: <20180322090059.19361-1-linux@dominikbrodowski.net> <20180322090059.19361-44-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-44-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, "Tautschnig, Michael" <tautschn@amazon.co.uk>, Michael Tautschnig <tautschn@amazon.com>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Jaswinder Singh <jaswinder@infradead.org>, Andi Kleen <ak@linux.intel.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

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
