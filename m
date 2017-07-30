Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751888AbdG3Ajq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jul 2017 20:39:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6U0cUvg005762
        for <linux-arch@vger.kernel.org>; Sat, 29 Jul 2017 20:39:46 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c0m06khhu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 29 Jul 2017 20:39:45 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 29 Jul 2017 20:39:45 -0400
Date: Sat, 29 Jul 2017 17:39:24 -0700
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v6 27/62] powerpc: helper to validate key-access
 permissions of a pte
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-28-git-send-email-linuxram@us.ibm.com>
 <87tw1we0q5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw1we0q5.fsf@linux.vnet.ibm.com>
Message-ID: <20170730003924.GJ5664@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Message-ID: <20170730003924.anRvEC6z0ptWHJDoZ7QxklmBy9AyqImn6qgWY80-7Ms@z>

On Fri, Jul 28, 2017 at 06:00:02PM -0300, Thiago Jung Bauermann wrote:
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -201,3 +201,36 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
> >  	 */
> >  	return vma_pkey(vma);
> >  }
> > +
> > +static bool pkey_access_permitted(int pkey, bool write, bool execute)
> > +{
> > +	int pkey_shift;
> > +	u64 amr;
> > +
> > +	if (!pkey)
> > +		return true;
> > +
> > +	pkey_shift = pkeyshift(pkey);
> > +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> > +		return true;
> > +
> > +	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
> > +		return true;
> > +
> > +	if (!write) {
> > +		amr = read_amr();
> > +		if (!(amr & (AMR_RD_BIT << pkey_shift)))
> > +			return true;
> > +	}
> > +
> > +	amr = read_amr(); /* delay reading amr uptil absolutely needed */
> 
> Actually, this is causing amr to be read twice in case control enters
> the "if (!write)" block above but doesn't enter the other if block nested
> in it.
> 
> read_amr should be called only once, right before "if (!write)".

the code can be simplified without having to read amr twice.
will fix it.

thanks,
RP

> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center

-- 
Ram Pai
