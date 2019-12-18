Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfLRU7J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 15:59:09 -0500
Date: Wed, 18 Dec 2019 21:59:05 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
Message-ID: <20191218205905.GG4113@kitsune.suse.cz>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
 <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <20191218205905.PvJNMYJbCDsH4jz2RHN_6L6yneQRUs3jHT1Cm2GdMJw@z>

On Wed, Dec 18, 2019 at 12:46:50PM -0800, Dave Hansen wrote:
> On 12/17/19 11:51 PM, Sandipan Das wrote:
> >  	write_pkey_reg(pkey_reg);
> > -	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
> > +	dprintf4("pkey_reg now: "PKEY_REG_FMT"\n", read_pkey_reg());
> >  }
> >  
> >  #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> > diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
> > index 2f04ade8ca9c..5f40901219d3 100644
> > --- a/tools/testing/selftests/vm/pkey-x86.h
> > +++ b/tools/testing/selftests/vm/pkey-x86.h
> > @@ -46,6 +46,8 @@
> >  #define HPAGE_SIZE		(1UL<<21)
> >  #define PAGE_SIZE		4096
> >  #define MB			(1<<20)
> > +#define pkey_reg_t		u32
> > +#define PKEY_REG_FMT		"%016x"
> 
> How big is the ppc one?
u64
> 
> I'd really just rather do %016lx *everywhere* than sprinkle the
> PKEY_REG_FMTs around.

Does lx work with u32 without warnings?

It's likely the size difference that requires a format specifier definition.

> 
> BTW, why are you doing a %016lx for a u32?

It's "%016x" without 'l' for x86 and with 'l' for ppc64.

Thanks

Michal
