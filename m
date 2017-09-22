Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35849 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdIVGJL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 02:09:11 -0400
Date: Fri, 22 Sep 2017 16:08:59 +1000
From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 3/6] mm: display pkey in smaps if arch_pkeys_enabled()
 is true
Message-ID: <20170922160859.33a01da9@firefly.ozlabs.ibm.com>
In-Reply-To: <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
        <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Message-ID: <20170922060859.auA1qoXJu1NxG97lGQ9qZankN6qeoSrgbP5hSTBUZIY@z>

On Fri, 15 Sep 2017 18:21:07 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +	if (arch_pkeys_enabled())

Sorry, I missed this bit in my previous review
the patch makes sense

> +		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> +#endif
> +

Balbir
