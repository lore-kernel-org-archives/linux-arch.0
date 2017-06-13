From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 12/12] tracing: Rename update the enum_map file
Date: Tue, 13 Jun 2017 16:21:48 -0500
Message-ID: <d111f8c9-1a31-c447-8f2e-8360df6ef835@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
 <20170531215653.3240-13-jeremy.linton@arm.com>
 <20170613171255.5090de5b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752525AbdFMVVv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Jun 2017 17:21:51 -0400
In-Reply-To: <20170613171255.5090de5b@gandalf.local.home>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org

Hi,

On 06/13/2017 04:12 PM, Steven Rostedt wrote:
> On Wed, 31 May 2017 16:56:53 -0500
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
>> The enum_map file is used to display a list of symbol
>> to name conversions. As its now used to resolve sizeof
>> lets update the name and description.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   kernel/trace/Kconfig | 22 +++++++++++-----------
>>   kernel/trace/trace.c | 20 ++++++++++----------
>>   2 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>> index 7e06f04..434c840 100644
>> --- a/kernel/trace/Kconfig
>> +++ b/kernel/trace/Kconfig
>> @@ -667,30 +667,30 @@ config RING_BUFFER_STARTUP_TEST
>>   
>>   	 If unsure, say N
>>   
>> -config TRACE_ENUM_MAP_FILE
>> -       bool "Show enum mappings for trace events"
>> +config TRACE_EVAL_MAP_FILE
>> +       bool "Show eval mappings for trace events"
>>          depends on TRACING
>>          help
>> -        The "print fmt" of the trace events will show the enum names instead
>> -	of their values. This can cause problems for user space tools that
>> -	use this string to parse the raw data as user space does not know
>> +	The "print fmt" of the trace events will show the enum/sizeof names
>> +	instead	of their values. This can cause problems for user space tools
>> +	that use this string to parse the raw data as user space does not know
>>   	how to convert the string to its value.
>>   
>>   	To fix this, there's a special macro in the kernel that can be used
>> -	to convert the enum into its value. If this macro is used, then the
>> -	print fmt strings will have the enums converted to their values.
>> +	to convert an enum/sizeof into its value. If this macro is used, then
>> +	the print fmt strings will be converted to their values.
>>   
>>   	If something does not get converted properly, this option can be
>> -	used to show what enums the kernel tried to convert.
>> +	used to show what enums/sizeof the kernel tried to convert.
>>   
>> -	This option is for debugging the enum conversions. A file is created
>> -	in the tracing directory called "enum_map" that will show the enum
>> +	This option is for debugging the conversions. A file is created
>> +	in the tracing directory called "eval_map" that will show the
>>   	names matched with their values and what trace event system they
>>   	belong too.
>>   
>>   	Normally, the mapping of the strings to values will be freed after
>>   	boot up or module load. With this option, they will not be freed, as
>> -	they are needed for the "enum_map" file. Enabling this option will
>> +	they are needed for the "eval_map" file. Enabling this option will
>>   	increase the memory footprint of the running kernel.
>>   
>>   	If unsure, say N
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 676c808..7297e9d 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -120,8 +120,8 @@ enum ftrace_dump_mode ftrace_dump_on_oops;
>>   /* When set, tracing will stop when a WARN*() is hit */
>>   int __disable_trace_on_warning;
>>   
>> -#ifdef CONFIG_TRACE_ENUM_MAP_FILE
>> -/* Map of enums to their values, for "enum_map" file */
>> +#ifdef CONFIG_TRACE_EVAL_MAP_FILE
>> +/* Map of enums to their values, for "eval_map" file */
>>   struct trace_eval_map_head {
>>   	struct module			*mod;
>>   	unsigned long			length;
>> @@ -145,7 +145,7 @@ static DEFINE_MUTEX(trace_eval_mutex);
>>    * one at the beginning, and one at the end. The beginning item contains
>>    * the count of the saved maps (head.length), and the module they
>>    * belong to if not built in (head.mod). The ending item contains a
>> - * pointer to the next array of saved enum_eval/enum_map items.
>> + * pointer to the next array of saved eval_map items.
>>    */
>>   union trace_eval_map_item {
>>   	struct trace_eval_map		map;
>> @@ -154,7 +154,7 @@ union trace_eval_map_item {
>>   };
>>   
>>   static union trace_eval_map_item *trace_eval_maps;
>> -#endif /* CONFIG_TRACE_ENUM_MAP_FILE */
>> +#endif /* CONFIG_TRACE_EVAL_MAP_FILE */
>>   
>>   static int tracing_set_tracer(struct trace_array *tr, const char *buf);
>>   
>> @@ -4717,7 +4717,7 @@ static const struct file_operations tracing_saved_cmdlines_size_fops = {
>>   	.write		= tracing_saved_cmdlines_size_write,
>>   };
>>   
>> -#ifdef CONFIG_TRACE_ENUM_MAP_FILE
>> +#ifdef CONFIG_TRACE_EVAL_MAP_FILE
>>   static union trace_eval_map_item *
>>   update_eval_map(union trace_eval_map_item *ptr)
>>   {
>> @@ -4868,15 +4868,15 @@ trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
>>   
>>   static void trace_create_eval_file(struct dentry *d_tracer)
>>   {
>> -	trace_create_file("enum_map", 0444, d_tracer,
>> +	trace_create_file("eval_map", 0444, d_tracer,
>>   			  NULL, &tracing_eval_map_fops);
> 
> Hmm, I have to audit some userspace code to see if this is used. The
> enum_map was a debug feature, but it could have been used by some tools.

I thought perf was using it, but I was mistaken. I didn't find anything 
using it, but to be on the safe side I placed this patch last so it 
could be dropped if a user was found. The CONFIG option seems to be 
disabled in the couple distro's I checked, further indicating that if 
someone is using it, they are seemingly obscure.



>>   }
>>   
>> -#else /* CONFIG_TRACE_ENUM_MAP_FILE */
>> +#else /* CONFIG_TRACE_EVAL_MAP_FILE */
>>   static inline void trace_create_eval_file(struct dentry *d_tracer) { }
>>   static inline void trace_insert_eval_map_file(struct module *mod,
>>   			      struct trace_eval_map **start, int len) { }
>> -#endif /* !CONFIG_TRACE_ENUM_MAP_FILE */
>> +#endif /* !CONFIG_TRACE_EVAL_MAP_FILE */
>>   
>>   static void trace_insert_eval_map(struct module *mod,
>>   				  struct trace_eval_map **start, int len)
>> @@ -7731,7 +7731,7 @@ static void trace_module_add_evals(struct module *mod)
>>   	trace_insert_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
>>   }
>>   
>> -#ifdef CONFIG_TRACE_ENUM_MAP_FILE
>> +#ifdef CONFIG_TRACE_EVAL_MAP_FILE
>>   static void trace_module_remove_evals(struct module *mod)
>>   {
>>   	union trace_eval_map_item *map;
>> @@ -7761,7 +7761,7 @@ static void trace_module_remove_evals(struct module *mod)
>>   }
>>   #else
>>   static inline void trace_module_remove_evals(struct module *mod) { }
>> -#endif /* CONFIG_TRACE_ENUM_MAP_FILE */
>> +#endif /* CONFIG_TRACE_EVAL_MAP_FILE */
>>   
>>   static int trace_module_notify(struct notifier_block *self,
>>   			       unsigned long val, void *data)
> 
