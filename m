From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: linux-next: tracebacks in workqueue.c/__flush_work()
Date: Wed, 6 Feb 2019 23:57:45 +0900
Message-ID: <e4dd7464-a787-c54f-24f9-9caaeb759cfc@i-love.sakura.ne.jp>
References: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
 <87munc306z.fsf@rustcorp.com.au>
 <201902060631.x166V9J8014750@www262.sakura.ne.jp>
 <20190206143625.GA25998@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206143625.GA25998@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Metcalf <chris.d.metcalf@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 2019/02/06 23:36, Guenter Roeck wrote:
> On Wed, Feb 06, 2019 at 03:31:09PM +0900, Tetsuo Handa wrote:
>> (Adding linux-arch ML.)
>>
>> Rusty Russell wrote:
>>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>>>> (Adding Chris Metcalf and Rusty Russell.)
>>>>
>>>> If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
>>>> evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
>>>> previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
>>>> commits listed below.
>>>>
>>>>   Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
>>>>   expects that has_work is evaluated by for_each_cpu().
>>>>
>>>>   Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
>>>>   assumes that for_each_cpu() does not need to evaluate has_work.
>>>>
>>>>   Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
>>>>   expects that has_work is evaluated by for_each_cpu().
>>>>
>>>> What should we do? Do we explicitly evaluate has_work if NR_CPUS == 1 ?
>>>
>>> No, fix the API to be least-surprise.  Fix 2d3854a37e8b767a too.
>>>
>>> Doing anything else would be horrible, IMHO.
>>>
>>
>> Fixing 2d3854a37e8b767a might involve subtle changes. If we do
>>
> 
> Why not fix the macros ?
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> 
> does not really make sense since it does not evaluate mask.
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1 && cpumask_test_cpu((cpu), (mask)); (cpu)++)
> 
> or something similar might do it.

Fixing macros is fine, The problem is that "mask" becomes evaluated
which might be currently undefined or unassigned if CONFIG_SMP=n.
Evaluating "mask" generates expected behavior for lru_add_drain_all()
case. But there might be cases where evaluating "mask" generate
unexpected behavior/results.
