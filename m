From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Any chance that kernel/uid6.c can go? [Was: [PATCH 22/45] kernel:
 provide ksys_*() wrappers for syscalls called by kernel/uid16.c]
Date: Thu, 22 Mar 2018 11:21:40 +0100
Message-ID: <20180322102140.GA14294@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-23-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322090059.19361-23-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 22, 2018 at 10:00:36AM +0100, Dominik Brodowski wrote:
> Using these helpers allows us to avoid the in-kernel calls to these
> syscalls: sys_setregid(), sys_setgid(), sys_setreuid(), sys_setuid(),
> sys_setresuid(), sys_setresgid(), sys_setfsuid(), and sys_setfsgid().
> 
> The ksys_ prefix denotes that these function are meant as a drop-in
> replacement for the syscall. In particular, they use the same calling
> convention.
> 
> This patch is part of a series which tries to remove in-kernel calls to
> syscalls. On this basis, the syscall entry path can be streamlined.
> 
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  kernel/sys.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  kernel/uid16.c | 19 ++++++++++---------

In its header, kernel/uid16.c says, since 2.3.39 was released in January
2000:

 *      Wrapper functions for 16bit uid back compatibility. All nicely tied
 *      together in the faint hope we can take the out in five years time.

Are we any closer to removing these wrappers?

Thanks,
	Dominik
