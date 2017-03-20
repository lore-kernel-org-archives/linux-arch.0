Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751106AbdCTFKd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 01:10:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2K58q54103491
        for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2017 01:10:32 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 299yqar7t5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2017 01:10:31 -0400
Received: from localhost
        by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Mon, 20 Mar 2017 10:40:28 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above 47-bits
In-Reply-To: <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com> <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
Date: Mon, 20 Mar 2017 10:40:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8760j4sfcz.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170320051020.daEAUbb82ZIJPDAXeMHjlwuz_GJLXjFCHOikQW0lZoQ@z>

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
 @@ -168,6 +182,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	unsigned long addr = addr0;
>  	struct vm_unmapped_area_info info;
>  
> +	addr = mpx_unmapped_area_check(addr, len, flags);
> +	if (IS_ERR_VALUE(addr))
> +		return addr;
> +
>  	/* requested length too big for entire address space */
>  	if (len > TASK_SIZE)
>  		return -ENOMEM;
> @@ -192,6 +210,14 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	info.length = len;
>  	info.low_limit = PAGE_SIZE;
>  	info.high_limit = mm->mmap_base;
> +
> +	/*
> +	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
> +	 * in the full address space.
> +	 */
> +	if (addr > DEFAULT_MAP_WINDOW)
> +		info.high_limit += TASK_SIZE - DEFAULT_MAP_WINDOW;
> +

Is this ok for 32 bit application ?


>  	info.align_mask = 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;
>  	if (filp) {


-aneesh
