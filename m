Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751837AbdHAQOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2017 12:14:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v71G8eHg025101
        for <linux-arch@vger.kernel.org>; Tue, 1 Aug 2017 12:14:23 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c2v1vtx97-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2017 12:14:22 -0400
Received: from localhost
        by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Tue, 1 Aug 2017 13:14:19 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-22-git-send-email-linuxram@us.ibm.com> <87shhgdx5i.fsf@linux.vnet.ibm.com> <87d18fu6o1.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
In-reply-to: <87d18fu6o1.fsf@concordia.ellerman.id.au>
Date: Tue, 01 Aug 2017 13:14:02 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87d18fw9it.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20170801161402.eJZIvbBLvSQ0qVva5AH_jndQ0HTuDAZOgGQeDcrGaoc@z>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> Ram Pai <linuxram@us.ibm.com> writes:
> ...
>>> +
>>> +	/* We got one, store it and use it from here on out */
>>> +	if (need_to_set_mm_pkey)
>>> +		mm->context.execute_only_pkey = execute_only_pkey;
>>> +	return execute_only_pkey;
>>> +}
>>
>> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
>> are read 3 times in total, and AMR is written twice. IAMR is read and
>> written twice. Since they are SPRs and access to them is slow (or isn't
>> it?),
>
> SPRs read/writes are slow, but they're not *that* slow in comparison to
> a system call (which I think is where this code is being called?).

Yes, this code runs on mprotect and mmap syscalls if the memory is
requested to have execute but not read nor write permissions.

> So we should try to avoid too many SPR read/writes, but at the same time
> we can accept more than the minimum if it makes the code much easier to
> follow.

Ok. Ram had asked me to suggest a way to optimize the SPR reads and
writes and I came up with the patch below. Do you think it's worth it?

The patch applies on top of this series, but if Ram includes it I think
he would break it up and merge it into the other patches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
