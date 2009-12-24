From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/37] kdb: core for kgdb back end
Date: Thu, 24 Dec 2009 12:01:49 +0100
Message-ID: <1261652509.4937.185.camel@laptop>
References: <1261603190-5036-1-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-2-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-3-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-4-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-5-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-6-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:48140 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZLXLCo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2009 06:02:44 -0500
In-Reply-To: <1261603190-5036-6-git-send-email-jason.wessel@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, kdb@oss.sgi.com, mingo@elte.hu, mort@sgi.com, linux-arch@vger.kernel.org

Please use --no-chain-reply-to when posting patches using git, these inf
deep nested series are impossible to read.

On Wed, 2009-12-23 at 15:19 -0600, Jason Wessel wrote:
> diff --git a/kernel/module.c b/kernel/module.c
> index e96b8ed..25f6a7b 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/elf.h>
> +#include <linux/kdb.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/syscalls.h>
> @@ -79,6 +80,10 @@ EXPORT_TRACEPOINT_SYMBOL(module_get);
>  DEFINE_MUTEX(module_mutex);
>  EXPORT_SYMBOL_GPL(module_mutex);
>  static LIST_HEAD(modules);
> +#ifdef CONFIG_KGDB_KDB
> +struct list_head *kdb_modules = &modules; /* kdb needs the list of
> modules */
> +#endif /* CONFIG_KGDB_KDB */
> +
>  
>  /* Block module loading/unloading? */
>  int modules_disabled = 0;
> @@ -2654,8 +2659,14 @@ int module_get_kallsym(unsigned int symnum,
> unsigned long *value, char *type,
>                         char *name, char *module_name, int *exported)
>  {
>         struct module *mod;
> +#ifdef CONFIG_KGDB_KDB
> +       int get_lock = !KDB_IS_RUNNING();
> +#else
> +#define        get_lock 1
> +#endif
>  
> -       preempt_disable();
> +       if (get_lock)
> +               preempt_disable();
>         list_for_each_entry_rcu(mod, &modules, list) {
>                 if (symnum < mod->num_symtab) {
>                         *value = mod->symtab[symnum].st_value;
> @@ -2664,12 +2675,14 @@ int module_get_kallsym(unsigned int symnum,
> unsigned long *value, char *type,
>                                 KSYM_NAME_LEN);
>                         strlcpy(module_name, mod->name,
> MODULE_NAME_LEN);
>                         *exported = is_exported(name, *value, mod);
> -                       preempt_enable();
> +                       if (get_lock)
> +                               preempt_enable();
>                         return 0;
>                 }
>                 symnum -= mod->num_symtab;
>         }
> -       preempt_enable();
> +       if (get_lock)
> +               preempt_enable();
>         return -ERANGE;
>  }

Could you explain this?
