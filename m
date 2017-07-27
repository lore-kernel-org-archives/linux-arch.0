From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC v6 17/62] powerpc: implementation for arch_set_user_pkey_access()
Date: Thu, 27 Jul 2017 11:15:36 -0300
Message-ID: <87d18m3r07.fsf@linux.vnet.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-18-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <1500177424-13695-18-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org


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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
