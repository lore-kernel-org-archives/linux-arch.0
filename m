From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 01/62] powerpc: Free up four 64K PTE bits in 4K backed HPTE pages
Date: Thu, 20 Jul 2017 11:21:51 +0530
Message-ID: <87d18vr6yw.fsf@skywalker.in.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org


.....

>  	/*
> @@ -116,8 +104,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * On hash insert failure we use old pte value and we don't
>  		 * want slot information there if we have a insert failure.
>  		 */
> -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> +		old_pte &= ~(H_PAGE_HASHPTE);
> +		new_pte &= ~(H_PAGE_HASHPTE);
>  		goto htab_insert_hpte;
>  	}

With the current path order and above hunk we will breaks the bisect I guess. With the above, when
we convert a 64k hpte to 4khpte, since this is the first patch, we
should clear that H_PAGE_F_GIX and H_PAGE_F_SECOND. We still use them
for 64k. I guess you should move this hunk to second patch.


-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
