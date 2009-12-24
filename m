From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 05/37] kdb: core for kgdb back end
Date: Thu, 24 Dec 2009 05:55:20 -0600
Message-ID: <4B3356A8.4020901@windriver.com>
References: <1261603190-5036-1-git-send-email-jason.wessel@windriver.com> <1261603190-5036-2-git-send-email-jason.wessel@windriver.com> <1261603190-5036-3-git-send-email-jason.wessel@windriver.com> <1261603190-5036-4-git-send-email-jason.wessel@windriver.com> <1261603190-5036-5-git-send-email-jason.wessel@windriver.com> <1261603190-5036-6-git-send-email-jason.wessel@windriver.com> <1261652509.4937.185.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757403AbZLXLzz@vger.kernel.org>
In-Reply-To: <1261652509.4937.185.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, kdb@oss.sgi.com, mingo@elte.hu, mort@sgi.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Peter Zijlstra wrote:

> On Wed, 2009-12-23 at 15:19 -0600, Jason Wessel wrote:
>   
>> diff --git a/kernel/module.c b/kernel/module.c
>> index e96b8ed..25f6a7b 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -79,6 +80,10 @@ EXPORT_TRACEPOINT_SYMBOL(module_get);
>>  DEFINE_MUTEX(module_mutex);
>>  EXPORT_SYMBOL_GPL(module_mutex);
>>  static LIST_HEAD(modules);
>> +#ifdef CONFIG_KGDB_KDB
>> +struct list_head *kdb_modules = &modules; /* kdb needs the list of
>> modules */
>> +#endif /* CONFIG_KGDB_KDB */
>> +
>>     

Above we export "modules" so that kdb can emulate lsmod.


The remainder was a port from the original kdb, and should not been
needed.  The preempt_disable and preempt_enable should be able to be
safely called while the system in the kgdb exception context, so this
chunk of code is going to get axed and re-tested.

Thanks,
Jason.

>>  
>>  /* Block module loading/unloading? */
>>  int modules_disabled = 0;
>> @@ -2654,8 +2659,14 @@ int module_get_kallsym(unsigned int symnum,
>> unsigned long *value, char *type,
>>                         char *name, char *module_name, int *exported)
>>  {
>>         struct module *mod;
>> +#ifdef CONFIG_KGDB_KDB
>> +       int get_lock = !KDB_IS_RUNNING();
>> +#else
>> +#define        get_lock 1
>> +#endif
>>  
>> -       preempt_disable();
>> +       if (get_lock)
>> +               preempt_disable();
>>         list_for_each_entry_rcu(mod, &modules, list) {
>>                 if (symnum < mod->num_symtab) {
>>                         *value = mod->symtab[symnum].st_value;
>> @@ -2664,12 +2675,14 @@ int module_get_kallsym(unsigned int symnum,
>> unsigned long *value, char *type,
>>                                 KSYM_NAME_LEN);
>>                         strlcpy(module_name, mod->name,
>> MODULE_NAME_LEN);
>>                         *exported = is_exported(name, *value, mod);
>> -                       preempt_enable();
>> +                       if (get_lock)
>> +                               preempt_enable();
>>                         return 0;
>>                 }
>>                 symnum -= mod->num_symtab;
>>         }
>> -       preempt_enable();
>> +       if (get_lock)
>> +               preempt_enable();
>>         return -ERANGE;
>>  }
>>     
