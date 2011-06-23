From: "Michael K. Edwards" <m.k.edwards@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH/RFC 0/8] ARM: DMA-mapping framework redesign
Date: Thu, 23 Jun 2011 09:24:53 -0700
Message-ID: <BANLkTikzTwNvaaUSk26qzONemogBAGuBRg@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<4E017539.30505@gmail.com>
	<001d01cc30a9$ebe5e460$c3b1ad20$%szyprowski@samsung.com>
	<4E01AD7B.3070806@gmail.com>
	<002701cc30be$ab296cc0$017c4640$%szyprowski@samsung.com>
	<4E02119F.4000901@codeaurora.org>
	<4E033AFF.4020603@gmail.com>
Reply-To: M.K.Edwards@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47336 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758347Ab1FWQYy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2011 12:24:54 -0400
Received: by ywe9 with SMTP id 9so776777ywe.19
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2011 09:24:54 -0700 (PDT)
In-Reply-To: <4E033AFF.4020603@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Subash Patel <subashrp@gmail.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org

On Thu, Jun 23, 2011 at 6:09 AM, Subash Patel <subashrp@gmail.com> wrote:

> We have some rare cases, where requirements like above are also there. So we
> require to have flexibility to map user allocated buffers to devices as
> well.

Not so rare, I think.  When using the OpenGL back end, Qt routinely
allocates buffers to hold image assets (e. g., decompressed JPEGs and
the glyph cache) and then uses them as textures.  Which, if there's a
GPU that doesn't participate in the cache coherency protocol, is a
problem.  (One which we can reliably trigger on our embedded
platform.)

The best workaround we have been able to come up with is for Qt's
allocator API, which already has a "flags" parameter, to grow an
"allocate for use as texture" flag, which makes the allocation come
from a separate pool backed by a write-combining uncacheable mapping.
Then we can grovel our way through the highest-frequency use cases,
restructuring the code that writes these assets to use the approved
write-combining tricks.

In the very near future, some of these assets are likely to come from
other hardware blocks, such as a hardware JPEG decoder (Subash's use
case), a V4L2 capture device, or a OpenMAX H.264 decoder.  Those may
add orthogonal allocation requirements, such as page alignment or
allocation from tightly coupled memory.  The only entity that knows
what buffers might be passed where is the userland application (or
potentially a userland media framework, like StageFright or
GStreamer).

So the solution that I'd like to see is for none of these drivers to
do their own allocation of buffers that aren't for strictly internal
use.  Instead, the userland application should ask each component for
a "buffer attributes" structure, and merge the attributes of the
components that may touch a given buffer in order to get the
allocation attributes for that buffer (or for the hugepage from which
it will carve out many like it).

The userland would ask the kernel to do the appropriate allocation --
ideally by passing in the merged allocation attributes and getting
back a file descriptor, which can be passed around to other processes
(over local domain sockets) and mmap'ed.  The buffers themselves would
have to be registered with each driver that uses them; i. e., the
driver's buffer allocation API is replaced with a buffer registration
API.  If the driver doesn't like the attributes of the mapping from
which the buffer was allocated, the registration fails.

I will try to get around to producing some code that does this soon,
at least for the Qt/GPU texture asset allocation/registration use
case.

Cheers,
- Michael
