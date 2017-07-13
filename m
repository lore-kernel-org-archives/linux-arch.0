Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37249 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750877AbdGMHzT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jul 2017 03:55:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6D7rbkv036586
        for <linux-arch@vger.kernel.org>; Thu, 13 Jul 2017 03:55:18 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3r4mct-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Jul 2017 03:55:18 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Thu, 13 Jul 2017 01:55:17 -0600
Date: Thu, 13 Jul 2017 00:55:02 -0700
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 15/38] powerpc: helper function to read,write
 AMR,IAMR,UAMOR registers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-16-git-send-email-linuxram@us.ibm.com>
 <20170712152601.3b2f52ed@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712152601.3b2f52ed@firefly.ozlabs.ibm.com>
Message-ID: <20170713075502.GG5525@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170713075502.yUk_rcK9KNgS3DLAsU882wH7vhYYpYX13I0z5-LQiQ4@z>

On Wed, Jul 12, 2017 at 03:26:01PM +1000, Balbir Singh wrote:
> On Wed,  5 Jul 2017 14:21:52 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Implements helper functions to read and write the key related
> > registers; AMR, IAMR, UAMOR.
> > 
> > AMR register tracks the read,write permission of a key
> > IAMR register tracks the execute permission of a key
> > UAMOR register enables and disables a key
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable.h |   60 ++++++++++++++++++++++++++
> >  1 files changed, 60 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index 85bc987..435d6a7 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -428,6 +428,66 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> >  		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
> >  }
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +
> > +#include <asm/reg.h>
> > +static inline u64 read_amr(void)
> > +{
> > +	return mfspr(SPRN_AMR);
> > +}
> > +static inline void write_amr(u64 value)
> > +{
> > +	mtspr(SPRN_AMR, value);
> > +}
> > +static inline u64 read_iamr(void)
> > +{
> > +	return mfspr(SPRN_IAMR);
> > +}
> > +static inline void write_iamr(u64 value)
> > +{
> > +	mtspr(SPRN_IAMR, value);
> > +}
> > +static inline u64 read_uamor(void)
> > +{
> > +	return mfspr(SPRN_UAMOR);
> > +}
> > +static inline void write_uamor(u64 value)
> > +{
> > +	mtspr(SPRN_UAMOR, value);
> > +}
> > +
> > +#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> > +static inline u64 read_amr(void)
> > +{
> > +	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
> > +	return -1;
> > +}
> 
> Why do we need to have a version here if we are going to WARN(), why not
> let the compilation fail if called from outside of CONFIG_PPC64_MEMORY_PROTECTION_KEYS?
> Is that the intention?

I did not want to stop someone; kernel module for example, from calling
these interfaces from outside the pkey domain.

Either way can be argued to be correct, I suppose.
RP
