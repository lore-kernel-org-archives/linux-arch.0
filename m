From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 19/28] lkl tools: host lib: virtio block device
Date: Sun, 8 Nov 2015 06:15:42 +0200
Message-ID: <CAE1zot+uEvkYd9B4861rZW2iGnai7fk_p0=kczfCYYvqCFa07g@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<1446582059-17355-20-git-send-email-octavian.purdila@intel.com>
	<CAFLxGvyS3Ru4Pu2WV9ssSTOQRRi4GLs9uGs=-7_8WJh5FVbdeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35260 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbbKHEPn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 23:15:43 -0500
Received: by wmdw130 with SMTP id w130so7095526wmd.0
        for <linux-arch@vger.kernel.org>; Sat, 07 Nov 2015 20:15:42 -0800 (PST)
In-Reply-To: <CAFLxGvyS3Ru4Pu2WV9ssSTOQRRi4GLs9uGs=-7_8WJh5FVbdeg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

On Sat, Nov 7, 2015 at 2:24 PM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Tue, Nov 3, 2015 at 9:20 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
>> Host independent implementation for virtio block devices. The host
>> dependent part of the host library must provide an implementation for
>> lkl_dev_block_ops.
>>
>> Disks can be added to the LKL configuration via lkl_disk_add(), a new
>> LKL application API.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> ---
>>  tools/lkl/include/lkl.h      |  20 ++++++++
>>  tools/lkl/include/lkl_host.h |  21 ++++++++
>>  tools/lkl/lib/virtio_blk.c   | 116 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 157 insertions(+)
>>  create mode 100644 tools/lkl/lib/virtio_blk.c
>

Hi Richard,

> Can you please outline what the differences between this driver and
> UML's block driver are?
>

LKL actually uses the standard virtio block driver, it does not
implement a new (Linux kernel) driver.

This patch is the implementation for the host side device (in virtio's
spec lingo).

Or maybe I misunderstood your question?

> While UML and LKL have different goals they could at least share some drivers.
> UML also has networking drivers you could reuse.
> Maybe it would make sense to integrate LKL completely into arch/um if
> we find a nice way
> to combine them.
> CONFIG_UML_LIBRARY, hmm?
> Would be a nice opportunity to clear away some dung from arch/um and
> refactor it. :-)
>

Yeah, that would be nice :) I think the key part is to define the
right host operations (in LKL terms) that can support UML. I'll have
to spend some time to study UML's internals a bit to see if that would
be doable.
