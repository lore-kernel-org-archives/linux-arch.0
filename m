From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm/pkeys: generate pkey system call code only if
 ARCH_HAS_PKEYS is selected
Date: Mon, 14 Nov 2016 08:44:24 -0800
Message-ID: <8d880fbe-5a20-c027-4c8f-8a464d81dcbb@linux.intel.com>
References: <20161114111251.70084-1-heiko.carstens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:1029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753954AbcKNQoc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Nov 2016 11:44:32 -0500
In-Reply-To: <20161114111251.70084-1-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>

On 11/14/2016 03:12 AM, Heiko Carstens wrote:
> Having code for the pkey_mprotect, pkey_alloc and pkey_free system
> calls makes only sense if ARCH_HAS_PKEYS is selected. If not selected
> these system calls will always return -ENOSPC or -EINVAL.
> 
> To simplify things and have less code generate the pkey system call
> code only if ARCH_HAS_PKEYS is selected.
> 
> For architectures which have already wired up the system calls, but do
> not select ARCH_HAS_PKEYS this will result in less generated code and
> a different return code: the three system calls will now always return
> -ENOSYS, using the cond_syscall mechanism.
> 
> For architectures which have not wired up the system calls less
> unreachable code will be generated.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

This is fine with me.  FWIW:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
