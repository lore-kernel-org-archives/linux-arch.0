From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
Date: Sun, 9 Jul 2017 23:01:01 -0700
Message-ID: <20170710060101.GE5713@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
 <1162ac6c-5e34-8a6c-fed2-6683d261352c@linux.vnet.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42029 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751224AbdGJGBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jul 2017 02:01:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6A5xZf0051424
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 02:01:19 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bjujyqv27-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 02:01:19 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Mon, 10 Jul 2017 00:01:18 -0600
Content-Disposition: inline
In-Reply-To: <1162ac6c-5e34-8a6c-fed2-6683d261352c@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com

On Mon, Jul 10, 2017 at 08:37:28AM +0530, Anshuman Khandual wrote:
> On 07/06/2017 02:52 AM, Ram Pai wrote:
> > Display the pkey number associated with the vma in smaps of a task.
> > The key will be seen as below:
> > 
> > ProtectionKey: 0
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/kernel/setup_64.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> > index f35ff9d..ebc82b3 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/memory.h>
> >  #include <linux/nmi.h>
> > +#include <linux/pkeys.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/kdump.h>
> > @@ -745,3 +746,10 @@ static int __init disable_hardlockup_detector(void)
> >  }
> >  early_initcall(disable_hardlockup_detector);
> >  #endif
> > +
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> 
> Why not for X86 protection keys ?

hmm.. I dont understand the comment.


-- 
Ram Pai
