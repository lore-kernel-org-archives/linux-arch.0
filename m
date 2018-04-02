From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH 002/109] kernel: use kernel_wait4() instead of sys_wait4()
Date: Mon, 2 Apr 2018 16:14:29 +0000
Message-ID: <20180402161429.GS30543@wotan.suse.de>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
 <20180329112426.23043-3-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329112426.23043-3-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 29, 2018 at 01:22:39PM +0200, Dominik Brodowski wrote:
> All call sites of sys_wait4() set *rusage to NULL. Therefore, there is
> no need for the copy_to_user() handling of *rusage, and we can use
> kernel_wait4() directly.
> 
> This patch is part of a series which removes in-kernel calls to syscalls.
> On this basis, the syscall entry path can be streamlined. For details, see
> http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net
> 
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
