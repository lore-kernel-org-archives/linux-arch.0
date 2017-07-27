Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751641AbdG0OPy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jul 2017 10:15:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6REETCj141473
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2017 10:15:54 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bycygp99a-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2017 10:15:53 -0400
Received: from localhost
        by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Thu, 27 Jul 2017 11:15:51 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-18-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 17/62] powerpc: implementation for arch_set_user_pkey_access()
In-reply-to: <1500177424-13695-18-git-send-email-linuxram@us.ibm.com>
Date: Thu, 27 Jul 2017 11:15:36 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87d18m3r07.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Message-ID: <20170727141536.25WjpnGg4MJi6rXJhmVE6w2stdPAh3yhcUwZ4UgmTeI@z>


Ram Pai <linuxram@us.ibm.com> writes:
> @@ -113,10 +117,14 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
>  	return 0;
>  }
>
> +extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +		unsigned long init_val);
>  static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  		unsigned long init_val)
>  {
> -	return 0;
> +	if (!pkey_inited)
> +		return -1;
> +	return __arch_set_user_pkey_access(tsk, pkey, init_val);
>  }

If non-zero, the return value of this function will be passed to
userspace by the pkey_alloc syscall. Shouldn't it be returning an errno
macro such as -EPERM?

Also, why are there both arch_set_user_pkey_access and
__arch_set_user_pkey_access? Is it a speed optimization so that the
early return is inlined into the caller? Ditto for execute_only_pkey
and __arch_override_mprotect_pkey.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
