Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751969AbdG2W7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jul 2017 18:59:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6TMwWAW014710
        for <linux-arch@vger.kernel.org>; Sat, 29 Jul 2017 18:59:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c0k8rb063-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 29 Jul 2017 18:59:19 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 29 Jul 2017 18:59:18 -0400
Date: Sat, 29 Jul 2017 15:59:04 -0700
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v6 17/62] powerpc: implementation for
 arch_set_user_pkey_access()
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-18-git-send-email-linuxram@us.ibm.com>
 <87d18m3r07.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d18m3r07.fsf@linux.vnet.ibm.com>
Message-ID: <20170729225904.GF5664@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Message-ID: <20170729225904.hCUPyM0k-KLhqV3JI7P9XVnzKzm_SlXFwkPAVpKt5Kk@z>

On Thu, Jul 27, 2017 at 11:15:36AM -0300, Thiago Jung Bauermann wrote:
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> > @@ -113,10 +117,14 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> >  	return 0;
> >  }
> >
> > +extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> > +		unsigned long init_val);
> >  static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> >  		unsigned long init_val)
> >  {
> > -	return 0;
> > +	if (!pkey_inited)
> > +		return -1;
> > +	return __arch_set_user_pkey_access(tsk, pkey, init_val);
> >  }
> 
> If non-zero, the return value of this function will be passed to
> userspace by the pkey_alloc syscall. Shouldn't it be returning an errno
> macro such as -EPERM?

Yes. it should be -EINVAL.  fixed it.

> 
> Also, why are there both arch_set_user_pkey_access and
> __arch_set_user_pkey_access? Is it a speed optimization so that the
> early return is inlined into the caller? Ditto for execute_only_pkey
> and __arch_override_mprotect_pkey.

arch_set_user_pkey_access() is the interface expected by the
architecture independent code.  The __arch_set_user_pkey_access() is an
powerpc internal function that implements the bulk of the work. It can
be called by any of the pkeys internal code only. This gives me the
flexibility to change implementation without having to worry about
changing the interface.

RP
