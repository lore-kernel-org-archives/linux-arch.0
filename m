Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:28719 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406649AbfFKRzj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 13:55:39 -0400
Subject: Re: [PATCH v7 25/27] mm/mmap: Add Shadow stack pages to memory
 accounting
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-26-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1cfc7396-ca90-1933-34ad-b3d43ae52e08@intel.com>
Date: Tue, 11 Jun 2019 10:55:38 -0700
MIME-Version: 1.0
In-Reply-To: <20190606200646.3951-26-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190611175538.aLhY9_RFXoeQ7i-r8vqZDL2aqJEpMB4cZyZtVhygFNs@z>

On 6/6/19 1:06 PM, Yu-cheng Yu wrote:
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1703,6 +1703,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	if (file && is_file_hugepages(file))
>  		return 0;
>  
> +	if (arch_copy_pte_mapping(vm_flags))
> +		return 1;
> +
>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
>  }
>  
> @@ -3319,6 +3322,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
>  		mm->stack_vm += npages;
>  	else if (is_data_mapping(flags))
>  		mm->data_vm += npages;
> +	else if (arch_copy_pte_mapping(flags))
> +		mm->data_vm += npages;
>  }

This classifies shadow stack as data instead of stack.  That seems a wee
bit counterintuitive.  Why did you make this choice?
