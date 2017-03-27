From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 5/6] x86/xen: Change __xen_pgd_walk() and
 xen_cleanmfnmap() to support p4d
Date: Mon, 27 Mar 2017 16:13:22 +0300
Message-ID: <20170327131322.3xroyjqeerb37f3d@node.shutemov.name>
References: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
 <20170317185515.8636-6-kirill.shutemov@linux.intel.com>
 <20170327063423.GA13876@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35611 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdC0NN1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2017 09:13:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id v2so7148662lfi.2
        for <linux-arch@vger.kernel.org>; Mon, 27 Mar 2017 06:13:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170327063423.GA13876@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Xiong Zhang <xiong.y.zhang@intel.com>

On Mon, Mar 27, 2017 at 08:34:23AM +0200, Ingo Molnar wrote:
> y
> * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> 
> > Split these helpers into few per-level functions and add support of
> > additional page table level.
> > 
> > Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > [kirill.shutemov@linux.intel.com: split off into separate patch]
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> So who's the primary author of this patch, you or Xiong Zhang? If the latter then 
> a "From: " line is missing. For now I've added the missing "From" line.

Xiong is author of the changes. I've writetten commit message.

So, you're right, "From:" is missing.

Thanks.

-- 
 Kirill A. Shutemov
