Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42004 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbaHYRik (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Aug 2014 13:38:40 -0400
Received: from localhost.localdomain ([127.0.0.1]:54260 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006756AbaHYRQKDdXZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Aug 2014 19:16:10 +0200
Date: Mon, 25 Aug 2014 19:16:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
Message-ID: <20140825171600.GH25892@linux-mips.org>
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Steven Hill <Steven.Hill@imgtec.com>
Message-ID: <20140825171600.Q5Hv2jB-AYNxHVfOzpEDSSKoOx3K6fcH1sTuYGQsbwk@z>

On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:

> this series adds mapping color control to the generic kmap code, allowing
> architectures with aliasing VIPT cache to use high memory. There's also
> use example of this new interface by xtensa.

I haven't actually ported this to MIPS but it certainly appears to be
the right framework to get highmem aliases handled on MIPS, too.

Though I still consider increasing PAGE_SIZE to 16k the preferable
solution because it will entirly do away with cache aliases.

Thanks,

  Ralf
