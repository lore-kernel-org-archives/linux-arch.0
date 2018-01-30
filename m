Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54353 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeA3MQO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jan 2018 07:16:14 -0500
Date: Tue, 30 Jan 2018 13:16:11 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v10 27/27] mm: display pkey in smaps if
 arch_pkeys_enabled() is true
Message-ID: <20180130121611.GC26445@dhcp22.suse.cz>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
 <1516326648-22775-28-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516326648-22775-28-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Message-ID: <20180130121611.lMue0JbtiQMk7gwSMU13xcO7DOuQSQf87UAPFgvegqk@z>

On Thu 18-01-18 17:50:48, Ram Pai wrote:
[...]
> @@ -851,9 +848,13 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
>  			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
>  
>  	if (!rollup_mode) {
> -		arch_show_smap(m, vma);
> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +		if (arch_pkeys_enabled())
> +			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> +#endif
>  		show_smap_vma_flags(m, vma);
>  	}
> +

Why do you need to add ifdef here? The previous patch should make
arch_pkeys_enabled == F when CONFIG_ARCH_HAS_PKEYS=n. Btw. could you
merge those two patches into one. It is usually much easier to review a
new helper function if it is added along with a user.

>  	m_cache_vma(m, vma);
>  	return ret;
>  }
> -- 
> 1.7.1

-- 
Michal Hocko
SUSE Labs
