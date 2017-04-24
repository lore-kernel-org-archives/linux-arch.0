From: David Miller <davem@davemloft.net>
Subject: Re: Question on the five-level page table support patches
Date: Mon, 24 Apr 2017 18:09:48 -0400 (EDT)
Message-ID: <20170424.180948.1311847745777709716.davem@davemloft.net>
References: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
        <20170424161959.c5ba2nhnxyy57wxe@node.shutemov.name>
        <fdc80e3c-6909-cf39-fe0b-6f1c012571e4@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:58404 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977769AbdDXWJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 18:09:52 -0400
In-Reply-To: <fdc80e3c-6909-cf39-fe0b-6f1c012571e4@physik.fu-berlin.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: glaubitz@physik.fu-berlin.de
Cc: kirill@shutemov.name, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, luto@amacapital.net, mhocko@suse.com, linux-arch@vger.kernel.org, linux-mm@kvack.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 24 Apr 2017 22:37:40 +0200

> Would be really nice to able to have a canonical solution for this issue,
> it's been biting us on SPARC for quite a while now due to the fact that
> virtual address space has been 52 bits on SPARC for a while now.

It's going to break again with things like ADI which encode protection
keys in the high bits of the 64-bit virtual address.

Reallly, it would be nice if these tags were instead encoded in the
low bits of suitably aligned memory allocations but I am sure it's to
late to do that now.
