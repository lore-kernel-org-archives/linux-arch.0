From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
Date: Tue, 11 Jul 2017 11:13:56 -0700
Message-ID: <8b0827c9-9fc9-c2d5-d1a5-52d9eef8965e@intel.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46674 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755947AbdGKSOX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 14:14:23 -0400
In-Reply-To: <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com

On 07/05/2017 02:22 PM, Ram Pai wrote:
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> +{
> +	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> +}
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */

This seems like kinda silly unnecessary duplication.  Could we just put
this in the fs/proc/ code and #ifdef it on ARCH_HAS_PKEYS?
