From: Laura Abbott <labbott@redhat.com>
Subject: Re: Query about merging memblock and bootmem into one new alloc
Date: Mon, 21 Dec 2015 09:24:04 -0800
Message-ID: <567835B4.3090101@redhat.com>
References: <CANDtUrciap2iHDWpB4SWwACJaUPaLRP4nFb9u9j1=iCJTiuK8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50907 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbbLURYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Dec 2015 12:24:06 -0500
In-Reply-To: <CANDtUrciap2iHDWpB4SWwACJaUPaLRP4nFb9u9j1=iCJTiuK8Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sumit Gupta <sumit.g.007@gmail.com>, inux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 12/19/2015 05:57 AM, Sumit Gupta wrote:
> Hi All,
>
> For ARM Linux, during booting first memblock reserves memory regions
> then bootmem allocator create node, mem_map, page bitmap data and then
> hands over to buddy.
> I have been thinking from some time about why we need two different
> allocators for this.
> Can we merge both into one(memblock into bootmem) or create a new
> allocator which can speed up the same thing which is easy to enhance
> in future.
> I am not sure about this and whether it's good idea or will it be fruitful.
>
> Please suggest and share your opinion.
>
> Thank you in advance for your help.
>

ARM no longer uses bootmem, just memblock (see 84f452b1e8fc73ac0e31254c66e3e2260ce5263d
ARM: mm: Remove bootmem code and switch to NO_BOOTMEM). Any bootmem calls
just go to mm/nobootmem.c which is a wrapper around memblock for compatibility.

Thanks,
Laura
