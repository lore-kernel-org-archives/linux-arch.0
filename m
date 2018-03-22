Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCVJ0j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:26:39 -0400
Date: Thu, 22 Mar 2018 10:26:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 40/45] x86: use _do_fork() in compat_sys_x86_clone()
In-Reply-To: <20180322090059.19361-41-linux@dominikbrodowski.net>
Message-ID: <alpine.DEB.2.21.1803221026130.1579@nanos.tec.linutronix.de>
References: <20180322090059.19361-1-linux@dominikbrodowski.net> <20180322090059.19361-41-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Message-ID: <20180322092635.dP-41RITJSsu26jCfj1yTwhm0jkXDi25zgR-MaQcU10@z>

On Thu, 22 Mar 2018, Dominik Brodowski wrote:

> It is trivial to directly call _do_fork() instead of the sys_clone()
> syscall in compat_sys_x86_clone().
> 
> This patch is part of a series which tries to remove in-kernel calls to
> syscalls. On this basis, the syscall entry path can be streamlined.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: x86@kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
