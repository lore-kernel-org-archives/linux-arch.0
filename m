From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv1 11/12] unicore32 core architecture: signals
Date: Fri, 7 Jan 2011 01:16:57 +0100
Message-ID: <201101070116.57654.arnd@arndb.de>
References: <00da01cba465$6d6e52f0$484af8d0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00da01cba465$6d6e52f0$484af8d0$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Saturday 25 December 2010, Guan Xuetao wrote:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> 
> Patch 11 implements signals.
> 
> Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> ---
>  arch/unicore32/include/asm/sigcontext.h |   61 ++++
>  arch/unicore32/kernel/signal.c          |  571 +++++++++++++++++++++++++++++++
>  arch/unicore32/kernel/signal.h          |   16 +
>  3 files changed, 648 insertions(+), 0 deletions(-)

Al Viro recently did a major cleanup of the signal handling code in a
number of architectures. He can probably give much better feedback
on this one than I can.

The one thing that sticks out to me is that you implement both legacy
and rt signals, where new architectures should generally only need the
rt variant.

	Arnd
