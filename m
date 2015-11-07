From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [RFC PATCH 19/28] lkl tools: host lib: virtio block device
Date: Sat, 7 Nov 2015 13:24:03 +0100
Message-ID: <CAFLxGvyS3Ru4Pu2WV9ssSTOQRRi4GLs9uGs=-7_8WJh5FVbdeg@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<1446582059-17355-20-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36147 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbKGMYE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 07:24:04 -0500
In-Reply-To: <1446582059-17355-20-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, thehajime@gmail.com, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

On Tue, Nov 3, 2015 at 9:20 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> Host independent implementation for virtio block devices. The host
> dependent part of the host library must provide an implementation for
> lkl_dev_block_ops.
>
> Disks can be added to the LKL configuration via lkl_disk_add(), a new
> LKL application API.
>
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  tools/lkl/include/lkl.h      |  20 ++++++++
>  tools/lkl/include/lkl_host.h |  21 ++++++++
>  tools/lkl/lib/virtio_blk.c   | 116 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+)
>  create mode 100644 tools/lkl/lib/virtio_blk.c

Can you please outline what the differences between this driver and
UML's block driver are?

While UML and LKL have different goals they could at least share some drivers.
UML also has networking drivers you could reuse.
Maybe it would make sense to integrate LKL completely into arch/um if
we find a nice way
to combine them.
CONFIG_UML_LIBRARY, hmm?
Would be a nice opportunity to clear away some dung from arch/um and
refactor it. :-)

-- 
Thanks,
//richard
