Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1819 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbeBZVMt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Feb 2018 16:12:49 -0500
Subject: Re: [PATCH v12 1/3] mm, powerpc, x86: define VM_PKEY_BITx bits if
 CONFIG_ARCH_HAS_PKEYS is enabled
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
 <1519257138-23797-2-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a5481355-9630-7f63-15ce-2b12d1520979@intel.com>
Date: Mon, 26 Feb 2018 13:12:46 -0800
MIME-Version: 1.0
In-Reply-To: <1519257138-23797-2-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Message-ID: <20180226211246.3PKU66hCRfdwvPnqap0rPo2Ye6AJSieiZ1Olpb3ZzJM@z>

On 02/21/2018 03:52 PM, Ram Pai wrote:
> VM_PKEY_BITx are defined only if CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> is enabled. Powerpc also needs these bits. Hence lets define the
> VM_PKEY_BITx bits for any architecture that enables
> CONFIG_ARCH_HAS_PKEYS.

Your fixed version looks fine to me.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
