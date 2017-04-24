From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Question on the five-level page table support patches
Date: Mon, 24 Apr 2017 19:19:59 +0300
Message-ID: <20170424161959.c5ba2nhnxyy57wxe@node.shutemov.name>
References: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35825 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S973271AbdDXQUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 12:20:02 -0400
Received: by mail-wm0-f45.google.com with SMTP id w64so1116448wma.0
        for <linux-arch@vger.kernel.org>; Mon, 24 Apr 2017 09:20:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org

On Sun, Apr 23, 2017 at 12:53:46PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Kirill!
> 
> I recently read the LWN article on your and your colleagues work to
> add five-level page table support for x86 to the Linux kernel [1]
> and I got your email address from the last patch of the series.
> 
> Since this extends the address space beyond 48-bits, as you may know,
> it will cause potential headaches with Javascript engines which use
> tagged pointers. On SPARC, the virtual address space already extends
> to 52 bits and we are running into these very issues with Javascript
> engines on SPARC.
> 
> Now, a possible way to mitigate this problem would be to pass the
> "hint" parameter to mmap() in order to tell the kernel not to allocate
> memory beyond the 48 bits address space. Unfortunately, on Linux this
> will only work when the area pointed to by "hint" is unallocated which
> means one cannot simply use a hardcoded "hint" to mitigate this problem.

In proposed implementation, we also use hint address, but in different
way: by default, if hint address is NULL, kernel would not create mappings
above 47-bits, preserving compatibility.

If an application wants to have access to larger address space, it has to
specify hint addess above 47-bits.

See details here:

http://lkml.kernel.org/r/20170420162147.86517-10-kirill.shutemov@linux.intel.com

-- 
 Kirill A. Shutemov
