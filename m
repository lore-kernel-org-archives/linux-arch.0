From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v4] kernel/signal: Signal-based pre-coredump notification
Date: Fri, 26 Oct 2018 15:23:47 -0700
Message-ID: <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026082812.GA10581@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

Hi, Olge:

This is really a good idea given that "parent" is declared as RCU-protected.
Just a bit odd, though, that the "parent" has not been accessed this way in
the code base.

So just to confirm: the revised code would look like the following:

static void do_notify_parent_predump(void)
{
        struct task_struct *parent;
        int sig;

        rcu_read_lock();
        parent = rcu_dereference(current->parent);
        sig = parent->signal->predump_signal;
        if (sig != 0)
                do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
        rcu_read_unlock();
}

Thank you so much for your help during this review. I would like to ack your
contribution in the "Reviewed-by:" field.

-- Enke

On 10/26/18 1:28 AM, Oleg Nesterov wrote:
> On 10/25, Enke Chen wrote:
>>
>> +static void do_notify_parent_predump(void)
>> +{
>> +	struct task_struct *parent;
>> +	int sig;
>> +
>> +	read_lock(&tasklist_lock);
>> +	parent = current->parent;
>> +	sig = parent->signal->predump_signal;
>> +	if (sig != 0)
>> +		do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
>> +	read_unlock(&tasklist_lock);
> 
> Ah. It is strange I didn't think about this before... Please, do not take
> tasklist_lock, use rcu_read_lock() instead. do_send_sig_info() uses the
> rcu-friendly lock_task_sighand(), so rcu_dereference(parent) should work
> fine.
> 
> Oleg.
> 
