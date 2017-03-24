From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above
 47-bits
Date: Fri, 24 Mar 2017 12:04:08 +0300
Message-ID: <20170324090408.xsj7othssj547w5k@node.shutemov.name>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
 <8760j4sfcz.fsf@skywalker.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34909 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965067AbdCXJEM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2017 05:04:12 -0400
Received: by mail-wm0-f48.google.com with SMTP id u132so7634817wmg.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2017 02:04:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8760j4sfcz.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Mon, Mar 20, 2017 at 10:40:20AM +0530, Aneesh Kumar K.V wrote:
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
>  @@ -168,6 +182,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
> >  	unsigned long addr = addr0;
> >  	struct vm_unmapped_area_info info;
> >  
> > +	addr = mpx_unmapped_area_check(addr, len, flags);
> > +	if (IS_ERR_VALUE(addr))
> > +		return addr;
> > +
> >  	/* requested length too big for entire address space */
> >  	if (len > TASK_SIZE)
> >  		return -ENOMEM;
> > @@ -192,6 +210,14 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
> >  	info.length = len;
> >  	info.low_limit = PAGE_SIZE;
> >  	info.high_limit = mm->mmap_base;
> > +
> > +	/*
> > +	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
> > +	 * in the full address space.
> > +	 */
> > +	if (addr > DEFAULT_MAP_WINDOW)
> > +		info.high_limit += TASK_SIZE - DEFAULT_MAP_WINDOW;
> > +
> 
> Is this ok for 32 bit application ?

DEFAULT_MAP_WINDOW is equal to TASK_SIZE on 32-bit, so it's nop and will
be compile out.

-- 
 Kirill A. Shutemov
