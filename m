From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
Date: Tue, 01 Aug 2017 16:46:22 +1000
Message-ID: <87d18fu6o1.fsf@concordia.ellerman.id.au>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-22-git-send-email-linuxram@us.ibm.com> <87shhgdx5i.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:34897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdHAGqY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Aug 2017 02:46:24 -0400
In-Reply-To: <87shhgdx5i.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> Ram Pai <linuxram@us.ibm.com> writes:
...
>> +
>> +	/* We got one, store it and use it from here on out */
>> +	if (need_to_set_mm_pkey)
>> +		mm->context.execute_only_pkey = execute_only_pkey;
>> +	return execute_only_pkey;
>> +}
>
> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
> are read 3 times in total, and AMR is written twice. IAMR is read and
> written twice. Since they are SPRs and access to them is slow (or isn't
> it?),

SPRs read/writes are slow, but they're not *that* slow in comparison to
a system call (which I think is where this code is being called?).

So we should try to avoid too many SPR read/writes, but at the same time
we can accept more than the minimum if it makes the code much easier to
follow.

cheers
