Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751126AbdGaSQM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Jul 2017 14:16:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6VIECcf122705
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2017 14:16:12 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c26dsswwg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2017 14:16:11 -0400
Received: from localhost
        by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Mon, 31 Jul 2017 15:16:09 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-14-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 13/62] powerpc: track allocation status of all pkeys
In-reply-to: <1500177424-13695-14-git-send-email-linuxram@us.ibm.com>
Date: Mon, 31 Jul 2017 15:15:55 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87d18g5v6s.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Message-ID: <20170731181555.FY4h2jvLS6y2wwjROMasJZd0IIcY5lMiDGWO7rfUqb0@z>


Ram Pai <linuxram@us.ibm.com> writes:
>  static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
>  {
> -	return -EINVAL;
> +	if (!pkey_inited)
> +		return -1;

Sorry, I missed this earlier but the pkey_free syscall will pass this
value to userspace so it needs to be an errno as well (-EINVAL?).

> +
> +	if (!mm_pkey_is_allocated(mm, pkey))
> +		return -EINVAL;
> +
> +	mm_set_pkey_free(mm, pkey);
> +
> +	return 0;
>  }

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
