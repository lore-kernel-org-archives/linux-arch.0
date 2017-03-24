From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above
 47-bits
Date: Fri, 24 Mar 2017 11:59:31 +0300
Message-ID: <20170324085931.7hvhrs2emqu5k5mr@node.shutemov.name>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
 <87a88jg571.fsf@skywalker.in.ibm.com>
 <20170317175714.3bvpdylaaudf4ig2@node.shutemov.name>
 <877f3lfzdo.fsf@skywalker.in.ibm.com>
 <CAFZ8GQx2JmEECQHEsKOymP8nDv9YHfLgcK80R75gM+r-1q-owQ@mail.gmail.com>
 <95631D05-2CA2-4967-A29E-DB396C76F62D@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32787 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965156AbdCXI7g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2017 04:59:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so1890457wma.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2017 01:59:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <95631D05-2CA2-4967-A29E-DB396C76F62D@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, x86@kernel.org, Andi Kleen <ak@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Mar 20, 2017 at 11:08:41AM -0700, hpa@zytor.com wrote:
> This *better* be conditional on some kind of settable limit.  Having a
> barrier in the middle of the address space for no apparent reason to
> "clean" software is insane.

I had the same argument (on your side) before, but if you look on numbers
it's far from the middle of address space. The barrier is around 0.2% from
the start 56-bit address space.

And it's we have vdso/vvar/stack just below the barier anyway.

I don't think we would loose much if wouldn't not allow VMA to sit
across it.

-- 
 Kirill A. Shutemov
