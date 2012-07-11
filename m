From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 3/3] ipc: compat: use signed size_t types for msgsnd and
 msgrcv
Date: Wed, 11 Jul 2012 12:06:55 -0400
Message-ID: <4FFDA49F.4070500@tilera.com>
References: <1342020741-12758-1-git-send-email-will.deacon@arm.com> <1342020741-12758-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:17564 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab2GKQG5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2012 12:06:57 -0400
In-Reply-To: <1342020741-12758-4-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davem@davemloft.net, chris@zankel.net, catalin.marinas@arm.com, arnd@arndb.de, akpm@linux-foundation.org

On 7/11/2012 11:32 AM, Will Deacon wrote:
> The msgsnd and msgrcv system calls use size_t to represent the size of
> the message being transferred. POSIX states that values of msgsz greater
> than SSIZE_MAX cause the result to be implementation-defined. On Linux,
> this equates to returning -EINVAL if (long) msgsz < 0.
>
> For compat tasks where !CONFIG_ARCH_WANT_OLD_COMPAT_IPC and
> compat_size_t is smaller than size_t, negative size values passed from
> userspace will be interpreted as positive values by do_msg{rcv,snd} and
> will fail to exit early with -EINVAL.
>
> This patch changes the compat prototypes for msg{rcv,snd} so that the
> message size is represented as a compat_ssize_t, which we cast to the
> native ssize_t type for the core IPC code.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/linux/compat.h |    4 ++--
>  ipc/compat.c           |    8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
