From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [RFC PATCH -tip] cpuacct: per-cgroup utime/stime statistics -
 v2
Date: Mon, 16 Mar 2009 16:58:45 +0800
Message-ID: <49BE14C5.2020109@cn.fujitsu.com>
References: <20090312110924.GC3344@in.ibm.com> <20090316103517.b0f8a20c.kamezawa.hiroyu@jp.fujitsu.com> <20090316043754.GA3449@in.ibm.com> <49BDFC22.6090202@cn.fujitsu.com> <20090316084756.GD3449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755143AbZCPI64@vger.kernel.org>
In-Reply-To: <20090316084756.GD3449@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bharata@linux.vnet.ibm.com
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-kernel@vger.kernel.org, Balaji Rao <balajirrao@gmail.com>, Dhaval Giani <dhaval@linux.vnet.ibm.com>, Balbir Singh <balbir@linux.vnet.ibm.com>, Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Bharata B Rao wrote:
> On Mon, Mar 16, 2009 at 03:13:38PM +0800, Li Zefan wrote:
>>>>> +/*
>>>>> + * Account the system/user time to the task's accounting group.
>>>>> + */
>>>>> +static void cpuacct_update_stats(struct task_struct *tsk,
>>>>> +		enum cpuacct_stat_index idx, cputime_t val)
>>>>> +{
>>>>> +	struct cpuacct *ca;
>>>>> +
>>>>> +	if (unlikely(!cpuacct_subsys.active))
>>>>> +		return;
>>>>> +
>>>>> +	ca = task_ca(tsk);
>>>>> +
>>>>> +	do {
>>>>> +		percpu_counter_add(&ca->cpustat[idx], val);
>>>>> +		ca = ca->parent;
>>>>> +	} while (ca);
>>>>> +}
>>>>> +
>>>> IIUC, to make sure accessing "ca" to be safe, we need some condition.
>>>> (task_lock() or some other.....
>>> task_lock() protects tsk->cgroups->subsys[]. So can we hold task_lock()
>>> to protect this walk ? But we do this cpuacct hierarchy walk for the
>>> current task here. So can a current task's ca or ca's parents disappear
>>> from under us ?
>>>
>> task_ca() should be protected by task_lock() or rcu_read_lock(), otherwise
>> there is a very small race:
>>
>>   ca = task_ca(tsk)
>> 				move @tsk to another cgroup
>> 				rmdir old_cgrp (thus ca is freed)
>>   ca->cpustat <--- accessing freed memory
>>
>> As KAMEZAWA-san said all updates are called under preempt-disabled, and
>> classic and tree rcu's rcu_read_lock does preempt disable only, so above
>> code is ok, except for rcupreempt.
> 
> So I will protect task_ca() and ca hierarchy walk with explicit
> rcu_read_lock() to be fully safe.
> 

either:

rcu_read_lock();
ca = task_ca(tsk);
do {
	percpu_counter_add(&ca->cpustat[idx], val);
	ca = ca->parent;
} while (ca);
rcu_read_unlock();

or:

rcu_read_lock();
ca = task_ca(tsk);
css_get(&ca->css);
rcu_read_unlock();
do {
	percpu_counter_add(&ca->cpustat[idx], val);
	ca = ca->parent;
} while (ca);
css_put(&ca->css);

which is more efficient?

> By the same logic, hierarchy walk in cpuacct_charge() is also
> not safe with rcupreempt. It is under preempt disabled section due
> to rq->lock. Does cpuacct_charge() also need a fix then ?
> 

I guess so..
