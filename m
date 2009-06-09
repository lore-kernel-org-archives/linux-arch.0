From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 02/27] score: create boot/Makefile configs/spct6600_defconfig
Date: Tue, 9 Jun 2009 21:14:17 +0200
Message-ID: <20090609191417.GC7181@uranus.ravnborg.org>
References: <OF27AB920F.5CDB40B4-ON482575D0.00230527-482575D0.00237FF4@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:38543 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474AbZFITMA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 15:12:00 -0400
Content-Disposition: inline
In-Reply-To: <OF27AB920F.5CDB40B4-ON482575D0.00230527-482575D0.00237FF4@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tue, Jun 09, 2009 at 02:23:27PM +0800, liqin.chen@sunplusct.com wrote:
> >From 2beb0093ab93e3d7bbf6928fb28b620718afbb9f Mon Sep 17 00:00:00 2001
> From: Chen Liqin <liqin.chen@sunplusct.com>
> Date: Tue, 9 Jun 2009 13:43:05 +0800
> 
> 
> 
> Signed-off-by: Chen Liqin <liqin.chen@sunplusct.com>
> ---
>  arch/score/boot/Makefile              |   15 +
>  arch/score/configs/spct6600_defconfig |  726 
> +++++++++++++++++++++++++++++++++
>  2 files changed, 741 insertions(+), 0 deletions(-)
>  create mode 100644 arch/score/boot/Makefile
>  create mode 100644 arch/score/configs/spct6600_defconfig
> 
> diff --git a/arch/score/boot/Makefile b/arch/score/boot/Makefile
> new file mode 100644
> index 0000000..c3376b1
> --- /dev/null
> +++ b/arch/score/boot/Makefile
> @@ -0,0 +1,15 @@
> +#
> +# arch/score/boot/Makefile
> +#
> +# This file is subject to the terms and conditions of the GNU General 
> Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +
> +targets        := vmlinux.bin
> +
> +$(obj)/vmlinux.bin: vmlinux FORCE
> +       $(call if_changed,objcopy)
> +       @echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
> +
> +clean-kernel += vmlinux.bin
I think you wanted to say: clean-files here?

[yeah, microblaze has same bug..]

	Sam
