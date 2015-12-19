From: Sumit Gupta <sumit.g.007@gmail.com>
Subject: Query about merging memblock and bootmem into one new alloc
Date: Sat, 19 Dec 2015 19:27:48 +0530
Message-ID: <CANDtUrciap2iHDWpB4SWwACJaUPaLRP4nFb9u9j1=iCJTiuK8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35334 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbbLSN63 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Dec 2015 08:58:29 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: inux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi All,

For ARM Linux, during booting first memblock reserves memory regions
then bootmem allocator create node, mem_map, page bitmap data and then
hands over to buddy.
I have been thinking from some time about why we need two different
allocators for this.
Can we merge both into one(memblock into bootmem) or create a new
allocator which can speed up the same thing which is easy to enhance
in future.
I am not sure about this and whether it's good idea or will it be fruitful.

Please suggest and share your opinion.

Thank you in advance for your help.

Regards,
Sumit Gupta
