Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113AbcFQU5b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jun 2016 16:57:31 -0400
Date: Fri, 17 Jun 2016 15:57:28 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 06/13] fork: Add generic vmalloced stack support
Message-ID: <20160617205728.qgha2qeubdkg73uh@treble>
References: <cover.1466192946.git.luto@kernel.org>
 <44f658aacbabd9d1689b3e0aae60ee8746881eff.1466192946.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44f658aacbabd9d1689b3e0aae60ee8746881eff.1466192946.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160617205728.H_CJ1W1Trx20tEnVTa9m384zy_SFBDkGQr0hDSj2Odg@z>

On Fri, Jun 17, 2016 at 01:00:42PM -0700, Andy Lutomirski wrote:
> @@ -213,24 +232,46 @@ struct kmem_cache *vm_area_cachep;
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>  
> -static void account_kernel_stack(struct thread_info *ti, int account)
> +static void account_kernel_stack(struct task_struct *tsk, int account)
>  {
> -	struct zone *zone = page_zone(virt_to_page(ti));
> +	struct zone *zone;
> +	struct thread_info *ti = task_thread_info(tsk);
> +	struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
> +
> +	if (vm) {
> +		int i;
>  
> -	mod_zone_page_state(zone, NR_KERNEL_STACK_KB,
> -			    THREAD_SIZE / 1024 * account);
> +		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
>  
> -	/* All stack pages belong to the same memcg. */
> -	memcg_kmem_update_page_stat(
> -		virt_to_page(ti), MEMCG_KERNEL_STACK,
> -		account * (THREAD_SIZE / PAGE_SIZE));
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> +			mod_zone_page_state(page_zone(vm->pages[i]),
> +					    1, PAGE_SIZE / 1024 * account);

Shouldn't the second argument be NR_KERNEL_STACK_KB instead of 1?

-- 
Josh
