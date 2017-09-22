From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 3/6] mm: display pkey in smaps if arch_pkeys_enabled()
 is true
Date: Fri, 22 Sep 2017 16:08:59 +1000
Message-ID: <20170922160859.33a01da9@firefly.ozlabs.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
        <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
List-Id: linux-arch.vger.kernel.org

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
